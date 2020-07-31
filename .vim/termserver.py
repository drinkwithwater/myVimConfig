
import time
import json
import random
import os

import gevent
import gevent.socket as socket
import gevent.time as time

class Client(object):
    def __init__(self, index, sock, addr):
        self.index = index
        self.sock = sock
        self.addr = addr
        self.buffer = bytearray()
        self.pid = None
        self.session = None

    def recv(self):
        while True:
            data = self.sock.recv(1024)
            print(self.addr, data)
            if not data:
                raise Exception("socket error")
            self.buffer.extend(data)
            i = self.buffer.find(b'\n')
            if i >= 0:
                msg = self.buffer[:i]
                self.buffer = self.buffer[i+1:]
                return json.loads(msg)

    def vim_update(self, session, pid):
        self.pid = pid
        self.session = session
        pass

    def close(self):
        self.sock.close()

    def tabe(self, file_name_str):
        send_msg = "[%s,\"%s\"]\n"%(self.session, file_name_str)
        self.sock.send(send_msg.encode("utf-8"))
        print("vim tabe:", self.pid, file_name_str)

    def getpid(self):
        return self.pid


server_socket = None
client_dict = {}

wait_socket_session = [None, None]

def serve_client(index, client_socket, addr):
    client = Client(index, client_socket, addr)
    client_dict[index] = client
    buffer = bytearray()
    while True:
        try:
            msg = client.recv()
            if type(msg[0]) == int:
                # vim msg : [session, pid]
                client.vim_update(msg[0], msg[1])
            elif type(msg[0]) == str:
                # tabe msg: [file_name, pid]
                for k,v in client_dict.items():
                    if v.getpid()==msg[1]:
                        v.tabe(msg[0])
                        raise Exception("normal close")
                force_choose_vim = next(iter(client_dict.values()))
                force_choose_vim.tabe(msg[0])
                raise Exception("normal close")
        except Exception as e:
            print("except:", e)
            break
    client_dict.pop(index)
    client.close()

def main():
    counter = 0
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        server_socket.bind(("127.0.0.1", 23333)) #socket.INADDR_ANY))
    except:
        exit()
    port = server_socket.getsockname()[1]
    server_socket.listen()
    while True:
        client_socket, addr = server_socket.accept()
        print("accept:", addr)
        index = counter
        counter += 1
        gevent.spawn(serve_client, index, client_socket, addr)


if __name__=="__main__":
    from daemon import DaemonContext
    context = DaemonContext(stdout=None, stdin=None)
    context.open()
    with context:
        main()
