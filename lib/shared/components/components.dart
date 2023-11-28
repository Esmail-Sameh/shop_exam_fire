import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextFormFiled({
  required String hintText,
  required IconData prefixIcon,
  IconData? suffixIcon,
  required String? Function(String?)? validator,
  Function(String)? onSubmitted,
  required TextEditingController controller,
  bool isPassword = false,
  Function()? onSuffixIcon,
  required TextInputType inputType,
}) =>
    TextFormField(
      textAlign: TextAlign.center,
      obscureText: isPassword,
      decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: onSuffixIcon,
          ),
          prefixIconColor: Colors.indigo[200],
          suffixIconColor: Colors.indigo[200],
          fillColor: Colors.grey[150],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade200),
          )),
      validator: validator,
      onFieldSubmitted: onSubmitted,
      keyboardType: inputType,
      controller: controller,
    );

Widget defaultPasswordTextFormFiled({
  required String hintText,
  required IconData prefixIcon,
  IconData? suffixIcon,
  required String? Function(String?)? validator,
  Function(String)? onSubmitted,
  required TextEditingController controller,
  required bool isPassword ,
  Function()? onSuffixIcon,
  required TextInputType inputType,
}) =>
    TextFormField(
      textAlign: TextAlign.center,
      obscureText: isPassword,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          hintText: hintText,

          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: onSuffixIcon,
          ),
          prefixIconColor: Colors.indigo[200],
          suffixIconColor: Colors.indigo[200],
          fillColor: Colors.grey[150],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: IconButton(
           icon: Icon(prefixIcon),
           onPressed: onSuffixIcon,
          ),

      ),
      keyboardType: inputType,
    );

////////////////////////////////////////////////////////////

void navigatAndRemove(BuildContext context, String routName) =>
    Navigator.pushReplacementNamed(context, routName);

void navigatTo(BuildContext context, String routName) =>
    Navigator.pushNamed(context, routName);

Widget defaultButton({
  required void Function()? onPressed,
  required String text,
}) =>
    Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

Widget defaultTextButton(
    {required Function()? onPressed, required String text}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(text.toUpperCase()),
    );

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

//enum toast color
enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
