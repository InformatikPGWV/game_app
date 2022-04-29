import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WsConnection {
  bool isConnected = false;

  late var channel;

  Future<void> connect() async {
    if (!isConnected) {
      try {
        channel = WebSocketChannel.connect(
          Uri.parse('ws://dyn.astrago.de:8080'),
        );
        isConnected = true;
      } catch (_) {
        print("cannot connect :(");
        isConnected = false;
      }
      // await Future.delayed(Duration(seconds: 1));
      // var listen = _listen();
      // listen.timeout(Duration(seconds: 3), onTimeout: () {
      //   isConnected = false;
      // });
    }
  }

  // Future _listen() async {
  //   channel.sink.add("ping");
  //   channel.stream.listen((data) {
  //     print(data);
  //     if (data == "pong") {
  //       isConnected = true;
  //     }
  //   });
  // }

  bool sendData(String data) {
    if (isConnected) {
      channel.sink.add(data);
      return true;
    } else {
      return false;
    }
  }

  void disconnect() {
    if (isConnected) {
      isConnected = false;
      channel.sink.close(status.normalClosure);
    } else {}
  }
}
