-module(mongoose_graphql_session_helper).

-export([format_session/1, format_sessions/1, format_status_user/1, format_status_users/1]).

-ignore_xref([format_session/1, format_status_user/1]).

-type session_data() :: map().
-type session_list() :: [{ok, session_data()}].
-type status_user_data() :: map().
-type status_user_list() :: [{ok, status_user_data()}].

-export_type([session_data/0, session_list/0, status_user_data/0, status_user_list/0]).

-spec format_sessions([mongoose_session_api:session_info()]) -> session_list().
format_sessions(Sessions) ->
    lists:map(fun(S) -> {ok, format_session(S)} end, Sessions).

-spec format_session(mongoose_session_api:session_info()) -> session_data().
format_session({USR, Conn, IPS, PORT, Prio, NodeS, Uptime}) ->
    #{<<"user">> => iolist_to_binary(USR),
      <<"connection">> => iolist_to_binary(Conn),
      <<"ip">> => iolist_to_binary(IPS),
      <<"port">> => PORT,
      <<"priority">> => Prio,
      <<"node">> => iolist_to_binary(NodeS),
      <<"uptime">> => Uptime}.

-spec format_status_users([mongoose_session_api:session_info()]) -> session_list().
format_status_users(Sessions) ->
    lists:map(fun(S) -> {ok, format_status_user(S)} end, Sessions).

-spec format_status_user(mongoose_session_api:status_user_info()) -> status_user_data().
format_status_user({User, Server, Res, Prio, StatusText}) ->
    #{<<"user">> => jid:to_binary({User, Server, Res}),
      <<"priority">> => Prio,
      <<"text">> => iolist_to_binary(StatusText)}.
