class Users {
  String name;
  String password;
  String email;
  String age;

  // Constructor con parámetros nombrados
  Users({
    required this.name,
    required this.password,
    required this.email,
    required this.age,
  });
}
Users miUsuario = Users(
  name: 'ale',
  password: 'ale',
  email: 'ale@gmail.com',
  age: '20',
);

