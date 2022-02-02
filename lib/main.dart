import 'package:flutter/material.dart';
import 'package:prescription_crud_front/form.dart';
import 'package:prescription_crud_front/show_patients.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      '/' : (context) => MyForm(),
      '/all' : (context) => ShowPatients(),
    },
  ));
}
