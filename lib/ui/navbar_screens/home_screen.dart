import 'package:flutter/cupertino.dart';
import 'package:todo_rebuild/ui/navbar_screens/account_setting.dart';
import 'package:todo_rebuild/ui/tabbar_screens/all_task.dart';
import 'package:todo_rebuild/ui/tabbar_screens/completed.dart';
import 'package:todo_rebuild/ui/tabbar_screens/pending.dart';
import 'package:todo_rebuild/ui/tabbar_screens/today_tasks.dart';
import 'package:todo_rebuild/utills/libraries.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: AppBar(
              
              backgroundColor: mainColor,
              title: const MyText(
                text: "Home",
                textColor: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0), // Set the radius you want
                child: Container(
                  child: const TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(text: 'All Tasks'),
                      Tab(text: 'Today Task'),
                      Tab(text: 'Pending'),
                      Tab(text: 'Completed task'),
                    ],
                  ),
                ),
              ),
            ),

             Expanded(
                child: TabBarView(children: [
                  AllTasks(),
                  TodayTasks(),
                  PendingTask(),
                  CompletedTask(),
                ])),

          ],
        ),
      ),
    );
  }
}
