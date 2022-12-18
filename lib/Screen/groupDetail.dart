import 'package:flutter/material.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({Key? key}) : super(key: key);

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("gg"),
      ),
      body: Text("ff"),
      bottomSheet: Container(
        color: Colors.grey,
        child: Text("Ff"),
      ),
    );
  }
}
