import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart';

void main() {
  Socket socket = io('http://10.1.0.188:3000',
      OptionBuilder().setTransports(['websocket']).build());
  socket.onConnectError((data) => print(data));
  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });
  socket.on('event', (data) => print(data));
  socket.on('msg', (data) => {print(data)});
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));
  runApp(const SDVXController());
}

class SDVXController extends StatelessWidget {
  const SDVXController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 250),
        child: Column(
          children: [
            TextField(),
            ElevatedButton(onPressed: () => {}, child: Text("aaa"))
          ],
        ),
      ),
    ));
  }
}
