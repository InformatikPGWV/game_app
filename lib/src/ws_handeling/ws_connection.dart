import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WsConnection {
  WsConnection(this.wSUrl);

  final String wSUrl;

  bool isConnected = false;
  bool isListening = false;

  late var channel;
  late var listeningStream;

  final _streamController = StreamController<String>.broadcast();
  Stream<String> get stream => _streamController.stream;

  void connectAndListen() {
    connect();
    listen();
  }

  Future<void> connect() async {
    if (!isConnected) {
      try {
        channel = WebSocketChannel.connect(
          Uri.parse(wSUrl),
        );
        isConnected = true;
      } catch (_) {
        isConnected = false;
      }
    }
  }

  void disconnect() {
    if (isConnected) {
      if (isListening) {
        cancelListen();
      }
      isConnected = false;
      channel.sink.close(status.normalClosure);
    }
  }

  // Listened and makes the streamm into a broadcast stream
  void listen() {
    if (isConnected && !isListening) {
      listeningStream = channel.stream.listen((data) {
        _streamController.sink.add(data);
      });
    }
  }

  void cancelListen() {
    if (isConnected && isListening) {
      listeningStream.cancel();
    }
  }

  bool sendData(String data) {
    if (isConnected) {
      channel.sink.add(data);
      return true;
    } else {
      return false;
    }
  }
}
