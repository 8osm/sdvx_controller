import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdvx_controller/socket.dart';

class SocketEvent {}

class SocketInitEvent extends SocketEvent {
  String url;

  SocketInitEvent(this.url);
}

class SocketDisconnectEvent extends SocketEvent {}

class SocketConnectEvent extends SocketEvent {}

class SocketConnectedEvent extends SocketEvent {}

class SocketDisconnectedEvent extends SocketEvent {}

class SocketState {
  bool connected;
  bool initialized;

  SocketState(this.connected, this.initialized);
}

class SocketKeyEvent extends SocketEvent {
  List<int> vol;
  bool startButton;
  List<bool> abcdButtons;
  List<bool> fxButtons;

  SocketKeyEvent(this.vol, this.startButton, this.abcdButtons, this.fxButtons);
}

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  late SDVXSocket sdvx;

  SocketBloc() : super(SocketState(false, false)) {
    on<SocketInitEvent>((event, emit) {
      sdvx = SDVXSocket(event.url, this);
      sdvx.socket.connect();
    });
    on<SocketDisconnectEvent>((event, emit) {
      sdvx.socket.disconnect();
    });
    on<SocketConnectEvent>((event, emit) {
      sdvx.socket.connect();
    });
    on<SocketConnectedEvent>((event, emit) {
      emit(SocketState(true, true));
    });
    on<SocketDisconnectedEvent>(
        (event, emit) => emit(SocketState(false, true)));
    on<SocketKeyEvent>(
        (event, emit) => {if (state.connected) sdvx.sendKeyEvent(event)});
  }
}
