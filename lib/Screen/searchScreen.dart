import 'package:clg_content_sharing/Screen/HostScreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/group_provider.dart';
import '../utils/app_constant.dart';


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
    var readGroupData = ref.read(groupProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            Container(
              height: 50,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                children: const [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ),
                  TextField(
                    // onChanged: (String s){
                    //   setState(() {
                    //     _searchIndexList = [];
                    //
                    //   });
                    // },
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
