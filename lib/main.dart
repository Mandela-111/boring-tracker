import 'package:flutter/material.dart';
import 'package:light_and_dark/theme/color_state.dart';
import 'package:provider/provider.dart';
import 'theme/theme.dart';
import 'pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ColorState>(
      create: (BuildContext context) => ColorState(),
      builder: (context, child){
        return MaterialApp(
          theme: Provider.of<ColorState>(context).isDone ? lightMode : darkMode,
          darkTheme: darkMode,
          home: Homepage(),
        );
      }
    );
  }
}


// quick challenge, let's toggle the color of the