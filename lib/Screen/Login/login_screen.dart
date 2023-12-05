import 'package:e_commerceitsharks/Cubits/Auth/auth_cubit.dart';
import 'package:e_commerceitsharks/Screen/Login/login_screen.dart';
import 'package:e_commerceitsharks/Screen/Register/register_screen.dart';
import 'package:e_commerceitsharks/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Network/Local/CashHelper.dart';
import '../HomeLayout/home_layout.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  var formkey = GlobalKey<FormState>();



  String? validPassword(String? value){
    if(value!.isEmpty){
      return 'Please Enter Your Password';
    }
  }

  String? validEmail(String? value){
    if(value!.isEmpty){
      return 'Please Enter Your Email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is LoginSuccess){
            if(state.state){
              var sncakBar = buildSnackBar2(
                num: 1,
                title: 'Success Process',
                message: state.message,
              );
              ScaffoldMessenger.of(context).showSnackBar(sncakBar);
              navigateTo(context, HomeLayout());
              CashHelper.putData(key: 'token', value: state.token);
            }
            else {
              var sncakBar = buildSnackBar2(
                num: 0,
                title: 'Fail Process',
                message: state.message,
              );
              ScaffoldMessenger.of(context).showSnackBar(sncakBar);
            }
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35, top: 30),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: emailController,
                                  validator: validEmail,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      labelText: "Email",
                                      labelStyle: TextStyle(color: Colors.white),
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: passwordController,
                                  validator: validPassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      labelText: "Password",
                                      labelStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    state is LoginLoading? buildLoadingWidget():
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Color(0xff4c505b),
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            if(formkey.currentState!.validate()){
                                              cubit.postLogin(
                                                password: passwordController.text,
                                                email: emailController.text,
                                              );
                                             // navigateTo(context, HomeLayout());
                                            }
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward,
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        navigateTo(context, RegisterScreen());
                                      },
                                      child: Text(
                                        'Sign up',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: Colors.white,
                                            fontSize: 18
                                        ),
                                      ),
                                      style: ButtonStyle(),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}