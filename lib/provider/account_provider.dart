import 'dart:io';

import 'package:clg_content_sharing/Models/data_models.dart';
import 'package:clg_content_sharing/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:http_parser/http_parser.dart';

final accountProvider = ChangeNotifierProvider((ref) => AccountProvider());

class AccountProvider extends ChangeNotifier {
  List<DataModel> AlluserData = [];
  late DataModel allData;

  Future<String> registerUser({
    required String fname,
    required String lname,
    required String email,
    required String roll_number,
    required String phone,
    required String branch,
    required String year,
    required String role,
    required String specification,
    required String pass,
    File? photo,
  }) async {
    notifyListeners();
     AlluserData.clear();
    String result = Constants.SUCCESS;
    Uri uri = Uri.parse("${Constants.baseUrl}/register");

    var body = {
      'f_name': fname,
      'l_name': lname,
      'roll_number': roll_number,
      'email': email,
      'mobile': phone,
      'year': year,
      'branch': branch,
      'specification': specification,
      'role': role,
      'password': pass,
    };

    try {
      var request = new http.MultipartRequest("POST", uri);
      request.fields['f_name'] = fname;
      request.fields['l_name'] = lname;
      request.fields['roll_number'] = roll_number;
      request.fields['email'] = email;
      request.fields['mobile'] = phone;
      request.fields['year'] = year;
      request.fields['branch'] = branch;
      request.fields['specification'] = specification;
      request.fields['role'] = role;
      request.fields['password'] = pass;
      print(request.fields);

      if (photo != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile',
          photo.path,
          contentType: MediaType('profile', 'jpeg'),
        ));
        request.send().then((response) async {
          print("object");
          print(response.statusCode);
          if (response.statusCode == 201) {
            var resulthttp = await http.Response.fromStream(response);
            var decodedData = JSON.jsonDecode(resulthttp.body);
            AlluserData.add(DataModel.fromJson(decodedData));

            print(decodedData);
            if (decodedData["Result"] == "success") {
              result = Constants.SUCCESS;
              print(result);
            }
          } else {
            result = Constants.FAILED;
          }
        });
      }
    } catch (e) {
      print(e.toString());
      result = Constants.FAILED;
    }

    notifyListeners();
    return result;
  }

  Future<String> login(
      {required String creadential,
      required String pass,
      required String role}) async {
    notifyListeners();
    AlluserData.clear();
    String result = Constants.SUCCESS;

    Uri uri = Uri.parse("${Constants.baseUrl}/login");

    var body;
    if (role == 'teacher') {
      body = {"email": creadential, "role": role, "password": pass};
    } else if (role == 'student') {
      body = {"roll_number": creadential, "role": role, "password": pass};
    } else {
      body = {"mobile": creadential, "role": role, "password": pass};
    }

    try {
      var response = await http.post(uri, body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var decodedData = JSON.jsonDecode(response.body);

        AlluserData.add(DataModel.fromJson(decodedData));

        notifyListeners();
        result = Constants.SUCCESS;
        print(AlluserData);
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