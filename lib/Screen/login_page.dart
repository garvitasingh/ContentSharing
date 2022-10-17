import 'package:clg_content_sharing/Functions/teacherLogin.dart';
import 'package:clg_content_sharing/Functions/studentLoginApi.dart';
import 'package:clg_content_sharing/Screen/signUp_chooseAcc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp_page extends StatefulWidget {
  const SignUp_page({Key? key}) : super(key: key);

  @override
  State<SignUp_page> createState() => _SignUp_pageState();
}

class _SignUp_pageState extends State<SignUp_page> {
  var selectAdminColor = Colors.transparent;
  var selectTeacherColor = Colors.transparent;
  var selectStudentColor = Colors.transparent;
  var selectStaffColor = Colors.transparent;
  var accountType = 0;
  var accountRole='none';
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerRollNo = TextEditingController();
  TextEditingController _controllerPhoneNo = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();

  selectState(value) {
    if (value == 1) {
      accountRole='admin';
      selectAdminColor = Color(0xFF35A3CB);
      selectTeacherColor = Colors.transparent;
      selectStaffColor = Colors.transparent;
      selectStudentColor = Colors.transparent;
    } else if (value == 2) {
      accountRole='teacher';
      selectAdminColor = Colors.transparent;
      selectStaffColor = Colors.transparent;
      selectStudentColor = Colors.transparent;
      selectTeacherColor = Color(0xFFAA3ED4);
    } else if (value == 3) {
      accountRole='student';
      selectAdminColor = Colors.transparent;
      selectTeacherColor = Colors.transparent;
      selectStaffColor = Colors.transparent;
      selectStudentColor = Color(0xFF36A23B);
    }else if (value == 4) {
      accountRole='staff';
      selectStaffColor = Color(0xFFEE412A);
      selectAdminColor = Colors.transparent;
      selectTeacherColor = Colors.transparent;
      selectStudentColor = Colors.transparent;
    }  else {
      accountRole='none';
      selectAdminColor = Colors.transparent;
      selectTeacherColor = Colors.transparent;
      selectStaffColor = Colors.transparent;
      selectStudentColor = Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  'Select Account Type',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                shrinkWrap: true,
                primary: true,
                children: <Widget>[
                  Card(
                    borderOnForeground: true,
                    color: selectAdminColor,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            accountType = 1;
                            selectState(accountType);
                          });
                        },
                        icon: Image.asset('assets/adminLogin.png')),
                  ),
                  Card(
                    borderOnForeground: true,
                    color: selectTeacherColor,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            accountType = 2;
                            selectState(accountType);
                          });
                        },
                        icon: Image.asset('assets/teaching.png')),
                  ),
                  Card(
                    borderOnForeground: true,
                    color: selectStudentColor,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            accountType = 3;
                            selectState(accountType);
                          });
                        },
                        icon: Image.asset('assets/studentLogin.png')),
                  ),
                  Card(
                    borderOnForeground: true,
                    color: selectStaffColor,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            accountType = 4;
                            selectState(accountType);
                          });
                        },
                        icon: Image.asset('assets/staff.png')),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    child: Divider(
                  thickness: 0.5,
                  color: Colors.white,
                  indent: 44,
                  endIndent: 17,
                )),
                Text(
                  "  Login  ",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Expanded(
                    child: Divider(
                  thickness: 0.5,
                  color: Colors.white,
                  indent: 17,
                  endIndent: 44,
                )),
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (accountType == 1)
                    Text(
                      'HELLO ADMIN!',
                      style: GoogleFonts.roboto(
                        color: selectAdminColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else if (accountType == 2)
                    Text(
                      'HELLO TEACHER!',
                      style: GoogleFonts.roboto(
                        color: selectTeacherColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else if (accountType == 3)
                      Text(
                        'HELLO STUDENT!',
                        style: GoogleFonts.roboto(
                          color: selectStudentColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  else if (accountType == 4)
                    Text(
                      'HELLO NON-TEACHING STAFF!',
                      style: GoogleFonts.roboto(
                        color: selectStaffColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else
                    Text(
                      'SELECT ACCOUT TYPE TO CONTINUE',
                      style: GoogleFonts.roboto(
                        color: selectState(accountType),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  if (accountType == 3)
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1),
                            ),
                            hintText: "Roll Number"
                            // border: BorderSide(color: Colors.black,width: 1),
                            ),
                        keyboardType: TextInputType.number,
                        controller: _controllerRollNo,
                        textAlign: TextAlign.center,
                      ),
                    )
                    else if(accountType==4)
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
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
                    )
                  else
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: selectState(accountType),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
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
                    margin: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          hintText: "Password"
                          // border: BorderSide(color: Colors.black,width: 1),

                          ),
                      keyboardType: TextInputType.visiblePassword,
                      controller: _controllerPass,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget Password?',
                          style: GoogleFonts.roboto(
                            // color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(right: 120, left: 120),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // backgroundColor: Colors.black87.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              side: BorderSide(color: Colors.white, width: 1)),
                          onPressed: () {
                            if(accountType==3){
                              LoginStudent(rollNo: _controllerRollNo.text, pass: _controllerPass.text);
                            }else if(accountType==4){

                            }
                            else
                              {
                                TeacherLogin(email: _controllerEmail.text, role: accountRole, pass: _controllerPass.text);
                              }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Login',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.roboto(
                      // color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => chooseAccount()),);
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.roboto(
                          decoration: TextDecoration.underline,
                          // color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
