class Student {
  String id;
  String isim;
  String vize;
  String sinif;
  String finalNotu;
  String ortalama;
  bool isPassed;

  Student(
      {required this.id,
      required this.vize,
      required this.finalNotu,
      required this.sinif,
      required this.ortalama,
      required this.isim,
      required this.isPassed});

  factory Student.fromJson(Map<String, dynamic> map) {
    return Student(
        isim: map['isim'],
        id: map['id'],
        vize: map['vize'],
        sinif: map['sinif'],
        finalNotu: map['finalNotu'],
        ortalama: map['ortalama'],
        isPassed: map['isPassed']);
  }

  Map<String, dynamic> get toJson => {
        'isim': isim,
        'id': id,
        'vize': vize,
        'sinif': sinif,
        'finalNotu': finalNotu,
        'ortalama': ortalama,
        'isPassed': isPassed,
      };
}
