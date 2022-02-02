import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prescription_crud_front/all_patients.dart';

class ShowPatients extends StatefulWidget {
  const ShowPatients({Key? key}) : super(key: key);

  @override
  _ShowPatientsState createState() => _ShowPatientsState();
}

class _ShowPatientsState extends State<ShowPatients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ViewPatients(),
      ),
    );
  }
}
