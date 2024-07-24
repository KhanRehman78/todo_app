import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:todo_rebuild/entities/add_task_entity.dart';
import 'package:todo_rebuild/utills/libraries.dart';

class TodayTasks extends StatefulWidget {
  const TodayTasks({super.key});

  @override
  State<TodayTasks> createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {
  Stream<QuerySnapshot<AddTaskEntity>> newTask = AddTaskEntity.collection()
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: newTask,
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
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return MyText(
              text: "No Record Found",
            );
          }
          List<DocumentSnapshot<AddTaskEntity>> todayTask =
          snapshot.data!.docs.where((doc) {
            AddTaskEntity data = doc.data();
            DateTime taskDate = data.dateTime!;
            DateTime now = DateTime.now();
            return taskDate.year == now.year &&
                taskDate.month == now.month &&
                taskDate.day == now.day;
          }).toList();
          return ListView.builder(
              itemCount: todayTask.length,
              itemBuilder: (context, index) {
                AddTaskEntity? data = todayTask[index].data();
                String formattedDate = DateFormat('dd/MM/yyyy').format(data!.dateTime!); // Format the date
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
                                  image: DecorationImage(image: NetworkImage(data!.image!),fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(11)),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: data.taskName,
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
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete_forever_outlined,
                                        size: 32,
                                      )),
                                  data.isCompleted == false?
                                  MyText(
                                    text: 'Pending',
                                    fontWeight: FontWeight.bold,
                                  ):MyText(
                                    text: 'Completed',
                                    fontsize: 12,
                                    textColor: Colors.green,
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
