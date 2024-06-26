// ignore_for_file: invalid_use_of_visible_for_testing_member

// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Cubits/Attendance%20data/attendance_data_cubit.dart';
import 'package:graduation_project/Cubits/Search/search_cubit.dart';
import 'package:graduation_project/Cubits/attendance%20new%20data/attendance_new_data_cubit.dart';
// import 'package:graduation_project/Screen/attendance/attendance_list.dart';
import 'package:graduation_project/Screen/manger%20screens/attendance/attendance_list2.dart';
import 'package:graduation_project/data/Repository/get_attendance_new_repo.dart';
import 'package:graduation_project/data/Repository/get_attendance_repo.dart';
import 'package:graduation_project/data/Repository/get_users_Repo.dart';
import 'package:graduation_project/functions/drawer.dart';
import 'package:graduation_project/functions/style.dart';

// ignore: must_be_immutable
class Attendance extends StatelessWidget {
  Attendance({super.key});

  TextEditingController _textEditingController = TextEditingController();

  List<String> items = ['day', 'month'];

  bool openDialog = false;

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
                context.read<SearchCubit>().close_search();
                selectedAttendanceItem = items[0];
                search_users_text = "";
                _textEditingController.clear();
                context.read<AttendanceDataCubit>().getAttendanceData();
                Navigator.pop(
                  context,
                );
              },
              icon: Icon(Icons.arrow_back),
            );
          }),
          actions: [
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return IconButton(
                  color: Colors.white,
                  onPressed: () {
                    context.read<SearchCubit>().search_icon();
                    // selectedAttendanceItem = items[0];
                    // search_department_text = "";
                    // _textEditingController.clear();
                    context.read<AttendanceDataCubit>().getAttendanceData();
                  },
                  icon: (context.read<SearchCubit>().search == false)
                      ? Icon(Icons.sort)
                      : Icon(Icons.close),
                );
              },
            ),
          ],
          automaticallyImplyLeading: false,
          title: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return !context.read<SearchCubit>().search
                  ? FittedBox(
                      child: Text(
                      "Attendance List",
                      style: (landscape)
                          ? getTextWhiteHeader(context)
                          : getTextWhite(context),
                    ))
                  : Row(
                      children: [
                        Text(
                          "Attendance List",
                          style: (landscape)
                              ? getTextWhiteHeader(context)
                              : getTextWhite(context),
                        ),
                        Spacer(),
                        DropdownButton<String>(
                          dropdownColor:
                              // const Color.fromRGBO(56, 149, 164, 1),
                              const Color.fromRGBO(50, 50, 160, 1),
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.white,
                          value: selectedAttendanceItem,
                          // style: TextStyle(color: Colors.white),
                          style: getTextWhite(context),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                  value: item, child: Text(item)))
                              .toList(),
                          onChanged: (item) {
                            selectedAttendanceItem = item;
                            // ignore: invalid_use_of_protected_member
                            context.read<SearchCubit>().emit(SearchInitial());
                            context
                                .read<AttendanceDataCubit>()
                                .getAttendanceData();
                          },
                        )
                      ],
                    );
            },
          ),
          centerTitle: true,
        ),
        // ignore: deprecated_member_use
        body: WillPopScope(
          onWillPop: () async {
            context.read<SearchCubit>().close_search();
            selectedAttendanceItem = items[0];
            search_users_text = "";
            _textEditingController.clear();
            context.read<AttendanceDataCubit>().getAttendanceData();
            Navigator.pop(
              context,
            );
            return true;
          },
          child: BlocBuilder<AttendanceDataCubit, AttendanceDataState>(
            builder: (context, state) {
              if (state is AttendanceDataSuccess) {
                return ListView.builder(
                    itemCount: attendance.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            // color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        // margin: EdgeInsets.only(top: 10, bottom: 10),
                        margin: (landscape)
                            ? EdgeInsets.all(5)
                            : EdgeInsets.all(10),
                        width: (landscape)
                            ? MediaQuery.of(context).size.height * 0.9
                            : MediaQuery.of(context).size.width * 0.9,
                        height: (landscape)
                            ? MediaQuery.of(context).size.width * 1 / 10
                            : MediaQuery.of(context).size.height * 1 / 10,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                            ),
                          ),
                          onPressed: () {
                            openDialog = true;
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Day info',
                                      // style: GoogleFonts.lato(),
                                    ),
                                    content: SingleChildScrollView(
                                      child: BlocBuilder<AttendanceDataCubit,
                                          AttendanceDataState>(
                                        builder: (context, state) {
                                          if (state is AttendanceDataError) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (state
                                              is AttendanceDataSuccess) {
                                            return Container(
                                              width:
                                                  mediaQuery.size.width / 1.8,
                                              height:
                                                  mediaQuery.size.height / 15,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Day : ${attendance[index].id}",
                                                      // style:
                                                      //     GoogleFonts.lato(
                                                      //         fontSize: 15),
                                                    ),
                                                    Text(
                                                      "Name : ${attendance[index].name}",
                                                      // style:
                                                      //     GoogleFonts.lato(
                                                      //         fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const Center(
                                                child: Text(
                                                    "Something wrong happened"));
                                          }
                                        },
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<SearchCubit>()
                                                  .close_search();
                                              if (selectedAttendanceItem ==
                                                  items[0]) {
                                                day_indexing = true;
                                              } else if (selectedAttendanceItem ==
                                                  items[1]) {
                                                day_indexing = false;
                                              }
                                              selectedAttendanceItem = items[0];
                                              search_users_text = "";
                                              _textEditingController.clear();
                                              day_or_month_index = index;
                                              day_of_attending =
                                                  index.toString();
                                              day_of_new_attending =
                                                  index.toString();
                                              // attended_employees_id =
                                              // attendance[index]
                                              //     .employees;
                                              check_in_employees =
                                                  attendance[index].check_in;
                                              check_out_employees =
                                                  attendance[index].check_out;
                                              context
                                                  .read<
                                                      AttendanceNewDataCubit>()
                                                  .getAttendanceNewData();
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          AttendanceList2(),
                                                ),
                                              );
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute<void>(
                                              //     builder:
                                              //         (BuildContext context) =>
                                              //             AttendanceList(),
                                              //   ),
                                              // );
                                              // editted_employee_id = index;
                                            },
                                            child: Text("Open"),
                                          ),
                                          Spacer(),
                                          TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // "",
                              '${attendance[index].id} ${attendance[index].name}',
                              // style: TextStyle(color: Colors.black),
                              style: getTextBlack(context),
                            ),
                          ),
                        ),
                      );
                    });
              } else if (state is AttendanceDataError) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return FutureBuilder<void>(
                  future:
                      context.read<AttendanceDataCubit>().getAttendanceData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Center(
                        child: Text("An error occurred while loading data."),
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
