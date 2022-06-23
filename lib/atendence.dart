import 'package:flutter/material.dart';
import 'package:hr/widgets/employ_items_widget.dart';
import 'add_emloee.dart';
import 'contants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String date = DateTime.now().toString().substring(0, 10);
  Query _ref;
  DatabaseReference ref;
final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: deprecated_member_use
    _ref = FirebaseDatabase.instance.reference().child('Employees').orderByChild('name');
    // ignore: deprecated_member_use
    ref = FirebaseDatabase.instance.reference().child('Date').child(date);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
            children: [
              Container(
                decoration:const BoxDecoration(
                    color: Constants.kPrimaryColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(33),bottomRight: Radius.circular(33))
                ),              height: 222,
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
                    Text('All the employees will be marked here.',
                        style: TextStyle(fontSize: 20,color: Colors.white)),
                  ],
                ),
              ),
              Container(
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
                height: screenSize.height * 0.6,
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
                                controller: _searchController,
                                decoration: InputDecoration(
                                    isDense: true,
                                    prefixIcon: const Icon(Icons.search, size: 27),
                                    hintText: 'Search Employee here',
                                    hintStyle: const TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7))),
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddEmployee()));
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
                        //shrinkWrap: true,
                      //  physics: ScrollPhysics(),
                        query: _ref,
                        itemBuilder: (BuildContext context, DataSnapshot snapshot,
                            Animation<double> animation, int index) {
                          Map contact = snapshot.value;
                          contact['key'] = snapshot.key;


                          return BuildEmployeesItem(
                              contact: contact,
                              index: index,
                              date: date,
                              searchController:_searchController,
                              ref: ref);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
