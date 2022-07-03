import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_project/models/student_model.dart';
import 'package:new_project/models/student_storage.dart';

class StudentPage extends StatefulWidget {
  final indexOgrenci;
  final StudentStorage studentStorage;
  const StudentPage(
      {Key? key, required this.indexOgrenci, required this.studentStorage})
      : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final _vizeController = TextEditingController();
  final _finalController = TextEditingController();
  bool passed = false;

  List<Student> students = [];
  @override
  void initState() {
    widget.studentStorage.readStudents().then((value) {
      if (value != null) {
        setState(() {
          students = value;
        });
      }
    });
    passed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrenci Detay'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('Kayıtlı Olduğu Sınıf: ${widget.indexOgrenci.sinif}'),
              Text('İsmi: ${widget.indexOgrenci.isim}'),
              Text('Vize Notu: ${widget.indexOgrenci.vize}'),
              Text('Final Notu: ${widget.indexOgrenci.finalNotu}'),
              Text('Ortalama: ${widget.indexOgrenci.ortalama}'),
              Container(
                height: 20,
                width: 50,
                decoration: BoxDecoration(
                  color:
                      widget.indexOgrenci.isPassed ? Colors.green : Colors.red,
                ),
                child: widget.indexOgrenci.isPassed
                    ? Center(
                        child: Text(
                        'Geçti',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ))
                    : Center(
                        child: Text(
                        'Kaldı',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
              ),
              TextField(
                controller: _vizeController,
                decoration: InputDecoration(
                  hintText: 'Vize Notu',
                ),
              ),
              TextField(
                controller: _finalController,
                decoration: InputDecoration(
                  hintText: 'Final Notu',
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_vizeController.text.isNotEmpty) {
                          Future<File> _changeVize(Student student) {
                            student = widget.indexOgrenci;
                            setState(() {
                              widget.indexOgrenci.vize = _vizeController.text;
                            });

                            final tile = students.firstWhere((element) =>
                                element.id == widget.indexOgrenci.id);
                            setState(() {
                              tile.vize = _vizeController.text;
                            });
                            return widget.studentStorage
                                .changeVize(students, index);
                          }

                          _changeVize(widget.indexOgrenci);
                        }
                      },
                      child: const Text('Vize Kaydet'),
                    );
                  }),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_finalController.text.isNotEmpty) {
                          Future<File> _changeFinal(Student student) {
                            student = widget.indexOgrenci;
                            setState(() {
                              widget.indexOgrenci.finalNotu =
                                  _finalController.text;
                            });

                            final tile = students.firstWhere((element) =>
                                element.id == widget.indexOgrenci.id);
                            setState(() {
                              widget.indexOgrenci.ortalama = tile.ortalama;
                            });
                            return widget.studentStorage
                                .changeFinal(students, index);
                          }

                          _changeFinal(widget.indexOgrenci);
                        }
                      },
                      child: const Text('Final Kaydet'),
                    );
                  }),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final tile = students.firstWhere((element) =>
                              element.id == widget.indexOgrenci.id);

                          tile.ortalama = widget.indexOgrenci.ortalama;

                          widget.indexOgrenci.ortalama = ((int.parse(
                                              widget.indexOgrenci.vize) *
                                          4) /
                                      10 +
                                  (int.parse(widget.indexOgrenci.finalNotu) *
                                          6) /
                                      10)
                              .toString();
                        });
                        if (double.parse(widget.indexOgrenci.ortalama) >= 65) {
                          setState(() {
                            widget.indexOgrenci.isPassed = true;
                          });
                        }
                      },
                      child: const Text('Ortalama Hesapla'),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
