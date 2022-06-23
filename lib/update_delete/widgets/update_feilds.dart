
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../contants.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class UpdateEmployee extends StatefulWidget {

Map contact;
DatabaseReference ref;
UpdateEmployee({Key key, this.ref,this.contact}) : super(key: key);
  @override
  State<UpdateEmployee> createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
   final TextEditingController _nameController= TextEditingController();
   final TextEditingController _emailController= TextEditingController();
   final TextEditingController _numberController= TextEditingController();
   final TextEditingController _designationController= TextEditingController();
   final TextEditingController _salaryController= TextEditingController();
   final TextEditingController _dateController= TextEditingController();
  DatabaseReference _ref;
   String imageUrl;
   String _image;

   uploadImage() async {
     final _firebaseStorage = FirebaseStorage.instance;

     final _imagePicker = ImagePicker();
     PickedFile image;

     await Permission.photos.request();
     // ignore: avoid_print

     var permissionStatus = await Permission.photos.status;

     if (permissionStatus.isGranted){
       // ignore: deprecated_member_use
       image = await _imagePicker.getImage(source: ImageSource.gallery);
       var file = File(image.path);

       if (image != null){
         var snapshot = await _firebaseStorage.ref().child('images/$file').putFile(file);
         var downloadUrl = await snapshot.ref.getDownloadURL();
         setState(() {
           imageUrl = downloadUrl;
         });
       } else {
         // ignore: avoid_print
         print('No Image Path Received');
       }
     } else {
       // ignore: avoid_print
       print('Permission not granted. Try Again with permission access');
     }
   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _nameController.text = widget.contact['name'];
    _numberController.text = widget.contact['number'];
    _emailController.text = widget.contact['email'];
    _designationController.text = widget.contact['designation'];
    _salaryController.text = widget.contact['salary'];
    _dateController.text = widget.contact['joiningDate'];
    _image = widget.contact['imageUrl'];
    // ignore: deprecated_member_use
    _ref = FirebaseDatabase.instance.reference().child('Employees');
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child:SingleChildScrollView(
            child: Stack(
                children:[
                  Container(
                    decoration: const BoxDecoration(
                        color: Constants.kPrimaryColor,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(77),bottomRight: Radius.circular(77))
                    ),                  height: 222,
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
                            Text('Form to enter employees details.',
                                style: TextStyle(fontSize: 20,color: Colors.white)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: screenSize.height*0.16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Employees data',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                            const SizedBox(height: 5,),
                            imageUrl!=null?      InkWell(
                                onTap: (){
                                  setState(() {
                                    uploadImage();
                                  });

                                },
                                child: Center(

                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(imageUrl),fit: BoxFit.fill
                                        ),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black,width: 4)
                                    ),
                                    width: screenSize.width*0.4,
                                    height: screenSize.height*0.2,
                                  ),)
                            ):_image==null?
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    uploadImage();
                                  });

                                },
                                child: Center(

                                  child: Container(
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/Userrr.png')
                                        ),
                                        shape: BoxShape.circle,
                                       // border: Border.all(color: Colors.black,width: 4)
                                    ),
                                    width: screenSize.width*0.4,
                                    height: screenSize.height*0.2,
                                  ),)
                            ):  InkWell(
                                onTap: (){
                                  setState(() {
                                    uploadImage();
                                  });

                                },
                                child: Center(

                                  child: Container(
                                    decoration: BoxDecoration(
                                        image:  DecorationImage(
                                            image: NetworkImage(_image),fit: BoxFit.fill
                                        ),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black,width: 4)
                                    ),
                                    width: screenSize.width*0.4,
                                    height: screenSize.height*0.2,
                                  ),)
                            )
                           ,
                            const Text('Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21)),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    // spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child:  TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: 'eg :  Name',
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey,width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),


                                ),
                              ),
                            ),



                            const SizedBox(height: 18,),
                            const Text('Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21)),
                            const SizedBox(height: 3,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    // spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child:  TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'eg :  abc@gmail.com',
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey,width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                ),
                              ),
                            ),
                            const SizedBox(height: 18,),
                            const Text('Phone Number',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21)),
                            const SizedBox(height: 3,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    // spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child:  TextField(
                                controller: _numberController,
                                decoration: InputDecoration(
                                  hintText: 'eg :  03401111111',

                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey,width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                ),
                              ),
                            ),
                            const SizedBox(height: 18,),
                            const Text('Designation',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21)),
                            const SizedBox(height: 3,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    // spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child:  TextField(
                                controller: _designationController,

                                decoration: InputDecoration(
                                  hintText:'eg :  Designation',

                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey,width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                ),
                              ),
                            ),
                            const SizedBox(height: 18,),
                            const Text('Salary',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21)),
                            const SizedBox(height: 3,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    // spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child:  TextField(
                                controller: _salaryController,

                                decoration: InputDecoration(
                                  hintText: 'eg :  5000000',

                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey,width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18,),

                            const Text('Joining date',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21)),
                            const SizedBox(height: 3,),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    // spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child:  TextField(
                                controller: _dateController,
                                decoration: InputDecoration(
                                  hintText: 'eg :  12/12/2022',

                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey,width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                ),
                              ),
                            ),
                            const SizedBox(height: 18,),
                            Center(
                              child: InkWell(
                                onTap: (){
                                  updateEmployee(contact: widget.contact, ref: widget.ref,);
                                },
                                child: Container(
                                  width: screenSize.width*0.7,
                                  height: screenSize.width*0.16,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Constants.kPrimaryColor
                                  ),
                                  child:const Center(child: Text('Update Employee',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21,color: Colors.white))) ,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ]

            ),
          )


      ),
    );
  }
   bool emailValidation=false;

   void updateEmployee({ DatabaseReference ref , Map contact}){
    String key = contact['key'];
    String name = _nameController.text;
    String email = _emailController.text;
    String number = _numberController.text;
    String salary = _salaryController.text;
    String designation = _designationController.text;
    String joiningDate = _designationController.text;

    Map<String,String> emplyee = {
      'name':name,
      'email':email,
      'number':number,
      'salary':salary,
      'designation':designation,
      'boola': 'false',
      'joiningDate': joiningDate,
      'imageUrl': imageUrl ?? _image,

    };

    if(email.contains('@') && email.endsWith('.com')){
      emailValidation=true;
    }
    if(name==''){
      Fluttertoast.showToast(
          msg: "Please Enter Name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else  if (email.isEmpty){
      Fluttertoast.showToast(
          msg: "Please Enter  Email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
    else if(emailValidation!=true)
    {
      Fluttertoast.showToast(
          msg: "Please Enter Valid Email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else if(number==''){
      Fluttertoast.showToast(
          msg: "Please Enter Phone Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else if(number.length!=11){
      Fluttertoast.showToast(
          msg: "Please Enter 11 digits",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else if(designation==''){
      Fluttertoast.showToast(
          msg: "Please Enter Designation",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else if(salary==''){
      Fluttertoast.showToast(
          msg: "Please Enter Salary",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else if(joiningDate==''){
      Fluttertoast.showToast(
          msg: "Please Enter JoiningDate",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    else{
      if(key.isNotEmpty) {
        ref.child(key.toString()).update(emplyee).then((value) {
          Navigator.pop(context);
          // ignore: avoid_print
          print('monem monem monem');
        });
      }
    }
    }

}