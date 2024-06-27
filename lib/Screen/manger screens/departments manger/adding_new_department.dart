import 'package:emas/Cubits/Departments%20Data/cubit/departments_data_cubit.dart';
import 'package:emas/Cubits/Show_field_requirments/field_requirments_cubit.dart';
import 'package:emas/Screen/Splash_Screen.dart';
import 'package:emas/data/Repository/get_departments_repo.dart';
import 'package:emas/functions/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_framework/responsive_row_column.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AddingDepartment extends StatelessWidget {
  AddingDepartment({super.key});

  RegExp department_name_regex =
      RegExp(r'^(?=^.{3,}$)([a-zA-Z0-9_])+( [a-zA-Z0-9_]+)*$');

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var department_Name_Info = false;

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
          "Adding New Department",
          style:
              (landscape) ? getTextWhiteHeader(context) : getTextWhite(context),
        )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                    //Department Name
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
                              Department_Name = text;
                            },
                            validator: (value) {
                              if (department_name_regex.hasMatch(value!) ==
                                  false) {
                                return 'Invalid Department Name';
                              } else {
                                Department_Name = value;
                                return null;
                              }
                            },
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.red[400], height: 0.8),
                                // contentPadding:
                                //     EdgeInsets.symmetric(vertical: 0.0),
                                prefixIcon: Image.asset(icons[4],
                                    scale: 3,
                                    color: Color.fromARGB(255, 145, 142, 142)),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // border: OutlineInputBorder(),
                                hintText: 'Department Name',
                                hintStyle: getTextGrey(context)),
                          ),
                        ),
                        InkWell(
                          onTapDown: (_) {
                            context
                                .read<FieldRequirmentsCubit>()
                                .FieldRequirments();
                            department_Name_Info = true;
                          },
                          onTapUp: (_) {
                            context
                                .read<FieldRequirmentsCubit>()
                                .FieldRequirments();
                            department_Name_Info = false;
                          },
                          onTapCancel: () {
                            context
                                .read<FieldRequirmentsCubit>()
                                .FieldRequirments();
                            department_Name_Info = false;
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
                        visible: department_Name_Info,
                        child: Container(
                          width: mediaQuery.size.width * 0.8,
                          child: Text(
                            'The Department Name must contain at least 3 characters\nThe First Name can only consist of alphanumeric characters (both lowercase and uppercase) and underscores.',
                            style: getSmallTextBlack(context),
                          ),
                        )),
                    SizedBox(height: mediaQuery.size.width / 50),
                    //Department Descreption
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
                                Department_Descreption = text;
                              },
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.red[400], height: 0.8),
                                  // contentPadding:
                                  //     EdgeInsets.symmetric(vertical: 0.0),
                                  prefixIcon: const Icon(Icons.person,
                                      color: Color.fromARGB(255, 145, 142, 142),
                                      size: 30),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // border: OutlineInputBorder(),
                                  hintText: 'Department Description',
                                  hintStyle: getTextGrey(context)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mediaQuery.size.width / 50),
                    SizedBox(
                      height: 10,
                    ),
                    ResponsiveRowColumnItem(
                      child: Container(
                        child: FittedBox(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                // await Future.delayed(const Duration(seconds: 3));
                                getting_number_of_departments = true;
                                await GetDepartmentsRepo().getDepartmentsData();
                                getting_number_of_departments = false;
                                // print((departments.length + 1).toString() +
                                //     'ahmed');
                                adding_department = true;
                                postDepartmentData = {
                                  "id": (departments.last.id + 1).toString(),
                                  "Name": Department_Name,
                                  "Description": Department_Descreption,
                                  "companyName": Company_Name
                                };
                                context
                                    .read<DepartmentsDataCubit>()
                                    .getDepartmentsData();
                                adding_department = false;
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString('Departments_number',
                                    (departments.length + 1).toString());
                                // Departments_number =
                                //     (int.parse(Departments_number) + 1)
                                //         .toString();
                                Navigator.pop(
                                  context,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
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
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
