import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_rebuild/entities/user_entity.dart';
import 'package:todo_rebuild/utills/libraries.dart';

class EditProfile extends StatefulWidget {
  final UserEntity? updateEditProfile;

  EditProfile({super.key, this.updateEditProfile});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _fullnamecontroller =
      TextEditingController(text: widget.updateEditProfile!.name);
  String? getUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: AppBar(
            backgroundColor: mainColor,
            title: const MyText(
              text: "Edit Profile",
              textColor: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  imagePicker != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(imagePicker!.absolute),
                          backgroundColor: greytextColor,
                        )
                      : widget.updateEditProfile!.profileImage != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                  widget.updateEditProfile!.profileImage!),
                              backgroundColor: greytextColor,
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundColor: greytextColor,
                            ),
                  Positioned(
                    right: 12,
                    bottom: 6,
                    child: GestureDetector(
                      onTap: getimage,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: mainColor, shape: BoxShape.circle),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            const MyText(
              text: "Full Name",
            ),
            CustomTextfield(
              controller: _fullnamecontroller,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            MyButton(
              onTap: () async {
                if (imagePicker != null) {
                  await FirebaseStorage.instance
                      .ref('profileImage')
                      .child(widget.updateEditProfile!.uid!)
                      .putFile(imagePicker!);
                  getUrl = await FirebaseStorage.instance
                      .ref('profileImage')
                      .child(widget.updateEditProfile!.uid!)
                      .getDownloadURL();
                }
                await UserEntity.doc(userId: widget.updateEditProfile!.uid!)
                    .update({
                  'profileImage':getUrl ?? widget.updateEditProfile!.profileImage,
                  'name': _fullnamecontroller.text,
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: MyText(
                  text: "Update Successfully",
                )));
              },
              text: "Update",
              fontsize: 22,
              radius: 15,
            ),
          ],
        ),
      ),
    );
  }

  File? imagePicker;

  getimage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        imagePicker = File(imagePicked.path);
      });
    }
  }
}
