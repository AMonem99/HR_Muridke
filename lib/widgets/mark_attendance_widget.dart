import 'package:firebase_database/firebase_database.dart';

void markAttendance(  {String imageUrl,Map contact , status,String date ,DatabaseReference ref,DatabaseReference refByName,String checkOutStatus }){

  DateTime now = DateTime.now();
  String dateKey = DateTime.now().toString().substring(0, 10);

  // ignore: avoid_print
  String nowMints= now.minute.toString();
  String nowHours= now.hour.toString();
  String name = contact['name'];
  String key = contact['key'];

  Map<String,String> attendanceMark = {
    'date':date.toString(),
    'name':name,
     'imageUrl':imageUrl,
    'checkInTimeMints':status=='ABSENT'||status=='LEAVE'?'--':nowMints,
    'checkInTimeHours':status=='ABSENT'||status=='LEAVE'?'--':nowHours,
    'status': status,
    'boola': 'false',
    'checkOutStatus':'',
    'checkOutTimeMints':'--',
    'checkOutTimeHours':'--',

  };
  Map<String,String> employeeMarkCheckOut = {
    'checkOutTimeMints':nowMints.toString(),
    'checkOutTimeHours':nowHours.toString(),
    'checkOutStatus':checkOutStatus
  };


  if(name.isNotEmpty){
    checkOutStatus=='CHECKOUT'? refByName.child(dateKey).update(employeeMarkCheckOut).then((value) {}):

    refByName.child(dateKey).update(attendanceMark).then((value) {});

    if(ref.child(key)==ref.child(key)){}
    else {
      checkOutStatus=='CHECKOUT'? ref.child(key).update(employeeMarkCheckOut).then((value) {}):
      ref.child(key).update(attendanceMark).then((value) {});
    }
  }



}
