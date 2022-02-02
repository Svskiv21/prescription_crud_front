import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:prescription_crud_front/objects/patient_object.dart';
import 'package:prescription_crud_front/show_patients.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final patientName = TextEditingController();
  final patientLastName = TextEditingController();
  final patientPesel = TextEditingController();
  PatientObject patientObject = PatientObject();
  // FilterObject filters = FilterObject();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        content: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Add new patient",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      child: Text("Name"),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      decoration: boxDecoration(),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        controller: patientName,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      child: Text("Last name"),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      decoration: boxDecoration(),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                        controller: patientLastName,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      child: Text("PESEL"),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      decoration: boxDecoration(),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter pesel';
                          }
                          if(validateNumbers(value)) {
                            return "Contains Letters";
                          } else {
                            if(value.length == 11) {
                              return null;
                            } else {
                              return "Invalid length";
                            }
                          }
                        },
                        controller: patientPesel,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            patientName.clear();
                            patientLastName.clear();
                            patientPesel.clear();
                            // Navigator.pop(context);
                          },
                          child: Text("Clear"),
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              patientObject.name = patientName.text;
                              patientObject.lastName = patientLastName.text;
                              patientObject.pesel = patientPesel.text;
                              sendRequest(patientObject);
                            }
                          },
                          child: Text("Add"),
                        ),
                        RaisedButton(
                          onPressed: () {

                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                ShowPatients()));
                          },
                          child: Text("Show all"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateNumbers(String value) {
    if(double.tryParse(value) != null) {
      return false;
    }
    return true;
  }

  Future<void> sendRequest(PatientObject patientObject) async {
    var body = {
      "name": patientObject.name,
      "lastName": patientObject.lastName,
      "pesel": patientObject.pesel
    };

    print(body);
    print(json.encode(body));
    var response = await post(Uri.parse("http://10.0.2.2:8080/patients/new-patient"),
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Accept-Encoding": "gzip, deflate, br",
        },

        body: json.encode(body),
        encoding: Encoding.getByName("utf-8"));

    print(response.body);
    print(response.statusCode);
    if(response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.body)),
      );
    }
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(border: Border.all());
  }
}
