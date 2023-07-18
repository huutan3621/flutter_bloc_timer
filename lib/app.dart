import 'package:flutter/material.dart';
import 'package:flutter_bloc_timer/timer/view/timer_page.dart';

class BlocTimerApp extends StatelessWidget {
  const BlocTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        colorScheme: const ColorScheme.light(
          secondary: Colors.blueGrey,
        ),
      ),
      home: const TimerPage(),
    );
  }
}
