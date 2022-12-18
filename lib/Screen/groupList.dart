import 'package:clg_content_sharing/Screen/groupDetail.dart';
import 'package:clg_content_sharing/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GroupList extends StatefulWidget {
  int? id;
  String? title, body , branch, year, admin;
  String? image;

  GroupList({
    required this.id,
    required this.title,
    required this.body,
    required this.branch,
    required this.year,
    required this.admin,
    this.image
});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      color: Constants.Icon_shadow,
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => GroupDetail()));
        },
        title: Text(widget.title!),
        subtitle: Text(widget.body!),
        leading: Container(
          height: 40,
          width: 40,
          child: CachedNetworkImage(
            imageUrl: "${Constants.GroupImage}/${widget.image!}",
            placeholder: (context,url) => CircularProgressIndicator(),
            errorWidget: (context,url,error) => new Icon(Icons.error),
          ),
        ),
        
      ),
    );
  }
}
