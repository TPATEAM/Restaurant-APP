class Employee {
  int? idEmployee;
  String? name;
  String? lastName;
  int? role;
  String? username;
  String? password;

  Employee({
    this.idEmployee,
    this.name,
    this.lastName,
    this.role,
    this.username,
    this.password,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      idEmployee: int.parse(json['idEmployee']),
      name: json['name'],
      lastName: json['lastName'],
      role: int.parse(json['role']),
      username: json['username'],
      password: json['password'],
    );
  }
}
