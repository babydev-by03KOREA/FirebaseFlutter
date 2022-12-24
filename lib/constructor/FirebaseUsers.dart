class Users {
  String id;
  String name;
  int age;
  DateTime birthday;

  Users({this.id = '', required this.name, required this.age, required this.birthday});

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'age' : age,
    'birthday' : birthday,
  };
}