import 'package:flutter/material.dart';

import '../utils/app_constant.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
        flexibleSpace:Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Constants.App_bar_blue,
                  Constants.App_bar_light,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.mirror),
          ),
        ),
        title: Text("Notification"),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Mark All As Read",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),),
                  IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.settings_outlined))
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index){
                  return Material(
                    color: const Color(0xFFD8E9FC),
                    child: ListTile(
                      shape: const Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                      leading: Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                            color: Color(0xFFCFCFD0)
                        ),
                      ),
                      trailing: const Icon(Icons.more_horiz,
                        color: Colors.black,),
                      subtitle: const Text("biggy goat responded!",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),),
                      title: const Text("*Name*  Posted in a Space you might like . 19 Oct",
                          style: TextStyle(
                            fontSize: 11,
                          )),
                    ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
