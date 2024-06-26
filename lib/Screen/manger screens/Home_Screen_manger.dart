// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Cubits/Departments%20Data/cubit/departments_data_cubit.dart';
import 'package:graduation_project/Cubits/Shifts%20data/shifts_data_cubit.dart';
import 'package:graduation_project/Cubits/Users%20data/users_data_cubit.dart';
import 'package:graduation_project/Screen/manger%20screens/attendance/attendance.dart';
import 'package:graduation_project/Screen/manger%20screens/departments%20manger/Departments_list.dart';
import 'package:graduation_project/Screen/manger%20screens/employee%20manger/Employee_list.dart';
import 'package:graduation_project/Screen/manger%20screens/shifts%20manger/Shifts_list.dart';
import 'package:graduation_project/data/Repository/get_users_Repo.dart';
import 'package:graduation_project/functions/drawer.dart';
import 'package:graduation_project/functions/style.dart';

class HomeScreenManger extends StatelessWidget {
  HomeScreenManger();

  List options = ["Employee List", "Attendance Repo", "Departments", "Shifts"];

  List icons = [
    'assets/images/Employee_list_logo.png',
    'assets/images/Attendance_report_logo.png',
    'assets/images/Departments_logo.png',
    'assets/images/Shifts_logo.png'
    // Icons.paste_rounded,
    // Icons.text_snippet_outlined,
    // Icons.swap_horiz_outlined,
  ];

  List navigators = [
    EmployeeList(),
    Attendance(),
    DepartmentList(),
    ShiftsList()
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    return SafeArea(
      child: Scaffold(
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
            title:
                // Container(
                //     width: MediaQuery.of(context).size.width * 3 / 5,
                //     child: FittedBox(child: Text("Employee Mangement System"))),
                Text(
              'EAMS',
              style: (landscape)
                  ? getTextWhiteHeader(context)
                  : getTextWhiteHeader(context),
            ),
            centerTitle: true,
          ),
          body: Container(
            // color: Colors.red,
            height: (landscape)
                ? mediaQuery.size.height -
                    (mediaQuery.size.height * (100 / 800))
                : mediaQuery.size.height -
                    (mediaQuery.size.height * (70 / 800)),
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
                                  // right: mediaQuery.size.width * (36 / 360),
                                  bottom: mediaQuery.size.width * (40 / 800),
                                )
                              : EdgeInsets.only(
                                  // left: mediaQuery.size.width * ( / 360),
                                  right: mediaQuery.size.width * (16 / 360),
                                  bottom: mediaQuery.size.width * (40 / 800),
                                ),
                          width: (landscape)
                              ? mediaQuery.size.width * (0.4)
                              : mediaQuery.size.width * (146 / 360),
                          height: (landscape)
                              ? mediaQuery.size.height * (0.3)
                              : mediaQuery.size.height * (140 / 800),
                          // mediaQuery.size.height * (123 / 800)
                          decoration: BoxDecoration(
                              color:
                                  // Color.fromRGBO(56, 149, 164, 1),
                                  const Color.fromRGBO(50, 50, 160, 1),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                              ),
                            ),
                            onPressed: () {
                              search_users_text = "";
                              context.read<UsersDataCubit>().getUsersData();
                              context
                                  .read<DepartmentsDataCubit>()
                                  .getDepartmentsData();
                              context.read<ShiftsDataCubit>().getShiftsData();
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      navigators[i],
                                ),
                              );
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
                                //   width: mediaQuery.size.width * 1 / 30,
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
                ),
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                              ),
                            ),
                            onPressed: () {
                              search_users_text = "";
                              context.read<UsersDataCubit>().getUsersData();
                              context
                                  .read<DepartmentsDataCubit>()
                                  .getDepartmentsData();
                              context.read<ShiftsDataCubit>().getShiftsData();
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      navigators[i],
                                ),
                              );
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
              ],
            ),
          )),
    );
  }
}
