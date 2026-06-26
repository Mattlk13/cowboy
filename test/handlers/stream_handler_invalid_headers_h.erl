%% This module sends invalid response headers in early_error.

-module(stream_handler_invalid_headers_h).
-behavior(cowboy_stream).

-export([init/3]).
-export([data/4]).
-export([info/3]).
-export([terminate/3]).
-export([early_error/5]).

init(_StreamID, _Req, _Opts) ->
	{[], undefined}.

data(_StreamID, _IsFin, _Data, State) ->
	{[], State}.

info(_StreamID, _Info, State) ->
	{[], State}.

terminate(_StreamID, _Reason, _State) ->
	ok.

early_error(_StreamID, _Reason, _PartialReq, Resp={response, _, Headers, _}, _Opts) ->
	setelement(3, Resp, Headers#{<<"x-test">> => "bad\r\nvalue"}).
