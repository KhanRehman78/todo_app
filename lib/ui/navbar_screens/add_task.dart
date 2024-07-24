import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_rebuild/entities/add_task_entity.dart';
import 'package:todo_rebuild/ui/navbar_screen.dart';
import 'package:todo_rebuild/utills/libraries.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController _Tasknamecontroller = TextEditingController();
  TextEditingController _datecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? getUrl;
  bool isLoading = false;
  static const spinkit = SpinKitFadingCircle(
    color: Colors.white,
    size: 50.0,
  );

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
              text: "Add Task",
              textColor: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    imagePicker != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(imagePicker!.absolute),
                            radius: 60,
                            backgroundColor: greytextColor,
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundColor: greytextColor,
                          ),
                    Positioned(
                      right: 12,
                      bottom: 6,
                      child: InkWell(
                        onTap: getImage,
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
                text: "Task Name",
              ),
              CustomTextfield(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Task Name";
                  }
                  return null;
                },
                controller: _Tasknamecontroller,
              ),
              const MyText(
                text: "Date Time",
              ),
              CustomTextfield(
                controller: _datecontroller,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (isLoading) return;
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      if (imagePicker == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: MyText(
                          text: "Please Select image",
                        )));
                        return;
                      }
                      if (!_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: MyText(
                          text: "Please Filled The Fields",
                        )));
                        return;
                      }
                      String currentUser =
                          FirebaseAuth.instance.currentUser!.uid;
                      String taskId = AddTaskEntity.collection().doc().id;
                      if (imagePicker != null) {
                        await FirebaseStorage.instance
                            .ref("taskImage")
                            .child(taskId)
                            .putFile(imagePicker!);
                        getUrl = await FirebaseStorage.instance
                            .ref("taskImage")
                            .child(taskId)
                            .getDownloadURL();
                      }
                      AddTaskEntity addTaskEntity = AddTaskEntity(
                        dateTime: DateTime.now(),
                        taskName: _Tasknamecontroller.text.trim(),
                        taskId: taskId,
                        userId: currentUser,
                        image: getUrl,
                      );
                      await AddTaskEntity.doc(taskId: taskId)
                          .set(addTaskEntity);
                      setState(() {
                        _Tasknamecontroller.clear();
                        imagePicker = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: MyText(text: "Data Added Successfully")));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavbarScreen()));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: MyText(
                        text: e.toString(),
                      )));
                    } finally {
                      isLoading = false;
                    }
                    AwesomeNotifications().createNotification(
                        content: NotificationContent(
                            id: 323,
                            channelKey: "basic_notify",
                            title: "Khan Rehman",
                            body: "Task Added successfully"));
                  },
                  child: isLoading
                      ? spinkit
                      : MyText(
                          text: "Add",
                          fontsize: 22,
                          textColor: Colors.white,
                        ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff01AFF0))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  File? imagePicker;

  getImage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        imagePicker = File(imagePicked.path);
      });
    }
  }
}
