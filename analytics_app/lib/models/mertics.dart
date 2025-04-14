class Metrics {
  final String timestamp;
  final int activeUsers;
  final int pageViews;
  final double avgSessionDuration;

  Metrics({
    required this.timestamp,
    required this.activeUsers,
    required this.pageViews,
    required this.avgSessionDuration,
  });

  factory Metrics.fromJson(Map<String, dynamic> json) {
    return Metrics(
      timestamp: json['timestamp'],
      activeUsers: json['active_users'],
      pageViews: json['page_views'],
      avgSessionDuration: json['avg_session_duration'].toDouble(),
    );
  }
}
