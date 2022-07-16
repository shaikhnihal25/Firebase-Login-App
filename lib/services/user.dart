class Users {
  final String username;
  final String phone;

  Users({required this.username, required this.phone});

  Map<String, dynamic> toJson() => {
        "username": username,
        "phone": phone,
      };

  static Users fromJson(Map<String, dynamic> json) =>
      Users(username: json["username"], phone: json["phone"]);
}
