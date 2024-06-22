import 'package:emas/modules/Notifications/notifications_screen.dart';
import 'package:emas/modules/ask_for_holiday/ask_screen.dart';
import 'package:emas/modules/information/information_screen.dart';
import 'package:emas/modules/salary_rating/salary_screen.dart';
import 'package:emas/modules/take_attendance/attendance_screen.dart';
import 'package:emas/shared/components/components.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EMAS',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
            icon: Icon(
              Icons.notifications,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              bottumItem(
                ontaped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AttendanceScreen()),
                  );
                },
                icon: 'assets/images/Checked User Male.png',
                text: 'Take Attendance',
              ),
              SizedBox(
                width: 26,
              ),
              bottumItem(
                ontaped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InformationScreen(),
                    ),
                  );
                },
                icon: 'assets/images/Info.png',
                text: 'Information',
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              bottumItem(
                ontaped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SalaryScreen()),
                  );
                },
                icon: 'assets/images/Card Wallet.png',
                text: 'Salary & Rating',
              ),
              SizedBox(
                width: 26,
              ),
              bottumItem(
                ontaped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AskScreen()),
                  );
                },
                icon: 'assets/images/Holiday.png',
                text: 'Ask for holiday',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
