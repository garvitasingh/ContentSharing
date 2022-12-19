import 'dart:io';

import 'package:clg_content_sharing/Common_Components/view_userProfile.dart';
import 'package:clg_content_sharing/Screen/aboutUs.dart';
import 'package:clg_content_sharing/Screen/contactUs.dart';
import 'package:clg_content_sharing/Screen/login_page.dart';
import 'package:clg_content_sharing/Screen/notification.dart';
import 'package:clg_content_sharing/Screen/privactPolicy.dart';
import 'package:clg_content_sharing/Screen/profile.dart';
import 'package:clg_content_sharing/Screen/termCondition.dart';
import 'package:clg_content_sharing/provider/account_provider.dart';
import 'package:clg_content_sharing/provider/group_provider.dart';
import 'package:clg_content_sharing/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'groupList.dart';
import 'members.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  ScrollController scrollController = ScrollController();

  File? image;
  File? adharImage;
  String? imagePath;
  bool _searchBoolean = false;

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _payoutController = TextEditingController();
  final TextEditingController _addMobilenumber = TextEditingController();

  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myGroup();
  }

  _myGroup() async {
    var viewUserData = ref.read(accountProvider);
    var myGroups = await ref
        .read(groupProvider)
        .myGroups(adminId: viewUserData.AlluserData.id.toString());
    var joinedGroupId = await ref
        .read(groupProvider)
        .joinedGroups(userId: viewUserData.AlluserData.id.toString());
    var readGroupData = ref.read(groupProvider);
    for (int i = 0; i < readGroupData.joinedGroupId.length; i++) {
      var joinedGroupDetail = await readGroupData.joinedGroupDetail(
          groupId: readGroupData.joinedGroupId[i].group_id.toString());
    }
  }

  final GlobalKey<FormState> _keyy = GlobalKey<FormState>();

  String? name;
  String? email;
  String? profile;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, w) {
      var viewUserData = ref.watch(accountProvider);
      var readUserData = ref.read(accountProvider);

      var viewGroupData = ref.watch(groupProvider);
      var readGroupData = ref.read(groupProvider);
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
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
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                margin: const EdgeInsets.only(bottom: 40.0),
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "${Constants.imageUrl}/${viewUserData.AlluserData.profile}"))),
                ),
                accountName: Text(
                  '${viewUserData.AlluserData.fName} ${viewUserData.AlluserData.lName}',
                  style: const TextStyle(color: Colors.black),
                ),
                accountEmail: Text(
                  '${viewUserData.AlluserData.mobile}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Members"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MemberScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_box_rounded),
                title: const Text("Profile"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: const Text("Contact Us"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactUs()));
                },
              ),
              ListTile(
                title: const Text("About Us"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AboutUs()));
                },
              ),
              ListTile(
                title: const Text("Privacy and Policy"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyPolicy()));
                },
              ),
              ListTile(
                title: const Text("Term and Conditions"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermCondition()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text("Log Out"),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Login_page()));
                },
              )
            ],
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              await readUserData.AlluserData;
              await readGroupData.myGroupData;
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewGroupData.myGroupData.length,
                        itemBuilder: ((context, index) {
                          return GroupList(
                            id: viewGroupData.myGroupData[index].id,
                            title: viewGroupData.myGroupData[index].title,
                            body: viewGroupData.myGroupData[index].body,
                            image: viewGroupData.myGroupData[index].image,
                            branch: viewGroupData.myGroupData[index].branch,
                            year: viewGroupData.myGroupData[index].year,
                            admin: viewGroupData.myGroupData[index].admin,
                          );
                        })),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.group_add_outlined),
        ),
      );
    });
  }

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        // setState(() {
        //   _searchIndexList = [];
        //   for (int i = 0; i < newsHeadlines.length; i++) {
        //     if (newsHeadlines[i].title.contains(s)) {
        //       _searchIndexList.add(i);
        //     }
        //   }
        // });
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction:
          TextInputAction.search, //Specify the action button on the keyboard
      decoration: const InputDecoration(
        //Style of TextField
        enabledBorder: UnderlineInputBorder(
            //Default TextField border
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            //Borders when a TextField is in focus
            borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search', //Text that is displayed when nothing is entered.
        hintStyle: TextStyle(
          //Style of hintText
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }
}