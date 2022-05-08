import 'package:flutter/foundation.dart';
import 'package:popolsuoh/screen/main_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class ChatProvider with ChangeNotifier {
  late final IO.Socket socket;


  void connectSocket() {
    socket = IO.io(
        'http://${MainScreen.localhostPath}:4000',
        IO.OptionBuilder().setTransports(['websocket']).build()
    );
    socket.onConnect((data) =>  print('소켓 연결 완료'));
  }

}