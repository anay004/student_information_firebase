import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_information_firebase/home_page.dart';
import 'package:student_information_firebase/model/notes.dart';
import 'package:student_information_firebase/services/note_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:student_information_firebase/update_stu.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  final NoteService noteService = NoteService();
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  Future<void> loadAllData() async {
    noteService.getStudents().listen((studentList) {
      setState(() {
        notes = studentList;
      });
    }, onError: (error) {
      Fluttertoast.showToast(
        msg: "Error fetching data: $error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    });
  }

  Future<void> deleteData(String id) async {
    await noteService.deleteStudent(id).then((_) {
      Fluttertoast.showToast(msg: "Student Information deleted successfully");
      loadAllData();
    }).catchError((error) {
      Fluttertoast.showToast(msg: "Failed to delete Student Information: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Student List",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAll(HomePage());
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: notes.isEmpty
                ? Center(
              child: Text(
                "No Student List Available",
                style: TextStyle(color: Colors.white),
              ),
            )
                : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                // Note initialize
                Note student = notes[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[900],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      onTap: () {
                        // Navigate to update page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateStu(notes: student)),
                        );
                      },
                      title: Text(
                        student.name ?? "No Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        student.id ?? "No ID",
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: student.imagepath != null && student.imagepath!.isNotEmpty
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.file(
                          File(student.imagepath!),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Icon(
                        Icons.account_circle_outlined,
                        size: 60,
                        color: Colors.white,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            headerAnimationLoop: false,
                            animType: AnimType.bottomSlide,
                            dialogBackgroundColor: Colors.black,
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 3,
                            ),
                            title: 'Delete',
                            titleTextStyle: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                            desc: 'Want To Delete this Student Information',
                            descTextStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                            btnOk: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                side: BorderSide(
                                    color: Colors.white, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                deleteData(student.id!);
                                Get.back();
                              },
                              child: Text(
                                'YES',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            btnCancel: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                side: BorderSide(
                                    color: Colors.white, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'NO',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ).show();
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 40,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
