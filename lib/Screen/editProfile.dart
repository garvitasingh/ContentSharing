import 'dart:async';
import 'dart:io';
import 'package:clg_content_sharing/Screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../provider/account_provider.dart';
import 'package:get/get.dart';

import '../utils/app_constant.dart';

class EditProfile extends StatefulWidget {
  var role;
  EditProfile({required this.role});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();

  final TextEditingController _rollNoController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _specificatoinController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _keyy = GlobalKey<FormState>();
  File? image;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(img!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
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
        body: Form(
          key: _keyy,
          child: Consumer(builder: (context, ref, w) {
            var viewData = ref.watch(accountProvider);
            var readData = ref.read(accountProvider);
            _fnameController.text = "${viewData.AlluserData.fName}";
            _lnameController.text = "${viewData.AlluserData.lName}";
            _emailController.text = "${viewData.AlluserData.email}";
            _rollNoController.text = "${viewData.AlluserData.rollNumber}";
            _mobileController.text = "${viewData.AlluserData.mobile}";
            _branchController.text = "${viewData.AlluserData.branch}";
            _yearController.text = "${viewData.AlluserData.year}";
            _passwordController.text = "${viewData.AlluserData.password}";
            // _specificatoinController.text = "${viewData.AlluserData.s}"
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: image != null
                              ? FileImage(image!)
                              : NetworkImage(
                                      "${Constants.imageUrl}/${viewData.AlluserData.profile}")
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 5,
                          right: 2,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: Colors.white,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(2, 4),
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 3,
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  size: 20,
                                ),
                                onPressed: () {
                                  getImage();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        controller: _fnameController,
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        controller: _lnameController,
                      ),
                    ),
                    widget.role == 'student' || widget.role == 'teacher'
                    ? Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        controller: _emailController,
                      ),
                    )
                        : const SizedBox(),
                    widget.role == 'student' ?
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Roll Number',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        controller: _rollNoController,
                      ),
                    ): const SizedBox(),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Mobile',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        controller: _mobileController,
                      ),
                    ),
                    (widget.role == "student" || widget.role == "teacher")
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 70,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Branch',
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                            ),
                            controller: _branchController,
                          ),
                        ),
                        (widget.role == "student")
                            ? Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          width: 150,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Year',
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                            ),
                            controller: _yearController,
                          ),
                        ): const SizedBox(width: 5,)
                      ],
                    )
                        : Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Specification',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        controller: _specificatoinController,
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        controller: _passwordController,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async{
                          var result = await ref.read(accountProvider)
                              .updateProfile(
                              fname: _fnameController.text,
                              lname: _lnameController.text,
                              email: _emailController.text,
                              photo: image ??= null,
                              roll_number: _rollNoController.text,
                              phone: _mobileController.text,
                              branch: _branchController.text,
                              year: _yearController.text,
                              role: widget.role,
                              specification: "",
                              pass: _passwordController.text,
                              profile: "${viewData.AlluserData.profile}"
                          );

                          if (result == Constants.SUCCESS) {
                            // ignore: use_build_context_synchronously
                            const CircularProgressIndicator();
                            Timer(const Duration(seconds: 5), () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => const ProfileScreen()));
                            });
                          }
                        },
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all(Constants.App_bar_light),
                          elevation: MaterialStateProperty.all(5)
                          // backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                        ),
                        child: const Text("Update"))
                  ],
                ),
              ),
            );
          }),
        ),
    );
  }
}
