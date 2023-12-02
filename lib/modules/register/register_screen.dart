import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_exam/layout/home_layout.dart';
import 'package:shop_exam/modules/login/login_screen.dart';
import 'package:shop_exam/modules/register/cubit/register_cubit.dart';
import '../../shared/components/components.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  static String routName = 'registerScreen';
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit , RegisterStates>(
        listener: (context, state) {
          if(state is RegisterCreateSuccessStates){
            navigatAndRemove(context, LoginScreen.routName);
          }
          if(state is RegisterErrorStates){
            showToast(text: state.error, state: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:  ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    if(state is RegisterLodingStates)
                      LinearProgressIndicator(),
                    // Register text
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Register now to browse our hot offers',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultTextFormFiled(
                            hintText: 'Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            prefixIcon: Icons.perm_identity,
                            controller: nameController,
                            inputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormFiled(
                            hintText:'Phone number' ,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            prefixIcon: Icons.phone,
                            controller: phoneController,
                            inputType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormFiled(
                            hintText: 'Email Address',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address';
                              }
                              return null;
                            },
                            prefixIcon: Icons.email_outlined,
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultPasswordTextFormFiled(
                            hintText: 'Password',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                            prefixIcon: Icons.lock_outline,
                            controller: passwordController,
                            inputType: TextInputType.visiblePassword,
                            suffixIcon: RegisterCubit.get(context).suffixIcon,
                            isPassword: RegisterCubit.get(context).isPassword,
                            onSuffixIcon: () {
                              RegisterCubit.get(context).changePasswordVisibility();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: state is! RegisterLodingStates,
                      builder: (context) => defaultButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                            print(emailController.text + passwordController.text);
                          }
                        },
                        text: 'Register',
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}
