import 'package:flutter/material.dart';

class AchievementCard extends StatelessWidget {
  final String title;
  final String level;
  final String progress;

  const AchievementCard({
    required this.title,
    required this.level,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 4),
              Text(
                'Level: $level',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Text(
            progress,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}