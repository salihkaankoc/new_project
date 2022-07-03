import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:new_project/models/student_model.dart';
import 'package:path_provider/path_provider.dart';

class StudentStorage {
  List<Student> studentFromJson(String str) =>
      List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

  String studentToJson(List<Student> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson)));

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/ogrenciler.json');
  }

  Future<List<Student>?> readStudents() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();

      return studentFromJson(contents);
    } catch (_) {
      return null;
    }
  }

  Future<File> writeStudents(List<Student> students) async {
    final file = await _localFile;

    String studentsAsString = studentToJson(students);
    return file.writeAsString(studentsAsString);
  }

  Future<File> changeVize(List<Student> students, int index) async {
    final file = await _localFile;

    String yeniVizeNotu = students[index].vize;

    String newString = studentToJson(students);
    return file.writeAsString(newString);
  }

  Future<File> changeFinal(List<Student> students, int index) async {
    final file = await _localFile;

    String yeniFinalNotu = students[index].finalNotu;

    String newString = studentToJson(students);
    return file.writeAsString(newString);
  }
}
