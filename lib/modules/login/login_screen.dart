import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_exam/layout/home_layout.dart';
import 'package:shop_exam/modules/login/cubit/login_cubit.dart';
import 'package:shop_exam/modules/login/cubit/login_states.dart';
import 'package:shop_exam/shared/components/components.dart';
import 'package:shop_exam/shared/network/local/cache_helper.dart';

import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static String routName = 'loginScreen';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorStates) {
            showToast(text: state.error, state: ToastState.ERROR);
          }
          if(state is LoginSuccessStates){
            CacheHelper.savaData(
                key: 'uId',
                value: state.uId
            ).then((value){
              navigatAndRemove(context, HomeLayout.routName);
            });
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Login To Continue Using The App',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defaultTextFormFiled(
                              hintText: 'Email Address',
                              prefixIcon: Icons.email_outlined,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'this field must not be empty';
                                }
                              },
                              onSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  print('done');
                                }
                              },
                              controller: emailController,
                              isPassword: false,
                              inputType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultPasswordTextFormFiled(
                              hintText: 'Password',
                              prefixIcon: cubit.prefixIcon,
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'it should not be less than five';
                                }
                              },
                              onSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  print('done');
                                }
                              },
                              isPassword: cubit.isPassword,
                              onSuffixIcon: () {
                                cubit.changePasswordVisibility();
                                print(cubit.isPassword);
                              },
                              inputType: TextInputType.visiblePassword,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ConditionalBuilder(
                        condition: state is! LoginLodingStates,
                        builder: (context) =>  defaultButton(
                          onPressed: (){
                            if (formKey.currentState!.validate()) {
                              print('btn Login');
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'Login',
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                    ),

                   SizedBox(height: 10,),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text('Don\'t have an account ?'),
                        TextButton(
                          onPressed: () {
                            navigatTo(context, RegisterScreen.routName);
                          },
                          child: Text('RESISTER'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
