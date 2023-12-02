import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_exam/layout/home_layout.dart';
import 'package:shop_exam/modules/login/login_screen.dart';
import 'package:shop_exam/shared/components/constants.dart';
import 'package:shop_exam/shared/network/local/cache_helper.dart';
import 'package:shop_exam/shared/styles/themes.dart';
import 'modules/register/register_screen.dart';
import 'shared/cubit/app_cubit/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  print("uId: ${uId}");
  Widget? widget;

  if(uId != null){
    widget = HomeLayout();
  }else{
    widget = LoginScreen();
  }


  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,

     home: startWidget,
      routes: {
        LoginScreen.routName: (context) => LoginScreen(),
        RegisterScreen.routName: (context) => RegisterScreen(),
        HomeLayout.routName: (context) => HomeLayout(),
      },
    );
  }
}
