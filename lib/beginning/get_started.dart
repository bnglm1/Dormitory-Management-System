import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:basic_started/screens/home.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordFocus = false;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      if (_passwordController.text.isNotEmpty) {
        setState(() {
          _isPasswordFocus = true;
        });
      } else {
        setState(() {
          _isPasswordFocus = false;
        });
      }
    });
  }

  void _login() {
    if (_usernameController.text.toLowerCase() == 'mehmet' &&
        _passwordController.text == '12345') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        _showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: _isPasswordFocus ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 500),
                      child: Image.asset(
                        'lib/assets/monkey.jpg',
                        height: 150,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _isPasswordFocus ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: Shake(
                        child: Image.asset(
                          'lib/assets/monkey_covering.jpg',
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                if (_showError)
                  Text(
                    'Kullanıcı adı veya şifre yanlış',
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: _login,
                  child: Text("Giriş Yap"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
