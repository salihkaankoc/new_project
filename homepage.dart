import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:new_project/models/student_model.dart';
import 'package:new_project/models/student_storage.dart';
import 'package:new_project/models/teacher_model.dart';
import 'package:new_project/models/teacher_storage.dart';
import 'package:new_project/screens/student_list.dart';

class HomePage extends StatefulWidget {
  final indexOgr;
  final StudentStorage storage;
  final TeacherStorage teacherStorage;
  const HomePage(
      {Key? key,
      required this.storage,
      required this.teacherStorage,
      required this.indexOgr})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Student> students = [];
  List<Teacher> teachers = [];
  @override
  void initState() {
    widget.storage.readStudents().then((value) {
      if (value != null) {
        setState(() {
          students = value;
        });
      }
    });
    widget.teacherStorage.readTeachers().then((value) {
      if (value != null) {
        setState(() {
          teachers = value;
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  Future<File> _addTeacher(Teacher teacher) {
    setState(() {
      teachers.add(teacher);
    });

    return widget.teacherStorage.writeTeachers(teachers);
  }

  Future<File> _addStudent(Student student) {
    setState(() {
      students.add(student);
    });

    return widget.storage.writeStudents(students);
  }

  final _ad = TextEditingController();
  final _sinif = TextEditingController();
  final _sifre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrenci Takip'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: _ad,
            decoration: InputDecoration(
              hintText: 'Ad',
            ),
          ),
          TextField(
            controller: _sifre,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          TextField(
            controller: _sinif,
            decoration: InputDecoration(
              hintText: 'Sınıflar',
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                print(teachers.length);

                print(students.length);

                if (_ad.text.isNotEmpty && _sinif.text.isNotEmpty) {
                  Student student = Student(
                      isPassed: false,
                      id: '100',
                      vize: '0',
                      finalNotu: '0',
                      sinif: _sinif.text,
                      ortalama: '0',
                      isim: _ad.text);
                  _addStudent(student);
                  _ad.clear();
                  _sifre.clear();
                }
              },
              child: Text('Kaydet')),
          FutureBuilder(
              future: widget.teacherStorage.readTeachers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      var indexSinif = widget.indexOgr.sinifListesi[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => StudentList(
                                  indexSinif: indexSinif,
                                  studentStorage: StudentStorage())));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                    widget.indexOgr.sinifListesi[index]
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }
}
