
import 'package:flutter/material.dart';

import '../contants.dart';
import 'mark_attendance_widget.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:fluttertoast/fluttertoast.dart';

Future<void> showMyDialog({ String imageUrl,Map contact ,context ,DatabaseReference ref,String date, String status , String checkOutStatus}) async {
  DatabaseReference refByName;
  // ignore: deprecated_member_use
  refByName = FirebaseDatabase.instance.reference().child('Name').child(contact['name']);

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  const Text('Attendance',style: TextStyle(fontWeight: FontWeight.bold),),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text('Confirm ${contact['name']} is $status ',),

            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text('Cancel',style: TextStyle(color: Constants.kPrimaryColor),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Confirm',style: TextStyle(color: Constants.kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 18),),
                onPressed: () {

                 markAttendance(imageUrl:imageUrl,checkOutStatus:checkOutStatus,contact: contact,status: status,ref:ref,date:date,refByName:refByName);
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Successfully You Have Marked the Attendance",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                  );
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
