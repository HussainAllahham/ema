import 'package:emas/modules/employee/employee.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, [EmployeeScreen()]);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          'Attendance',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 40,
            ),
            child: Container(
              width: double.infinity,
              height: 214,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: HexColor('FFFFFF'),
                border: Border.all(
                  color: HexColor('7D7D7D'),
                ),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/Camera.png'),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 180,
                    child: Text(
                      'You should open the camera ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      var image = await ImagePicker()
                          .pickImage(source: ImageSource.camera)
                          .then((value) {})
                          .catchError(() {});
                    },
                    height: 42,
                    minWidth: 175,
                    color: HexColor('3232A0'),
                    child: Text(
                      'open camera',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(78.5),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
