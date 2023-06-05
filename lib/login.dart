import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        titleTextStyle: const TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
        title: const Text('Supermarket Sales Data Visualizer',
        ),
      ),
      body: Row(
        children: [
          Expanded(child: Container(),),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {
                      // Perform login functionality here
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      // Navigate to create account page
                    },
                    child: Text(
                      "Don't have an account? Create Account",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: Container(),),
        ],
      ),
    );
  }
}
