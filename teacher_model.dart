class Teacher {
  String userName;
  String password;
  List sinifListesi;

  Teacher(
      {required this.userName,
      required this.password,
      required this.sinifListesi});

  factory Teacher.fromJson(Map<String, dynamic> map) {
    return Teacher(
        userName: map['userName'],
        password: map['password'],
        sinifListesi: map['sinifListesi']);
  }

  Map<String, dynamic> get toJson => {
        'userName': userName,
        'password': password,
        'sinifListesi': sinifListesi,
      };
}
