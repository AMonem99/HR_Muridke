
import 'package:flutter/material.dart';

import 'dilog_attendance_widget.dart';
import 'package:firebase_database/firebase_database.dart';

// ignore: must_be_immutable
class AttendanceStatusWidget extends StatefulWidget {
  Map contact;
  final Size screenSize;
  String date;
  DatabaseReference ref;
  bool isAlreadyData;
  // bool isOnTime;
  bool isCheckedOut;
  bool boolaboola;
  String checkStatus;
  String imageUrl;

  AttendanceStatusWidget(
      {Key key, this.contact, @required this.imageUrl,this.isCheckedOut,this.screenSize, this.ref, this.date,this.isAlreadyData,this.checkStatus})
      : super(key: key);

  @override
  State<AttendanceStatusWidget> createState() => _AttendanceStatusWidgetState();
}

class _AttendanceStatusWidgetState extends State<AttendanceStatusWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override

@override
 Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      height: widget.screenSize.height * 0.1,

      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(

              color: Colors.grey.withOpacity(0.5),
              blurRadius: 3,
               offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(44),bottomRight: Radius.circular(44))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: widget.isAlreadyData==true?

        InkWell(
          onTap: (){
            // ignore: avoid_print
            widget.isCheckedOut==true ? print('absent or leave '):widget.checkStatus=='PRESENT'|| widget.checkStatus=='LATE'? showMyDialog(
                checkOutStatus: 'CHECKOUT',
                status: widget.checkStatus,
                contact: widget.contact,
                context: context,
                imageUrl: widget.imageUrl,
                ref: widget.ref,
                date: widget.date)
            // ignore: avoid_print
            :print('absent or leave ');
          },
          child: Container(
          //  width: widget.screenSize.width * 0.24,
            height: widget.screenSize.height * 0.05,
            decoration: BoxDecoration(
                color:widget.isCheckedOut==true?Colors.grey:widget.checkStatus=='PRESENT'||  widget.checkStatus=='LATE'?Colors.blue:Colors.grey,
                borderRadius: BorderRadius.circular(27)),
            child:  Center(
                child:  Text(widget.isCheckedOut==true?'Attendance Already Marked':
                  widget.checkStatus=='PRESENT'||  widget.checkStatus=='LATE'?'Check Out': 'Attendance Already Marked',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )
                  ),
          ),
        )

            :Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  widget.contact['boola'] = 'false';

                  showMyDialog(
                      status:
                  //    widget.isOnTime==true?
                      'PRESENT',
                          //: 'LATE',
                      contact: widget.contact,
                      context: context,
                      ref: widget.ref,
                      imageUrl: widget.imageUrl,
                      date: widget.date);
                });
              },
              child: Container(
                width: widget.screenSize.width * 0.24,
                height: widget.screenSize.height * 0.05,
                decoration: BoxDecoration(
                    color:
                  //  widget.isOnTime==true ?
                    Colors.green,
                        //:Colors.yellow,
                    borderRadius: BorderRadius.circular(27)),
                child: const Center(
                    child:
                  //  widget.isOnTime==true ? const
                    Text(
                            'Check In',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )
                    //     : const
                    // Text(
                    //         'Late',
                    //         style: TextStyle(
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 15),
                    //       )
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  widget.contact['boola'] = 'false';

                  showMyDialog(
                      status: 'LEAVE',
                      contact: widget.contact,
                      context: context,
                      ref: widget.ref,
                      imageUrl: widget.imageUrl,
                      date: widget.date);
                });
              },
              child: Container(
                width: widget.screenSize.width * 0.24,
                height: widget.screenSize.height * 0.05,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(27)),
                child: const Center(
                    child: Text(
                  'Leave',
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

                  showMyDialog(
                      status: 'ABSENT',
                      contact: widget.contact,
                      context: context,
                      ref: widget.ref,
                      imageUrl: widget.imageUrl,
                      date: widget.date);
                });
              },
              child: Container(
                width: widget.screenSize.width * 0.24,
                height: widget.screenSize.height * 0.05,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(27)),
                child: const Center(
                    child: Text(
                  'Absent',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
