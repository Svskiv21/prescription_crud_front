import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prescription_crud_front/objects/patient_object.dart';

class ViewPatients extends StatefulWidget {
  const ViewPatients({Key? key}) : super(key: key);

  @override
  _ViewPatientsState createState() => _ViewPatientsState();
}

class _ViewPatientsState extends State<ViewPatients> {

  Future<List<PatientObject>> getData() async {
    List<PatientObject> itemsFromCategory = await PatientObject.getAllPatients();
    return itemsFromCategory;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, snapshot) {
        // Checking if future is resolved or not
        if (snapshot.connectionState == ConnectionState.done) {
          // If we got an error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occured',
                style: TextStyle(fontSize: 18),
              ),
            );

            // if we got our data
          } else if (snapshot.hasData) {
            // Extracting data from snapshot object
            List<PatientObject>? items = snapshot.data as List<PatientObject>?;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: items!.length,
              itemBuilder: (context, index) {
                PatientObject item = items[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {

                    },
                    child: Container(
                      color: Colors.grey[300],
                      child: SizedBox(
                        width: 400,
                        // height: 200,
                        child: Column(
                          children: [
                            Text(
                              "Name: ${item.name!}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Last name: ${item.lastName!}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "PESEL: ${item.pesel!}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Text(
                            //   'Last Sale : 289 USD',
                            //   style: TextStyle(fontSize: 10, color: Colors.black38),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }

        // Displaying LoadingSpinner to indicate waiting state
        return Scaffold(
          backgroundColor: Colors.tealAccent,
          body: Center(
            child: SpinKitCircle(
              color: Colors.white,
              size: 50.0,
            ),
          ),
        );
      },

      // Future that needs to be resolved
      // inorder to display something on the Canvas
      future: getData(),
    );
  }
}
