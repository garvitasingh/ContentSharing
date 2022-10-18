import 'dart:io';

import 'package:clg_content_sharing/Commen_Components/view_userProfile.dart';
import 'package:clg_content_sharing/provider/account_provider.dart';
import 'package:clg_content_sharing/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ScrollController scrollController = ScrollController();

  ScrollController scrollController = ScrollController();

  File? image;
  File? adharImage;
  String? imagePath;

  TextEditingController _nameController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  TextEditingController _usernameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _payoutController = TextEditingController();
  TextEditingController _addMobilenumber = TextEditingController();

  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  GlobalKey<FormState> _keyy = GlobalKey<FormState>();

  String? name;
  String? email;
  String? profile;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, w) {
      var viewData = ref.watch(accountProvider);
      var readData = ref.read(accountProvider);

      return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text("Profile")),
          ),
          drawer: Drawer(
            child: Center(
              child: Column(children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  margin: const EdgeInsets.only(bottom: 40.0),
                  currentAccountPicture: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "${Constants.imageUrl}/${profile}"))),
                  ),
                  accountName: Container(
                      child: Text(
                    '${name}',
                    style: const TextStyle(color: Colors.black),
                  )),
                  accountEmail: Container(
                      child: Text(
                    '${email}',
                    style: const TextStyle(color: Colors.black),
                  )),
                )
              ]),
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
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: viewData.AlluserData.length,
                          itemBuilder: ((context, index) {
                            print(viewData.AlluserData.length);
                            name = viewData.AlluserData[index].fName;
                            email = viewData.AlluserData[index].email;
                            profile = viewData.AlluserData[index].profile;

                            return UserDeatails(
                                fname: viewData.AlluserData[index].fName
                                    .toString(),
                                lname: viewData.AlluserData[index].lName
                                    .toString(),
                                phone: viewData.AlluserData[index].mobile
                                    .toString(),
                                email: viewData.AlluserData[index].email
                                    .toString(),
                                user: viewData.AlluserData[index],
                                temp: false,
                                profile: viewData.AlluserData[index].profile
                                    .toString(),
                                year:
                                    viewData.AlluserData[index].year.toString(),
                                branch: viewData.AlluserData[index].branch
                                    .toString(),
                                role:
                                    viewData.AlluserData[index].role.toString(),
                                specification:
                                    viewData.AlluserData[index].role.toString(),
                                index: index);
                          }))
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }

  Widget _buildSizedBox() {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.02);
  }
}
