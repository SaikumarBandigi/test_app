import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'RegisterPage.dart';
import 'MenuPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/users/login'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 220, 239, 166),
              const Color.fromARGB(255, 8, 15, 18),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Raju Ratna Cafeteria',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(217, 16, 17, 17),
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Welcome Buddy',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: const Color.fromARGB(247, 33, 28, 68),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 214, 239, 161),
                            ),
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()),
                              );
                            },
                            child: Text(
                              'Not registered? Click here',
                              style: TextStyle(
                                  color: const Color.fromRGBO(5, 6, 3, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
