import 'package:flutter/material.dart';
import 'package:todo/signup.dart';
import 'config.dart';
import 'dart:convert';
import 'Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TodoLoginPage extends StatefulWidget {
  @override
  State<TodoLoginPage> createState() => _TodoLoginPageState();
}

class _TodoLoginPageState extends State<TodoLoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isValidate = false;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void isLogin() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      var reqBody = {
        "email": email.text,
        "password": password.text,
      };

      var response = await http.post(Uri.parse(login),
        body: jsonEncode(reqBody),
        headers: {'content-type': 'application/json'},
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) {
            return dashboard(token: myToken);
          }),
                (Route<dynamic> route) => false
        );
      } else {
        print('something is wrong');
      }
    } else {
      setState(() {
        isValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          child :Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),
              Text("TODO APPs",style:TextStyle(
                  fontSize:60,color:Colors.white,fontWeight:FontWeight.bold
              )
              ),
              SizedBox(height: screenHeight * 0.05),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.8,
                ),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    errorText: isValidate? 'Please filled this field' : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(12),
                    prefixIcon: Icon(Icons.email),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[700]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.8,
                ),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    errorText: isValidate? 'Enter password was incorrect' : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(12),
                    prefixIcon: Icon(Icons.lock),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[700]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              ElevatedButton(
                onPressed: isLogin,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[700],
                  onPrimary: Colors.white,
                  minimumSize: Size(screenWidth * 0.8, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Log in'),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return TodoSignUpPage();
                    }),
                  );
                },
                child: Text(
                  'Don\'t have an account? Sign up',
                  style: TextStyle(
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ],
          ),
          width : double.infinity,
          height : double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

          ),
        )

    );
  }
}