import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_exam/modules/login/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData prefixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    prefixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangeVisibilityStates());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLodingStates());
    FirebaseAuth.instance
      .signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      // print(value.user!.email);
      // print(value.user!.uid);
      emit(LoginSuccessStates(uId: value.user!.uid));
    }).catchError((error){
      emit(LoginErrorStates(error.toString()));
    });
  }
}
