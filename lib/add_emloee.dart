import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'contants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  TextEditingController _nameController, _emailController, _numberController, _designationController, _salaryController,_dateController;
  DatabaseReference _ref;
  String imageUrl;

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
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _emailController = TextEditingController();
    _designationController = TextEditingController();
    _salaryController = TextEditingController();
    _dateController = TextEditingController();
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
                          const Text('Employess data',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                          const SizedBox(height: 5,),

                       imageUrl==null? InkWell(
                          onTap: (){
                            setState(() {
                              uploadImage();
                            });

                          },
                          child: Center(

                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black,width: 4),
                              ),
                              width: screenSize.width*0.4,
                              height: screenSize.height*0.2,
                              child: Image.asset('assets/edit.png'),),
                          ),
                        ):
                       InkWell(
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
                          ),
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
                              keyboardType: TextInputType.text,
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: 'Name',
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
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'pagieportal@gmail.com',
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
                              keyboardType: TextInputType.number,
                              controller: _numberController,
                              decoration: InputDecoration(

                                hintText: '030001111111',

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
                              keyboardType: TextInputType.text,
                              controller: _designationController,

                              decoration: InputDecoration(

                                hintText: 'Designation',

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
                              keyboardType: TextInputType.number,
                              controller: _salaryController,

                              decoration: InputDecoration(
                                hintText: 'Salary',

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
                              keyboardType: TextInputType.datetime,
                              controller: _dateController,
                              decoration: InputDecoration(
                                hintText: '12/12/2020',

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
                                saveEmployee(imageUrl:imageUrl);
                              },
                              child: Container(
                                width: screenSize.width*0.7,
                                height: screenSize.width*0.16,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Constants.kPrimaryColor
                                ),
                                child:const Center(child: Text('+ Add',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21,color: Colors.white))) ,
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
  void saveEmployee({String imageUrl}){
    String name = _nameController.text;
    String email = _emailController.text;
    String number = _numberController.text;
    String salary = _salaryController.text;
    String designation = _designationController.text;
    String joiningDate = _dateController.text;


    Map<String,String> employee = {
      'name':name,
      'email':email,
      'number':number,
      'salary':salary,
      'designation':designation,
      'boola': 'false',
      'joiningDate': joiningDate,
      'imageUrl': imageUrl,

    };

    if(email.contains('@') && email.endsWith('.com')){
      emailValidation=true;

    }
    if(imageUrl==null){
      Fluttertoast.showToast(
          msg: "Add the Image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

   else if(name==''){
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
    else {
      _ref.push().set(employee).then((value) {
        // ignore: avoid_print
        print('success');
        Navigator.pop(context);
      });

    }


  }









}