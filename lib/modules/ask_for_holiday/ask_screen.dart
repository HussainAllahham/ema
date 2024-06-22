import 'package:emas/modules/employee/employee.dart';
import 'package:emas/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

var startDateController = TextEditingController();
var endDateController = TextEditingController();
var reasonController = TextEditingController();
var formKey = GlobalKey<FormState>();

class AskScreen extends StatelessWidget {
  const AskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ask for holiday',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, [EmployeeScreen()]);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defultFormField(
                ontap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                  ).then((value) {
                    if (value != null) {
                      String formattedDate =
                          DateFormat.yMMMMd('en_US').format(value);
                      startDateController.text = formattedDate;
                    }
                  });
                },
                readonly: true,
                controller: startDateController,
                labeltext: 'Start date',
                prefixicon: Icons.calendar_month_sharp,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'You must enter the date';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 27,
              ),
              defultFormField(
                ontap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                  ).then((value) {
                    if (value != null) {
                      var formatdate = DateFormat.yMMMMd('en_US').format(value);
                      endDateController.text = formatdate;
                    }
                  });
                },
                readonly: true,
                controller: endDateController,
                labeltext: 'End date',
                prefixicon: Icons.calendar_month_sharp,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'You must enter the date';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 27,
              ),
              defultFormField(
                ontap: () {},
                controller: reasonController,
                labeltext: 'reason',
                prefixicon: Icons.info,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'You must enter the reason';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 74,
              ),
              MaterialButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    startDateController.text = '';
                    endDateController.text = '';
                    reasonController.text = '';
                  }
                },
                height: 53,
                minWidth: 224,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: HexColor('3232A0'),
                child: Text(
                  'send',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
