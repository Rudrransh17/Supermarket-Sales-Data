import 'package:flutter/material.dart';
import 'credential_textfield.dart';
import 'package:realm/realm.dart';

// ignore_for_file: prefer_const_constructors

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLogin = true;


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
      body: Center(
        child: isLogin
            ? Container(
                width: 500,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
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
                          print(emailController.text);
                          print(passwordController.text);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLogin = false;
                          });
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Don't have an account? Create Account",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                width: 500,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      CredentialTextfield(
                        controller: nameController,
                        text: 'Name',
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10.0),
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
                        controller: passwordController,
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/home');
                          print(emailController.text);
                          print(passwordController.text);
                          print(nameController.text);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text(
                              'Signup',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLogin = true;
                          });
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Already have an account? Sign-in",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
