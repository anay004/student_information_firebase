//model class
class Save {
  String? email;
  String? password;

  //constructor
  Save({
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
  static Save fromJson(Map<String,dynamic> json){
    return Save(
      email: json['email'],
      password:json['password'],
    );
  }
}
