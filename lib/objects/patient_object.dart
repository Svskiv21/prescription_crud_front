

import 'dart:convert';

import 'package:http/http.dart';

class PatientObject {

  String? id;
  String? name;
  String? lastName;
  String? pesel;

  PatientObject({this.name, this.lastName, this.pesel, this.id});

  factory PatientObject.fromJson(Map<String, dynamic> json){
    return PatientObject(
      // id: json["id"],
      name: json["name"],
      lastName: json["lastName"],
      pesel: json["pesel"]
    );
  }

  static Future<List<PatientObject>> getAllPatients() async {
    // make request
    List<PatientObject> items;
    Response response = await get(Uri.parse("http://10.0.2.2:8080/patients/all-patients"));
    var data = jsonDecode(response.body);
    print(data);
    var list = data as List;
    print(list);
    items = list.map<PatientObject>((json) => PatientObject.fromJson(json)).toList();

    return items;
  }

  // static Future<void> sendRequest(PatientObject patientObject) async {
  //   var body = {
  //     "name": patientObject.name,
  //     "lastName": patientObject.lastName,
  //     "pesel": patientObject.pesel
  //   };
  //
  //   print(body);
  //   print(json.encode(body));
  //   var response = await post(Uri.parse("http://10.0.2.2/patients/new-patient"),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Access-Control-Allow-Origin": "*",
  //         "Accept-Encoding": "gzip, deflate, br",
  //       },
  //
  //       body: json.encode(body),
  //       encoding: Encoding.getByName("utf-8"));
  //
  //   if(response.statusCode != 200) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text(response.body)),
  //     );
  //   }
  // }
}