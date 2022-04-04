class Employee {
  String? idEmployee;
  String? name;
  String? lastName;
  String? role;
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
      idEmployee: json['idEmployee'],
      name: json['name'],
      lastName: json['lastName'],
      role: json['role'],
      username: json['username'],
      password: json['password'],
    );
  }
}
