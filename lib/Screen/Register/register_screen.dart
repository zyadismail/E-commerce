import 'package:e_commerceitsharks/Cubits/Auth/auth_cubit.dart';
import 'package:e_commerceitsharks/Screen/Login/login_screen.dart';
import 'package:e_commerceitsharks/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_icons/awesome_icons.dart';

import '../../Network/Local/CashHelper.dart';
import '../../Shared/Widgets/TextField/text_form_field.dart';
import '../HomeLayout/home_layout.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool show = false;
  IconData icon = FontAwesomeIcons.eyeSlash;



  var formkey = GlobalKey<FormState>();
  
  String? validName(String? value){
    if(value!.isEmpty){
      return 'Please Enter Your Name';
    }
  }

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
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if(state is RegisterSuccess){
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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),

    child: Scaffold(
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
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: nameController,
                              validator: validName,
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
                                  labelText: "Name",
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
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
                              //style: TextStyle(color: Colors.white),
                              controller: passwordController,
                              validator: validPassword,
                              obscureText: show,
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
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        show = !show;
                                        if (show) {
                                          icon = FontAwesomeIcons.eye;
                                        } else {
                                          icon = FontAwesomeIcons.eyeSlash;
                                        }
                                      });
                                    },
                                    icon: Icon(icon,color: Colors.white,),),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),

                            ),

                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: phoneController,
                              validator: validPassword,
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
                                  labelText: "phone",
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
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                              state is RegisterLoading? buildLoadingWidget():
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        if(formkey.currentState!.validate() == true){
                                          cubit.postRegister(
                                              name: nameController.text,
                                              password: passwordController.text,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                          );
                                          //navigateTo(context, HomeLayout());
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
                                    navigateTo(context, LoginScreen());
                                  },
                                  child: Text(
                                    'Sign In',
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
              ),
    ),
        );

  },

);
  }
}