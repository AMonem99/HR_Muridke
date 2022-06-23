
import 'package:flutter/material.dart';

import '../../contants.dart';
import 'mark_attendance_widget.dart';
import 'package:firebase_database/firebase_database.dart';


Future<void> showDeleteDialog({Map contact ,context ,DatabaseReference ref}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:   const Text('Delete',style: TextStyle(fontWeight: FontWeight.bold),),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Row(
                children: [
                  const Text('Are You Sure to Delete ',style: TextStyle(color: Colors.black),),
                  Text('${contact['name']} ',style: const TextStyle(color: Colors.blue),),
                ],
              ),

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
                child: const Text('Confirm',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                onPressed: () {
                  markDelete(contact: contact,ref:ref);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
