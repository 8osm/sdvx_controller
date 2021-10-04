import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdvx_controller/socket_bloc.dart';

void main() {
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
      home: BlocProvider<SocketBloc>(
          create: (_) => SocketBloc(), child: const MyHomePage()),
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
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 250),
          child: BlocBuilder<SocketBloc, SocketState>(
            builder: (_, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextField(),
                  ElevatedButton(
                      onPressed: () {
                        if (!state.initialized) {
                          context
                              .read<SocketBloc>()
                              .add(SocketInitEvent('http://10.1.0.188:3000'));
                          context.read<SocketBloc>().add(SocketConnectEvent());
                        } else {
                          if (!state.connected) {
                            context
                                .read<SocketBloc>()
                                .add(SocketConnectEvent());
                          } else {
                            context
                                .read<SocketBloc>()
                                .add(SocketDisconnectEvent());
                          }
                        }
                      },
                      child: Text("aaa")),
                  Text(state.connected ? "connected" : "disconnected")
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
