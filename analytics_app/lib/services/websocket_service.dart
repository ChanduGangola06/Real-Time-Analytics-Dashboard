import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class WebSocketService {
  WebSocketChannel? _channel;
  final String _url = 'ws://localhost:3001';

  void connect() {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(_url));
    } catch (e) {
      print('WebSocket connection error: $e');
      // Attempt to reconnect after 5 seconds
      Future.delayed(const Duration(seconds: 5), () => connect());
    }
  }

  Stream<Map<String, dynamic>> get stream {
    return _channel!.stream.map((data) {
      return jsonDecode(data) as Map<String, dynamic>;
    });
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
