
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'attendance_status_widget.dart';

// ignore: must_be_immutable
class AllEmployeesItem extends StatefulWidget {
  Map contact;
  int index;
  String date;
  DatabaseReference ref;
  TextEditingController searchController;

  AllEmployeesItem({Key key, this.contact,this.index,this.date,this.ref,this.searchController}) : super(key: key);

  @override
  _AllEmployeesItemState createState() => _AllEmployeesItemState();
}

class _AllEmployeesItemState extends State<AllEmployeesItem> {
  bool showPresentStatus = true;
  int myHour=12;
  int myMins=12;
  bool isTimeOver = true;
  timerFunction(){
    DateTime now =  DateTime.now();

    myHour = now.hour;
    myMins = now.minute;
    // print(myHour);
    // print(myMins);

  }
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      timerFunction();
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return widget.searchController.text==''?Container(
        margin: const EdgeInsets.only(top: 7),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  // ignore: avoid_print
                  print(myMins);
                  widget.contact['boola']=widget.contact['boola']=='false'?true:'false';

                });
              },
              child: Container(
                width: screenSize.width * 0.94,
                height: screenSize.height * 0.1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(

                        color: Colors.grey.withOpacity(0.5),
                        //spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    //  color: Constants.kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(11),
                      topRight: const Radius.circular(11),
                      bottomLeft: widget.contact['boola']==true?const Radius.circular(0):const Radius.circular(11),
                      bottomRight: widget.contact['boola']==true?const Radius.circular(0):const Radius.circular(11),

                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          widget.contact['imageUrl']==null?
                          Container(

                            decoration:  const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/Userrr.png'),
                                    fit: BoxFit.fill)
                            ),
                            width: screenSize.width * 0.16,
                            height: screenSize.height * 0.1,
                          ):
                          Container(

                            decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        widget.contact['imageUrl']),
                                    fit: BoxFit.fill)
                            ),
                            width: screenSize.width * 0.16,
                            height: screenSize.height * 0.1,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                widget.contact['name'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Text(
                                widget.contact['designation'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        child:  widget.contact['boola']==true
                            ? const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                          color: Colors.black,
                        )
                            : const Icon(
                          Icons.keyboard_arrow_right_outlined,
                          size: 30,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if(widget.contact['boola'] == true)
              DleteUpdateStatusWidget(myHour : myHour,myMins:myMins,screenSize: screenSize, contact:widget.contact,ref:widget.ref,date:widget.date)
            else
              const SizedBox()
          ],
        )):widget.searchController.text==widget.contact['name']? Container(
        margin: const EdgeInsets.only(top: 7),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  // ignore: avoid_print
                  print(myMins);
                  widget.contact['boola']=widget.contact['boola']=='false'?true:'false';

                });
              },
              child: Container(
                width: screenSize.width * 0.94,
                height: screenSize.height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                    boxShadow: [
                      BoxShadow(

                        color: Colors.grey.withOpacity(0.5),
                        //spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  //  color: Constants.kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(11),
                        topRight: const Radius.circular(11),
                    bottomLeft: widget.contact['boola']==true?const Radius.circular(0):const Radius.circular(11),
                        bottomRight: widget.contact['boola']==true?const Radius.circular(0):const Radius.circular(11),

                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          widget.contact['imageUrl']==null?
                          Container(

                            decoration:  const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/Userrr.png'),
                                    fit: BoxFit.fill)
                            ),
                            width: screenSize.width * 0.16,
                            height: screenSize.height * 0.1,
                          ):
                          Container(

                            decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        widget.contact['imageUrl']),
                                    fit: BoxFit.fill)
                            ),
                            width: screenSize.width * 0.16,
                            height: screenSize.height * 0.1,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                widget.contact['name'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Text(
                                widget.contact['designation'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        child:  widget.contact['boola']==true
                            ? const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                          color: Colors.black,
                        )
                            : const Icon(
                          Icons.keyboard_arrow_right_outlined,
                          size: 30,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if(widget.contact['boola'] == true)
              DleteUpdateStatusWidget(myHour : myHour,myMins:myMins,screenSize: screenSize, contact:widget.contact,ref:widget.ref,date:widget.date)
             else
                 const SizedBox()
          ],
        )):const SizedBox();
  }
}


