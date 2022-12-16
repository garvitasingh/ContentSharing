import 'dart:async';
import 'dart:io';
import 'package:clg_content_sharing/Screen/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:clg_content_sharing/Common_Components/view_userProfile.dart';
import 'package:clg_content_sharing/provider/account_provider.dart';
import 'package:clg_content_sharing/utils/app_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ScrollController scrollController = ScrollController();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, w) {
      var viewData = ref.watch(accountProvider);
      var readData = ref.read(accountProvider);
      String role = viewData.AlluserData.role.toString();
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // leading: IconButton(
          //   onPressed: (){
          //     Navigator.pop(context);
          //   },
          //   icon: const Icon(Icons.arrow_back_ios_new),
          // ),
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => EditProfile(role: role)));
                },
                icon: const Icon(Icons.edit))
          ],
          centerTitle: true,
          elevation: 0,
          flexibleSpace:Container(
            decoration: const BoxDecoration(
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
          )
        ),
        body: SafeArea(
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              await readData.AlluserData;
              setState(() {});
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            const BoxShadow(
                              color: Constants.Icon_shadow,
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            )
                          ],
                          borderRadius: BorderRadius.vertical(
                            bottom:
                            Radius.elliptical(MediaQuery.of(context).size.width, 90.0),
                          ),
                          gradient: const LinearGradient(
                              colors: [
                                Constants.App_bar_blue,
                                Constants.App_bar_light,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.mirror),
                        ),
                        // child:
                      ),
                      Center(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // margin: EdgeInsets.symmetric(
                                  //   vertical: deviceHeight(context) * 0.05,
                                  // ),
                                  height: 100.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            "${Constants.imageUrl}/${viewData.AlluserData.profile}")),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${viewData.AlluserData.fName}',
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Role',
                              hintText: "${role}",
                              labelStyle: const TextStyle(fontSize: 20.0),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                              alignLabelWithHint: true,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                        (role == "student" || role == "teacher")
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: 70,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              child: TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Branch',
                                  hintText: "${viewData.AlluserData.branch}",
                                  labelStyle: const TextStyle(fontSize: 20.0),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: const OutlineInputBorder(),
                                  alignLabelWithHint: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            (role == "student")
                            ? Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              width: 150,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              child: TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Year',
                                  hintText: "${viewData.AlluserData.year}",
                                  labelStyle: const TextStyle(fontSize: 20.0),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: const OutlineInputBorder(),
                                  alignLabelWithHint: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                ),
                              ),
                            ): const SizedBox(width: 5,)
                          ],
                        )
                            : Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Specification',
                              hintText: "${viewData.AlluserData.specification}",
                              labelStyle: const TextStyle(fontSize: 20.0),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                              alignLabelWithHint: true,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Mobile',
                              hintText: "${viewData.AlluserData.mobile}",
                              labelStyle: const TextStyle(fontSize: 20.0),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                              alignLabelWithHint: true,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: "${viewData.AlluserData.email}",
                              labelStyle: const TextStyle(fontSize: 20.0),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                              alignLabelWithHint: true,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Roll Number',
                              hintText: "${viewData.AlluserData.rollNumber}",
                              labelStyle: const TextStyle(fontSize: 20.0),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                              alignLabelWithHint: true,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
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
  }

  Widget _sizedBox(){
    return const SizedBox(height: 20,);
  }
}
