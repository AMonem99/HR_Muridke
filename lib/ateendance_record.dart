import 'package:flutter/material.dart';
import 'add_emloee.dart';
import 'contants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class AttendanceRecord extends StatefulWidget {
  const AttendanceRecord({Key key}) : super(key: key);

  @override
  State<AttendanceRecord> createState() => _AttendanceRecordState();
}

class _AttendanceRecordState extends State<AttendanceRecord> {
  final TextEditingController _searchController = TextEditingController();
  String date = DateTime.now().toString().substring(0, 10);
  Query _refAR;
  Query _refDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: deprecated_member_use
    _refAR = FirebaseDatabase.instance.reference().child('Date');
    // ignore: deprecated_member_use
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 222,
              decoration: const BoxDecoration(
                  color: Constants.kPrimaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(33),bottomRight: Radius.circular(33))
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('Welcome, HR(Muridke)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white)),
                      SizedBox(height: 15),
                      Text('All the employees records shown here.',
                          style: TextStyle(fontSize: 20,color: Colors.white)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: screenSize.height * 0.6,
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 2,
                            // offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(11),
                        //  border: Border.all(color: Colors.grey,width: 2)
                      ),
                     // height: screenSize.height * 0.999,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: screenSize.height * 0.02,
                                bottom: screenSize.height * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                    height: screenSize.height * 0.055,
                                    width: screenSize.width * 0.68,
                                    child: TextField(
                                      onChanged: (value){
                                        setState(() {

                                        });

                                      },

                                      controller:  _searchController,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          prefixIcon: const Icon(Icons.search, size: 27),
                                          hintText: 'Search here by Dates',
                                          hintStyle: const TextStyle(color: Colors.grey),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7))),
                                    )),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddEmployee()));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      //  shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage('assets/add.png'),
                                            fit: BoxFit.fill)),
                                    width: screenSize.width * 0.12,
                                    height: screenSize.height * 0.055,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.47,
                            child: FirebaseAnimatedList(
                             // physics: ScrollPhysics(),
                              //shrinkWrap: true,
                              query: _refAR,
                              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                                  Animation<double> animation, int index) {
                                Map aRecord = snapshot.value;
                                aRecord['key'] = snapshot.key;
                                return _buildAttendanceRecord(
                                    searchController:_searchController,
                                    aRecord: aRecord, index: index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],

        ),
      ),
    );
  }

  Widget _buildAttendanceRecord({Map aRecord, index,TextEditingController searchController}) {
    var screenSize = MediaQuery.of(context).size;
    return  searchController.text==''?Container(
        margin: const EdgeInsets.only(top: 7),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  aRecord['boola'] = aRecord['boola'] == true ? 'false' : true;
                });
              },
              child: Container(
                width: screenSize.width * 0.94,
                height: screenSize.height * 0.1,
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(22),
                      topRight: const Radius.circular(22),
                      bottomRight: aRecord['boola'] == true
                          ? const Radius.circular(0)
                          : const Radius.circular(22),
                      bottomLeft: aRecord['boola'] == true
                          ? const Radius.circular(0)
                          : const Radius.circular(22),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/calender.png'),
                      Text(
                        aRecord['key'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Icon(
                        aRecord['boola'] != true
                            ?   Icons.keyboard_arrow_right:Icons.keyboard_arrow_down_outlined,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
            aRecord['boola'] == true
                ? _buildAttendanceRecordDetails(aRecord: aRecord, index: index)
                : const SizedBox()
          ],
        )): searchController.text== aRecord['key']?Container(
        margin: const EdgeInsets.only(top: 7),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  aRecord['boola'] = aRecord['boola'] == true ? 'false' : true;
                });
              },
              child: Container(
                width: screenSize.width * 0.94,
                height: screenSize.height * 0.1,
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(22),
                      topRight: const Radius.circular(22),
                      bottomRight: aRecord['boola'] == true
                          ? const Radius.circular(0)
                          : const Radius.circular(22),
                      bottomLeft: aRecord['boola'] == true
                          ? const Radius.circular(0)
                          : const Radius.circular(22),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/calender.png'),
                      Text(
                        aRecord['key'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Icon(
                        aRecord['boola'] != true
                            ?   Icons.keyboard_arrow_right:Icons.keyboard_arrow_down_outlined,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
            aRecord['boola'] == true
                ? _buildAttendanceRecordDetails(aRecord: aRecord, index: index)
                : const SizedBox()
          ],
        )):const SizedBox();
  }

  Widget _buildAttendanceRecordDetails({Map aRecord, index}) {
    _refDetails = FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child('Date')
        .child(aRecord['key']);
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      // height: screenSize.height*0.1999,
      width: screenSize.width * 0.94,
      decoration:  BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(22),
              bottomRight:  Radius.circular(22)
          )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Container(
                alignment: Alignment.topLeft,

                width: screenSize.width * 0.12,
                child: const Text(
                  'Name',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,

                width: screenSize.width * 0.1,
                child: const Text(
                  'In',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),

              Container(
                alignment: Alignment.topCenter,

                width: screenSize.width * 0.1,
                child: const Text(
                  'Out',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              Container(
                width: screenSize.width * 0.12,
                alignment: Alignment.topCenter,
                child: const Text(
                  'Status',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              Container(
                width: screenSize.width * 0.12,
                alignment: Alignment.topRight,
                child: const Text(
                  'Hours',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              Container(
                width: screenSize.width * 0.12,
                alignment: Alignment.topRight,
                child: const Text(
                  'Yes/No',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ],
          ),
          FirebaseAnimatedList(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            query: _refDetails,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map aRecordDetails = snapshot.value;
              //  print(aRecordDetails);
              aRecordDetails['key'] = snapshot.key;
              return _buildAttendanceRecordRA(

                  aRecordDetails: aRecordDetails, index: index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceRecordRA({Map aRecordDetails, index}) {
    var screenSize = MediaQuery.of(context).size;


    int outH;
    int totalH;
    int totalM;
    int  inH;
    int  inM;
if(aRecordDetails['checkOutTimeHours']=='--'){
  outH = 0;
   totalH= 0;
}
else{

   outH = int.parse(aRecordDetails['checkOutTimeHours']);

}
if(aRecordDetails['checkInTimeHours']=='--'){
   inH = 0;
}
else{
   inH =  int.parse(aRecordDetails['checkInTimeHours']);

}

    int outM;
    if(aRecordDetails['checkOutTimeMints']=='--'){
      outM = 0;
      totalM= 0;
    }
    else{
       outM =  int.parse(aRecordDetails['checkOutTimeMints']);

    }
    if(aRecordDetails['checkInTimeMints']=='--')
      {
         inM = 0;
      }
    else{
       inM =  int.parse(aRecordDetails['checkInTimeMints']);

    }



     totalH = outH-inH;
     totalM = outM-inM;
   if(totalM<0){
     totalH=totalH-1;
     totalM=totalM+60;

   }
   int totalMints=( (outH*60)+outM)-((inH*60)+inM);
   bool yesNo = false;
   if(totalMints>=480)
     {
       yesNo=true;
     }


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,

                  width: screenSize.width * 0.12,
                  child: Text(
                    aRecordDetails['name'],
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: screenSize.width * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        aRecordDetails['checkInTimeHours'],
                        style: const TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      const Text(
                      ':',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Text(
                        aRecordDetails['checkInTimeMints'],
                        style: const TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                ),


                Container(
                  alignment: Alignment.topCenter,
                  width: screenSize.width * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                     Text(
                          aRecordDetails['checkOutTimeHours'],
                          style: const TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      const Text(
                        ':',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),

                    Text(
                          aRecordDetails['checkOutTimeMints'],
                          style: const TextStyle(color: Colors.black, fontSize: 12),

                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: screenSize.width * 0.15,
                  child: Text(
                    aRecordDetails['status'],
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  width: screenSize.width * 0.1,
                  child:aRecordDetails['checkOutTimeHours']=='--'|| aRecordDetails['checkOutTimeMints']=='--' ?
            const Text(

           '--:--',
            style:
            TextStyle(color: Colors.black, fontSize: 12),
            ):Text(

                    totalH.toString()+':'+totalM.toString(),
                       style:
                       const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  width: screenSize.width * 0.12,
                  child: Text(yesNo==true?'Yes':'No',
                    style:
                    const TextStyle(color: Colors.black, fontSize: 12),
                  )
                ),
              ],
            );
          }),
    );
  }
}
