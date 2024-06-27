// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:emas/Cubits/Adding%20Users%20To%20Department%20Or%20Shift/adding_users_to_department_or_shift_cubit.dart';
import 'package:emas/Cubits/Departments%20Data/cubit/departments_data_cubit.dart';
import 'package:emas/Cubits/Search/search_cubit.dart';
import 'package:emas/Cubits/Shifts%20data/shifts_data_cubit.dart';
import 'package:emas/Cubits/Users%20data/users_data_cubit.dart';
import 'package:emas/data/Repository/get_departments_repo.dart';
import 'package:emas/data/Repository/get_shifts_repo.dart';
import 'package:emas/data/Repository/get_users_Repo.dart';
import 'package:emas/functions/drawer.dart';
import 'package:emas/functions/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

// ignore: must_be_immutable
class AddingEmployeeToDepartment extends StatefulWidget {
  AddingEmployeeToDepartment({super.key});

  @override
  State<AddingEmployeeToDepartment> createState() =>
      _AddingEmployeeToDepartmentState();
}

class _AddingEmployeeToDepartmentState
    extends State<AddingEmployeeToDepartment> {
  List<String> items_Department = [
    'id',
    'firstName',
    'lastName',
    'age',
    'gender',
    'phone',
    'email',
    'salary',
    'departmentId',
    'shiftId',
    'rating'
  ];

  List<String> sort_items = [
    'id',
    'firstName',
    'lastName',
    'age',
    'phone',
    'email',
    'salary',
    'departmentId',
    'shiftId',
    'rating'
  ];

  List<String> items_Shift = [
    'id',
    'firstName',
    'lastName',
    'age',
    'gender',
    'phone',
    'email',
    'salary',
    'departmentId',
    'shiftId',
    'rating'
  ];

  var male_gender_color = Colors.white;
  var female_gender_color = Colors.white;

  RangeValues salary_values = RangeValues(0, 100000);
  RangeLabels salary_labels = RangeLabels('0', '100000');

  RangeValues age_values = RangeValues(20, 90);
  RangeLabels age_labels = RangeLabels('20', '90');

  RangeValues rating_values = RangeValues(0.0, 5.0);
  RangeLabels rating_labels = RangeLabels('0.0', '5.0');

  bool _isVisible = false;
  List<int> checked_users_id = [];
  String current_department_or_shift = search_users_text;

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    final statusBar = MediaQuery.of(context).viewPadding.top;
    return SafeArea(
      child: Scaffold(
        drawer: myDrawer(),
        appBar: AppBar(
          toolbarHeight: (landscape)
              ? mediaQuery.size.height * (100 / 800)
              : mediaQuery.size.height * (70 / 800),
          // backgroundColor: const Color(0xfff0a307),
          backgroundColor:
              // const Color.fromRGBO(56, 149, 164, 1),
              const Color.fromRGBO(50, 50, 160, 1),
          leading: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return Builder(builder: (context) {
                return (context.read<SearchCubit>().search == false)
                    ? IconButton(
                        color: Colors.white,
                        onPressed: () {
                          context.read<SearchCubit>().close_search();
                          context.read<SearchCubit>().close_sort();
                          sort_ascending = true;
                          sort = false;
                          if (adding_employee_to_department == true) {
                            selectedUsersItem_department = items_Department[0];
                          } else if (adding_employee_to_shift == true) {
                            selectedUsersItem_department = items_Shift[0];
                          }
                          selectedUsersSortItem = sort_items[0];

                          adding_employee_to_department = false;
                          adding_employee_to_shift = false;
                          isChecked.clear();
                          for (int i = 0; i < users.length; i++) {
                            isChecked.add(false);
                          }
                          exiption_condition = "";
                          editing_employee = false;
                          search_users_text_department = "";
                          _textEditingController.clear();
                          male_gender_color = Colors.white;
                          female_gender_color = Colors.white;
                          Employer_age_start = 20;
                          Employer_age_end = 90;
                          Employer_salary_start = 0;
                          Employer_salary_end = 100000;
                          Employer_rating_start = 0.0;
                          Employer_rating_end = 5.0;
                          context.read<UsersDataCubit>().getUsersData();
                          context.read<ShiftsDataCubit>().getShiftsData();
                          context
                              .read<DepartmentsDataCubit>()
                              .getDepartmentsData();
                          Navigator.pop(
                            context,
                          );
                        },
                        icon: Icon(Icons.arrow_back),
                      )
                    : IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          // ignore: invalid_use_of_protected_member
                          context.read<SearchCubit>().emit(Sort());
                          // sort = context.read<SearchCubit>().sort;
                          context.read<UsersDataCubit>().getUsersData();
                          if (sort_ascending == true) {
                            sort_ascending = false;
                          } else {
                            sort_ascending = true;
                          }
                          // selectedUsersItem = items[0];
                          // search_users_text = "";
                          // _textEditingController.clear();
                          // female_gender_color = Colors.white;
                          // male_gender_color = Colors.white;
                          // Employer_age_start = 20;
                          // Employer_age_end = 90;
                          // Employer_salary_start = 0;
                          // Employer_salary_end = 100000;
                          // // if (context.read<SearchCubit>().search == false)
                          //   // Future.delayed(Duration(milliseconds: 1500), () {
                          //   //   print('Function started!');
                          //   //   // Add your code here that you want to execute after 2 seconds
                          //   //   context.read<UsersDataCubit>().getUsersData();
                          //   // });
                          //   // context.read<UsersDataCubit>().getUsersData();
                        },
                        icon: (sort_ascending == true)
                            ? Icon(Icons.arrow_downward)
                            : Icon(Icons.arrow_upward));
              });
            },
          ),
          actions: [
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return Row(
                  children: [
                    (context.read<SearchCubit>().sort == true)
                        ? SizedBox()
                        :
                        // search case
                        IconButton(
                            color: Colors.white,
                            onPressed: () {
                              context.read<SearchCubit>().search_icon();
                              context.read<SearchCubit>().close_sort();
                              if (adding_employee_to_department == true) {
                                selectedUsersItem_department =
                                    items_Department[0];
                              } else if (adding_employee_to_shift == true) {
                                selectedUsersItem_department = items_Shift[0];
                              }
                              search_users_text_department = "";
                              _textEditingController.clear();
                              male_gender_color = Colors.white;
                              female_gender_color = Colors.white;
                              Employer_age_start = 20;
                              Employer_age_end = 90;
                              Employer_salary_start = 0;
                              Employer_salary_end = 100000;
                              Employer_rating_start = 0.0;
                              Employer_rating_end = 5.0;
                              sort = true;
                              if (context.read<SearchCubit>().search == false) {
                                sort = false;
                                selectedUsersSortItem = sort_items[0];
                                sort_ascending = true;
                              }
                              context.read<UsersDataCubit>().getUsersData();
                            },
                            icon: (context.read<SearchCubit>().search == false)
                                ? Icon(Icons.search)
                                : Icon(Icons.close),
                          ),
                    (context.read<SearchCubit>().search == false)
                        ?
                        // sort case
                        IconButton(
                            color: Colors.white,
                            onPressed: () async {
                              context.read<SearchCubit>().sort_icon();
                              sort = context.read<SearchCubit>().sort;
                              context.read<UsersDataCubit>().getUsersData();
                              sort_ascending = true;
                              selectedUsersSortItem =
                                  (Department_Employee_List == true)
                                      ? sort_items[0]
                                      : sort_items[0];
                              // selectedUsersItem = items[0];
                              // search_users_text = "";
                              // _textEditingController.clear();
                              // female_gender_color = Colors.white;
                              // male_gender_color = Colors.white;
                              // Employer_age_start = 20;
                              // Employer_age_end = 90;
                              // Employer_salary_start = 0;
                              // Employer_salary_end = 100000;
                              // // if (context.read<SearchCubit>().search == false)
                              //   // Future.delayed(Duration(milliseconds: 1500), () {
                              //   //   print('Function started!');
                              //   //   // Add your code here that you want to execute after 2 seconds
                              //   //   context.read<UsersDataCubit>().getUsersData();
                              //   // });
                              //   // context.read<UsersDataCubit>().getUsersData();
                            },
                            icon: (sort == false)
                                ? Icon(Icons.sort)
                                : Icon(Icons.close))
                        : SizedBox(),
                  ],
                );
              },
            ),
          ],
          automaticallyImplyLeading: false,
          title: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return (!context.read<SearchCubit>().search &&
                      !context.read<SearchCubit>().sort)
                  ?
                  // default case
                  FittedBox(
                      child: Text(
                      (Department_Employee_List == true)
                          ? "Add Employee to ${departments[departments.indexWhere((element) => element.id == int.parse(search_users_text))].name}"
                          : 'Add Employee to ${shifts[shifts.indexWhere((element) => element.id == int.parse(search_users_text))].name} Shift',
                      // "Employees List",
                      style: (landscape)
                          ? getTextWhiteHeader(context)
                          : getTextWhite(context),
                    ))
                  : (context.read<SearchCubit>().search == true)
                      ?
                      // search case
                      Row(
                          children: [
                            (selectedUsersItem_department == 'salary')
                                ? Expanded(
                                    child: Container(
                                        // height: mediaQuery.size.height * (50 / 800),
                                        child: Center(
                                      child: Text(
                                        "${(Employer_salary_start).toString()} - ${(Employer_salary_end)}",
                                        style: getTextWhite(context),
                                      ),
                                    )
                                        //     RangeSlider(
                                        //   min: 0,
                                        //   max: 100000,
                                        //   divisions: (100000),
                                        //   values: salary_values,
                                        //   labels: salary_labels,
                                        //   onChanged: (value) {
                                        //     Employer_salary_start =
                                        //         (value.start.toInt());
                                        //     Employer_salary_end = (value.end.toInt());
                                        //     search_users_text_department = "salary";
                                        //     // print("salary start:" + Employer_age_start);
                                        //     // print("salary end:" + Employer_age_end);
                                        //     // print("selectedUsersItem: " +
                                        //     // selectedUsersItem.toString());
                                        //     salary_values = value;
                                        //     salary_labels = RangeLabels(
                                        //         '${value.start.toInt().toString()}\$',
                                        //         '${value.end.toInt().toString()}\$');
                                        //     context
                                        //         .read<SearchCubit>()
                                        //         // ignore: invalid_use_of_protected_member
                                        //         .emit(SearchInitial());
                                        //     context
                                        //         .read<UsersDataCubit>()
                                        //         .getUsersData();
                                        //     // setState(() {});
                                        //   },
                                        // )
                                        ),
                                  )
                                : (selectedUsersItem_department == 'age')
                                    ? Expanded(
                                        child: Container(
                                            // width: 400,
                                            // height: 100,
                                            child: Center(
                                          child: Text(
                                            "${(Employer_age_start).toString()} - ${(Employer_age_end)}",
                                            style: getTextWhite(context),
                                          ),
                                        )
                                            //     RangeSlider(
                                            //   min: 20,
                                            //   max: 90,
                                            //   divisions: (90),
                                            //   values: age_values,
                                            //   labels: age_labels,
                                            //   onChanged: (value) {
                                            //     Employer_age_start =
                                            //         (value.start.toInt());
                                            //     Employer_age_end = (value.end.toInt());
                                            //     search_users_text_department = 'age';
                                            //     age_values = value;
                                            //     age_labels = RangeLabels(
                                            //         value.start.toInt().toString(),
                                            //         value.end.toInt().toString());
                                            //     context
                                            //         .read<SearchCubit>()
                                            //         // ignore: invalid_use_of_protected_member
                                            //         .emit(SearchInitial());
                                            //     context
                                            //         .read<UsersDataCubit>()
                                            //         .getUsersData();
                                            //     // setState(() {});
                                            //   },
                                            // )
                                            ),
                                      )
                                    : (selectedUsersItem_department == 'gender')
                                        ? Expanded(
                                            child: Container(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  child: Text("Male",
                                                      style: TextStyle(
                                                          fontSize:
                                                              ResponsiveValue(
                                                            context,
                                                            valueWhen: [
                                                              Condition
                                                                  .smallerThan(
                                                                      name:
                                                                          MOBILE,
                                                                      value:
                                                                          14.0),
                                                              Condition
                                                                  .largerThan(
                                                                      name:
                                                                          MOBILE,
                                                                      value:
                                                                          16.0),
                                                              Condition
                                                                  .smallerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          18.0),
                                                              Condition
                                                                  .largerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          20.0),
                                                              Condition
                                                                  .largerThan(
                                                                      name:
                                                                          DESKTOP,
                                                                      value:
                                                                          24.0),
                                                              Condition
                                                                  .largerThan(
                                                                      name:
                                                                          'XL',
                                                                      value:
                                                                          28.0),
                                                            ],
                                                            defaultValue: 12.0,
                                                          ).value,
                                                          color:
                                                              male_gender_color)),
                                                  onTap: () {
                                                    search_users_text_department =
                                                        "male";
                                                    context
                                                        .read<UsersDataCubit>()
                                                        .getUsersData();
                                                    male_gender_color =
                                                        Colors.black;
                                                    female_gender_color =
                                                        Colors.white;
                                                    context
                                                        .read<SearchCubit>()
                                                        .Gender_color();
                                                  },
                                                ),
                                                InkWell(
                                                  child: Text("Female",
                                                      style: TextStyle(
                                                          fontSize:
                                                              ResponsiveValue(
                                                            context,
                                                            valueWhen: [
                                                              Condition
                                                                  .smallerThan(
                                                                      name:
                                                                          MOBILE,
                                                                      value:
                                                                          14.0),
                                                              Condition
                                                                  .largerThan(
                                                                      name:
                                                                          MOBILE,
                                                                      value:
                                                                          16.0),
                                                              Condition
                                                                  .smallerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          18.0),
                                                              Condition
                                                                  .largerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          20.0),
                                                              Condition
                                                                  .largerThan(
                                                                      name:
                                                                          DESKTOP,
                                                                      value:
                                                                          24.0),
                                                              Condition
                                                                  .largerThan(
                                                                      name:
                                                                          'XL',
                                                                      value:
                                                                          28.0),
                                                            ],
                                                            defaultValue: 12.0,
                                                          ).value,
                                                          color:
                                                              female_gender_color)),
                                                  onTap: () {
                                                    search_users_text_department =
                                                        "female";
                                                    context
                                                        .read<UsersDataCubit>()
                                                        .getUsersData();
                                                    female_gender_color =
                                                        Colors.black;
                                                    male_gender_color =
                                                        Colors.white;
                                                    context
                                                        .read<SearchCubit>()
                                                        .Gender_color();
                                                  },
                                                ),
                                              ],
                                            )),
                                          )
                                        : (selectedUsersItem_department ==
                                                'rating')
                                            // ahmed othman
                                            ? Expanded(
                                                child: Container(
                                                    // width: 400,
                                                    // height: 100,
                                                    child: Center(
                                                  child: Text(
                                                    "${(Employer_rating_start).toString().substring(0, 3)} - ${(Employer_rating_end).toString().substring(0, 3)}",
                                                    style:
                                                        getTextWhite(context),
                                                  ),
                                                )
                                                    //     RangeSlider(
                                                    //   min: 20,
                                                    //   max: 90,
                                                    //   divisions: (90),
                                                    //   values: age_values,
                                                    //   labels: age_labels,
                                                    //   onChanged: (value) {
                                                    //     Employer_age_start =
                                                    //         (value.start.toInt());
                                                    //     Employer_age_end = (value.end.toInt());
                                                    //     search_users_text_department = 'age';
                                                    //     age_values = value;
                                                    //     age_labels = RangeLabels(
                                                    //         value.start.toInt().toString(),
                                                    //         value.end.toInt().toString());
                                                    //     context
                                                    //         .read<SearchCubit>()
                                                    //         // ignore: invalid_use_of_protected_member
                                                    //         .emit(SearchInitial());
                                                    //     context
                                                    //         .read<UsersDataCubit>()
                                                    //         .getUsersData();
                                                    //     // setState(() {});
                                                    //   },
                                                    // )
                                                    ),
                                              )
                                            : Expanded(
                                                child: TextFormField(
                                                  controller:
                                                      _textEditingController,
                                                  style: getTextWhite(context),
                                                  onChanged: (text) {
                                                    search_users_text_department =
                                                        "";
                                                    search_users_text_department =
                                                        text;
                                                    context
                                                        .read<UsersDataCubit>()
                                                        .getUsersData();
                                                    // print(search_text);
                                                  },
                                                  // validator: (value) {
                                                  //   if (value == "") {
                                                  //     return 'Invalid Company Name';
                                                  //   }
                                                  //   return null;
                                                  // },
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .white, // Change to your desired color
                                                      ),
                                                    ),
                                                    errorStyle: TextStyle(
                                                        color: Colors.red[400]),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    // prefixIcon: const Icon(Icons.business,
                                                    //     color: Color.fromARGB(255, 145, 142, 142), size: 30),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    border: null,
                                                    hintText: 'Search',
                                                    hintStyle: (landscape)
                                                        ? getTextWhite(context)
                                                        : getTextWhite(context),
                                                    // const TextStyle(
                                                    //   fontSize: 20,
                                                    // )
                                                  ),
                                                ),
                                              ),
                            DropdownButton<String>(
                              dropdownColor:
                                  // const Color.fromRGBO(56, 149, 164, 1),
                                  const Color.fromRGBO(50, 50, 160, 1),
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              value: selectedUsersItem_department,
                              // style: TextStyle(color: Colors.white),
                              style: getTextWhite(context),
                              items: (adding_employee_to_department == true)
                                  ? items_Department
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item, child: Text(item)))
                                      .toList()
                                  : items_Shift
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item, child: Text(item)))
                                      .toList(),
                              onChanged: (item) {
                                selectedUsersItem_department = item;
                                selectedUsersSortItem =
                                    (selectedUsersItem_department == 'gender')
                                        ? 'id'
                                        : selectedUsersItem_department;
                                sort_ascending = true;
                                search_users_text_department = "";
                                _textEditingController.clear();
                                male_gender_color = Colors.white;
                                female_gender_color = Colors.white;
                                age_values = RangeValues(20, 90);
                                age_labels = RangeLabels('20', '90');
                                salary_values = RangeValues(0, 100000);
                                salary_labels = RangeLabels('0', '100000');
                                rating_values = RangeValues(0.0, 5.0);
                                rating_labels = RangeLabels('0.0', '5.0');
                                Employer_age_start = 20;
                                Employer_age_end = 90;
                                Employer_salary_start = 0;
                                Employer_salary_end = 100000;
                                Employer_rating_start = 0.0;
                                Employer_rating_end = 5.0;
                                // ignore: invalid_use_of_protected_member
                                context
                                    .read<SearchCubit>()
                                    // ignore: invalid_use_of_protected_member
                                    .emit(SearchInitial());
                                context.read<UsersDataCubit>().getUsersData();
                              },
                            )
                          ],
                        )
                      :
                      // sort case
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                color: Colors.white,
                                onPressed: () async {
                                  // ignore: invalid_use_of_protected_member
                                  context.read<SearchCubit>().emit(Sort());
                                  sort = context.read<SearchCubit>().sort;
                                  context.read<UsersDataCubit>().getUsersData();
                                  if (sort_ascending == true) {
                                    sort_ascending = false;
                                  } else {
                                    sort_ascending = true;
                                  }
                                  // selectedUsersItem = items[0];
                                  // search_users_text = "";
                                  // _textEditingController.clear();
                                  // female_gender_color = Colors.white;
                                  // male_gender_color = Colors.white;
                                  // Employer_age_start = 20;
                                  // Employer_age_end = 90;
                                  // Employer_salary_start = 0;
                                  // Employer_salary_end = 100000;
                                  // // if (context.read<SearchCubit>().search == false)
                                  //   // Future.delayed(Duration(milliseconds: 1500), () {
                                  //   //   print('Function started!');
                                  //   //   // Add your code here that you want to execute after 2 seconds
                                  //   //   context.read<UsersDataCubit>().getUsersData();
                                  //   // });
                                  //   // context.read<UsersDataCubit>().getUsersData();
                                },
                                icon: (sort_ascending == true)
                                    ? Icon(Icons.arrow_downward)
                                    : Icon(Icons.arrow_upward)),
                            DropdownButton<String>(
                              dropdownColor:
                                  // const Color.fromRGBO(56, 149, 164, 1),
                                  const Color.fromRGBO(50, 50, 160, 1),
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              value: selectedUsersSortItem,
                              style: getTextWhite(context),
                              //           selectedUsersSortItem = (Department_Employee_List == true)
                              // ? sort_Department_items[0]
                              // : sort_Shift_items[0];
                              items: (Department_Employee_List == true)
                                  ? sort_items
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item, child: Text(item)))
                                      .toList()
                                  : sort_items
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item, child: Text(item)))
                                      .toList(),
                              onChanged: (item) {
                                selectedUsersSortItem = item;
                                sort_ascending = true;
                                context
                                    .read<SearchCubit>()
                                    // ignore: invalid_use_of_protected_member
                                    .emit(SearchInitial());
                                context.read<UsersDataCubit>().getUsersData();
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
            context.read<ShiftsDataCubit>().getShiftsData();
            context.read<DepartmentsDataCubit>().getDepartmentsData();
            context.read<SearchCubit>().close_search();
            context.read<SearchCubit>().close_sort();
            sort_ascending = true;
            sort = false;
            if (adding_employee_to_department == true) {
              selectedUsersItem_department = items_Department[0];
            } else if (adding_employee_to_shift == true) {
              selectedUsersItem_department = items_Shift[0];
            }
            adding_employee_to_department = false;
            adding_employee_to_shift = false;
            isChecked.clear();
            for (int i = 0; i < users.length; i++) {
              isChecked.add(false);
            }
            sort_ascending = true;
            sort = false;
            exiption_condition = "";
            editing_employee = false;
            search_users_text_department = "";
            Employer_age_start = 20;
            Employer_age_end = 90;
            Employer_salary_start = 0;
            Employer_salary_end = 100000;
            Employer_rating_start = 0.0;
            Employer_rating_end = 5.0;
            _textEditingController.clear();
            male_gender_color = Colors.white;
            female_gender_color = Colors.white;
            context.read<UsersDataCubit>().getUsersData();
            Navigator.pop(
              context,
            );
            return true;
          },
          child: BlocBuilder<AddingUsersToDepartmentOrShiftCubit,
              AddingUsersToDepartmentOrShiftState>(
            builder: (context, state) {
              return Stack(children: [
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              child: (selectedUsersItem_department == 'age')
                                  ? Container(
                                      height: (landscape)
                                          ? mediaQuery.size.height * 0.08
                                          : mediaQuery.size.height * 0.05,
                                      width: mediaQuery.size.width * 0.7,
                                      // color: Colors.yellow,
                                      child: Container(
                                          // width: 400,
                                          // height: 100,
                                          child: RangeSlider(
                                        min: 20,
                                        max: 90,
                                        divisions: (90),
                                        values: age_values,
                                        labels: age_labels,
                                        onChanged: (value) {
                                          Employer_age_start =
                                              (value.start.toInt());
                                          Employer_age_end =
                                              (value.end.toInt());
                                          search_users_text_department = 'age';
                                          age_values = value;
                                          age_labels = RangeLabels(
                                              value.start.toInt().toString(),
                                              value.end.toInt().toString());
                                          context
                                              .read<SearchCubit>()
                                              // ignore: invalid_use_of_protected_member
                                              .emit(SearchInitial());
                                          context
                                              .read<UsersDataCubit>()
                                              .getUsersData();
                                          // setState(() {});
                                        },
                                      )))
                                  : (selectedUsersItem_department == 'salary')
                                      ? Container(
                                          height: (landscape)
                                              ? mediaQuery.size.height * 0.08
                                              : mediaQuery.size.height * 0.05,
                                          width: mediaQuery.size.width * 0.7,
                                          // color: Colors.yellow,
                                          // height: mediaQuery.size.height * (50 / 800),
                                          child: RangeSlider(
                                            min: 0,
                                            max: 100000,
                                            divisions: (100000),
                                            values: salary_values,
                                            labels: salary_labels,
                                            onChanged: (value) {
                                              Employer_salary_start =
                                                  (value.start.toInt());
                                              Employer_salary_end =
                                                  (value.end.toInt());
                                              search_users_text_department =
                                                  "salary";
                                              // print("salary start:" + Employer_age_start);
                                              // print("salary end:" + Employer_age_end);
                                              // print("selectedUsersItem: " +
                                              // selectedUsersItem.toString());
                                              salary_values = value;
                                              salary_labels = RangeLabels(
                                                  '${value.start.toInt().toString()}\$',
                                                  '${value.end.toInt().toString()}\$');
                                              context
                                                  .read<SearchCubit>()
                                                  // ignore: invalid_use_of_protected_member
                                                  .emit(SearchInitial());
                                              context
                                                  .read<UsersDataCubit>()
                                                  .getUsersData();
                                              // setState(() {});
                                            },
                                          ))
                                      : (selectedUsersItem_department ==
                                              'rating')
                                          ? Container(
                                              height: (landscape)
                                                  ? mediaQuery.size.height *
                                                      0.08
                                                  : mediaQuery.size.height *
                                                      0.05,
                                              width:
                                                  mediaQuery.size.width * 0.7,
                                              // color: Colors.yellow,
                                              // height: mediaQuery.size.height * (50 / 800),
                                              child: RangeSlider(
                                                min: 0.0,
                                                max: 5.0,
                                                divisions: (50),
                                                values: rating_values,
                                                labels: rating_labels,
                                                onChanged: (value) {
                                                  Employer_rating_start =
                                                      (value.start.toDouble());
                                                  Employer_rating_end =
                                                      (value.end.toDouble());
                                                  search_users_text_department =
                                                      "rating";
                                                  // print("salary start:" + Employer_age_start);
                                                  // print("salary end:" + Employer_age_end);
                                                  // print("selectedUsersItem: " +
                                                  // selectedUsersItem.toString());
                                                  rating_values = value;
                                                  rating_labels = RangeLabels(
                                                      (value.start
                                                              .toDouble()
                                                              .toString())
                                                          .substring(0, 3),
                                                      (value.end
                                                              .toDouble()
                                                              .toString())
                                                          .substring(0, 3));
                                                  context
                                                      .read<SearchCubit>()
                                                      // ignore: invalid_use_of_protected_member
                                                      .emit(SearchInitial());
                                                  context
                                                      .read<UsersDataCubit>()
                                                      .getUsersData();
                                                  // setState(() {});
                                                },
                                              ))
                                          : Container()),
                          Container(
                            height: (selectedUsersItem_department == 'age' ||
                                    selectedUsersItem_department == 'salary')
                                ? (landscape)
                                    ? (mediaQuery.size.height -
                                        (mediaQuery.size.height * (100 / 800)) -
                                        (statusBar) -
                                        mediaQuery.size.height * 0.08)
                                    : (mediaQuery.size.height -
                                        (mediaQuery.size.height * (70 / 800)) -
                                        (statusBar) -
                                        mediaQuery.size.height * 0.05)
                                : (landscape)
                                    ? (mediaQuery.size.height -
                                        (mediaQuery.size.height * (100 / 800)) -
                                        (statusBar))
                                    : (mediaQuery.size.height -
                                        (mediaQuery.size.height * (70 / 800)) -
                                        (statusBar)),
                            child: BlocBuilder<UsersDataCubit, UsersDataState>(
                              builder: (context, state) {
                                if (state is UsersDataSuccess) {
                                  return ListView.builder(
                                      itemCount: users.length,
                                      // itemCount: state.response.users.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          // margin: EdgeInsets.only(top: 10, bottom: 10),
                                          margin: (landscape)
                                              ? EdgeInsets.all(5)
                                              : EdgeInsets.all(10),
                                          width: (landscape)
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.9
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                          height: (landscape)
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1 /
                                                  10
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1 /
                                                  10,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                              ),
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                        'Employee\'s info',
                                                        // style: GoogleFonts.lato(),
                                                      ),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: BlocBuilder<
                                                            UsersDataCubit,
                                                            UsersDataState>(
                                                          builder:
                                                              (context, state) {
                                                            if (state
                                                                is UsersDataError) {
                                                              return const Center(
                                                                  child:
                                                                      CircularProgressIndicator());
                                                            } else if (state
                                                                is UsersDataSuccess) {
                                                              return Container(
                                                                width: mediaQuery
                                                                        .size
                                                                        .width /
                                                                    1.8,
                                                                height: mediaQuery
                                                                        .size
                                                                        .height /
                                                                    2.5,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        child: Image.network(
                                                                            users[index].image),
                                                                        width: mediaQuery.size.width /
                                                                            1.8,
                                                                        height: mediaQuery.size.height /
                                                                            4.5,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        "Id : ${users[index].id}",
                                                                      ),
                                                                      Text(
                                                                        "Name : ${users[index].firstName} ${users[index].lastName}",
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "Age : ${users[index].age}",
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "Gender : ${users[index].gender}",
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "Email : ${users[index].email}",
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "Phone : ${users[index].phone}",
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "Salary : ${users[index].salary}",
                                                                        // style:
                                                                        //     GoogleFonts.lato(
                                                                        //         fontSize: 15),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "Salary Type : ${users[index].salary_type}",
                                                                        // style:
                                                                        //     GoogleFonts.lato(
                                                                        //         fontSize: 15),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "Address : ${users[index].address}",
                                                                        // style:
                                                                        //     GoogleFonts.lato(
                                                                        //         fontSize: 15),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "Position : ${users[index].position}",
                                                                        // style:
                                                                        //     GoogleFonts.lato(
                                                                        //         fontSize: 15),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "department Id : ${users[index].departmentId}",
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "shift Id : ${users[index].shiftId}",
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "Rating : ${users[index].rating}",
                                                                        // style:
                                                                        //     GoogleFonts.lato(
                                                                        //         fontSize: 15),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "Hiring Date : ${users[index].hiring_date}",
                                                                        // style:
                                                                        //     GoogleFonts.lato(
                                                                        //         fontSize: 15),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
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
                                                            TextButton(
                                                              child: Text('OK'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
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
                                              child: Row(children: [
                                                Checkbox(
                                                  value: isChecked[index],
                                                  onChanged: (bool? value) {
                                                    context
                                                        .read<
                                                            AddingUsersToDepartmentOrShiftCubit>()
                                                        .Check_User();
                                                    isChecked[index] =
                                                        value ?? false;
                                                    // print(users.length.toString() +
                                                    //     " " +
                                                    //     isChecked.length.toString());
                                                    for (int i = 0;
                                                        i < users.length;
                                                        i++) {
                                                      print(i.toString() +
                                                          " " +
                                                          users[i]
                                                              .id
                                                              .toString() +
                                                          " " +
                                                          isChecked[i]
                                                              .toString());
                                                    }
                                                    // setState(() {
                                                    //   isChecked[index] =
                                                    //       value ?? false;
                                                    // });
                                                    if (isChecked
                                                            .contains(true) ==
                                                        false) {
                                                      _isVisible = false;
                                                    } else {
                                                      _isVisible = true;
                                                    }
                                                  },
                                                ),
                                                ClipOval(
                                                    // decoration: BoxDecoration(
                                                    //     borderRadius:
                                                    //         BorderRadius.circular(100)),
                                                    child: Image.network(
                                                  width: (landscape)
                                                      ? mediaQuery.size.height *
                                                          0.12
                                                      : mediaQuery.size.width *
                                                          0.12,
                                                  height: (landscape)
                                                      ? mediaQuery.size.height *
                                                          0.12
                                                      : mediaQuery.size.width *
                                                          0.12,
                                                  // "data:image/jpeg;base64,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",
                                                  users[index].image,
                                                  fit: BoxFit.cover,
                                                )),
                                                SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.01,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    // "",
                                                    '${users[index].id} ${users[index].firstName} ${users[index].lastName}',
                                                    // 'ahmed',
                                                    // style: TextStyle(color: Colors.black),
                                                    style:
                                                        getTextBlack(context),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        );
                                      });
                                } else if (state is UsersDataError) {
                                  return Center(
                                    child: Text(state.errorMessage),
                                  );
                                } else {
                                  return FutureBuilder<void>(
                                    future: context
                                        .read<UsersDataCubit>()
                                        .getUsersData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return Center(
                                          child: Text(
                                              "An error occurred while loading data."),
                                        );
                                      }
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Visibility(
                  visible: _isVisible,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        width: (landscape)
                            ? mediaQuery.size.height * (49 / 360)
                            : mediaQuery.size.width * (49 / 360),
                        height: (landscape)
                            ? mediaQuery.size.height * (49 / 360)
                            : mediaQuery.size.width * (49 / 360),
                        margin: EdgeInsets.only(
                          left: (landscape)
                              ? mediaQuery.size.height * (288 / 360)
                              : mediaQuery.size.width * (288 / 360),
                          right: (landscape)
                              ? mediaQuery.size.height * (23 / 360)
                              : mediaQuery.size.width * (23 / 360),
                          bottom: (landscape)
                              ? mediaQuery.size.height * (33 / 800)
                              : mediaQuery.size.width * (33 / 800),
                        ),
                        // width: min(MediaQuery.of(context).size.width,
                        //         MediaQuery.of(context).size.height) *
                        //     1 /
                        //     8,
                        // height: min(MediaQuery.of(context).size.width,
                        //         MediaQuery.of(context).size.height) *
                        //     1 /
                        //     8,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(241, 242, 246, 1),
                            borderRadius: BorderRadius.circular(
                              100,
                            )),
                        child: IconButton(
                          onPressed: () async {
                            // id of the checked users
                            checked_users_id.clear();
                            context.read<SearchCubit>().close_search();
                            context.read<SearchCubit>().close_sort();
                            sort_ascending = true;
                            sort = false;
                            editing_employee = true;
                            for (int i = 0; i < isChecked.length; i++) {
                              if (isChecked[i] == true) {
                                print(users[i].id.toString() +
                                    " " +
                                    users[i].firstName);
                                // editted_employee_id = users[i].id - 1;
                                editted_employee_id = users[i].id;
                                putUsersData = {
                                  "id": users[i].id,
                                  "firstName": users[i].firstName,
                                  "lastName": users[i].lastName,
                                  // "age": users[i].age,
                                  "age": users[i].age,
                                  "gender": users[i].gender,
                                  "email": users[i].email,
                                  "phone": users[i].phone,
                                  "image": users[i].image,
                                  "departmentId":
                                      (adding_employee_to_department == true)
                                          ? current_department_or_shift
                                          : users[i].departmentId,
                                  "shiftId": (adding_employee_to_shift == true)
                                      ? current_department_or_shift
                                      : users[i].shiftId,
                                  "salary": users[i].salary,
                                  "salary_type": users[i].salary_type,
                                  "address": users[i].address,
                                  "position": users[i].position,
                                  "hiring_date": users[i].hiring_date,
                                  "rating": users[i].rating,
                                  "companyName": users[i].companyName
                                  // "departmentId": "department1",
                                  // "shiftId": "shift1"
                                };
                                context.read<UsersDataCubit>().getUsersData();
                              }
                            }
                            print(adding_employee_to_shift);
                            // print(current_department_or_shift.toString() +
                            //     '*/*//*/**/**//*/*');
                            adding_employee_to_department = false;
                            adding_employee_to_shift = false;
                            isChecked.clear();
                            for (int i = 0; i < users.length; i++) {
                              isChecked.add(false);
                            }
                            age_values = RangeValues(20, 90);
                            age_labels = RangeLabels('20', '90');
                            salary_values = RangeValues(0, 100000);
                            salary_labels = RangeLabels('0', '100000');
                            Employer_age_start = 20;
                            Employer_age_end = 90;
                            Employer_salary_start = 0;
                            Employer_salary_end = 100000;
                            exiption_condition = "";
                            editing_employee = false;
                            search_users_text_department = "";
                            selectedUsersItem_department = items_Shift[0];
                            context.read<UsersDataCubit>().getUsersData();
                            Navigator.pop(
                              context,
                            );
                            // Navigator.pop(
                            //   context,
                            // );
                          },
                          icon: FittedBox(child: Icon(Icons.check)),
                        )),
                  ),
                )
              ]);
            },
          ),
        ),
      ),
    );
  }
}
