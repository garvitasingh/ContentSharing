import 'package:clg_content_sharing/Screen/HostScreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/group_provider.dart';
import '../utils/app_constant.dart';
import 'createGroup.dart';
import 'groupList.dart';


class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {

  List _searchIndexList = [];
  @override
  Widget build(BuildContext context) {

    var viewGroupData = ref.watch(groupProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            Container(
              height: 50,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 40,
                    width: 250,
                    child: TextField(
                      onChanged: (String s) async{
                        var searchGroupData = await ref.read(groupProvider)
                            .searchGroup(groupName: s);
                        // setState(() {
                        //   _searchIndexList = [];
                        //
                        // });
                      },
                      autofocus: true,
                          cursorColor: Colors.blue,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textInputAction:
                          TextInputAction.search, //Specify the action button on the keyboard
                          decoration: const InputDecoration(
                            //Style of TextField
                            enabledBorder: UnderlineInputBorder(
                              //Default TextField border
                                borderSide: BorderSide(color: Colors.black54)),
                            focusedBorder: UnderlineInputBorder(
                              //Borders when a TextField is in focus
                                borderSide: BorderSide(color: Colors.black54)),
                            hintText: 'Search', //Text that is displayed when nothing is entered.
                            hintStyle: TextStyle(
                              //Style of hintText
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            viewGroupData.searchedGroup.length == 0
            ? Container(
              alignment: Alignment.center,
              child: Text("Opps! No Group Found",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewGroupData.searchedGroup.length,
                itemBuilder: ((context, index) {
                  return GroupList(
                    id: viewGroupData.searchedGroup[index].id,
                    title: viewGroupData.searchedGroup[index].title,
                    body: viewGroupData.searchedGroup[index].body,
                    image: viewGroupData.searchedGroup[index].image,
                    branch: viewGroupData.searchedGroup[index].branch,
                    year: viewGroupData.searchedGroup[index].year,
                    admin: viewGroupData.searchedGroup[index].admin,
                  );
                })),
          ],
        ),
      ),
      floatingActionButton:
      FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=> CreateGroup()));
        },
        child: const Icon(Icons.group_add_outlined),
      ),
    );
  }
}
