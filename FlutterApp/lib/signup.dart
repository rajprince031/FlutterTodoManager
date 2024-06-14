import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/config.dart';

import 'login.dart';
import 'package:http/http.dart' as http;

class TodoSignUpPage extends StatefulWidget {
  @override
  State<TodoSignUpPage> createState() => _TodoSignUpPageState();
}

class _TodoSignUpPageState extends State<TodoSignUpPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    bool isNotValidate = false;

    void registerUser() async {
      if(email.text.isNotEmpty && password.text.isNotEmpty){
        var regBody = {
          "email" : email.text,
          "password" : password.text,
        };

        var response = await http.post(Uri.parse(registration),
        headers : {"Content-Type":"application/json"},
        body : jsonEncode(regBody)
        );

        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['status']);
        if(jsonResponse['status']){
          // // Navigator.push(context,MaterialPageRoute(builder:(context){
          // //   return TodoLoginPage();
          //
          // }));
          showDialog(
              context:context,
              builder:(BuildContext context){
                return AlertDialog(
                    title:Text('Registration Successful'),
                    actions : [
                      ElevatedButton(
                          child:Text('login'),
                          onPressed:(){
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder:(context){
                                  return TodoLoginPage();
                                }
                                ),
                                    (Route<dynamic> route) => false

                            );
                            setState((){});
                          }
                      )
                    ]
                );
              }
          );
        }else{
          print('something went wrong');
        }
      }else{
        setState((){
          isNotValidate = true;
        });

      }

    }



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
                controller :email,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(fontSize:10),
                  errorStyle:TextStyle(fontSize:8),
                  errorText: isNotValidate ? "Enter valid email" : null,
                  border: OutlineInputBorder(),
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
                controller : password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(fontSize:10),
                  errorStyle:TextStyle(fontSize:8),
                  errorText: isNotValidate ? "Enter valid password" : null,
                  border: OutlineInputBorder(),
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
            SizedBox(height : screenHeight * 0.05),
            ElevatedButton(
              onPressed: () {
                registerUser();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                onPrimary: Colors.white,
                minimumSize: Size(screenWidth * 0.8, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Sign up'),
            ),
            SizedBox(height: screenHeight * 0.02),
            TextButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return TodoLoginPage();
                }));
              },
              child: Text(
                'Already have an account? Log in',
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

          )
      ),
    );
  }
}