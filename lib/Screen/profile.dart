import 'dart:async';
import 'dart:io';
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
  File? image;
  File? adharImage;
  String? imagePath;
  ScrollController scrollController = ScrollController();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  String? name;
  String? email;
  String? profile;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, w) {
      var viewData = ref.watch(accountProvider);
      var readData = ref.read(accountProvider);

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height / 4,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom:
                    Radius.elliptical(MediaQuery.of(context).size.width, 150.0),
              ),
              gradient: const LinearGradient(
                  colors: [
                    Constants.App_bar_blue,
                    Constants.App_bar_light,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    "${Constants.imageUrl}/${viewData.AlluserData.profile}")
              ),
            ),
          ),
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   // margin: EdgeInsets.symmetric(
                    //   //   vertical: deviceHeight(context) * 0.05,
                    //   // ),
                    //   height: 120.0,
                    //   width: 100.0,
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         fit: BoxFit.fill,
                    //         image: NetworkImage(
                    //             "${Constants.imageUrl}/${viewData.AlluserData.profile}")),
                    //     shape: BoxShape.rectangle,
                    //   ),
                    // ),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          shadows: <Shadow>[
                            BoxShadow(
                              color: Constants.Icon_shadow,
                              spreadRadius: 4,
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: Constants.Icon_shadow,
                              spreadRadius: -4,
                              blurRadius: 5,
                            )
                          ],
                          size: 25,
                          color: Constants.ICON,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Role : ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${viewData.AlluserData.fName}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rate_outlined,
                          shadows: <Shadow>[
                            BoxShadow(
                              color: Constants.Icon_shadow,
                              spreadRadius: 4,
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: Constants.Icon_shadow,
                              spreadRadius: -4,
                              blurRadius: 5,
                            )
                          ],
                          size: 25,
                          color: Constants.ICON,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Ratting : ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${viewData.AlluserData.lName}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.work,
                            shadows: <Shadow>[
                              BoxShadow(
                                color: Constants.Icon_shadow,
                                spreadRadius: 4,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Constants.Icon_shadow,
                                spreadRadius: -4,
                                blurRadius: 5,
                              )
                            ],
                            size: 20,
                            color: Constants.ICON),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Designation : ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${viewData.AlluserData.branch}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.interests,
                            shadows: <Shadow>[
                              BoxShadow(
                                color: Constants.Icon_shadow,
                                spreadRadius: 4,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Constants.Icon_shadow,
                                spreadRadius: -4,
                                blurRadius: 5,
                              )
                            ],
                            size: 25,
                            color: Constants.ICON),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Roll no : ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${viewData.AlluserData.rollNumber}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.assured_workload,
                            shadows: <Shadow>[
                              BoxShadow(
                                color: Constants.Icon_shadow,
                                spreadRadius: 4,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Constants.Icon_shadow,
                                spreadRadius: -4,
                                blurRadius: 5,
                              )
                            ],
                            size: 25,
                            color: Constants.App_bar_light),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Interest : ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${viewData.AlluserData.year}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.description,
                            shadows: <Shadow>[
                              BoxShadow(
                                color: Constants.Icon_shadow,
                                spreadRadius: 4,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Constants.Icon_shadow,
                                spreadRadius: -4,
                                blurRadius: 5,
                              )
                            ],
                            size: 20,
                            color: Constants.ICON),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Job Description : ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${viewData.AlluserData.mobile}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
