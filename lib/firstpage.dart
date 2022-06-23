
import 'package:flutter/material.dart';
import 'package:hr/recor_by_name/record_by_name.dart';
import 'package:hr/update_delete/all_empolyees.dart';

import 'ateendance_record.dart';
import 'atendence.dart';
import 'contants.dart';

class FirstPage extends StatefulWidget {
  const FirstPage ({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage > {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Attendance(),
    AllEmployees(),
    AttendanceRecord(),
    AttendanceRecordByName(),
 //   Text('salary Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Constants.kPrimaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.40),
          selectedFontSize: 14,
          unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5,
          items:  const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label:'Attendance' ,
              icon: Icon(Icons.drive_file_rename_outline,size: 33,),

           //   icon: Container(width: 27,height:35,child: Image.asset('assets/clipboard.png',)),
            ),
            BottomNavigationBarItem(
              label:  ' Employees',
            //    icon: Container(width: 27,height:35,child: Image.asset('assets/home.png',)),
                icon: Icon(Icons.people,size: 33,),
            ),

            BottomNavigationBarItem(
              label: 'Dates',
            //  icon: Container(width: 27,height:35,child: Image.asset('assets/clipboard.png',)),
              icon: Icon(Icons.text_snippet_sharp,size: 33,),
            ),
            BottomNavigationBarItem(
              label: 'Names',
              //  icon: Container(width: 27,height:35,child: Image.asset('assets/clipboard.png',)),
              icon: Icon(Icons.text_snippet_sharp,size: 33,),
            ),
            // BottomNavigationBarItem(
            //   label: 'Salary',
            //   icon: Container(width: 27,height:35,child: Image.asset('assets/salary.png',)),
            // ),
          ],

      ),
    );
  }
}  