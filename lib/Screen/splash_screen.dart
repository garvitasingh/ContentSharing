import 'dart:async';

import 'package:clg_content_sharing/Screen/HostScreen.dart';
import 'package:clg_content_sharing/Screen/home.dart';
import 'package:clg_content_sharing/Screen/login_page.dart';
import 'package:clg_content_sharing/provider/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final storage = const FlutterSecureStorage();
  void getUserInfo() async {
    Timer(const Duration(seconds: 2), () async {
      String? username = await storage.read(key: "username");
      String? password = await storage.read(key: "pass");

      print(password);

      if (username == "false" || username == null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Login_page()));
      } else {
        // ignore: use_build_context_synchronously

        final result = await ref.read(accountProvider).login(
              credential: username.toString(),
              pass: password.toString(),
              // role: accountRole.toString()
            );

        if (result == 'success') {
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => const HostScreen())),
              (route) => false);
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Invalid Credentials, User not Found!!")));
        }
      }
    });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo.png"), fit: BoxFit.fill),
                shape: BoxShape.circle),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Content Sharing",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w800),
          )
        ],
      )),
    );
  }
}
