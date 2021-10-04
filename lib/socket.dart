import 'package:sdvx_controller/socket_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SDVXSocket {
  Socket socket;

  SDVXSocket(String url, SocketBloc bloc)
      : socket = io(
            url,
            OptionBuilder()
                .setTransports(['websocket'])
                .disableAutoConnect()
                .build()) {
    socket.onConnect((_) => bloc.add(SocketConnectedEvent()));
    socket.on('', _newData);
    socket.onConnectError((data) => print(data));
    socket.onDisconnect((_) => bloc.add(SocketDisconnectedEvent()));
  }

  sendKeyEvent(SocketKeyEvent event) {
    socket.emit("key_data",
        [event.vol, event.startButton, event.abcdButtons, event.fxButtons]);
  }

  _newData(data) {}
}
