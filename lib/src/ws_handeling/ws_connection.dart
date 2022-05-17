import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'package:shared_preferences/shared_preferences.dart';

class WsConnection {
  WsConnection(this.wSUrl);

  late String wSUrl;

  bool isConnected = false;
  bool isListening = false;

  late var channel;
  late var listeningStream;

  final _streamController = StreamController<String>.broadcast();
  Stream<String> get stream => _streamController.stream;

  void setAddress(String address) {
    wSUrl = address;
  }

  Future<void> setAddressFromMemory() async {
    var prefs = await SharedPreferences.getInstance();
    String? _urlFromSetting = await prefs.getString("serverAddress");
    if (_urlFromSetting != null || _urlFromSetting != "") {
      wSUrl = _urlFromSetting!;
    }
  }

  String getAddress() {
    return wSUrl;
  }

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
      channel.sink.close(status.normalClosure);
      isConnected = false;
    }
  }

  // Listened and makes the streamm into a broadcast stream
  void listen() {
    if (isConnected && !isListening) {
      isListening = true;
      listeningStream = channel.stream.listen((data) {
        _streamController.sink.add(data);
      });
    }
  }

  void cancelListen() {
    if (isConnected && isListening) {
      listeningStream.cancel();
      isListening = false;
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
