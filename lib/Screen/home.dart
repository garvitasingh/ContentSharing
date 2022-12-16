import 'dart:io';

import 'package:clg_content_sharing/Common_Components/view_userProfile.dart';
import 'package:clg_content_sharing/Screen/aboutUs.dart';
import 'package:clg_content_sharing/Screen/contactUs.dart';
import 'package:clg_content_sharing/Screen/privactPolicy.dart';
import 'package:clg_content_sharing/Screen/profile.dart';
import 'package:clg_content_sharing/Screen/termCondition.dart';
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
  ScrollController scrollController = ScrollController();

  File? image;
  File? adharImage;
  String? imagePath;
  bool _searchBoolean = false;

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
              elevation: 0,
              // backgroundColor: Colors.transparent,
              // toolbarHeight: MediaQuery.of(context).size.height / 4,
              flexibleSpace:Container(
                decoration: BoxDecoration(
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
              ),
              actions: !_searchBoolean
              ?[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchBoolean = true;
                    });
                  }),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ]
              :[
                IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchBoolean = false;
                      });
                    }),

              ],
            title: !_searchBoolean
                ? const Text(
              "Search in Feed",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            )
                : _searchTextField(),
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
                                "${Constants.imageUrl}/${viewData.AlluserData.profile}"))),
                  ),
                  accountName: Container(
                      child: Text(
                    '${viewData.AlluserData.fName} ${viewData.AlluserData.lName}',
                    style: const TextStyle(color: Colors.black),
                  )),
                  accountEmail: Container(
                      child: Text(
                    '${viewData.AlluserData.email}',
                    style: const TextStyle(color: Colors.black),
                  )),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  title: Text("Contact Us"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute
                          (builder: (context)=> const ContactUs()));
                  },
                ),
                ListTile(
                  title: Text("About Us"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute
                          (builder: (context)=> const AboutUs()));
                  },
                ),
                ListTile(
                  title: Text("Privacy and Policy"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute
                          (builder: (context)=> const PrivacyPolicy()));
                  },
                ),
                ListTile(
                  title: Text("Term and Conditions"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute
                          (builder: (context)=> const TermCondition()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout_rounded),
                  title: Text("Log Out"),
                  onTap: () {},
                )
              ],
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
                    children: const [
                      Text('Joined Group List'),
                      Divider(
                        height: 2,
                      ),
                      Text('Recommended Group List'),
                      // ListView.builder(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemCount: viewData.AlluserData.length,
                      //     itemBuilder: ((context, index) {
                      //       print(viewData.AlluserData.length);
                      //       name = viewData.AlluserData[index].fName;
                      //       email = viewData.AlluserData[index].email;
                      //       profile = viewData.AlluserData[index].profile;
                      //
                      //       return UserDeatails(
                      //           fname: viewData.AlluserData[index].fName
                      //               .toString(),
                      //           lname: viewData.AlluserData[index].lName
                      //               .toString(),
                      //           phone: viewData.AlluserData[index].mobile
                      //               .toString(),
                      //           email: viewData.AlluserData[index].email
                      //               .toString(),
                      //           user: viewData.AlluserData[index],
                      //           temp: false,
                      //           profile: viewData.AlluserData[index].profile
                      //               .toString(),
                      //           year:
                      //               viewData.AlluserData[index].year.toString(),
                      //           branch: viewData.AlluserData[index].branch
                      //               .toString(),
                      //           role:
                      //               viewData.AlluserData[index].role.toString(),
                      //           specification:
                      //               viewData.AlluserData[index].role.toString(),
                      //           index: index);
                      //     }))
                    ],
                  ),
                ),
              ),
            ),
          ));
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
