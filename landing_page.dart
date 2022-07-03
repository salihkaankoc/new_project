import 'package:flutter/material.dart';
import 'package:new_project/models/student_storage.dart';
import 'package:new_project/models/teacher_model.dart';
import 'package:new_project/models/teacher_storage.dart';
import 'package:new_project/screens/homepage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final kullaniciAdiController = TextEditingController();

  final sifreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Öğrenci Takip',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 300,
              child: TextField(
                controller: kullaniciAdiController,
                decoration: InputDecoration(
                  hintText: 'Kullanıcı Adı',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 300,
              child: TextField(
                obscureText: true,
                controller: sifreController,
                decoration: InputDecoration(
                  hintText: 'Şifre',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              width: 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent),
                      onPressed: () async {
                        login();
                      },
                      child: Text('Giriş Yap'),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  login() {
    List<Teacher> ogretmenListesi = [
      Teacher(
          userName: 'aliogr',
          password: 'aliogr',
          sinifListesi: ["4A", "4B", "4C", "4D"]),
      Teacher(
          userName: 'ahmetogr',
          password: 'ahmetogr',
          sinifListesi: ["5A", "5B", "5C", "5D"]),
    ];
    if (ogretmenListesi[0].userName == kullaniciAdiController.text &&
        ogretmenListesi[0].password == sifreController.text) {
      var indexOgretmen = ogretmenListesi[0];

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(
                indexOgr: indexOgretmen,
                storage: StudentStorage(),
                teacherStorage: TeacherStorage(),
              )));
    } else {
      if (ogretmenListesi[1].userName == kullaniciAdiController.text &&
          ogretmenListesi[1].password == sifreController.text) {
        var indexOgretmen2 = ogretmenListesi[1];
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage(
                  indexOgr: indexOgretmen2,
                  storage: StudentStorage(),
                  teacherStorage: TeacherStorage(),
                )));
      } else {
        return null;
      }
    }
  }
}
