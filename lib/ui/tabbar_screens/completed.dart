import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:todo_rebuild/entities/add_task_entity.dart';
import 'package:todo_rebuild/utills/libraries.dart';

class CompletedTask extends StatefulWidget {
  CompletedTask({super.key});

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  Stream<QuerySnapshot<AddTaskEntity>> fetchCompleteTask =
      AddTaskEntity.collection()
          .where('isCompleted', isEqualTo: true)
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fetchCompleteTask,
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
          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: MyText(
              text: "No Data Found",
            ));
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                AddTaskEntity taskData = snapshot.data!.docs[index].data();
                String formattedDate = DateFormat('dd/MM/yyyy').format(taskData.dateTime!);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhysicalModel(
                    color: Colors.white,
                    shadowColor: Colors.black,
                    elevation: 18,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: Row(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11)),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: taskData.taskName,
                                ),
                                MyText(
                                  text: formattedDate,
                                  textColor: Colors.grey,
                                )
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        await AddTaskEntity.doc(
                                                taskId: taskData.taskId!)
                                            .delete();
                                        await FirebaseStorage.instance
                                            .ref('taskImage')
                                            .child(taskData.image!)
                                            .delete();
                                      },
                                      icon: Icon(
                                        Icons.delete_forever_outlined,
                                        size: 32,
                                      )),
                                  taskData.isCompleted == true
                                      ? MyText(
                                          text: 'Completed',
                                          fontWeight: FontWeight.bold,
                                          textColor: Colors.green,
                                        )
                                      : MyText(
                                          text: 'Pending',
                                          fontWeight: FontWeight.bold,
                                        )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
