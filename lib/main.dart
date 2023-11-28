import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_exam/modules/login/login_screen.dart';

import 'modules/register/register_screen.dart';
import 'observer.dart';


void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
Bloc.observer = MyBlocObserver();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Colors.white,
        ),
        fontFamily: 'janna'
      ),
      initialRoute: LoginScreen.routName,
      routes: {
        LoginScreen.routName : (context) => LoginScreen(),
        RegisterScreen.routName : (context) => RegisterScreen(),
      },


    );
  }

}