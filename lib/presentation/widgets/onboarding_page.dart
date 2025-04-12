import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? graphic;
  final String? actionText;
  final VoidCallback? onTap;

  const OnboardingPage({
    required this.title,
    this.subtitle,
    this.graphic,
    this.actionText = 'TAP TO CONTINUE',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          if (graphic != null) ...[
            SizedBox(height: 20),
            graphic!,
          ],
          if (subtitle != null) ...[
            SizedBox(height: 10),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
          SizedBox(height: 20),
          if (actionText != null)
            GestureDetector(
              onTap: onTap,
              child: Text(
                actionText!,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}