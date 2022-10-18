import 'dart:async';
import 'dart:io';

import 'package:clg_content_sharing/Screen/home.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get/get.dart';

import '../Commen_Components/commen_Textfield.dart';
import '../Commen_Components/commen_button.dart';
import '../provider/account_provider.dart';
import '../utils/app_constant.dart';

class Registration extends StatefulWidget {
  var role;
  Registration({required this.role});
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _height = Get.height;

  final _textTheme = Get.textTheme;

  ScrollController scrollController = ScrollController();

  File? image;
  File? adharFrontImage, adharBackImage;
  String? imagePath;
  bool temp = true;

  final TextEditingController _fNameController = TextEditingController();

  final TextEditingController _lNameController = TextEditingController();

  final TextEditingController _branchController = TextEditingController();

  final TextEditingController _rollnumController = TextEditingController();

  final TextEditingController _yearController = TextEditingController();

  final TextEditingController _specificationController =
      TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(img!.path);
    });
  }

  final GlobalKey<FormState> _keyy = GlobalKey<FormState>();

  //contrller for Google map

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _keyy,
        child: Consumer(builder: (context, ref, w) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: image != null
                            ? FileImage(image!)
                            : const NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQReKDfAvvCuxNIHCD4tZpodoS3tlQUVok7yQ&usqp=CAU")
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
                  _buildSizedBox(),
                  CommonTextField(
                    level: "FirstName",
                    controller: _fNameController,
                    hintText: 'FirstName',
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value!.trim().length < 3) {
                        return "Too short";
                      }
                    },
                  ),
                  _buildSizedBox(),
                  CommonTextField(
                    level: "LastName",
                    controller: _lNameController,
                    hintText: 'LastName',
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value!.trim().length < 1) {
                        return "Cannot be empty";
                      }
                    },
                  ),
                  widget.role == 'student' || widget.role == 'teacher'
                      ? _buildSizedBox()
                      : const SizedBox(),
                  widget.role == 'student' || widget.role == 'teacher'
                      ? CommonTextField(
                          level: "Email",
                          controller: _emailController,
                          hintText: 'Email',
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value!.trim().length < 1) {
                              return "Cannot be empty";
                            }
                          },
                        )
                      : const SizedBox(),
                  widget.role == 'student'
                      ? _buildSizedBox()
                      : const SizedBox(),
                  widget.role == 'student'
                      ? CommonTextField(
                          level: "RollNumber",
                          controller: _rollnumController,
                          hintText: 'RollNumber',
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value!.trim().length < 1) {
                              return "Cannot be empty";
                            }
                          },
                        )
                      : const SizedBox(),
                  _buildSizedBox(),
                  CommonTextField(
                    level: "Mobile",
                    controller: _mobileController,
                    hintText: 'Mobile',
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value!.trim().length < 1) {
                        return "Cannot be empty";
                      }
                    },
                  ),
                  widget.role == 'student' || widget.role == 'teacher'
                      ? _buildSizedBox()
                      : const SizedBox(),
                  widget.role == 'student' || widget.role == 'teacher'
                      ? CommonTextField(
                          level: "Branch",
                          controller: _branchController,
                          hintText: 'Branch',
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value!.trim().length < 1) {
                              return "Cannot be empty";
                            }
                          },
                        )
                      : const SizedBox(),
                  widget.role == 'student'
                      ? _buildSizedBox()
                      : const SizedBox(),
                  widget.role == 'student'
                      ? CommonTextField(
                          level: "Year",
                          controller: _yearController,
                          hintText: 'Year',
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value!.trim().length < 1) {
                              return "Cannot be empty";
                            }
                          },
                        )
                      : const SizedBox(),
                  widget.role == 'staff' ? _buildSizedBox() : const SizedBox(),
                  widget.role == 'staff'
                      ? CommonTextField(
                          level: "Specification",
                          controller: _specificationController,
                          hintText: 'Specification',
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value!.trim().length < 1) {
                              return "Cannot be empty";
                            }
                          },
                        )
                      : const SizedBox(),
                  _buildSizedBox(),
                  CommonTextField(
                    level: "Password",
                    controller: _passwordController,
                    hintText: 'Password',
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value!.trim().length < 1) {
                        return "Cannot be empty";
                      }
                    },
                  ),
                  _buildSizedBox(),
                  _buildSizedBox(),
                  _buildSizedBox(),
                  _buildSizedBox(),
                  CommonFatButton(
                      text: temp == true ? "Register" : "Waiting",
                      onPressed: () async {
                        temp == false;
                        var result = await ref
                            .read(accountProvider)
                            .registerUser(
                                pass: _passwordController.text,
                                roll_number: _rollnumController.text,
                                photo: image,
                                fname: _fNameController.text,
                                lname: _lNameController.text,
                                email: _emailController.text,
                                phone: _mobileController.text,
                                year: _yearController.text,
                                branch: _branchController.text,
                                specification: _specificationController.text,
                                role: widget.role.toString());

                        if (result == Constants.SUCCESS) {
                          // ignore: use_build_context_synchronously
                          const CircularProgressIndicator();
                          Timer(const Duration(seconds: 6), () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          });
                        }
                      }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSizedBox() {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.02);
  }
}
