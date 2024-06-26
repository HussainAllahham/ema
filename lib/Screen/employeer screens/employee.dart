import 'package:flutter/material.dart';
import 'package:graduation_project/Screen/employeer%20screens/Take_attendance.dart';
import 'package:graduation_project/Screen/employeer%20screens/ask_screen.dart';
// import 'package:graduation_project/Screen/employeer%20screens/attendance_screen.dart';
import 'package:graduation_project/Screen/employeer%20screens/information_screen.dart';
import 'package:graduation_project/Screen/employeer%20screens/salary_screen.dart';
import 'package:graduation_project/functions/drawer.dart';
import 'package:graduation_project/functions/style.dart';

// ignore: must_be_immutable
class EmployeeScreen extends StatelessWidget {
  EmployeeScreen({super.key});

  List options = [
    "Take Attendance",
    "Information",
    "Salary & Rating",
    "Ask for holiday"
  ];

  List icons = [
    'assets/images/Checked User Male.png',
    'assets/images/Info.png',
    'assets/images/Card Wallet.png',
    'assets/images/Holiday.png'
  ];

  String? shift_id_for_employee_info;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        toolbarHeight: (landscape)
            ? mediaQuery.size.height * (100 / 800)
            : mediaQuery.size.height * (70 / 800),
        backgroundColor:
            // const Color.fromRGBO(56, 149, 164, 1),
            const Color.fromRGBO(50, 50, 160, 1),
        leading: Builder(builder: (context) {
          return IconButton(
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          );
        }),
        automaticallyImplyLeading: false,
        title: Text(
          'EAMS',
          style: (landscape)
              ? getTextWhiteHeader(context)
              : getTextWhiteHeader(context),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: (landscape)
            ? mediaQuery.size.height - (mediaQuery.size.height * (100 / 800))
            : mediaQuery.size.height - (mediaQuery.size.height * (70 / 800)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 2; i++)
                  Container(
                      margin: (i == 0)
                          ? EdgeInsets.only(
                              left: mediaQuery.size.width * (16 / 360),
                              bottom: mediaQuery.size.width * (40 / 800),
                            )
                          : EdgeInsets.only(
                              right: mediaQuery.size.width * (16 / 360),
                              bottom: mediaQuery.size.width * (40 / 800),
                            ),
                      width: (landscape)
                          ? mediaQuery.size.width * (0.4)
                          : mediaQuery.size.width * (146 / 360),
                      height: (landscape)
                          ? mediaQuery.size.height * (0.3)
                          : mediaQuery.size.height * (140 / 800),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(50, 50, 160, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                          ),
                        ),
                        onPressed: () {
                          if (i == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TakeAttendance()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InformationScreen(),
                              ),
                            );
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: (landscape)
                                  ? mediaQuery.size.width * 0.3
                                  : mediaQuery.size.width * (41 / 360),
                              height: (landscape)
                                  ? mediaQuery.size.height * 0.15
                                  : mediaQuery.size.width * (41 / 360),
                              child: FittedBox(
                                child: Image.asset(
                                  icons[i],
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              options[i],
                              textAlign: TextAlign.center,
                              style: getTextWhite(context),
                            ),
                          ],
                        ),
                      ))
              ],
            ),
            // SizedBox(
            //   height: 40,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 2; i < 4; i++)
                  Container(
                      margin: (i == 2)
                          ? EdgeInsets.only(
                              left: mediaQuery.size.width * (16 / 360),
                              // right: mediaQuery.size.width * (36 / 360),
                              // bottom: mediaQuery.size.width * (40 / 800),
                            )
                          : EdgeInsets.only(
                              // left: mediaQuery.size.width * ( / 360),
                              right: mediaQuery.size.width * (16 / 360),
                              // bottom: mediaQuery.size.width * (40 / 800),
                            ),
                      width: (landscape)
                          ? mediaQuery.size.width * (0.4)
                          : mediaQuery.size.width * (146 / 360),
                      height: (landscape)
                          ? mediaQuery.size.height * (0.3)
                          : mediaQuery.size.height * (140 / 800),
                      // : mediaQuery.size.height * (123 / 800),
                      decoration: BoxDecoration(
                          color:
                              // Color.fromRGBO(56, 149, 164, 1),
                              const Color.fromRGBO(50, 50, 160, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                          ),
                        ),
                        onPressed: () {
                          if (i == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AskScreen()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SalaryScreen()),
                            );
                          }
                          // search_users_text = "";
                          // context.read<UsersDataCubit>().getUsersData();
                          // context
                          //     .read<DepartmentsDataCubit>()
                          //     .getDepartmentsData();
                          // context.read<ShiftsDataCubit>().getShiftsData();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute<void>(
                          //     builder: (BuildContext context) => navigators[i],
                          //   ),
                          // );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: (landscape)
                                  ? mediaQuery.size.width * 0.3
                                  : mediaQuery.size.width * (41 / 360),
                              height: (landscape)
                                  ? mediaQuery.size.height * 0.15
                                  : mediaQuery.size.width * (41 / 360),
                              child: FittedBox(
                                child: Image.asset(
                                  icons[i],
                                  color: Colors.white,
                                  // width: mediaQuery.size.width * (41 / 360),
                                  // height: mediaQuery.size.width * (41 / 360),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: mediaQuery.size.width * 1 / 50,
                            // ),
                            Text(
                              options[i],
                              textAlign: TextAlign.center,
                              style: getTextWhite(context),
                              // style: TextStyle(
                              //   color: Colors.white,
                              //   // fontSize: ,
                              // ),
                            ),
                          ],
                        ),
                      ))
              ],
            )
            // Row(
            //   children: [
            //     bottumItem(
            //       ontaped: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SalaryScreen()),
            // );
            //       },
            //       icon: 'assets/images/Card Wallet.png',
            //       text: 'Salary & Rating',
            //     ),
            //     SizedBox(
            //       width: 26,
            //     ),
            //     bottumItem(
            //       ontaped: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AskScreen()),
            // );
            //       },
            //       icon: 'assets/images/Holiday.png',
            //       text: 'Ask for holiday',
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
