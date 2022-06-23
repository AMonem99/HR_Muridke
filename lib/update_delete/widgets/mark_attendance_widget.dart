import 'package:firebase_database/firebase_database.dart';

void markDelete(  {Map contact ,DatabaseReference ref }){


  String key = contact['key'];
  ref.child(key.toString()).remove().then((value) {});
}
