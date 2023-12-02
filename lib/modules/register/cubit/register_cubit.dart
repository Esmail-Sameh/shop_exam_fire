import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_exam/models/user_model.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangeVisibilityStates());
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLodingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //print(value.user!.email);
      createUser(
        email: email,
        phone: phone,
        name: name,
        password: password,
        uId: value.user!.uid,
      );
      emit(RegisterSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorStates(error: error.toString()));
    });
  }

  void createUser({
    required String email,
    required String phone,
    required String name,
    required String password,
    required String uId,
  }) {
    UserModel model = UserModel(
        name: name,
        phone: phone,
        email: email,
        uId: uId,
        password: password,
        isEmailVerified: false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      emit(RegisterCreateSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterCreateErrorStates());
    });
  }

}
