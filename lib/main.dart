import 'package:flutter/material.dart';
import 'package:supermarket_sales_data/home.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<String, WidgetBuilder> routes = {
    '/login': (context) => LoginPage(),
    '/home' : (context) => HomeScreen(),
    // Add more routes here
  };

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Supermarket Sales Data Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: routes,
    );
  }
}






