import 'package:clg_content_sharing/Screen/signUp_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class chooseAccount extends StatefulWidget {
  const chooseAccount({Key? key}) : super(key: key);

  @override
  State<chooseAccount> createState() => _chooseAccountState();
}

class _chooseAccountState extends State<chooseAccount> {
  var selectAdminColor = Colors.transparent;
  var selectTeacherColor = Colors.transparent;
  var selectStudentColor = Colors.transparent;
  var selectStaffColor = Colors.transparent;
  var accountType = 0;
  var accountRole = 'none';

  selectState(value) {
    if (value == 1) {
      accountRole = 'admin';
      selectAdminColor = Color(0xFF35A3CB);
      selectTeacherColor = Colors.transparent;
      selectStaffColor = Colors.transparent;
      selectStudentColor = Colors.transparent;
    } else if (value == 2) {
      accountRole = 'teacher';
      selectAdminColor = Colors.transparent;
      selectStaffColor = Colors.transparent;
      selectStudentColor = Colors.transparent;
      selectTeacherColor = Color(0xFFAA3ED4);
    } else if (value == 3) {
      accountRole = 'student';
      selectAdminColor = Colors.transparent;
      selectTeacherColor = Colors.transparent;
      selectStaffColor = Colors.transparent;
      selectStudentColor = Color(0xFF36A23B);
    } else if (value == 4) {
      accountRole = 'staff';
      selectStaffColor = Color(0xFFD4C53E);
      selectAdminColor = Colors.transparent;
      selectTeacherColor = Colors.transparent;
      selectStudentColor = Colors.transparent;
    } else {
      accountRole = 'none';
      selectAdminColor = Colors.transparent;
      selectTeacherColor = Colors.transparent;
      selectStaffColor = Colors.transparent;
      selectStudentColor = Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 40, top: 80),
              child: Text(
                'Select Account Type',
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpPage(role: accountRole)),
                  );
                },
                child: Text('SELECT',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )))
          ],
        ),
      ),
    );
  }
}
