import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, w){
      return Scaffold(
        appBar: AppBar(
          title: Text("Create New Group"),
        ),
        body: Text("dd"),
      );
    });
  }
}
