import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class WebSocketService {
  WebSocketChannel? _channel;
  final String _url = 'wss://real-time-analytics-dashboard-dmtb.onrender.com';

  void connect() {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(_url));
    } catch (e) {
      // ignore: avoid_print
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
