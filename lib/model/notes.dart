//model class
class Note {
  String? imagepath;
  String? id;
  String? name;
  String? phone;
  String? department;
  String? email;
  String? address;

  //constructor
  Note({

    required this.id,
    required this.name,
    required this.phone,
    required this.department,
    required this.email,
    required this.address,
    required this.imagepath,

  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'department': department,
      'email': email,
      'address': address,
      'image': imagepath,
    };
  }
  static Note fromJson(Map<String,dynamic> json){
    return Note(
      id : json['id'],
      name:json['name'],
      phone:json['phone'],
      department:json['department'],
      email: json['email'],
      address:json['address'],
      imagepath:json['image'],
    );
  }
}
