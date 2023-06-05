import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'credential_textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        titleTextStyle: const TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
        title: const Text(
          'Supermarket Sales Data Visualizer',
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(),
          ),
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
                  CredentialTextfield(
                    controller: emailController,
                    text: 'Email Address',
                    icon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  CredentialTextfield(
                      text: 'Password',
                      icon: Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.grey,
                      ),
                      controller: passwordController),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue, borderRadius: BorderRadius.circular(10.0),),
                    ),
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
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
