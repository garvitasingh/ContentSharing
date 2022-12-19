import 'package:clg_content_sharing/Screen/groupDetail.dart';
import 'package:clg_content_sharing/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/group_provider.dart';

class GroupList extends ConsumerStatefulWidget {
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
  ConsumerState<GroupList> createState() => _GroupListState();
}

class _GroupListState extends ConsumerState<GroupList> {

bool _isJoined = false;
bool _isAdmin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commonGroup();
  }

  commonGroup() async{
    var viewGroupData = ref.watch(groupProvider);
    if(viewGroupData.joinedGroupId.contains(widget.id)){
      print("joined");
      _isJoined = false;
    }
    else{
      _isJoined = true;
    }
    // if(viewGroupData.myGroupData.)
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      color: Constants.Icon_shadow,
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const GroupDetail()));
        },
        title: Text(widget.title!),
        subtitle: Text(widget.body!),
        leading: Container(
          height: 40,
          width: 40,
          child: CachedNetworkImage(
            imageUrl: "${Constants.GroupImage}/${widget.image!}",
            placeholder: (context,url) => const CircularProgressIndicator(),
            errorWidget: (context,url,error) => new Icon(Icons.error),
          ),
        ),
        trailing:_isJoined
            ? ElevatedButton(
          child: Text("Join"),
          onPressed: (){},
        ) : _isAdmin?
            SizedBox(width: 1,)
            :Icon(Icons.shield_sharp)
      ),
    );
  }
}
