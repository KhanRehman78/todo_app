import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_rebuild/entities/user_entity.dart';
import 'package:todo_rebuild/ui/navbar_screen.dart';
import 'package:todo_rebuild/utills/libraries.dart';

import 'login_screen.dart';

class SignUPScreen extends StatefulWidget {
  SignUPScreen({super.key});

  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _pwdcontroller = TextEditingController();
  TextEditingController _confirmpwdcontroller = TextEditingController();
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
                text: "Sign UP",
                textColor: mainColor,
                fontsize: 32,
                fontWeight: FontWeight.bold,
              ),
              const MyText(
                text: "Welcome!",
                textColor: greytextColor,
                fontsize: 30,
              ),
              const SizedBox(
                height: 15,
              ),
              const MyText(
                text: "Full Name",
              ),
              CustomTextfield(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter your name";
                  }
                  return null;
                },
                controller: _namecontroller,
              ),
              const MyText(
                text: "EmailAddress",
              ),
              CustomTextfield(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter your Email";
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
                    return "Please Enter your Password";
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
                  child: Icon(
                      obsecure ? Icons.remove_red_eye : Icons.visibility_off),
                ),
                controller: _pwdcontroller,
              ),
              const MyText(
                text: "Confirm Password",
              ),
              CustomTextfield(
                validator: (value) {
                  if (value != _pwdcontroller.text.trim()) {
                    return "Password didn't match";
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
                  child: Icon(
                      obsecure ? Icons.remove_red_eye : Icons.visibility_off),
                ),
                controller: _confirmpwdcontroller,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              MyButton(
                  text: "Sign UP",
                  radius: 22,
                  fontsize: 23,
                  onTap: () async {
                    try {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _emailcontroller.text.trim(),
                          password: _pwdcontroller.text.trim());
                      String userId = FirebaseAuth.instance.currentUser!.uid;
                      UserEntity userEntity = UserEntity(
                        email: _emailcontroller.text.trim(),
                        name: _namecontroller.text.trim(),
                        uid: userId,
                      );
                      await UserEntity.doc(userId: userId).set(userEntity);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Data Added Successfully")));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())));
                    }
                    setState(() {});
                  }),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyText(
                      text: "Already have an account?",
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: const MyText(
                          text: "Login",
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
