import 'package:emas/Cubits/Search/search_cubit.dart';
import 'package:emas/Cubits/Users%20data/users_data_cubit.dart';
import 'package:emas/Cubits/attendance%20new%20data/attendance_new_data_cubit.dart';
import 'package:emas/Screen/Splash_Screen.dart';
import 'package:emas/data/Repository/get_attendance_new_repo.dart';
import 'package:emas/data/Repository/get_users_Repo.dart';
import 'package:emas/functions/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddingNewEmployeetoAttendance extends StatelessWidget {
  AddingNewEmployeetoAttendance({super.key});
  RegExp attendance_checkin_checkout_regex =
      RegExp(r'^(?:[1-9]|1[0-9]|2[0-4])$');

  RegExp attendance_day_regex = RegExp(r'^(?:[1-9]|[12][0-9]|3[01])$');

  final GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: (landscape)
            ? mediaQuery.size.height * (100 / 800)
            : mediaQuery.size.height * (70 / 800),
        // backgroundColor: const Color(0xfff0a307),
        backgroundColor: const Color.fromRGBO(50, 50, 160, 1),
        leading: Builder(builder: (context) {
          return IconButton(
            color: Colors.white,
            onPressed: () {
              attending_employee_to_day = false;
              Navigator.pop(
                context,
              );
            },
            icon: Icon(Icons.arrow_back),
          );
        }),
        automaticallyImplyLeading: false,
        title: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return FittedBox(
                child: Text(
              'Attending employee ${users[users.indexWhere((employee) => employee.id == int.parse(id_of_added_employee))].firstName} to day ${int.parse(day_of_new_attending) + 1}',
              // "Employees List",
              style: (landscape)
                  ? getTextWhiteHeader(context)
                  : getTextWhite(context),
            ));
          },
        ),
        centerTitle: true,
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          attending_employee_to_day = false;
          Navigator.pop(
            context,
          );
          return true;
        },
        child: Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          child: Form(
            key: _formkey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // attendance day
                // Container(
                //   width: mediaQuery.size.width * 0.8,
                //   child: TextFormField(
                //     onChanged: (text) {
                //       selectedAttendanceDayItem = text;
                //     },
                //     validator: (value) {
                //       if (selectedAttendanceDayItem != "") {
                //         if (attendance_day_regex.hasMatch(value!) == false) {
                //           return 'Invalid Day';
                //         } else {
                //           selectedAttendanceDayItem = value;
                //           return null;
                //         }
                //       } else {
                //         return 'Invalid Day';
                //       }
                //       // return null;
                //     },
                //     textAlign: TextAlign.left,
                //     decoration: InputDecoration(
                //         errorStyle:
                //             TextStyle(color: Colors.red[400], height: 0.2),
                //         contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                //         prefixIcon: const Icon(Icons.person,
                //             color: Color.fromARGB(255, 145, 142, 142), size: 30),
                //         filled: true,
                //         fillColor: Colors.white,
                //         // border: OutlineInputBorder(
                //         //   borderRadius: BorderRadius.circular(100),
                //         // ),
                //         border: OutlineInputBorder(),
                //         hintText: "Enter The Day",
                //         hintStyle: getTextGrey(context)),
                //   ),
                // ),
                // BlocBuilder<SearchCubit, SearchState>(
                //   builder: (context, state) {
                //     return Container(
                //       color: const Color.fromRGBO(56, 149, 164, 1),
                //       // width: 100,
                //       // height: 100,
                //       child: DropdownButton<String>(
                //         dropdownColor: const Color.fromRGBO(56, 149, 164, 1),
                //         iconEnabledColor: Colors.white,
                //         iconDisabledColor: Colors.white,
                //         value: selectedAttendanceDayItem,
                //         style: TextStyle(color: Colors.white),
                //         items: Attendance_days.map((item) =>
                //             DropdownMenuItem<String>(
                //                 value: item, child: Text(item))).toList(),
                //         onChanged: (item) {
                //           selectedAttendanceDayItem = item;
                //           // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                //           context.read<SearchCubit>().emit(SearchInitial());
                //         },
                //       ),
                //     );
                //   },
                // ),
                // check in time
                Container(
                  width: mediaQuery.size.width * 0.8,
                  child: TextFormField(
                    onChanged: (text) {
                      selectedAttendanceCheckInItem = text;
                    },
                    validator: (value) {
                      if (selectedAttendanceCheckInItem != "") {
                        if (attendance_checkin_checkout_regex
                                .hasMatch(value!) ==
                            false) {
                          return 'Invalid Check in Date';
                        } else {
                          selectedAttendanceCheckInItem = value;
                          return null;
                        }
                      } else {
                        return 'Invalid Check in Date';
                      }
                      // return null;
                    },
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        errorStyle:
                            TextStyle(color: Colors.red[400], height: 0.2),
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                        prefixIcon: const Icon(Icons.person,
                            color: Color.fromARGB(255, 145, 142, 142),
                            size: 30),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // border: OutlineInputBorder(),
                        hintText: "Enter check in date",
                        hintStyle: getTextGrey(context)),
                  ),
                ),
                // BlocBuilder<SearchCubit, SearchState>(
                //   builder: (context, state) {
                //     return Container(
                //       color: const Color.fromRGBO(56, 149, 164, 1),
                //       // width: 100,
                //       // height: 100,
                //       child: DropdownButton<String>(
                //         dropdownColor: const Color.fromRGBO(56, 149, 164, 1),
                //         iconEnabledColor: Colors.white,
                //         iconDisabledColor: Colors.white,
                //         value: selectedAttendanceCheckInItem,
                //         style: TextStyle(color: Colors.white),
                //         items: Attendance_check_in.map((item) =>
                //             DropdownMenuItem<String>(
                //                 value: item, child: Text(item))).toList(),
                //         onChanged: (item) {
                //           selectedAttendanceCheckInItem = item;
                //           // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                //           context.read<SearchCubit>().emit(SearchInitial());
                //         },
                //       ),
                //     );
                //   },
                // ),
                // check out time
                Container(
                  width: mediaQuery.size.width * 0.8,
                  child: TextFormField(
                    onChanged: (text) {
                      selectedAttendanceCheckOutItem = text;
                    },
                    validator: (value) {
                      if (selectedAttendanceCheckOutItem != "") {
                        if (attendance_checkin_checkout_regex
                                .hasMatch(value!) ==
                            false) {
                          return 'Invalid Check out Date';
                        } else {
                          if (int.parse(selectedAttendanceCheckOutItem!) <=
                              int.parse(selectedAttendanceCheckInItem!)) {
                            return 'The Check out Date must be after the Check in Date';
                          } else {
                            selectedAttendanceCheckOutItem = value;
                            return null;
                          }
                        }
                      } else {
                        return 'Invalid Check out Date';
                      }
                      // return null;
                    },
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        errorStyle:
                            TextStyle(color: Colors.red[400], height: 0.2),
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                        prefixIcon: const Icon(Icons.person,
                            color: Color.fromARGB(255, 145, 142, 142),
                            size: 30),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // border: OutlineInputBorder(),
                        hintText: "Enter check out date",
                        hintStyle: getTextGrey(context)),
                  ),
                ),
                // BlocBuilder<SearchCubit, SearchState>(
                //   builder: (context, state) {
                //     return Container(
                //       color: const Color.fromRGBO(56, 149, 164, 1),
                //       // width: 100,
                //       // height: 100,
                //       child: DropdownButton<String>(
                //         dropdownColor: const Color.fromRGBO(56, 149, 164, 1),
                //         iconEnabledColor: Colors.white,
                //         iconDisabledColor: Colors.white,
                //         value: selectedAttendanceCheckOutItem,
                //         style: TextStyle(color: Colors.white),
                //         items: Attendance_check_out.map((item) =>
                //             DropdownMenuItem<String>(
                //                 value: item, child: Text(item))).toList(),
                //         onChanged: (item) {
                //           selectedAttendanceCheckOutItem = item;
                //           // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                //           context.read<SearchCubit>().emit(SearchInitial());
                //         },
                //       ),
                //     );
                //   },
                // ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey1.currentState!.validate()) {
                      print('adding ///**');
                      // new_attendance[int.parse(day_of_attending)]
                      //     .employee_id
                      //     .add(int.parse(id_of_added_employee));
                      // // adding employee check in to the attendance day check in
                      // attendance[int.parse(day_of_attending)]
                      //     .check_in
                      //     .add(int.parse(selectedAttendanceCheckInItem!));
                      // // adding employee check out to the attendance day check out
                      // attendance[int.parse(day_of_attending)]
                      //     .check_out
                      //     .add(int.parse(selectedAttendanceCheckOutItem!));
                      return_all_data = true;
                      await context
                          .read<AttendanceNewDataCubit>()
                          .getAttendanceNewData();
                      return_all_data = false;

                      attending_employee_to_day = true;

                      // print(new_attendance[int.parse(day_of_attending)]
                      //     .employees
                      //     .toString());
                      print((new_attendance.last.id + 1).toString() + '///**');
                      postAttendanceData = {
                        // "Name": "day31"
                        "id": new_attendance.last.id + 1,
                        "employee_id": int.parse(id_of_added_employee),
                        "date": int.parse(day_of_new_attending) + 1,
                        "time_in": selectedAttendanceCheckInItem.toString(),
                        "time_out": selectedAttendanceCheckOutItem.toString(),
                        "company_name": Company_Name.toString(),
                        // "id": 3,
                        // "employee_id": 110,
                        // "date": 1,
                        // "time_in": "10",
                        // "time_out": "20",
                        // "company_name": "ali",
                      };
                      adding_employee_to_attendance = false;
                      context.read<UsersDataCubit>().getUsersData();
                      context
                          .read<AttendanceNewDataCubit>()
                          .getAttendanceNewData();
                      attending_employee_to_day = false;
                      Navigator.pop(
                        context,
                      );
                      Navigator.pop(
                        context,
                      );
                      Navigator.pop(
                        context,
                      );
                    }
                  },
                  child: Text(
                    "Submit",
                    style: getTextWhite(context),
                  ),
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      elevation: 10,
                      backgroundColor: const Color.fromRGBO(50, 50, 160, 1),
                      // Colors.green[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
