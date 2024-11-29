import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_information_firebase/home_page.dart';
import 'package:student_information_firebase/services/note_service.dart';

import 'model/notes.dart';

class AddStu extends StatefulWidget {
  const AddStu({super.key});

  @override
  State<AddStu> createState() => _AddStuState();
}

class _AddStuState extends State<AddStu> {
  var idController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var departmentController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  final GlobalKey<FormState> infoFormKey = GlobalKey();

  File? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> addstu() async {
    final newNote = Note(
      id: idController.text,
      name: nameController.text,
      phone: phoneController.text,
      department: departmentController.text,
      email: emailController.text,
      address: addressController.text,
      imagepath: _pickedImage?.path, // Save image path
    );

    final NoteService noteService = NoteService();

    try {
      await noteService.addStudent(newNote);

      Get.snackbar(
        "",
        "",
        titleText: Text(
          "Success! Info Added",
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(HomePage());
    } catch (error) {
      print("Error: $error");

      Get.snackbar(
        "",
        "",
        titleText: Text(
          "Error in Info Added",
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title: const Text("Add Student Info", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: infoFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Picker Section
              Column(
                children: [
                  // Image Preview
                  _pickedImage == null
                      ? Text(
                    "No image selected",
                    style: TextStyle(color: Colors.white),
                  )
                      : Image.file(
                    _pickedImage!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  // Pick Image Button
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(Icons.image),
                    label: Text("Pick Image"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                  ),
                ],
              ),



              // ID Input Field
              Text("ID:",
                style: GoogleFonts.lato(
                  textStyle:TextStyle(fontSize: 16, color: Colors.white),),
              ),
              SizedBox(height: 5),
              TextFormField(
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),),
                controller: idController,
                decoration: InputDecoration(
                  fillColor: Colors.teal[900],
                  filled: true,
                  //hintText: "Enter ID ",
                  labelText: "Enter ID",
                  labelStyle: GoogleFonts.lato(
                    color: Colors.white.withOpacity(1),),
                  //prefixIcon: const Icon(Icons.title, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey, // Border color
                      width: 3,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.blueGrey, // Border color for enabled state
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey, // Border color when focused
                      width: 3,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter ID";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Name Input Field
              Text(
                "Name:",
                style: GoogleFonts.lato(
                  textStyle:TextStyle(fontSize: 16, color: Colors.white),),
              ),
              SizedBox(height: 5),
              TextFormField(
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),),
                controller: nameController,
                //maxLines: 3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal[900],
                  //hintText: "Enter Name",
                  labelText: "Enter Name",
                  labelStyle: GoogleFonts.lato(
                    color: Colors.white.withOpacity(1),),
                  //prefixIcon: const Icon(Icons.description, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 3,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 3,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Phone Input Field
              Text(
                "Phone Number:",
                style: GoogleFonts.lato(
                  textStyle:TextStyle(fontSize: 16, color: Colors.white),),
              ),
              SizedBox(height: 5),
              TextFormField(
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),),
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal[900],
                  //hintText: "Enter Phone number",
                  labelText: "Enter Phone number",
                  labelStyle: GoogleFonts.lato(
                    color: Colors.white.withOpacity(1),),
                  //prefixIcon: const Icon(Icons.phone, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 3,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 3,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter phone number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              //Department Input Field
              Text(
                "Department:",
                style: GoogleFonts.lato(
                  textStyle:TextStyle(fontSize: 16, color: Colors.white),),
              ),
              SizedBox(height: 5),
              TextFormField(
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),),
                controller: departmentController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal[900],
                 // hintText: "Enter Department",
                  labelText: "Enter Department",
                  labelStyle: GoogleFonts.lato(
                    color: Colors.white.withOpacity(1),),
                  //prefixIcon: const Icon(Icons.local_fire_, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 3,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 3,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Department";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Email Input Field
              Text(
                "Email:",
                style: GoogleFonts.lato(
                  textStyle:TextStyle(fontSize: 16, color: Colors.white),),
              ),
              SizedBox(height: 5),
              TextFormField(
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal[900],
                 // hintText: "Enter email address",
                  labelText: "Enter email address",
                  labelStyle: GoogleFonts.lato(
                    color: Colors.white.withOpacity(1),),
                  //prefixIcon: const Icon(Icons.email, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 3,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 3,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email address";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Address Input Field
              Text(
                "Address:",
                style: GoogleFonts.lato(
                  textStyle:TextStyle(fontSize: 16, color: Colors.white),),
              ),
              SizedBox(height: 5),
              TextFormField(
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),),
                controller: addressController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal[900],
                  labelText: "Enter Address",
                  labelStyle: GoogleFonts.lato(
                    color: Colors.white.withOpacity(1),
                  ),
                   border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 3,
                    ),
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8),
                     borderSide: BorderSide(
                       color: Colors.blueGrey,
                       width: 3,
                     ),
                   ),
                   focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 3,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter address";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Save Button
              Center(
                child:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (infoFormKey.currentState!.validate()) {
                      infoFormKey.currentState!.save();
                      addstu();
                    }
                  },
                  child:  Text(
                    "Save Student Info",
                    style: GoogleFonts.lato(
                      textStyle:TextStyle(fontSize: 16, color: Colors.white),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
