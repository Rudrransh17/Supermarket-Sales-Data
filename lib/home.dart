import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supermarket Sales Data Visualizer'),
      ),
      body: Center(
        child: Text(
          'Dummy Home Screen',
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }
}
