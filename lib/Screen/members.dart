import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clg_content_sharing/provider/account_provider.dart';

import '../utils/app_constant.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({Key? key}) : super(key: key);

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  late String _role;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, w) {
      var viewData = ref.watch(accountProvider);
      var readData = ref.read(accountProvider);
      _role = viewData.AlluserData.role.toString();
      return Scaffold(
        appBar: AppBar(
          title: const Text("Members"),
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
        body: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                TabBar(
                  tabs: _role == "student" || _role == "teacher"
                      ? [
                          const Tab(text: 'Class'),
                          const Tab(
                            text: 'Faculty',
                          ),
                        ]
                      : [
                          const Tab(text: 'Class'),
                          const Tab(
                            text: 'Faculty',
                          ),
                          const Tab(text: 'Staff'),
                          const Tab(
                            text: 'Admin',
                          ),
                        ],
                  // controller: _tabBarController,
                  // indicatorColor: Colors.blue,
                  indicator: const BoxDecoration(
                    color: Colors.white,
                    // border: Border(bottom: BorderSide(width: 1.5, color: Colors.blue))
                  ),
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black,
                  labelStyle: const TextStyle(fontSize: 20),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    children:
                        _role == "student" || _role == "teacher"
                        ? [
                      _Interests(),
                      _Interests(),
                    ] : [
                          _Interests(),
                          _Interests(),
                          _Interests(),
                          _Interests(),
                        ]
                  ),
                )
              ],
            )),
      );
    });
  }


  Widget _Interests() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAr,
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "https://images.unsplash.com/photo-1670968982568-51116a0770c0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1926&q=80",
                        )),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFCFCFD0)),
              ),
              Container(
                width: 160,
                child: const Text("Garvita Singh ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),

              Row(
                children: [
                  _role == "student"
                  ? const SizedBox(width: 30,)
                  : const SizedBox(width: 1,),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.message)),
                  _role=="student"
                      ? const SizedBox(width: 5,)
                      :IconButton(onPressed: (){}, icon: const Icon(Icons.delete))

                ],
              )
            ],
          );
        });
  }
}

