import 'package:flutter/material.dart';
import 'package:new_project/models/student_model.dart';
import 'package:new_project/models/student_storage.dart';

import 'package:new_project/screens/student_page.dart';

class StudentList extends StatefulWidget {
  final indexSinif;
  final StudentStorage studentStorage;
  const StudentList(
      {Key? key, required this.indexSinif, required this.studentStorage})
      : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrenci Listesi'),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              '${widget.indexSinif} Öğrenci Listesi',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: students.length,
                itemBuilder: (context, index) {
                  if (students[index].sinif == widget.indexSinif) {
                    var indexOgrenci = students[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StudentPage(
                                    indexOgrenci: indexOgrenci,
                                    studentStorage: StudentStorage())));
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              students[index].isim,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  } else {
                    return Center();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
