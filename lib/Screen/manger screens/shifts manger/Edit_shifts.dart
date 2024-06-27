import 'package:emas/Cubits/Shifts%20data/shifts_data_cubit.dart';
import 'package:emas/Cubits/Show_field_requirments/field_requirments_cubit.dart';
import 'package:emas/data/Repository/get_shifts_repo.dart';
import 'package:emas/functions/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_framework/responsive_row_column.dart';

// ignore: must_be_immutable
class EditShifts extends StatelessWidget {
  EditShifts({super.key});

  RegExp shift_name_regex =
      RegExp(r'^(?=^.{3,}$)([a-zA-Z0-9_])+( [a-zA-Z0-9_]+)*$');

  RegExp shift_start_time_regex = RegExp(r'^(?:[0-9]|1[0-9]|2[0-4])$');
  RegExp shift_end_time_regex = RegExp(r'^(?:[0-9]|1[0-9]|2[0-4])$');

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var shift_Name_Info = false;
  var shift_Start_time_Info = false;
  var shift_End_time_Info = false;

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
        backgroundColor:
            // const Color.fromRGBO(56, 149, 164, 1),
            const Color.fromRGBO(50, 50, 160, 1),
        leading: Builder(builder: (context) {
          return IconButton(
            color: Colors.white,
            onPressed: () {
              // Scaffold.of(context).openDrawer();
              context.read<ShiftsDataCubit>().getShiftsData();
              Navigator.pop(
                context,
              );
            },
            icon: Icon(Icons.arrow_back),
          );
        }),
        automaticallyImplyLeading: false,
        title: FittedBox(
            child: Text(
          "Editing Shift ${shifts[editted_shift_index].name}",
          style:
              (landscape) ? getTextWhiteHeader(context) : getTextWhite(context),
        )),
        centerTitle: true,
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          context.read<ShiftsDataCubit>().getShiftsData();
          Navigator.pop(
            context,
          );
          return true;
        },
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formkey,
              child: BlocBuilder<FieldRequirmentsCubit, FieldRequirmentsState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //shift Name
                      Container(
                        // color: Colors.yellow,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: mediaQuery.size.width / 50,
                            right: mediaQuery.size.width / 50),
                        width: mediaQuery.size.width * 0.8,
                        height: (landscape)
                            ? mediaQuery.size.height / 7
                            : mediaQuery.size.height / 10,
                        child: Row(children: [
                          Expanded(
                            child: TextFormField(
                              onChanged: (text) {
                                shift_Name = text;
                              },
                              validator: (value) {
                                if (shift_Name != "") {
                                  if (shift_name_regex.hasMatch(value!) ==
                                      false) {
                                    return 'Invalid Shift Name';
                                  } else {
                                    shift_Name = value;
                                    return null;
                                  }
                                }
                                return null;
                              },
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.red[400], height: 0.2),
                                  // contentPadding:
                                  //     EdgeInsets.symmetric(vertical: 0.0),
                                  prefixIcon: Image.asset(icons[4],
                                      scale: 3,
                                      color:
                                          Color.fromARGB(255, 145, 142, 142)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // border: OutlineInputBorder(),
                                  hintText: shifts[editted_shift_index].name,
                                  hintStyle: getTextGrey(context)),
                            ),
                          ),
                          InkWell(
                            onTapDown: (_) {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              shift_Name_Info = true;
                            },
                            onTapUp: (_) {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              shift_Name_Info = false;
                            },
                            onTapCancel: () {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              shift_Name_Info = false;
                            },
                            child: IconButton(
                              icon: Icon(Icons.info,
                                  color: Color.fromARGB(255, 145, 142, 142)),
                              onPressed: () {},
                            ),
                          )
                        ]),
                      ),
                      Visibility(
                          visible: shift_Name_Info,
                          child: Container(
                            width: mediaQuery.size.width * 0.8,
                            child: Text(
                              'The Shift Name must contain at least 3 characters\nThe First Name can only consist of alphanumeric characters (both lowercase and uppercase) and underscores.',
                              style: getSmallTextBlack(context),
                            ),
                          )),
                      SizedBox(height: mediaQuery.size.width / 50),
                      //Shift description
                      Container(
                        // color: Colors.yellow,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: mediaQuery.size.width / 50,
                            right: mediaQuery.size.width / 50),
                        width: mediaQuery.size.width * 0.8,
                        height: (landscape)
                            ? mediaQuery.size.height / 7
                            : mediaQuery.size.height / 10,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                onChanged: (text) {
                                  shift_Descreption = text;
                                },
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        color: Colors.red[400], height: 0.2),
                                    // contentPadding:
                                    //     EdgeInsets.symmetric(vertical: 0.0),
                                    prefixIcon: const Icon(
                                        Icons.description_outlined,
                                        color:
                                            Color.fromARGB(255, 145, 142, 142),
                                        size: 30),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // border: OutlineInputBorder(),
                                    hintText:
                                        shifts[editted_shift_index].description,
                                    hintStyle: getTextGrey(context)),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: mediaQuery.size.width / 50),
                      //shift start time
                      Container(
                        // color: Colors.yellow,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: mediaQuery.size.width / 50,
                            right: mediaQuery.size.width / 50),
                        width: mediaQuery.size.width * 0.8,
                        height: (landscape)
                            ? mediaQuery.size.height / 7
                            : mediaQuery.size.height / 10,
                        child: Row(children: [
                          Expanded(
                            child: TextFormField(
                              onChanged: (text) {
                                shift_Start_time = text;
                              },
                              validator: (value) {
                                if (shift_Start_time != "") {
                                  if (shift_start_time_regex.hasMatch(value!) ==
                                      false) {
                                    return 'Invalid Shift Start Time';
                                  } else if (int.parse((shift_End_time == "")
                                          ? shifts[editted_shift_index].end_time
                                          : shift_End_time) <=
                                      int.parse((shift_Start_time == "")
                                          ? shifts[editted_shift_index]
                                              .start_time
                                          : shift_Start_time)) {
                                    // return 'Shift End Time must be greater than Shift Start Time';
                                    return 'Start Time must be smaller than End Time';
                                  } else {
                                    shift_Start_time = value;
                                    return null;
                                  }
                                }
                                return null;
                              },
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.red[400], height: 0.2),
                                  // contentPadding:
                                  //     EdgeInsets.symmetric(vertical: 0.0),
                                  prefixIcon: const Icon(
                                      Icons.timelapse_rounded,
                                      color: Color.fromARGB(255, 145, 142, 142),
                                      size: 30),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // border: OutlineInputBorder(),
                                  hintText:
                                      shifts[editted_shift_index].start_time,
                                  hintStyle: getTextGrey(context)),
                            ),
                          ),
                          InkWell(
                            onTapDown: (_) {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              shift_Start_time_Info = true;
                            },
                            onTapUp: (_) {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              shift_Start_time_Info = false;
                            },
                            onTapCancel: () {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              shift_Start_time_Info = false;
                            },
                            child: IconButton(
                              icon: Icon(Icons.info,
                                  color: Color.fromARGB(255, 145, 142, 142)),
                              onPressed: () {},
                            ),
                          )
                        ]),
                      ),
                      Visibility(
                          visible: shift_Start_time_Info,
                          child: Container(
                            width: mediaQuery.size.width * 0.8,
                            child: Text(
                              'The Shift Start time must be a number smaller than the Shift End time',
                              style: getSmallTextBlack(context),
                            ),
                          )),

                      SizedBox(height: mediaQuery.size.width / 50),
                      //shift end time
                      Container(
                        // color: Colors.yellow,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: mediaQuery.size.width / 50,
                            right: mediaQuery.size.width / 50),
                        width: mediaQuery.size.width * 0.8,
                        height: (landscape)
                            ? mediaQuery.size.height / 7
                            : mediaQuery.size.height / 10,
                        child: Row(children: [
                          Expanded(
                            child: TextFormField(
                              onChanged: (text) {
                                shift_End_time = text;
                              },
                              validator: (value) {
                                if (shift_End_time != "") {
                                  if (shift_end_time_regex.hasMatch(value!) ==
                                      false) {
                                    return 'Invalid Shift End Time';
                                  } else if (int.parse((shift_End_time == "")
                                          ? shifts[editted_shift_index].end_time
                                          : shift_End_time) <=
                                      int.parse((shift_Start_time == "")
                                          ? shifts[editted_shift_index]
                                              .start_time
                                          : shift_Start_time)) {
                                    // return 'Shift End Time must be greater than Shift Start Time';
                                    return 'End Time must be greater than Start Time';
                                  } else {
                                    shift_End_time = value;
                                    return null;
                                  }
                                }
                                return null;
                              },
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.red[400], height: 0.2),
                                  // contentPadding:
                                  //     EdgeInsets.symmetric(vertical: 0.0),
                                  prefixIcon: const Icon(
                                      Icons.timelapse_rounded,
                                      color: Color.fromARGB(255, 145, 142, 142),
                                      size: 30),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // border: OutlineInputBorder(),
                                  hintText:
                                      shifts[editted_shift_index].end_time,
                                  hintStyle: getTextGrey(context)),
                            ),
                          ),
                          InkWell(
                            onTapDown: (_) {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              shift_End_time_Info = true;
                            },
                            onTapUp: (_) {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              shift_End_time_Info = false;
                            },
                            onTapCancel: () {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              shift_End_time_Info = false;
                            },
                            child: IconButton(
                              icon: Icon(Icons.info,
                                  color: Color.fromARGB(255, 145, 142, 142)),
                              onPressed: () {},
                            ),
                          )
                        ]),
                      ),
                      Visibility(
                          visible: shift_End_time_Info,
                          child: Container(
                            width: mediaQuery.size.width * 0.8,
                            child: Text(
                              'The Shift End time must be a number greater than the Shift End time',
                              style: getSmallTextBlack(context),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      ResponsiveRowColumnItem(
                        child: Container(
                          child: FittedBox(
                            child: ElevatedButton(
                              onPressed: () async {
                                // if (int.parse(shift_Start_time) <
                                //     int.parse(shift_End_time)) {
                                //   print('error');
                                // }
                                // if (int.parse((shift_End_time == "")
                                //         ? shifts[editted_shift_index].end_time
                                //         : shift_End_time) <=
                                //     int.parse((shift_Start_time == "")
                                //         ? shifts[editted_shift_index].start_time
                                //         : shift_Start_time)) {
                                //   print(int.parse((shift_End_time == "")
                                //               ? shifts[editted_shift_index]
                                //                   .end_time
                                //               : shift_End_time)
                                //           .toString() +
                                //       '//**');
                                //   print('error //**');
                                // }
                                if (_formkey.currentState!.validate()) {
                                  // getting_number_of_shifts = true;
                                  // await GetShiftsRepo().getShiftsData();
                                  // getting_number_of_shifts = false;
                                  // print((shifts.length + 1).toString() + 'ahmed');
                                  // print((editted_shift_index).toString() +
                                  //     'ahmed');
                                  editing_shift = true;
                                  putshiftData = {
                                    "id": shifts[editted_shift_index].id,
                                    "Name": (shift_Name == "")
                                        ? shifts[editted_shift_index].name
                                        : shift_Name,
                                    "Description": (shift_Descreption == "")
                                        ? shifts[editted_shift_index]
                                            .description
                                        : shift_Descreption,
                                    "companyName":
                                        shifts[editted_shift_index].companyName,
                                    "start_time": (shift_Start_time == "")
                                        ? shifts[editted_shift_index].start_time
                                        : shift_Start_time,
                                    "end_time": (shift_End_time == "")
                                        ? shifts[editted_shift_index].end_time
                                        : shift_End_time,
                                  };
                                  context
                                      .read<ShiftsDataCubit>()
                                      .getShiftsData();
                                  editing_shift = false;
                                  Navigator.pop(
                                    context,
                                  );
                                  shift_Name = "";
                                  shift_Descreption = "";
                                  shift_Start_time = "";
                                  shift_End_time = "";
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.black,
                                  elevation: 10,
                                  backgroundColor: Colors.green[500],
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                  )),
                              child: Text(
                                "Submit",
                                style: getTextBlack(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
