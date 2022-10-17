import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  var role;
  SignUpPage({required this.role});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _controllerF_name = TextEditingController();
  TextEditingController _controllerL_name = TextEditingController();
  TextEditingController _controllerRollNo = TextEditingController();
  TextEditingController _controllerYear = TextEditingController();
  TextEditingController _controllerBranch = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPhoneNo = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  String dropdownvalue='CSE';
  var branch=[
    'CSE',
    'EL',
    'EE'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              'Welcome ${widget.role}',
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(color: Colors.black87, width: 1),
                  ),
                  hintText: "First Name"
                // border: BorderSide(color: Colors.black,width: 1),
              ),
              controller: _controllerF_name,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(color: Colors.black87, width: 1),
                  ),
                  hintText: "Last Name"
                // border: BorderSide(color: Colors.black,width: 1),
              ),
              controller: _controllerL_name,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(color: Colors.black87, width: 1),
                  ),
                  hintText: "Email"
                // border: BorderSide(color: Colors.black,width: 1),
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _controllerEmail,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(color: Colors.black87, width: 1),
                  ),
                  hintText: "Mobile Number"
                // border: BorderSide(color: Colors.black,width: 1),
              ),
              keyboardType: TextInputType.number,
              controller: _controllerPhoneNo,
              textAlign: TextAlign.center,
            ),
          ),
          if(widget.role=='student') ...[
            Container(
              margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Colors.black87, width: 1),
                    ),
                    hintText: "Roll Number"
                  // border: BorderSide(color: Colors.black,width: 1),
                ),
                controller: _controllerRollNo,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Colors.black87, width: 1),
                    ),
                    hintText: "Year"
                  // border: BorderSide(color: Colors.black,width: 1),
                ),
                controller: _controllerYear,
                textAlign: TextAlign.center,
              ),
            ),
          ],
          if(widget.role=='teacher' || widget.role=='student')
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 50, 10),
                  child: Text('Branch : ',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                  ),),
                ),
                DropdownButton(
                  value: dropdownvalue,
                    items: branch.map((String branch){
                  return DropdownMenuItem(child: Text(branch),value: branch,);
                }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    }),
              ],
            ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(color: Colors.black87, width: 1),
                  ),
                  hintText: "Password"
                // border: BorderSide(color: Colors.black,width: 1),
              ),
              controller: _controllerPass,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(color: Colors.black87, width: 1),
                  ),
                  hintText: "Confirm Password"
                // border: BorderSide(color: Colors.black,width: 1),
              ),
              controller: _controllerPass,
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
              onPressed: () {
              },
              child: Text('SIGN UP',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )))
        ],
      ),
    );
  }
}

