class Login {
  int id;
  String name;
  String email;

  Login({this.id, this.name, this.email});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };

  Login.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'];
}
