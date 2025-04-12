import 'package:flutter/material.dart';

class DayButton extends StatelessWidget {
  final String day;
  final String label;
  final bool isToday;
  final bool isSelected;

  const DayButton({
    required this.day,
    required this.label,
    this.isToday = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: label == 'TODAY'
                  ? Colors.yellow
                  : (isToday
                  ? Colors.black
                  : (isSelected ? Colors.grey : Colors.transparent)),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  color: label == 'TODAY'
                      ? Colors.black
                      : (isToday || isSelected ? Colors.white : Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: label == 'TODAY' ? Colors.yellow : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}