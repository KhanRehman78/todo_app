import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_rebuild/auth_screens/signup_screen.dart';
import 'package:todo_rebuild/ui/navbar_screen.dart';
import 'package:todo_rebuild/utills/libraries.dart';

import 'forget_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _pwdcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const MyText(
                text: "Login",
                textColor: mainColor,
                fontsize: 32,
                fontWeight: FontWeight.bold,
              ),
              const MyText(
                text: "Welcome Back!",
                textColor: greytextColor,
                fontsize: 30,
              ),
              const SizedBox(
                height: 15,
              ),
              const MyText(
                text: "EmailAddress",
              ),
              CustomTextfield(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Email";
                  }
                  return null;
                },
                controller: _emailcontroller,
              ),
              const MyText(
                text: "Password",
              ),
              CustomTextfield(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter password";
                  }
                  return null;
                },
                obsecure: obsecure,
                suffIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obsecure = !obsecure;
                    });
                  },
                  child:
                      Icon(obsecure ? Icons.visibility : Icons.visibility_off),
                ),
                controller: _pwdcontroller,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetScreen()));
                      },
                      child: const MyText(
                        text: "Forgot Password?",
                        textColor: mainColor,
                      ))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              MyButton(
                onTap: () async {
                  try {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailcontroller.text.trim(),
                        password: _pwdcontroller.text.trim());
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: MyText(text: "Login Successfull")));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavbarScreen()));
                    _emailcontroller.clear();
                    _pwdcontroller.clear();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: MyText(text: e.toString())));
                  }
                },
                text: "Login",
                radius: 22,
                fontsize: 23,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyText(
                      text: "Don't have an account?",
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUPScreen()));
                        },
                        child: const MyText(
                          text: "SignUp",
                          textColor: mainColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
