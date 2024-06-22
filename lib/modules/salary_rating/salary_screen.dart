import 'package:emas/modules/employee/employee.dart';
import 'package:flutter/material.dart';

class SalaryScreen extends StatelessWidget {
  const SalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salary & Rationg',
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
    );
  }
}
