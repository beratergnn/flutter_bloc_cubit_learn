import 'package:bloc_learn/feature/travel/view/travel_tab_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        tabBarTheme: TabBarTheme(
          labelColor: Colors.red.shade700,
          unselectedLabelColor: Colors.grey.withOpacity(0.5),
          indicatorColor: Colors.red,
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),
      home: TravelTabView(),
    );
  }
}
