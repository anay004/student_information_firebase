import 'package:firebase_database/firebase_database.dart';
import 'package:student_information_firebase/model/notes.dart';

class NoteService {
  // Connect to Firebase database
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref('notes');

  // Get all student data from Firebase database
  Stream<List<Note>> getStudents() {
    return dbReference.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};

      // Safely parse data to a list of Note objects
      return data.entries.map((entry) {
        try {
          final studentData = Map<String, dynamic>.from(entry.value);
          return Note.fromJson(studentData);
        } catch (e) {
          print("Error parsing student: ${entry.key} -> ${entry.value}");
          return Note(
              id: 'id',
              name: 'name',
              phone: 'phone',
              department: 'department',
              email: 'email',
              address: 'address',

          ); // Return empty Note on error
        }
      }).toList();
    });
  }

  // Check if a student exists in the database
  Future<bool> doesStudentExist(String id) async {
    final snapshot = await dbReference.child(id).get();
    return snapshot.exists;
  }

  // Add a new student to the database
  Future<void> addStudent(Note student) async {
    if (await doesStudentExist(student.id!)) {
      print("Error: A student with this ID already exists!");
      return;
    }

    await dbReference.child(student.id!).set(student.toJson());
  }

  // Update student data
  Future<void> updateStudent(Note student) async {
    if (student.id != null && student.id!.isNotEmpty) {
      await dbReference.child(student.id!).set(student.toJson());
    } else {
      print("Error: Student ID is null or empty!");
    }
  }

  // Delete a student from the database
  Future<void> deleteStudent(String id) async {
    try {
      await dbReference.child(id).remove();
      print("Student with ID $id deleted successfully.");
    } catch (e) {
      print("Error deleting student with ID $id -> $e");
    }
  }
}
