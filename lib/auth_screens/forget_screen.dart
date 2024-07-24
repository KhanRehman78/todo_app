import 'package:flutter/cupertino.dart';
import 'package:todo_rebuild/utills/libraries.dart';
class ForgetScreen extends StatelessWidget {
  TextEditingController _emailcontroller = TextEditingController();
   ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const MyText(
              text: "Forgot Password",
              textColor: mainColor,
              fontsize: 35,
              fontWeight: FontWeight.bold,
            ),
            const MyText(text: "Email Address",),
            CustomTextfield(controller: _emailcontroller,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            MyButton(
              onTap: (){},
              text: "Send",fontsize: 22,radius: 15,
            )
          ],
        ),
      ),
    );
  }
}
