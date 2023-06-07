import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermarket_sales_data/app_services.dart';
import 'credential_textfield.dart';
import 'package:realm/realm.dart';

// ignore_for_file: prefer_const_constructors

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLogin = true;
  String? _errorMessage;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController()..addListener(clearError);
    _passwordController = TextEditingController()..addListener(clearError);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
        child: Container(
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
                        _isLogin ?
                        'Welcome Back'
                        : 'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      CredentialTextfield(
                        controller: _emailController,
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
                          controller: _passwordController),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          _logInOrSignUpUser(context,
                              _emailController.text, _passwordController.text);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text(
                              _isLogin ?
                              'Login'
                              : 'Signup',
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
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            _isLogin ?
                            "Don't have an account? Create Account"
                            : "Already have an account? Sign-in",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(_errorMessage ?? "",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void clearError() {
    if (_errorMessage != null) {
      setState(() {
        // Reset error message when user starts typing
        _errorMessage = null;
      });
    }
  }

  void _logInOrSignUpUser(BuildContext context, String email, String password) async {
    final appServices = Provider.of<AppServices>(context, listen: false);
    clearError();
    try {
      if (_isLogin) {
        await appServices.logInUserEmailPassword(email, password);
      } else {
        await appServices.registerUserEmailPassword(email, password);
      }
      Navigator.pushReplacementNamed(context, '/home');
    } catch (err) {
      setState(() {
        print(err.toString());
        _errorMessage = "Wrong Email or Password. Type Correct credentials or signup instead";
      });
    }
  }
}
