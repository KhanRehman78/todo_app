import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_rebuild/auth_screens/login_screen.dart';
import 'package:todo_rebuild/firebase_options.dart';
import 'package:todo_rebuild/ui/navbar_screen.dart';
// import 'firebase_options.dart';
import 'notification_controller.dart';
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   runApp(MyApp());
   await AwesomeNotifications().initialize(null, [
     NotificationChannel(
         channelGroupKey: "basic_notify_group",
         channelKey: "basic_notify",
         channelName: "First notification",
         channelDescription: "First notification test"),
   ], channelGroups: [
     NotificationChannelGroup(
         channelGroupKey: "basic_notify_group",
         channelGroupName: "First notification")
   ]);
   bool isAllowedToSendNotification =
   await AwesomeNotifications().isNotificationAllowed();
   if (!isAllowedToSendNotification) {
     AwesomeNotifications().requestPermissionToSendNotifications();
   }
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onDismissActionReceivedMethod:
      NotificationController.onDismissActionReceivedMethod,
      onNotificationCreatedMethod:
      NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
      NotificationController.onNotificationDisplayedMethod,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckUser(),
    );
  }

   CheckUser(){
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return NavbarScreen();
    }else{
      return LoginScreen();
    }

  }
}