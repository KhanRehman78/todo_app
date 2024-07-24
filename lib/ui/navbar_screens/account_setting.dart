import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_rebuild/auth_screens/login_screen.dart';
import 'package:todo_rebuild/entities/user_entity.dart';
import 'package:todo_rebuild/models/theme_model.dart';
import 'package:todo_rebuild/ui/edit_profile.dart';
import 'package:todo_rebuild/utills/libraries.dart';

class AccountSetting extends StatefulWidget {
  AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  Stream<DocumentSnapshot<UserEntity>> getUserData =
      UserEntity.doc(userId: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();

  @override
  Widget build(BuildContext context) {
    // var ThemeChanger = Provider.of<themeChanger>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: AppBar(
            backgroundColor: mainColor,
            title: const MyText(
              text: "Account Settings",
              textColor: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: getUserData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: MyText(
                text: snapshot.error.toString(),
              ));
            }
            var userData = snapshot.data!.data();
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      userData!.profileImage != null
                          ? CircleAvatar(
                              radius: 45,
                              backgroundImage:
                                  NetworkImage(userData.profileImage!),
                              backgroundColor: greytextColor,
                            )
                          : CircleAvatar(
                              radius: 45,
                              backgroundColor: greytextColor,
                            ),
                      const SizedBox(
                        width: 9,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: userData.name,
                            fontWeight: FontWeight.bold,
                            fontsize: 22,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.edit),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditProfile(
                                                  updateEditProfile: userData,
                                                )));
                                  },
                                  child: const MyText(
                                    text: "Edit profile",
                                    textColor: mainColor,
                                    fontsize: 16,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Row(
                    children: [
                      Icon(Icons.pageview_outlined),
                      SizedBox(
                        width: 7,
                      ),
                      MyText(
                        text: "Terms & Conditions",
                        fontsize: 18,
                      )
                    ],
                  ),
                  const SizedBox(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.privacy_tip_rounded),
                      SizedBox(
                        width: 7,
                      ),
                      MyText(
                        text: "Privacy & Policy",
                        fontsize: 18,
                      )
                    ],
                  ),
                  const SizedBox(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.contact_phone),
                      SizedBox(
                        width: 7,
                      ),
                      MyText(
                        text: "Contact Us",
                        fontsize: 18,
                      )
                    ],
                  ),
                  const SizedBox(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.logout),
                      const SizedBox(
                        width: 7,
                      ),
                      GestureDetector(
                          onTap: () async{
                          await  FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: const MyText(
                            text: "Logout",
                            fontsize: 18,
                          ))
                    ],
                  ),
                  const SizedBox(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
