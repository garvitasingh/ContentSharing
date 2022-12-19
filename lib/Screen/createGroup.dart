import 'package:clg_content_sharing/Screen/HostScreen.dart';
import 'package:clg_content_sharing/Screen/home.dart';
import 'package:clg_content_sharing/provider/account_provider.dart';
import 'package:clg_content_sharing/provider/group_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import '../utils/app_constant.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerBody = TextEditingController();
  File? image;
  String? imagePath;
  final GlobalKey<FormState> _keyy = GlobalKey<FormState>();
  String year = "1";
  String branch = "CSE";
  var loading=false;
  ScrollController scrollController = ScrollController();
  var years = ['All','1','2','3','4'];
  var branches = ['All','CSE', 'EE', 'EL'];
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(img!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, w){
      return Scaffold(
        appBar: AppBar(
          title: Text("Create New Group"),
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 40,),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: image != null
                          ? FileImage(image!)
                          : const NetworkImage(
                          "https://www.kindpng.com/picc/m/30-302589_blue-community-icon-hd-png-download.png")
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
                SizedBox(height: 40,),
                Container(
                  margin: const EdgeInsets.only(
                      right: 20, left: 20, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors.black87, width: 1),
                        ),
                        hintText: "Title"
                      // border: BorderSide(color: Colors.black,width: 1),
                    ),
                    controller: _controllerTitle,
                    textAlign: TextAlign.start,
                    validator: (value){
                      if(value == null){
                        return "Please Enter Title";
                      }
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      child: DropdownButton(
                        dropdownColor: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                        value: year,
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        items: years.map((String item){
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                            alignment: Alignment.center,
                          );
                        }).toList(),
                        onChanged: (String? value){
                          setState(() {
                            year = value!;
                          });
                        },
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      child: DropdownButton(
                        dropdownColor: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                        value: branch,
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        items: branches.map((String item){
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                            alignment: Alignment.center,
                          );
                        }).toList(),
                        onChanged: (String? value){
                          setState(() {
                            branch = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Container(
                  margin: const EdgeInsets.only(
                      right: 20, left: 20, bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors.black87, width: 1),
                        ),
                        hintText: "Description"
                      // border: BorderSide(color: Colors.black,width: 1),
                    ),
                    controller: _controllerBody,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  child: loading == true
                      ?Text("Waiting")
                      :Text("Create"),
                    onPressed: () async{
                    loading = false;
                    var result = await ref.read(groupProvider).createGroup(
                      title: _controllerTitle.text,
                      description: _controllerBody.text,
                      branch: branch,
                      year: year,
                      adminId: ref.read(accountProvider).AlluserData.id.toString(),
                      image: image
                    );

                    if(result == Constants.SUCCESS){
                      CircularProgressIndicator();
                      Timer(const Duration(seconds: 6), () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      });
                    }
                    },
                ),

              ],
            ),
          ),
        ),
      );
    });
  }
}
