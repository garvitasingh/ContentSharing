import 'dart:convert';
import 'dart:io';
import 'package:clg_content_sharing/Models/group_model.dart';
import 'package:clg_content_sharing/Models/joinedGroup_model.dart';
import 'package:flutter/material.dart';
import 'package:clg_content_sharing/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:http_parser/http_parser.dart';

final groupProvider = ChangeNotifierProvider((ref) => GroupProvider());

class GroupProvider extends ChangeNotifier {

  List<GroupModel> myGroupData = [];

  Future<String> myGroups(
      {required String adminId}) async {
    notifyListeners();
    myGroupData.clear();
    String result = Constants.SUCCESS;

    Uri uri = Uri.parse("${Constants.baseUrl}/my-group");

    var body;
    body = {"admin": adminId};

    try {
      var response = await http.post(uri, body: body);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print(decodedData);
        for(int i =0; i<decodedData["Result"].length; i++){
          myGroupData.add(GroupModel.fromJson(decodedData["Result"][i]));
        }
        print("kkkk");
        notifyListeners();
        result = Constants.SUCCESS;

      } else {
        result = Constants.FAILED;
      }
    } catch (e) {
      result = Constants.FAILED;
    }

    notifyListeners();

    return result;
  }

  List<JoinedGroupModel> joinedGroupId = [];
  Future<String> joinedGroups(
  {required String userId}) async{
    notifyListeners();
    joinedGroupId.clear();
    String result = Constants.SUCCESS;

    Uri uri = Uri.parse("${Constants.baseUrl}/joinmy-group");

    var body;
    body = {"user_id": userId};

    try {
      var response = await http.post(uri, body: body);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print(decodedData);
        for(int i =0; i<decodedData["Result"].length; i++){
          var data = JoinedGroupModel.fromJson(decodedData["Result"][i]);
          if(joinedGroupId.contains(data)){
            null;
          }else{
            joinedGroupId.add(JoinedGroupModel.fromJson(decodedData["Result"][i]));
          }
        }
        print("kkkk");
        print(joinedGroupId[0].group_id);
        notifyListeners();
        result = Constants.SUCCESS;

      } else {
        result = Constants.FAILED;
      }
    } catch (e) {
      result = Constants.FAILED;
    }

    notifyListeners();

    return result;
  }

  Future<String> joinedGroupDetail(
  {required String groupId}) async{
    notifyListeners();

    String result = Constants.SUCCESS;

    Uri uri = Uri.parse("${Constants.baseUrl}/groupbyId/${groupId}");

    try {
      var response = await http.get(uri);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print(decodedData);
        for(int i =0; i<decodedData["Result"].length; i++){
          myGroupData.add(GroupModel.fromJson(decodedData["Result"][i]));
        }
        notifyListeners();
        result = Constants.SUCCESS;

      } else {
        result = Constants.FAILED;
      }
    } catch (e) {
      result = Constants.FAILED;
    }

    notifyListeners();

    return result;
  }

  Future<String> createGroup(
  {required String title,
    required String description,
    required String year,
    required String branch,
    required String adminId,
    File? image,
  }) async{
    notifyListeners();

    String result = Constants.SUCCESS;
    Uri uri = Uri.parse("${Constants.baseUrl}/createGroup");

    try {
      var request = http.MultipartRequest('POST', uri);
      request.fields['title'] = title;
      request.fields['body'] = description;
      request.fields['year'] = year;
      request.fields['branch'] = branch;
      request.fields['admin'] = adminId;

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('image',
          image.path,
          contentType: MediaType('profile', 'jpeg'),
        ));
      }
      request.send().then((response) async {
        print(response.statusCode);
        if (response.statusCode == 200) {
          var resulthttp = await http.Response.fromStream(response);
          var decodedData = JSON.jsonDecode(resulthttp.body);

          if (decodedData["Result"] == "Group Created!") {
            result = Constants.SUCCESS;
            print(result);
          }
        } else {
          result = Constants.FAILED;
        }
      });
    }catch(e) {
      print(e.toString());
      result = Constants.FAILED;
    }

    notifyListeners();
    return result;
  }

  List<GroupModel> searchedGroup = [];
  Future<String> searchGroup(
      {required String groupName}) async{
    notifyListeners();

    searchedGroup.clear();
    String result = Constants.SUCCESS;

    Uri uri = Uri.parse("${Constants.baseUrl}/get-communit/${groupName}");

    try {
      var response = await http.get(uri);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print(decodedData);
        for(int i =0; i<decodedData["Result"].length; i++){
          searchedGroup.add(GroupModel.fromJson(decodedData["Result"][i]));
        }
        notifyListeners();
        result = Constants.SUCCESS;

      } else {
        result = Constants.FAILED;
      }
    } catch (e) {
      result = Constants.FAILED;
    }

    notifyListeners();

    return result;
  }
}