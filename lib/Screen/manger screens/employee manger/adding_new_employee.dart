// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Cubits/Circular_indicator_cubit/circular_indicator_cubit.dart';
// import 'package:graduation_project/Cubits/Circular_indicator_cubit/circular_indicator_cubit.dart';
// import 'package:graduation_project/Cubits/Departments%20Data/cubit/departments_data_cubit.dart';
import 'package:graduation_project/Cubits/Search/search_cubit.dart';
import 'package:graduation_project/Cubits/Show_field_requirments/field_requirments_cubit.dart';
import 'package:graduation_project/Cubits/Users%20data/users_data_cubit.dart';
import 'package:graduation_project/Screen/Splash_Screen.dart';
import 'package:graduation_project/data/Repository/get_departments_repo.dart';
import 'package:graduation_project/data/Repository/get_shifts_repo.dart';
import 'package:graduation_project/data/Repository/get_users_Repo.dart';
import 'package:graduation_project/functions/style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: must_be_immutable
class AddingEmployee extends StatelessWidget {
  AddingEmployee({super.key});

  TextEditingController _textEditingController = TextEditingController();

  RegExp employer_name_regex =
      RegExp(r'^(?=^.{3,}$)([a-zA-Z0-9_])+( [a-zA-Z0-9_]+)*$');

  RegExp department_id_regex = RegExp(r'^[0-9]+$');

  RegExp shift_id_regex = RegExp(r'^[0-9]+$');

  // RegExp Employer_age_regex = RegExp(r'^(2[1-9]|[3-5]\d)$');
  RegExp Employer_age_regex = RegExp(r'^\b([2-8][0-9]|90)\b$');

  RegExp Employer_email_regex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail.com$');

  RegExp Employer_salary_regex = RegExp(r'^[1-9]\d*$');

  RegExp Employer_phone_regex = RegExp(r'^\+(?:[0-9] ?){6,14}[0-9]$');

  RegExp Employer_address_regex = RegExp(r'^.{4,}$');

  RegExp Employer_position_regex = RegExp(r'^[A-Za-z]{4,}$');

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var first_Name_Info = false;

  var last_Name_Info = false;

  var age_Info = false;

  var email_Info = false;

  var salary_Info = false;

  var phone_Info = false;

  var address_Info = false;

  var position_Info = false;

  var department_id_Info = false;

  var shift_id_Info = false;

  bool image_uploaded_successfuly = false;
  bool submitted = false;
  bool form_validate = false;

  String path = '';
  var image;

  String last_id = '';

  int selected_department_id = 0;
  int selected_shift_id = 0;

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
              selectedDepartmentItem_adding = null;
              selectedShiftItem_adding = null;
              gender_current_option = 0;
              salary_type_current_option = 0;
              Employer_first_Name = '';
              Employer_last_Name = '';
              Employer_age = '';
              Employer_phone = '';
              Employer_email = '';
              Employer_image = '';
              Employer_salary = '';
              Employer_address = '';
              Employer_position = '';
              // Scaffold.of(context).openDrawer();
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
          "Adding New Employee",
          style:
              (landscape) ? getTextWhiteHeader(context) : getTextWhite(context),
        )),
        centerTitle: true,
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          selectedDepartmentItem_adding = null;
          selectedShiftItem_adding = null;
          gender_current_option = 0;
          salary_type_current_option = 0;
          Employer_first_Name = '';
          Employer_last_Name = '';
          Employer_age = '';
          Employer_phone = '';
          Employer_email = '';
          Employer_image = '';
          Employer_salary = '';
          Employer_address = '';
          Employer_position = '';
          // Scaffold.of(context).openDrawer();
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
                      SizedBox(
                        height: mediaQuery.size.height / 50,
                      ),
                      //Employer first Name
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
                                Employer_first_Name = text;
                              },
                              validator: (value) {
                                if (employer_name_regex.hasMatch(value!) ==
                                    false) {
                                  return 'Invalid Employer First Name';
                                } else if (users.any((element) => element
                                        .lastName
                                        .contains(Employer_last_Name)) &&
                                    users.any((element) => element.firstName
                                        .contains(Employer_first_Name))) {
                                  return 'The employee full name is already found';
                                } else {
                                  Employer_first_Name = value;
                                  return null;
                                }
                              },
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.red[400], height: 0.8),
                                  // contentPadding:
                                  //     EdgeInsets.symmetric(vertical: 0.0),
                                  prefixIcon: Image.asset(icons[5],
                                      scale: 3,
                                      color:
                                          Color.fromARGB(255, 145, 142, 142)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // border: OutlineInputBorder(),
                                  hintText: 'Employer First Name',
                                  hintStyle: getTextGrey(context)),
                            ),
                          ),
                          InkWell(
                            onTapDown: (_) {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              first_Name_Info = true;
                              // print(Departments_number);
                            },
                            onTapUp: (_) {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              first_Name_Info = false;
                            },
                            onTapCancel: () {
                              context
                                  .read<FieldRequirmentsCubit>()
                                  .FieldRequirments();
                              first_Name_Info = false;
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
                          visible: first_Name_Info,
                          child: Container(
                            width: mediaQuery.size.width * 0.8,
                            child: Text(
                              'The First Name must contain at least 3 characters\nThe First Name can only consist of alphanumeric characters (both lowercase and uppercase) and underscores.',
                              style: getSmallTextBlack(context),
                            ),
                          )),
                      SizedBox(height: mediaQuery.size.width / 50),
                      //Employer last Name
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
                                  Employer_last_Name = text;
                                },
                                validator: (value) {
                                  if (employer_name_regex.hasMatch(value!) ==
                                      false) {
                                    return 'Invalid Employer Last Name';
                                  } else if (users.any((element) => element
                                          .lastName
                                          .contains(Employer_last_Name)) &&
                                      users.any((element) => element.firstName
                                          .contains(Employer_first_Name))) {
                                    return 'The employee full name is already found';
                                  } else {
                                    Employer_last_Name = value;
                                    return null;
                                  }
                                },
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        color: Colors.red[400], height: 0.8),
                                    // contentPadding:
                                    //     EdgeInsets.symmetric(vertical: 0.0),
                                    prefixIcon: Image.asset(icons[5],
                                        scale: 3,
                                        color:
                                            Color.fromARGB(255, 145, 142, 142)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // border: OutlineInputBorder(),
                                    hintText: 'Employer Last Name',
                                    hintStyle: getTextGrey(context)),
                              ),
                            ),
                            InkWell(
                              onTapDown: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                last_Name_Info = true;
                              },
                              onTapUp: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                last_Name_Info = false;
                              },
                              onTapCancel: () {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                last_Name_Info = false;
                              },
                              child: IconButton(
                                icon: Icon(Icons.info,
                                    color: Color.fromARGB(255, 145, 142, 142)),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: last_Name_Info,
                          child: Container(
                            width: mediaQuery.size.width * 0.8,
                            child: Text(
                              'The Last Name must contain at least 3 characters\nThe Last Name can only consist of alphanumeric characters (both lowercase and uppercase) and underscores.',
                              style: getSmallTextBlack(context),
                            ),
                          )),
                      SizedBox(height: mediaQuery.size.width / 50),
                      //Employer age Name
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
                                  Employer_age = text;
                                },
                                validator: (value) {
                                  if (Employer_age_regex.hasMatch(value!) ==
                                      false) {
                                    return 'Invalid Employer Age';
                                  } else {
                                    Employer_age = value;
                                    return null;
                                  }
                                },
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        color: Colors.red[400], height: 0.8),
                                    // contentPadding:
                                    //     EdgeInsets.symmetric(vertical: 0.0),
                                    prefixIcon: const Icon(Icons.calendar_month,
                                        color:
                                            Color.fromARGB(255, 145, 142, 142),
                                        size: 30),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // border: OutlineInputBorder(),
                                    hintText: 'Employer Age',
                                    hintStyle: getTextGrey(context)),
                              ),
                            ),
                            InkWell(
                              onTapDown: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                age_Info = true;
                              },
                              onTapUp: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                age_Info = false;
                              },
                              onTapCancel: () {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                age_Info = false;
                              },
                              child: IconButton(
                                icon: Icon(Icons.info,
                                    color: Color.fromARGB(255, 145, 142, 142)),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: age_Info,
                          child: Container(
                            width: mediaQuery.size.width * 0.8,
                            child: Text(
                              'The age must be between 20 & 90 ',
                              style: getSmallTextBlack(context),
                            ),
                          )),
                      SizedBox(height: mediaQuery.size.width / 50),
                      //Employer email
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
                                  Employer_email = text;
                                },
                                validator: (value) {
                                  if (Employer_email_regex.hasMatch(value!) ==
                                      false) {
                                    return 'Invalid Email';
                                  } else {
                                    Employer_email = value;
                                    return null;
                                  }
                                },
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        color: Colors.red[400], height: 0.8),
                                    // contentPadding:
                                    //     EdgeInsets.symmetric(vertical: 0.0),
                                    prefixIcon: const Icon(Icons.email_outlined,
                                        color:
                                            Color.fromARGB(255, 145, 142, 142),
                                        size: 30),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // border: OutlineInputBorder(),
                                    hintText: 'Employer Emial',
                                    hintStyle: getTextGrey(context)),
                              ),
                            ),
                            InkWell(
                              onTapDown: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                email_Info = true;
                              },
                              onTapUp: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                email_Info = false;
                              },
                              onTapCancel: () {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                email_Info = false;
                              },
                              child: IconButton(
                                icon: Icon(Icons.info,
                                    color: Color.fromARGB(255, 145, 142, 142)),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: email_Info,
                          child: Container(
                            width: mediaQuery.size.width * 0.8,
                            child: Text(
                              'The email address must start with one or more alphanumeric characters, dots, underscores, percent signs, plus signs, or hyphens.\nThe domain part of the email address must be exactly "@gmail.com"',
                              style: getSmallTextBlack(context),
                            ),
                          )),
                      SizedBox(height: mediaQuery.size.width / 50),
                      //Employer phone
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
                                  Employer_phone = text;
                                },
                                validator: (value) {
                                  if (Employer_phone_regex.hasMatch(value!) ==
                                      false) {
                                    return 'Invalid Phone';
                                  } else {
                                    Employer_phone = value;
                                    return null;
                                  }
                                },
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        color: Colors.red[400], height: 0.8),
                                    // contentPadding:
                                    //     EdgeInsets.symmetric(vertical: 0.0),
                                    prefixIcon: Image.asset(icons[7],
                                        scale: 3,
                                        color:
                                            Color.fromARGB(255, 145, 142, 142)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // border: OutlineInputBorder(),
                                    hintText: 'Employer Phone',
                                    hintStyle: getTextGrey(context)),
                              ),
                            ),
                            InkWell(
                              onTapDown: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                phone_Info = true;
                              },
                              onTapUp: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                phone_Info = false;
                              },
                              onTapCancel: () {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                phone_Info = false;
                              },
                              child: IconButton(
                                icon: Icon(Icons.info,
                                    color: Color.fromARGB(255, 145, 142, 142)),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: phone_Info,
                          child: Container(
                            width: mediaQuery.size.width * 0.8,
                            child: Text(
                              'The phone must start with a plus sign followed by digits\nThe digits must be between 7 & 15 digit',
                              style: getSmallTextBlack(context),
                            ),
                          )),
                      SizedBox(height: mediaQuery.size.width / 50),
                      // salary
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
                                  Employer_salary = text;
                                },
                                validator: (value) {
                                  if (Employer_salary_regex.hasMatch(value!) ==
                                      false) {
                                    return 'Invalid Salary';
                                  } else {
                                    Employer_salary = value;
                                    return null;
                                  }
                                },
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        color: Colors.red[400], height: 0.8),
                                    // contentPadding:
                                    //     EdgeInsets.symmetric(vertical: 0.0),
                                    prefixIcon: Image.asset(icons[8],
                                        scale: 3,
                                        color:
                                            Color.fromARGB(255, 145, 142, 142)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // border: OutlineInputBorder(),
                                    hintText: 'Employer Salary',
                                    hintStyle: getTextGrey(context)),
                              ),
                            ),
                            InkWell(
                              onTapDown: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                salary_Info = true;
                              },
                              onTapUp: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                salary_Info = false;
                              },
                              onTapCancel: () {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                salary_Info = false;
                              },
                              child: IconButton(
                                icon: Icon(Icons.info,
                                    color: Color.fromARGB(255, 145, 142, 142)),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: salary_Info,
                          child: Container(
                            width: mediaQuery.size.width * 0.8,
                            child: Text(
                              'The salary must contain only digits\nStarting with non-zero digit\nMust be decimal',
                              style: getSmallTextBlack(context),
                            ),
                          )),
                      SizedBox(height: mediaQuery.size.width / 50),
                      // address
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
                                  Employer_address = text;
                                },
                                validator: (value) {
                                  if (Employer_address_regex.hasMatch(value!) ==
                                      false) {
                                    return 'Invalid Address';
                                  } else {
                                    Employer_address = value;
                                    return null;
                                  }
                                },
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        color: Colors.red[400], height: 0.8),
                                    // contentPadding:
                                    //     EdgeInsets.symmetric(vertical: 0.0),
                                    prefixIcon: Image.asset(icons[9],
                                        scale: 3,
                                        color:
                                            Color.fromARGB(255, 145, 142, 142)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // border: OutlineInputBorder(),
                                    hintText: 'Employer Address',
                                    hintStyle: getTextGrey(context)),
                              ),
                            ),
                            InkWell(
                              onTapDown: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                address_Info = true;
                              },
                              onTapUp: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                address_Info = false;
                              },
                              onTapCancel: () {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                address_Info = false;
                              },
                              child: IconButton(
                                icon: Icon(Icons.info,
                                    color: Color.fromARGB(255, 145, 142, 142)),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: address_Info,
                          child: Container(
                            width: mediaQuery.size.width * 0.8,
                            child: Text(
                              'The address must contain at least 4 characters',
                              style: getSmallTextBlack(context),
                            ),
                          )),
                      SizedBox(height: mediaQuery.size.width / 50),
                      // position
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
                                  Employer_position = text;
                                },
                                validator: (value) {
                                  if (Employer_position_regex.hasMatch(
                                          value!) ==
                                      false) {
                                    return 'Invalid Position';
                                  } else {
                                    Employer_position = value;
                                    return null;
                                  }
                                },
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        color: Colors.red[400], height: 0.8),
                                    // contentPadding:
                                    //     EdgeInsets.symmetric(vertical: 0.0),
                                    prefixIcon: Image.asset(icons[10],
                                        scale: 3,
                                        color:
                                            Color.fromARGB(255, 145, 142, 142)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // border: OutlineInputBorder(),
                                    hintText: 'Employer Position',
                                    hintStyle: getTextGrey(context)),
                              ),
                            ),
                            InkWell(
                              onTapDown: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                position_Info = true;
                              },
                              onTapUp: (_) {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                position_Info = false;
                              },
                              onTapCancel: () {
                                context
                                    .read<FieldRequirmentsCubit>()
                                    .FieldRequirments();
                                position_Info = false;
                              },
                              child: IconButton(
                                icon: Icon(Icons.info,
                                    color: Color.fromARGB(255, 145, 142, 142)),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: position_Info,
                          child: Container(
                            width: mediaQuery.size.width * 0.8,
                            child: Text(
                              'The position must contain only letters\nAt least 4 letters',
                              style: getSmallTextBlack(context),
                            ),
                          )),
                      SizedBox(height: mediaQuery.size.width / 50),

                      // Employer department id
                      BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          return DropdownButton<String>(
                            // dropdownColor: const Color.fromRGBO(56, 149, 164, 1),
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.black,
                            // style: TextStyle(color: Colors.black),
                            style: getTextBlack(context),
                            hint: Text(
                              'Select a Department',
                              // Company Name
                              style: TextStyle(color: Colors.black),
                            ),

                            value: selectedDepartmentItem_adding,
                            items: department_items
                                .map((item) => DropdownMenuItem<String>(
                                    value: item, child: Text(item)))
                                .toList(),
                            onChanged: (item) {
                              selectedDepartmentItem_adding = item;
                              _textEditingController.clear();
                              // ignore: duplicate_ignore
                              // ignore: invalid_use_of_protected_member
                              context.read<SearchCubit>().emit(SearchInitial());
                            },
                          );
                        },
                      ),
                      // Container(
                      //   // color: Colors.yellow,
                      //   alignment: Alignment.center,
                      //   margin: EdgeInsets.only(
                      //       left: mediaQuery.size.width / 50,
                      //       right: mediaQuery.size.width / 50),
                      //   width: mediaQuery.size.width * 0.8,
                      //   height: (landscape)
                      //       ? mediaQuery.size.height / 7
                      //       : mediaQuery.size.height / 10,
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: TextFormField(
                      //           onChanged: (text) {
                      //             departmentId = text;
                      //           },
                      //           validator: (value) {
                      //             if (department_id_regex.hasMatch(value!) ==
                      //                 true) {
                      //               if (int.parse(departmentId) > 0 &&
                      //                   int.parse(departmentId) <=
                      //                       int.parse(Departments_number)) {
                      //                 departmentId = value;
                      //                 return null;
                      //               } else {
                      //                 return "Invalid Department Id";
                      //               }
                      //             } else {
                      //               return "Invalid Department Id";
                      //             }
                      //           },
                      //           textAlign: TextAlign.left,
                      //           decoration: InputDecoration(
                      //               errorStyle: TextStyle(
                      //                   color: Colors.red[400], height: 0.8),
                      //               prefixIcon: const Icon(Icons.numbers,
                      //                   color: Color.fromARGB(255, 145, 142, 142),
                      //                   size: 30),
                      //               filled: true,
                      //               fillColor: Colors.white,
                      //               border: OutlineInputBorder(),
                      //               hintText: "Department Id",
                      //               hintStyle: getTextGrey(context)),
                      //         ),
                      //       ),
                      //       InkWell(
                      //         onTapDown: (_) {
                      //           context
                      //               .read<FieldRequirmentsCubit>()
                      //               .FieldRequirments();
                      //           department_id_Info = true;
                      //         },
                      //         onTapUp: (_) {
                      //           context
                      //               .read<FieldRequirmentsCubit>()
                      //               .FieldRequirments();
                      //           department_id_Info = false;
                      //         },
                      //         onTapCancel: () {
                      //           context
                      //               .read<FieldRequirmentsCubit>()
                      //               .FieldRequirments();
                      //           department_id_Info = false;
                      //         },
                      //         child: IconButton(
                      //           icon: Icon(Icons.info,
                      //               color: Color.fromARGB(255, 145, 142, 142)),
                      //           onPressed: () {},
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Visibility(
                      //     visible: department_id_Info,
                      //     child: Container(
                      //       width: mediaQuery.size.width * 0.8,
                      //       child: Text(
                      //         'The department id must be a digit that starts from 1 to ${departments.length}',
                      //         style: getSmallTextBlack(context),
                      //       ),
                      //     )),

                      SizedBox(height: mediaQuery.size.width / 50),

                      // Employer shift id
                      BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          return DropdownButton<String>(
                            // dropdownColor: const Color.fromRGBO(56, 149, 164, 1),
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.black,
                            // style: TextStyle(color: Colors.black),
                            style: getTextBlack(context),
                            hint: Text(
                              'Select a Shift',
                              // Company Name
                              style: TextStyle(color: Colors.black),
                            ),
                            value: selectedShiftItem_adding,
                            items: shift_items
                                .map((item) => DropdownMenuItem<String>(
                                    value: item, child: Text(item)))
                                .toList(),
                            onChanged: (item) async {
                              selectedShiftItem_adding = item;
                              _textEditingController.clear();
                              context.read<SearchCubit>().emit(SearchInitial());
                            },
                          );
                        },
                      ),
                      // upload photo
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: mediaQuery.size.width / 50,
                            right: mediaQuery.size.width / 50),
                        width: mediaQuery.size.width * 0.55,
                        height: (landscape)
                            ? mediaQuery.size.height / 7
                            : mediaQuery.size.height / 10,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Upload Photo',
                              style: getTextBlack(context),
                            ),
                            BlocBuilder<UsersDataCubit, UsersDataState>(
                              builder: (context, state) {
                                return IconButton(
                                    onPressed: () async {
                                      var pic = await ImagePicker().pickImage(
                                          source: ImageSource.gallery);
                                      image = File(pic!.path);
                                      image_uploaded_successfuly = true;
                                      context
                                          .read<UsersDataCubit>()
                                          .uploadedImage();
                                    },
                                    icon: Image.asset(icons[11],
                                        scale: 1.7,
                                        color: (image_uploaded_successfuly ==
                                                    false &&
                                                submitted == true)
                                            ? Colors.red
                                            : Color.fromARGB(
                                                255, 145, 142, 142)));
                              },
                            ),
                          ],
                        ),
                      ),
                      // BlocBuilder<UsersDataCubit, UsersDataState>(
                      //   builder: (context, state) {
                      //     return ElevatedButton(
                      //         onPressed: () async {
                      //           var pic = await ImagePicker()
                      //               .pickImage(source: ImageSource.gallery);
                      //           image = File(pic!.path);
                      //           image_uploaded_successfuly = true;
                      //           context.read<UsersDataCubit>().uploadedImage();
                      //         },
                      //         style: ElevatedButton.styleFrom(
                      // side: (image_uploaded_successfuly == false &&
                      //         submitted == true)
                      //     ? const BorderSide(
                      //         color: Colors.red, width: 2)
                      //     : null,
                      //             shadowColor: Colors.black,
                      //             elevation: 10,
                      //             backgroundColor: Colors.green[500],
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(100),
                      //             ),
                      //             textStyle: const TextStyle(
                      //               fontSize: 18,
                      //             )),
                      //         child: Text("get photo from phone"));
                      //   },
                      // ),
                      // Container(
                      //   // color: Colors.yellow,
                      //   alignment: Alignment.center,
                      //   margin: EdgeInsets.only(
                      //       left: mediaQuery.size.width / 50,
                      //       right: mediaQuery.size.width / 50),
                      //   width: mediaQuery.size.width * 0.8,
                      //   height: (landscape)
                      //       ? mediaQuery.size.height / 7
                      //       : mediaQuery.size.height / 10,
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: TextFormField(
                      //           onChanged: (text) {
                      //             shiftId = text;
                      //           },
                      //           validator: (value) {
                      //             if (shift_id_regex.hasMatch(value!) == true) {
                      //               if (int.parse(shiftId) > 0 &&
                      //                   int.parse(shiftId) <=
                      //                       int.parse(Shifts_number)) {
                      //                 shiftId = value;
                      //                 return null;
                      //               } else {
                      //                 return "Invalid Shift Id";
                      //               }
                      //             } else {
                      //               return "Invalid Shift Id";
                      //             }
                      //           },
                      //           textAlign: TextAlign.left,
                      //           decoration: InputDecoration(
                      //               errorStyle: TextStyle(
                      //                   color: Colors.red[400], height: 0.8),
                      //               prefixIcon: const Icon(Icons.numbers,
                      //                   color: Color.fromARGB(255, 145, 142, 142),
                      //                   size: 30),
                      //               filled: true,
                      //               fillColor: Colors.white,
                      //               border: OutlineInputBorder(),
                      //               hintText: "Shift Id",
                      //               hintStyle: getTextGrey(context)),
                      //         ),
                      //       ),
                      //       InkWell(
                      //         onTapDown: (_) {
                      //           context
                      //               .read<FieldRequirmentsCubit>()
                      //               .FieldRequirments();
                      //           shift_id_Info = true;
                      //         },
                      //         onTapUp: (_) {
                      //           context
                      //               .read<FieldRequirmentsCubit>()
                      //               .FieldRequirments();
                      //           shift_id_Info = false;
                      //         },
                      //         onTapCancel: () {
                      //           context
                      //               .read<FieldRequirmentsCubit>()
                      //               .FieldRequirments();
                      //           shift_id_Info = false;
                      //         },
                      //         child: IconButton(
                      //           icon: Icon(Icons.info,
                      //               color: Color.fromARGB(255, 145, 142, 142)),
                      //           onPressed: () {},
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Visibility(
                      //     visible: shift_id_Info,
                      //     child: Container(
                      //       width: mediaQuery.size.width * 0.8,
                      //       child: Text(
                      //         'The shift id must be a digit that starts from 1 to ${shifts.length}',
                      //         style: getSmallTextBlack(context),
                      //       ),
                      //     )),
                      // Employer salary_type
                      BlocBuilder<UsersDataCubit, UsersDataState>(
                        builder: (context, state) {
                          return (mediaQuery.size.width > 328)
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: mediaQuery.size.width * 0.97,
                                    margin: EdgeInsets.only(
                                        left: mediaQuery.size.width / 30,
                                        right: mediaQuery.size.width / 30),
                                    // color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Salary Type :"),
                                        Container(
                                          child: Row(children: [
                                            Radio(
                                                value: 0,
                                                groupValue:
                                                    salary_type_current_option,
                                                onChanged: (value) {
                                                  salary_type_current_option =
                                                      0;
                                                  context
                                                      .read<UsersDataCubit>()
                                                      .SalaryType();
                                                }),
                                            InkWell(
                                              child: Text("Monthly"),
                                              onTap: () {
                                                salary_type_current_option = 0;
                                                context
                                                    .read<UsersDataCubit>()
                                                    .SalaryType();
                                              },
                                            ),
                                          ]),
                                        ),
                                        Container(
                                          child: Row(children: [
                                            Radio(
                                                value: 1,
                                                groupValue:
                                                    salary_type_current_option,
                                                onChanged: (value) {
                                                  salary_type_current_option =
                                                      1;
                                                  context
                                                      .read<UsersDataCubit>()
                                                      .SalaryType();
                                                }),
                                            InkWell(
                                              child: Text("Weekly"),
                                              onTap: () {
                                                salary_type_current_option = 1;
                                                context
                                                    .read<UsersDataCubit>()
                                                    .SalaryType();
                                              },
                                            ),
                                          ]),
                                        ),
                                        Container(
                                          child: Row(children: [
                                            Radio(
                                                value: 2,
                                                groupValue:
                                                    salary_type_current_option,
                                                onChanged: (value) {
                                                  salary_type_current_option =
                                                      2;
                                                  context
                                                      .read<UsersDataCubit>()
                                                      .SalaryType();
                                                }),
                                            InkWell(
                                              child: Text("Daily"),
                                              onTap: () {
                                                salary_type_current_option = 2;
                                                context
                                                    .read<UsersDataCubit>()
                                                    .SalaryType();
                                              },
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                    // child: Row(
                                    //   children: [
                                    //     Flexible(
                                    //       child: FittedBox(
                                    //         child: Text(
                                    //           "Salary Type :",
                                    //           // style: getTextBlack(context),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Flexible(
                                    //       child: ListTile(
                                    //         contentPadding: EdgeInsets.zero,
                                    //         title: FittedBox(
                                    //           child: Text(
                                    //             'Monthly',
                                    //             style: getTextBlack(context),
                                    //           ),
                                    //         ),
                                    //         leading: Radio(
                                    //           value: 0,
                                    //           groupValue:
                                    //               salary_type_current_option,
                                    //           onChanged: (value) {
                                    //             salary_type_current_option = 0;
                                    //             context
                                    //                 .read<UsersDataCubit>()
                                    //                 .SalaryType();
                                    //           },
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Flexible(
                                    //       child: ListTile(
                                    //         contentPadding: EdgeInsets.zero,
                                    //         title: FittedBox(
                                    //           child: Text(
                                    //             'Weekly',
                                    //             style: getTextBlack(context),
                                    //           ),
                                    //         ),
                                    //         leading: Radio(
                                    //           value: 1,
                                    //           groupValue:
                                    //               salary_type_current_option,
                                    //           onChanged: (value) {
                                    //             salary_type_current_option = 1;
                                    //             context
                                    //                 .read<UsersDataCubit>()
                                    //                 .SalaryType();
                                    //           },
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Flexible(
                                    //       child: ListTile(
                                    //         contentPadding: EdgeInsets.zero,
                                    //         title: FittedBox(
                                    //           child: Text(
                                    //             'Daily',
                                    //             style: getTextBlack(context),
                                    //           ),
                                    //         ),
                                    //         leading: Radio(
                                    //           value: 2,
                                    //           groupValue:
                                    //               salary_type_current_option,
                                    //           onChanged: (value) {
                                    //             salary_type_current_option = 2;
                                    //             context
                                    //                 .read<UsersDataCubit>()
                                    //                 .SalaryType();
                                    //           },
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                      left: mediaQuery.size.width / 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Salary Type :"),
                                      Container(
                                        child: Row(children: [
                                          Radio(
                                              value: 0,
                                              groupValue:
                                                  salary_type_current_option,
                                              onChanged: (value) {
                                                salary_type_current_option = 0;
                                                context
                                                    .read<UsersDataCubit>()
                                                    .SalaryType();
                                              }),
                                          InkWell(
                                            child: Text("Monthly"),
                                            onTap: () {
                                              salary_type_current_option = 0;
                                              context
                                                  .read<UsersDataCubit>()
                                                  .SalaryType();
                                            },
                                          ),
                                        ]),
                                      ),
                                      Container(
                                        child: Row(children: [
                                          Radio(
                                              value: 1,
                                              groupValue:
                                                  salary_type_current_option,
                                              onChanged: (value) {
                                                salary_type_current_option = 1;
                                                context
                                                    .read<UsersDataCubit>()
                                                    .SalaryType();
                                              }),
                                          InkWell(
                                            child: Text("Weekly"),
                                            onTap: () {
                                              salary_type_current_option = 1;
                                              context
                                                  .read<UsersDataCubit>()
                                                  .SalaryType();
                                            },
                                          ),
                                        ]),
                                      ),
                                      Container(
                                        child: Row(children: [
                                          Radio(
                                              value: 2,
                                              groupValue:
                                                  salary_type_current_option,
                                              onChanged: (value) {
                                                salary_type_current_option = 2;
                                                context
                                                    .read<UsersDataCubit>()
                                                    .SalaryType();
                                              }),
                                          InkWell(
                                            child: Text("Daily"),
                                            onTap: () {
                                              salary_type_current_option = 2;
                                              context
                                                  .read<UsersDataCubit>()
                                                  .SalaryType();
                                            },
                                          ),
                                        ]),
                                      ),
                                    ],
                                    // children: [
                                    //   Text(
                                    //     "Salary Type :",
                                    //     style: getTextBlack(context),
                                    //   ),
                                    //   ListTile(
                                    //     contentPadding: EdgeInsets.zero,
                                    //     title: Text(
                                    //       'Monthly',
                                    //       style: getTextBlack(context),
                                    //     ),
                                    //     leading: Radio(
                                    //       value: 0,
                                    //       groupValue: salary_type_current_option,
                                    //       onChanged: (value) {
                                    //         salary_type_current_option = 0;
                                    //         context
                                    //             .read<UsersDataCubit>()
                                    //             .Gender();
                                    //       },
                                    //     ),
                                    //   ),
                                    //   ListTile(
                                    //     contentPadding: EdgeInsets.zero,
                                    //     title: Text(
                                    //       'Weekly',
                                    //       style: getTextBlack(context),
                                    //     ),
                                    //     leading: Radio(
                                    //       value: 1,
                                    //       groupValue: salary_type_current_option,
                                    //       onChanged: (value) {
                                    //         salary_type_current_option = 1;
                                    // context
                                    //     .read<UsersDataCubit>()
                                    //     .Gender();
                                    //       },
                                    //     ),
                                    //   ),
                                    //   ListTile(
                                    //     contentPadding: EdgeInsets.zero,
                                    //     title: Text(
                                    //       'Daily',
                                    //       style: getTextBlack(context),
                                    //     ),
                                    //     leading: Radio(
                                    //       value: 2,
                                    //       groupValue: salary_type_current_option,
                                    //       onChanged: (value) {
                                    //         salary_type_current_option = 2;
                                    //         context
                                    //             .read<UsersDataCubit>()
                                    //             .Gender();
                                    //       },
                                    //     ),
                                    //   ),
                                    // ],
                                  ),
                                );
                        },
                      ),
                      SizedBox(height: mediaQuery.size.width / 50),
                      // Employer gender id
                      BlocBuilder<UsersDataCubit, UsersDataState>(
                        builder: (context, state) {
                          return (mediaQuery.size.width > 287)
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: mediaQuery.size.width * 0.7,
                                    margin: EdgeInsets.only(
                                        left: mediaQuery.size.width / 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Gender :'),
                                        Container(
                                          child: Row(children: [
                                            Radio(
                                              value: 0,
                                              groupValue: gender_current_option,
                                              onChanged: (value) {
                                                gender_current_option = 0;
                                                context
                                                    .read<UsersDataCubit>()
                                                    .Gender();
                                              },
                                            ),
                                            InkWell(
                                              child: Text('Male'),
                                              onTap: () {
                                                gender_current_option = 0;
                                                context
                                                    .read<UsersDataCubit>()
                                                    .Gender();
                                              },
                                            )
                                          ]),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                child: Row(children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue:
                                                        gender_current_option,
                                                    onChanged: (value) {
                                                      gender_current_option = 1;
                                                      context
                                                          .read<
                                                              UsersDataCubit>()
                                                          .Gender();
                                                    },
                                                  ),
                                                  InkWell(
                                                    child: Text('Female'),
                                                    onTap: () {
                                                      gender_current_option = 1;
                                                      context
                                                          .read<
                                                              UsersDataCubit>()
                                                          .Gender();
                                                    },
                                                  )
                                                ]),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                      // children: [
                                      //   Flexible(
                                      //     child: Text(
                                      //       "Gender :",
                                      //       style: getTextBlack(context),
                                      //     ),
                                      //   ),
                                      //   Flexible(
                                      //     child: ListTile(
                                      //       contentPadding: EdgeInsets.zero,
                                      //       title: Text(
                                      //         'Male',
                                      //         style: getTextBlack(context),
                                      //       ),
                                      //       leading: Radio(
                                      //         value: 0,
                                      //         groupValue: gender_current_option,
                                      //         onChanged: (value) {
                                      //           gender_current_option = 0;
                                      //           context
                                      //               .read<UsersDataCubit>()
                                      //               .Gender();
                                      //         },
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   Flexible(
                                      //     child: ListTile(
                                      //       contentPadding: EdgeInsets.zero,
                                      //       title: Text(
                                      //         'Female',
                                      //         style: getTextBlack(context),
                                      //       ),
                                      // leading: Radio(
                                      //   value: 1,
                                      //   groupValue: gender_current_option,
                                      //   onChanged: (value) {
                                      //     gender_current_option = 1;
                                      //     context
                                      //         .read<UsersDataCubit>()
                                      //         .Gender();
                                      //   },
                                      // ),
                                      //     ),
                                      //   ),
                                      // ],
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                      left: mediaQuery.size.width / 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Gender :'),
                                      Container(
                                        child: Row(children: [
                                          Radio(
                                            value: 0,
                                            groupValue: gender_current_option,
                                            onChanged: (value) {
                                              gender_current_option = 0;
                                              context
                                                  .read<UsersDataCubit>()
                                                  .Gender();
                                            },
                                          ),
                                          InkWell(
                                            child: Text('Male'),
                                            onTap: () {
                                              gender_current_option = 0;
                                              context
                                                  .read<UsersDataCubit>()
                                                  .Gender();
                                            },
                                          )
                                        ]),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Row(children: [
                                                Radio(
                                                  value: 1,
                                                  groupValue:
                                                      gender_current_option,
                                                  onChanged: (value) {
                                                    gender_current_option = 1;
                                                    context
                                                        .read<UsersDataCubit>()
                                                        .Gender();
                                                  },
                                                ),
                                                InkWell(
                                                  child: Text('Female'),
                                                  onTap: () {
                                                    gender_current_option = 1;
                                                    context
                                                        .read<UsersDataCubit>()
                                                        .Gender();
                                                  },
                                                )
                                              ]),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                    // children: [
                                    //   Text(
                                    //     "Gender :",
                                    //     style: getTextBlack(context),
                                    //   ),
                                    //   ListTile(
                                    //     contentPadding: EdgeInsets.zero,
                                    //     title: Text(
                                    //       'Male',
                                    //       style: getTextBlack(context),
                                    //     ),
                                    //     leading: Radio(
                                    //       value: 0,
                                    //       groupValue: gender_current_option,
                                    //       onChanged: (value) {
                                    //         gender_current_option = 0;
                                    //         context
                                    //             .read<UsersDataCubit>()
                                    //             .Gender();
                                    //       },
                                    //     ),
                                    //   ),
                                    //   ListTile(
                                    //     contentPadding: EdgeInsets.zero,
                                    //     title: Text(
                                    //       'Female',
                                    //       style: getTextBlack(context),
                                    //     ),
                                    //     leading: Radio(
                                    //       value: 1,
                                    //       groupValue: gender_current_option,
                                    //       onChanged: (value) {
                                    //         gender_current_option = 1;
                                    //         context
                                    //             .read<UsersDataCubit>()
                                    //             .Gender();
                                    //       },
                                    //     ),
                                    //   ),
                                    // ],
                                  ),
                                );
                        },
                      ),
                      SizedBox(height: mediaQuery.size.width / 50),
                      BlocBuilder<CircularIndicatorCubit,
                          CircularIndicatorState>(
                        builder: (context, state) {
                          return ResponsiveRowColumnItem(
                            child: Container(
                              child: FittedBox(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    submitted = true;
                                    context
                                        .read<CircularIndicatorCubit>()
                                        .Circular_Location();
                                    if (image == null) {
                                      image_uploaded_successfuly = false;
                                    } else {
                                      image_uploaded_successfuly = true;
                                    }
                                    context
                                        .read<UsersDataCubit>()
                                        .uploadedImage();
                                    if (_formkey.currentState!.validate()) {
                                      form_validate = true;
                                      getting_number_of_users = true;
                                      GetUsersRepo().getEmployeeData();
                                      last_id = (users.last.id + 1).toString();
                                      getting_number_of_users = false;
                                      GetUsersRepo().getEmployeeData();
                                      // start uploading image to server
                                      Supabase.initialize(
                                        url:
                                            'https://oarqjspwajbojrddcvky.supabase.co',
                                        anonKey:
                                            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hcnFqc3B3YWpib2pyZGRjdmt5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTE3Mzk2NTQsImV4cCI6MjAyNzMxNTY1NH0.NJ-QaQKrveyPpE2G9-8kizBh6ByFShdQ47xs2Bx8wmQ',
                                      );
                                      SupabaseClient supabase =
                                          Supabase.instance.client;
                                      path = basename(image.path);
                                      print(path + '//**');
                                      supabase.storage
                                          .from('image')
                                          .upload(last_id, image)
                                          .then((value) {
                                        image_uploaded_successfuly = false;
                                      });
                                      Employer_image = await supabase.storage
                                          .from('image')
                                          .getPublicUrl(last_id);
                                      // end uploading image to server
                                      // await Future.delayed(const Duration(seconds: 3));

                                      // print((users.last.id).toString() + 'ahmed');
                                      DateTime now = DateTime.now();
                                      String hiring_date =
                                          DateFormat('dd/MM/yyyy').format(now);
                                      // print(formattedDate + '//**');
                                      // print(now.toString() + '//**');
                                      adding_employee = true;
                                      postUsersData = {
                                        "id": last_id,
                                        "firstName": Employer_first_Name,
                                        "lastName": Employer_last_Name,
                                        "age": int.parse(Employer_age),
                                        "gender": (gender_current_option == 0)
                                            ? "male"
                                            : "female",
                                        "salary_type":
                                            (salary_type_current_option == 0)
                                                ? "Monthly"
                                                : (salary_type_current_option ==
                                                        1)
                                                    ? "Weekly"
                                                    : "Daily",
                                        "email": Employer_email,
                                        "phone": Employer_phone,
                                        "salary": Employer_salary,
                                        "address": Employer_address,
                                        "position": Employer_position,
                                        "hiring_date": hiring_date,
                                        'rating': '0.0',
                                        // "image":
                                        //     "https://robohash.org/Tevin.png?set=set4",
                                        "image": Employer_image,
                                        "departmentId":
                                            (selectedDepartmentItem_adding !=
                                                    null)
                                                ? department_id_items[
                                                    department_items.indexOf(
                                                        selectedDepartmentItem_adding!)]
                                                : "Empty",
                                        // selectedDepartmentItem_adding?[
                                        //         selectedDepartmentItem_adding!
                                        //                 .length -
                                        //             1] ??
                                        //     "Empty",
                                        // "shiftId": shiftId,
                                        "shiftId": (selectedShiftItem_adding !=
                                                null)
                                            ? shift_id_items[
                                                shift_items.indexOf(
                                                    selectedShiftItem_adding!)]
                                            : "Empty",
                                        // selectedShiftItem_adding?[
                                        //         selectedShiftItem_adding!.length -
                                        //             1] ??
                                        //     "Empty"

                                        "companyName": Company_Name
                                      };
                                      context
                                          .read<UsersDataCubit>()
                                          .getUsersData();
                                      adding_employee = false;
                                      Employer_first_Name = "";
                                      Employer_last_Name = "";
                                      Employer_age = "";
                                      gender_current_option = 0;
                                      salary_type_current_option = 0;
                                      Employer_email = "";
                                      Employer_phone = "";
                                      Employer_salary = "";
                                      Employer_address = "";
                                      Employer_position = "";
                                      shiftId = "";
                                      selectedDepartmentItem_adding = null;
                                      selectedShiftItem_adding = null;
                                      image_uploaded_successfuly = false;
                                      Navigator.pop(
                                        context,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      side: (submitted == true &&
                                              form_validate == false)
                                          ? const BorderSide(
                                              color: Colors.red, width: 2)
                                          : null,
                                      shadowColor: Colors.black,
                                      elevation: 10,
                                      backgroundColor:
                                          const Color.fromRGBO(50, 50, 160, 1),
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                      )),
                                  child: Text(
                                    "Submit",
                                    style: getTextWhite(context),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
