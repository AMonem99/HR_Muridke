
import 'package:flutter/material.dart';
import 'package:hr/update_delete/widgets/update_feilds.dart';

import 'dilog_attendance_widget.dart';
import 'package:firebase_database/firebase_database.dart';

// ignore: must_be_immutable
class DleteUpdateStatusWidget extends StatefulWidget {
  Map contact;
  final Size screenSize;
  String date;
  int myHour;
  int myMins;
  DatabaseReference ref;

  DleteUpdateStatusWidget(
      {Key key, this.contact, @required this.screenSize, this.ref, this.date,this.myMins,this.myHour})
      : super(key: key);

  @override
  State<DleteUpdateStatusWidget> createState() => _DleteUpdateStatusWidgetState();
}

class _DleteUpdateStatusWidgetState extends State<DleteUpdateStatusWidget> {

  int myHour=12;
  int myMins=12;

  @override
  void initState() {
     myHour = widget.myHour;
     myMins = widget.myMins;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      //  width: screenSize.width * 1,
      height: widget.screenSize.height * 0.1,

      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(

              color: Colors.grey.withOpacity(0.5),
             // spreadRadius: 2,
              blurRadius: 3,
               offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(44),bottomRight: Radius.circular(44))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  widget.contact['boola'] = 'false';
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateEmployee(
                    contact: widget.contact,
                    ref: widget.ref,

                  )));

                });
              },
              child: Container(
                width: widget.screenSize.width * 0.24,
                height: widget.screenSize.height * 0.05,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(27)),
                child: const Center(
                    child:Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  widget.contact['boola'] = 'false';

                  showDeleteDialog(
                      contact: widget.contact,
                      context: context,
                      ref: widget.ref,
                      );
                });
              },
              child: Container(
                width: widget.screenSize.width * 0.24,
                height: widget.screenSize.height * 0.05,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(27)),
                child: const Center(
                    child: Text(
                  'Delete',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     setState(() {
            //       widget.contact['boola'] = 'false';
            //
            //       // showDeleteUpdateDialog(
            //       //     status:'Update',
            //       //     contact: widget.contact,
            //       //     context: context,
            //       //     ref: widget.ref,
            //       //     date: widget.date);
            //     });
            //   },
            //   child: Container(
            //     width: widget.screenSize.width * 0.24,
            //     height: widget.screenSize.height * 0.05,
            //     decoration: BoxDecoration(
            //         color: Colors.blue,
            //         borderRadius: BorderRadius.circular(27)),
            //     child: const Center(
            //         child:Text(
            //           'Details',
            //           style: TextStyle(
            //               color: Colors.black,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 15),
            //         )),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}
