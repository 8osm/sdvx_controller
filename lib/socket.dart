import 'package:socket_io_client/socket_io_client.dart';

class SDVXSocket {
  late Socket socket;

  SDVXSocket(String url) {
    Socket socket = io('http://10.1.0.188:3000',
        OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('event', _newData);
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  _newData(data) {}
}
