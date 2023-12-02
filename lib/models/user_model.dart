
class UserModel {
  String name;
  String phone;
  String email;
  String password;
  bool isEmailVerified;
  String uId;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.uId,
    required this.password,
    required this.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json)=>
      UserModel(
          name: json['name'],
          phone: json['phone'],
          email: json['email'],
          uId: json['uId'],
        password:json['password'],
        isEmailVerified: json['isEmailVerified'],
      );

  Map<String , dynamic> toJson()=> {
    'name': name,
    'phone': phone,
    'email': email,
    'uId':uId,
    'password': password,
    'isEmailVerified': isEmailVerified,
  };

}