

function RemoteHandler0(channel, msg)
endfunction

function RemoteHandlerRPC(channel, msg)
	exec "tabe ".a:msg
	call ch_sendexpr(a:channel, getpid(), {'callback':"RemoteHandlerRPC"})
endfunction

function! RemoteOpen()
	let channel = ch_open('localhost:23333', {'callback':"RemoteHandler0", 'mode':'json'})
	call ch_sendexpr(channel, getpid(), {'callback':"RemoteHandlerRPC"})
endfunction

