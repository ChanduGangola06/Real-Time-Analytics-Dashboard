// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class PageViewsCard extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const PageViewsCard({super.key, required this.data});

  @override
  State<PageViewsCard> createState() => _PageViewsCardState();
}

class _PageViewsCardState extends State<PageViewsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        height: 320, // Increased height to accommodate axis labels
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Page Views',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (widget.data.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${widget.data.last['page_views']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Add bottom padding for axis labels
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withOpacity(0.1),
                          strokeWidth: 1,
                          dashArray: [5, 5],
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      // leftTitles: AxisTitles(
                      //   sideTitles: SideTitles(
                      //     showTitles: true,
                      //     reservedSize: 45,
                      //     interval: 1,
                      //     getTitlesWidget: (value, meta) {
                      //       return Padding(
                      //         padding: const EdgeInsets.only(right: 8.0),
                      //         child: Text(
                      //           value.toInt().toString(),
                      //           style: const TextStyle(
                      //             color: Colors.grey,
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 25,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() < widget.data.length) {
                              final date = DateTime.parse(
                                widget.data[value.toInt()]['timestamp'],
                              );
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  DateFormat('ss').format(date.toLocal()),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                        left: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    minX: 0,
                    maxX: widget.data.isNotEmpty ? (widget.data.length - 1).toDouble() : 0,
                    minY: 0,
                    maxY: widget.data.isNotEmpty
                        ? widget.data.map((e) => e['page_views'] as num).reduce((a, b) => a > b ? a : b).toDouble() + 1
                        : 1,
                    lineBarsData: [
                      LineChartBarData(
                        spots: widget.data.asMap().entries.map((entry) {
                          return FlSpot(
                            entry.key.toDouble(),
                            entry.value['page_views'].toDouble(),
                          );
                        }).toList(),
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 3,
                              color: Colors.blue,
                              strokeWidth: 2,
                              strokeColor: Colors.white,
                            );
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.1),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.withOpacity(0.2),
                              Colors.blue.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Real-time page views over time',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
