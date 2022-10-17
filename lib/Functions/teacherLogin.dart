import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> TeacherLogin(
{required String email,required String role, required String pass}) async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('http://172.16.139.2/CollegeProject/public/api/login'));
  request.body = json.encode({
    "email": email,
    "role": role,
    "password": pass
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}