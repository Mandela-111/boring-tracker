import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  final String city;

  const WeatherWidget({required this.city});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            city,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Row(
            children: [
              Icon(Icons.wb_sunny, color: Colors.yellow),
              SizedBox(width: 8),
              Text(
                '72°F',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}