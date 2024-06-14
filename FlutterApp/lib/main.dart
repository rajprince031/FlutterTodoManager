import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dashboard.dart';
import 'login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(myApp(token: prefs.getString('token')));
}
class myApp extends StatelessWidget{

  final token;
  const myApp({
    @required
  this.token,
    Key? key,
}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (token != null && JwtDecoder.isExpired(token)==false)?dashboard(token: token):TodoLoginPage(),
    );
  }
}