import 'package:analytics_app/models/mertics.dart';
import 'package:analytics_app/screens/active_users_card.dart';
import 'package:analytics_app/screens/page_views_card.dart';
import 'package:analytics_app/screens/session_duration_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'services/websocket_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Analytics Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final WebSocketService _webSocketService = WebSocketService();
  final List<Map<String, dynamic>> _pageViewsData = [];
  Metrics? _currentMetrics;

  @override
  void initState() {
    super.initState();
    _webSocketService.connect();
    _webSocketService.stream.listen((data) {
      setState(() {
        _currentMetrics = Metrics.fromJson(data);
        _pageViewsData.add(data);
        if (_pageViewsData.length > 10) {
          _pageViewsData.removeAt(0);
        }
      });
    });
  }

  @override
  void dispose() {
    _webSocketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real-Time Analytics Dashboard')),
      body:
          _currentMetrics == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      crossAxisCount: 1,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: [
                        ActiveUsersCard(count: _currentMetrics!.activeUsers),
                        PageViewsCard(data: _pageViewsData),
                        SessionDurationCard(
                          duration: _currentMetrics!.avgSessionDuration,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Last updated: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(_currentMetrics!.timestamp).toLocal())}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
    );
  }
}
