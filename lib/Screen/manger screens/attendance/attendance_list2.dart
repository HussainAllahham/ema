// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project/Cubits/Search/search_cubit.dart';
// import 'package:graduation_project/Cubits/Users%20data/users_data_cubit.dart';
// import 'package:graduation_project/Cubits/attendance%20new%20data/attendance_new_data_cubit.dart';
// import 'package:graduation_project/Screen/attendance/choosing_new_employee_to_attendance.dart';
// import 'package:graduation_project/data/Repository/get_attendance_new_repo.dart';
// import 'package:graduation_project/data/Repository/get_users_Repo.dart';
// import 'package:graduation_project/functions/style.dart';
// import 'package:responsive_framework/responsive_value.dart';
// import 'package:responsive_framework/responsive_wrapper.dart';

// // ignore: must_be_immutable
// class AttendanceList2 extends StatelessWidget {
//   AttendanceList2({super.key});

//   List<String> items = [
//     'id',
//     'firstName',
//     'lastName',
//     'age',
//     'gender',
//     'phone',
//     'email',
//     'salary',
//     'departmentId',
//     'shiftId',
//     'rating'
//   ];

//   List<String> sort_items = [
//     'id',
//     'firstName',
//     'lastName',
//     'age',
//     'phone',
//     'email',
//     'salary',
//     'departmentId',
//     'shiftId',
//     'rating'
//   ];

//   int employee_index = 0;

//   var male_gender_color = Colors.white;
//   var female_gender_color = Colors.white;

//   RangeValues salary_values = RangeValues(0, 100000);
//   RangeLabels salary_labels = RangeLabels('0', '100000');

//   RangeValues age_values = RangeValues(20, 90);
//   RangeLabels age_labels = RangeLabels('20', '90');

//   RangeValues rating_values = RangeValues(0.0, 5.0);
//   RangeLabels rating_labels = RangeLabels('0.0', '5.0');

//   String search_text = "";

//   int j = -1;
//   int i = -1;

//   TextEditingController _textEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final landscape = mediaQuery.orientation == Orientation.landscape;
//     final statusBar = MediaQuery.of(context).viewPadding.top;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           toolbarHeight: (landscape)
//               ? mediaQuery.size.height * (100 / 800)
//               : mediaQuery.size.height * (70 / 800),
//           backgroundColor: const Color.fromRGBO(56, 149, 164, 1),
//           leading: BlocBuilder<SearchCubit, SearchState>(
//             builder: (context, state) {
//               return Builder(builder: (context) {
//                 return (context.read<SearchCubit>().search == false)
//                     ? IconButton(
//                         color: Colors.white,
//                         onPressed: () async {
//                           context.read<SearchCubit>().close_search();
//                           context.read<SearchCubit>().close_sort();
//                           selectedUsersItem = items[0];
//                           search_users_text = "";
//                           _textEditingController.clear();
//                           female_gender_color = Colors.white;
//                           male_gender_color = Colors.white;
//                           Employer_age_start = 20;
//                           Employer_age_end = 90;
//                           Employer_salary_start = 0;
//                           Employer_salary_end = 100000;
//                           Employer_rating_start = 0.0;
//                           Employer_rating_end = 5.0;
//                           sort_ascending = true;
//                           sort = false;
//                           emploees_to_be_attended = "";
//                           context.read<UsersDataCubit>().getUsersData();
//                           j = 0;
//                           Navigator.pop(
//                             context,
//                           );
//                         },
//                         icon: Icon(Icons.arrow_back),
//                       )
//                     : IconButton(
//                         color: Colors.white,
//                         onPressed: () async {
//                           // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//                           context.read<SearchCubit>().emit(Sort());
//                           // sort = context.read<SearchCubit>().sort;
//                           context.read<UsersDataCubit>().getUsersData();
//                           if (sort_ascending == true) {
//                             sort_ascending = false;
//                           } else {
//                             sort_ascending = true;
//                           }
//                           if (j > new_attendance.length) {
//                             j = -1;
//                             i = -1;
//                           }
//                           // print(sort.toString() + '//**');
//                           // print(selectedUsersSortItem.toString() + '//**');
//                           // selectedUsersItem = items[0];
//                           // search_users_text = "";
//                           // _textEditingController.clear();
//                           // female_gender_color = Colors.white;
//                           // male_gender_color = Colors.white;
//                           // Employer_age_start = 20;
//                           // Employer_age_end = 90;
//                           // Employer_salary_start = 0;
//                           // Employer_salary_end = 100000;
//                           // // if (context.read<SearchCubit>().search == false)
//                           //   // Future.delayed(Duration(milliseconds: 1500), () {
//                           //   //   print('Function started!');
//                           //   //   // Add your code here that you want to execute after 2 seconds
//                           //   //   context.read<UsersDataCubit>().getUsersData();
//                           //   // });
//                           //   // context.read<UsersDataCubit>().getUsersData();
//                         },
//                         icon: (sort_ascending == true)
//                             ? Icon(Icons.arrow_downward)
//                             : Icon(Icons.arrow_upward));
//               });
//             },
//           ),
//           actions: [
//             BlocBuilder<SearchCubit, SearchState>(
//               builder: (context, state) {
//                 return Row(
//                   children: [
//                     (context.read<SearchCubit>().sort == true)
//                         ? SizedBox()
//                         :
//                         // search case
//                         IconButton(
//                             color: Colors.white,
//                             onPressed: () async {
//                               context.read<SearchCubit>().search_icon();
//                               context.read<SearchCubit>().close_sort();
//                               selectedUsersItem = items[0];
//                               search_users_text = "";
//                               _textEditingController.clear();
//                               female_gender_color = Colors.white;
//                               male_gender_color = Colors.white;
//                               Employer_age_start = 20;
//                               Employer_age_end = 90;
//                               Employer_salary_start = 0;
//                               Employer_salary_end = 100000;
//                               Employer_rating_start = 0.0;
//                               Employer_rating_end = 5.0;
//                               sort = true;
//                               if (context.read<SearchCubit>().search == false) {
//                                 sort = false;
//                                 selectedUsersSortItem = sort_items[0];
//                                 sort_ascending = true;
//                               }
//                               // Future.delayed(Duration(milliseconds: 1500), () {
//                               //   print('Function started!');
//                               //   // Add your code here that you want to execute after 2 seconds
//                               //   context.read<UsersDataCubit>().getUsersData();
//                               // });
//                               context.read<UsersDataCubit>().getUsersData();
//                             },
//                             icon: (context.read<SearchCubit>().search == false)
//                                 ? Icon(Icons.search)
//                                 : Icon(Icons.close),
//                           ),
//                     (context.read<SearchCubit>().search == false)
//                         ?
//                         // sort case
//                         IconButton(
//                             color: Colors.white,
//                             onPressed: () async {
//                               context.read<SearchCubit>().sort_icon();
//                               sort = context.read<SearchCubit>().sort;
//                               context.read<UsersDataCubit>().getUsersData();
//                               sort_ascending = true;
//                               // selectedUsersItem = items[0];
//                               selectedUsersSortItem = sort_items[0];
//                               // search_users_text = "";
//                               // _textEditingController.clear();
//                               // female_gender_color = Colors.white;
//                               // male_gender_color = Colors.white;
//                               // Employer_age_start = 20;
//                               // Employer_age_end = 90;
//                               // Employer_salary_start = 0;
//                               // Employer_salary_end = 100000;
//                               // // if (context.read<SearchCubit>().search == false)
//                               //   // Future.delayed(Duration(milliseconds: 1500), () {
//                               //   //   print('Function started!');
//                               //   //   // Add your code here that you want to execute after 2 seconds
//                               //   //   context.read<UsersDataCubit>().getUsersData();
//                               //   // });
//                               //   // context.read<UsersDataCubit>().getUsersData();
//                             },
//                             icon: (sort == false)
//                                 ? Icon(Icons.sort)
//                                 : Icon(Icons.close))
//                         : SizedBox(),
//                   ],
//                 );
//               },
//             ),
//           ],
//           automaticallyImplyLeading: false,
//           title: BlocBuilder<SearchCubit, SearchState>(
//             builder: (context, state) {
//               return (!context.read<SearchCubit>().search &&
//                       !context.read<SearchCubit>().sort)
//                   ?
//                   // default case
//                   FittedBox(
//                       child: Text(
//                       "Employees List",
//                       style: (landscape)
//                           ? getTextWhiteHeader(context)
//                           : getTextWhite(context),
//                     ))
//                   : (context.read<SearchCubit>().search == true)
//                       ?
//                       // search case
//                       Row(
//                           children: [
//                             // IconButton(
//                             //     color: Colors.white,
//                             //     onPressed: () async {
//                             //       // ignore: invalid_use_of_protected_member
//                             //       context.read<SearchCubit>().emit(Sort());
//                             //       sort = context.read<SearchCubit>().sort;
//                             //       context.read<UsersDataCubit>().getUsersData();
//                             //       if (sort_ascending == true) {
//                             //         sort_ascending = false;
//                             //       } else {
//                             //         sort_ascending = true;
//                             //       }
//                             //       // selectedUsersItem = items[0];
//                             //       // search_users_text = "";
//                             //       // _textEditingController.clear();
//                             //       // female_gender_color = Colors.white;
//                             //       // male_gender_color = Colors.white;
//                             //       // Employer_age_start = 20;
//                             //       // Employer_age_end = 90;
//                             //       // Employer_salary_start = 0;
//                             //       // Employer_salary_end = 100000;
//                             //       // // if (context.read<SearchCubit>().search == false)
//                             //       //   // Future.delayed(Duration(milliseconds: 1500), () {
//                             //       //   //   print('Function started!');
//                             //       //   //   // Add your code here that you want to execute after 2 seconds
//                             //       //   //   context.read<UsersDataCubit>().getUsersData();
//                             //       //   // });
//                             //       //   // context.read<UsersDataCubit>().getUsersData();
//                             //     },
//                             //     icon: (sort_ascending == true)
//                             //         ? Icon(Icons.arrow_downward)
//                             //         : Icon(Icons.arrow_upward)),
//                             (selectedUsersItem == 'salary')
//                                 ? Expanded(
//                                     child: Container(
//                                       // height: mediaQuery.size.height * (50 / 800),
//                                       child: Text(
//                                         "${Employer_salary_start} - ${Employer_salary_end}",
//                                         style: getTextWhite(context),
//                                       ),
//                                       //     RangeSlider(
//                                       //   min: 0,
//                                       //   max: 100000,
//                                       //   divisions: (100000),
//                                       //   values: salary_values,
//                                       //   labels: salary_labels,
//                                       //   onChanged: (value) {
//                                       //     Employer_salary_start =
//                                       //         (value.start.toInt() - 1).toString();
//                                       //     Employer_salary_end =
//                                       //         (value.end.toInt() + 1).toString();
//                                       //     search_users_text = "salary";
//                                       //     // print("salary start:" + Employer_age_start);
//                                       //     // print("salary end:" + Employer_age_end);
//                                       //     // print("selectedUsersItem: " +
//                                       //     // selectedUsersItem.toString());
//                                       //     salary_values = value;
//                                       //     salary_labels = RangeLabels(
//                                       //         '${value.start.toInt().toString()}\$',
//                                       //         '${value.end.toInt().toString()}\$');
//                                       //     context
//                                       //         .read<SearchCubit>()
//                                       //         // ignore: invalid_use_of_protected_member
//                                       //         .emit(SearchInitial());
//                                       //     context
//                                       //         .read<UsersDataCubit>()
//                                       //         .getUsersData();
//                                       //     // setState(() {});
//                                       //   },
//                                       // )
//                                     ),
//                                   )
//                                 : (selectedUsersItem == 'age')
//                                     ? Expanded(
//                                         child: Container(
//                                             // width: 400,
//                                             // height: 100,
//                                             child: Center(
//                                           child: Text(
//                                             "${(Employer_age_start).toString()} - ${(Employer_age_end)}",
//                                             style: getTextWhite(context),
//                                           ),
//                                         )
//                                             //         RangeSlider(
//                                             //   min: 20,
//                                             //   max: 90,
//                                             //   divisions: (90),
//                                             //   values: age_values,
//                                             //   labels: age_labels,
//                                             //   onChanged: (value) {
//                                             //     Employer_age_start =
//                                             //         value.start.toInt();
//                                             //     Employer_age_end = value.end.toInt();
//                                             //     search_users_text = 'age';
//                                             //     age_values = value;
//                                             //     age_labels = RangeLabels(
//                                             //         value.start.toInt().toString(),
//                                             //         value.end.toInt().toString());
//                                             //     context
//                                             //         .read<SearchCubit>()
//                                             //         // ignore: invalid_use_of_protected_member
//                                             //         .emit(SearchInitial());
//                                             //     context
//                                             //         .read<UsersDataCubit>()
//                                             //         .getUsersData();
//                                             //     // setState(() {});
//                                             //   },
//                                             // )
//                                             ),
//                                       )
//                                     : (selectedUsersItem == 'gender')
//                                         ? Expanded(
//                                             child: Container(
//                                                 child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 InkWell(
//                                                   child: Text("Male",
//                                                       style: TextStyle(
//                                                           fontSize:
//                                                               ResponsiveValue(
//                                                             context,
//                                                             valueWhen: [
//                                                               Condition
//                                                                   .smallerThan(
//                                                                       name:
//                                                                           MOBILE,
//                                                                       value:
//                                                                           14.0),
//                                                               Condition
//                                                                   .largerThan(
//                                                                       name:
//                                                                           MOBILE,
//                                                                       value:
//                                                                           16.0),
//                                                               Condition
//                                                                   .smallerThan(
//                                                                       name:
//                                                                           TABLET,
//                                                                       value:
//                                                                           18.0),
//                                                               Condition
//                                                                   .largerThan(
//                                                                       name:
//                                                                           TABLET,
//                                                                       value:
//                                                                           20.0),
//                                                               Condition
//                                                                   .largerThan(
//                                                                       name:
//                                                                           DESKTOP,
//                                                                       value:
//                                                                           24.0),
//                                                               Condition
//                                                                   .largerThan(
//                                                                       name:
//                                                                           'XL',
//                                                                       value:
//                                                                           28.0),
//                                                             ],
//                                                             defaultValue: 12.0,
//                                                           ).value,
//                                                           color:
//                                                               male_gender_color)),
//                                                   onTap: () {
//                                                     search_users_text = "male";
//                                                     context
//                                                         .read<UsersDataCubit>()
//                                                         .getUsersData();
//                                                     context
//                                                         .read<UsersDataCubit>()
//                                                         .getUsersData();
//                                                     male_gender_color =
//                                                         Colors.black;
//                                                     female_gender_color =
//                                                         Colors.white;
//                                                     context
//                                                         .read<SearchCubit>()
//                                                         .Gender_color();
//                                                   },
//                                                 ),
//                                                 InkWell(
//                                                   child: Text("Female",
//                                                       style: TextStyle(
//                                                           fontSize:
//                                                               ResponsiveValue(
//                                                             context,
//                                                             valueWhen: [
//                                                               Condition
//                                                                   .smallerThan(
//                                                                       name:
//                                                                           MOBILE,
//                                                                       value:
//                                                                           14.0),
//                                                               Condition
//                                                                   .largerThan(
//                                                                       name:
//                                                                           MOBILE,
//                                                                       value:
//                                                                           16.0),
//                                                               Condition
//                                                                   .smallerThan(
//                                                                       name:
//                                                                           TABLET,
//                                                                       value:
//                                                                           18.0),
//                                                               Condition
//                                                                   .largerThan(
//                                                                       name:
//                                                                           TABLET,
//                                                                       value:
//                                                                           20.0),
//                                                               Condition
//                                                                   .largerThan(
//                                                                       name:
//                                                                           DESKTOP,
//                                                                       value:
//                                                                           24.0),
//                                                               Condition
//                                                                   .largerThan(
//                                                                       name:
//                                                                           'XL',
//                                                                       value:
//                                                                           28.0),
//                                                             ],
//                                                             defaultValue: 12.0,
//                                                           ).value,
//                                                           color:
//                                                               female_gender_color)),
//                                                   onTap: () {
//                                                     search_users_text =
//                                                         "female";
//                                                     context
//                                                         .read<UsersDataCubit>()
//                                                         .getUsersData();
//                                                     female_gender_color =
//                                                         Colors.black;
//                                                     male_gender_color =
//                                                         Colors.white;
//                                                     context
//                                                         .read<SearchCubit>()
//                                                         .Gender_color();
//                                                   },
//                                                 ),
//                                               ],
//                                             )),
//                                           )
//                                         : (selectedUsersItem == 'rating')
//                                             ? Expanded(
//                                                 child: Container(
//                                                     // width: 400,
//                                                     // height: 100,
//                                                     child: Center(
//                                                 child: Text(
//                                                   "${(Employer_rating_start).toString().substring(0, 3)} - ${(Employer_rating_end).toString().substring(0, 3)}",
//                                                   style: getTextWhite(context),
//                                                 ),
//                                               )))
//                                             : Expanded(
//                                                 child: TextFormField(
//                                                   controller:
//                                                       _textEditingController,
//                                                   style: getTextWhite(context),
//                                                   onChanged: (text) {
//                                                     search_users_text = "";
//                                                     search_users_text = text;
//                                                     context
//                                                         .read<UsersDataCubit>()
//                                                         .getUsersData();
//                                                     // print(search_text);
//                                                   },
//                                                   // validator: (value) {
//                                                   //   if (value == "") {
//                                                   //     return 'Invalid Company Name';
//                                                   //   }
//                                                   //   return null;
//                                                   // },
//                                                   textAlign: TextAlign.left,
//                                                   decoration: InputDecoration(
//                                                     enabledBorder:
//                                                         UnderlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color: Colors
//                                                             .white, // Change to your desired color
//                                                       ),
//                                                     ),
//                                                     errorStyle: TextStyle(
//                                                         color: Colors.red[400]),
//                                                     contentPadding:
//                                                         const EdgeInsets.all(
//                                                             15),
//                                                     // prefixIcon: const Icon(Icons.business,
//                                                     //     color: Color.fromARGB(255, 145, 142, 142), size: 30),
//                                                     filled: true,
//                                                     fillColor:
//                                                         Colors.transparent,
//                                                     border: null,
//                                                     hintText: 'Search',
//                                                     hintStyle: (landscape)
//                                                         ? getTextWhite(context)
//                                                         : getTextWhite(context),

//                                                     // const TextStyle(
//                                                     //   fontSize: 20,
//                                                     // )
//                                                   ),
//                                                 ),
//                                               ),
//                             DropdownButton<String>(
//                               dropdownColor:
//                                   const Color.fromRGBO(56, 149, 164, 1),
//                               iconEnabledColor: Colors.white,
//                               iconDisabledColor: Colors.white,
//                               value: selectedUsersItem,
//                               // style: TextStyle(color: Colors.white),
//                               style: getTextWhite(context),
//                               items: items
//                                   .map((item) => DropdownMenuItem<String>(
//                                       value: item, child: Text(item)))
//                                   .toList(),
//                               onChanged: (item) {
//                                 selectedUsersItem = item;
//                                 selectedUsersSortItem =
//                                     (selectedUsersItem == 'gender')
//                                         ? 'id'
//                                         : selectedUsersItem;

//                                 search_users_text = "";
//                                 _textEditingController.clear();
//                                 female_gender_color = Colors.white;
//                                 male_gender_color = Colors.white;
//                                 age_values = RangeValues(20, 90);
//                                 age_labels = RangeLabels('20', '90');
//                                 salary_values = RangeValues(0, 100000);
//                                 salary_labels = RangeLabels('0', '100000');
//                                 rating_values = RangeValues(0.0, 5.0);
//                                 rating_labels = RangeLabels('0.0', '5.0');
//                                 Employer_age_start = 20;
//                                 Employer_age_end = 90;
//                                 Employer_salary_start = 0;
//                                 Employer_salary_end = 100000;
//                                 Employer_rating_start = 0.0;
//                                 Employer_rating_end = 5.0;
//                                 // ignore: invalid_use_of_protected_member
//                                 context
//                                     .read<SearchCubit>()
//                                     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//                                     .emit(SearchInitial());
//                                 context.read<UsersDataCubit>().getUsersData();
//                               },
//                             )
//                           ],
//                         )
//                       :
//                       // sort case
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             IconButton(
//                                 color: Colors.white,
//                                 onPressed: () async {
//                                   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//                                   context.read<SearchCubit>().emit(Sort());
//                                   sort = context.read<SearchCubit>().sort;
//                                   context.read<UsersDataCubit>().getUsersData();
//                                   if (sort_ascending == true) {
//                                     sort_ascending = false;
//                                   } else {
//                                     sort_ascending = true;
//                                   }
//                                   // print('sort :' + sort.toString() + '//**');
//                                   // selectedUsersItem = items[0];
//                                   // search_users_text = "";
//                                   // _textEditingController.clear();
//                                   // female_gender_color = Colors.white;
//                                   // male_gender_color = Colors.white;
//                                   // Employer_age_start = 20;
//                                   // Employer_age_end = 90;
//                                   // Employer_salary_start = 0;
//                                   // Employer_salary_end = 100000;
//                                   // // if (context.read<SearchCubit>().search == false)
//                                   //   // Future.delayed(Duration(milliseconds: 1500), () {
//                                   //   //   print('Function started!');
//                                   //   //   // Add your code here that you want to execute after 2 seconds
//                                   //   //   context.read<UsersDataCubit>().getUsersData();
//                                   //   // });
//                                   //   // context.read<UsersDataCubit>().getUsersData();
//                                 },
//                                 icon: (sort_ascending == true)
//                                     ? Icon(Icons.arrow_downward)
//                                     : Icon(Icons.arrow_upward)),
//                             DropdownButton<String>(
//                               dropdownColor:
//                                   const Color.fromRGBO(56, 149, 164, 1),
//                               iconEnabledColor: Colors.white,
//                               iconDisabledColor: Colors.white,
//                               value: selectedUsersSortItem,
//                               style: getTextWhite(context),
//                               items: sort_items
//                                   .map((item) => DropdownMenuItem<String>(
//                                       value: item, child: Text(item)))
//                                   .toList(),
//                               onChanged: (item) {
//                                 selectedUsersSortItem = item;
//                                 sort_ascending = true;
//                                 // ignore: invalid_use_of_protected_member
//                                 context
//                                     .read<SearchCubit>()
//                                     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//                                     .emit(SearchInitial());
//                                 context.read<UsersDataCubit>().getUsersData();
//                               },
//                             )
//                           ],
//                         );
//             },
//           ),
//           centerTitle: true,
//         ),
//         body: Stack(
//           children: [
//             BlocBuilder<SearchCubit, SearchState>(
//               builder: (context, state) {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       // ElevatedButton(
//                       //     onPressed: () {
//                       //       context
//                       //           .read<AttendanceNewDataCubit>()
//                       //           .getAttendanceNewData();
//                       //     },
//                       //     child: Text('data')),
//                       Container(
//                         height: (selectedUsersItem == 'age' ||
//                                 selectedUsersItem == 'salary')
//                             ? (landscape)
//                                 ? (mediaQuery.size.height -
//                                     (mediaQuery.size.height * (100 / 800)) -
//                                     (statusBar) -
//                                     mediaQuery.size.height * 0.08)
//                                 : (mediaQuery.size.height -
//                                     (mediaQuery.size.height * (70 / 800)) -
//                                     (statusBar) -
//                                     mediaQuery.size.height * 0.05)
//                             : (landscape)
//                                 ? (mediaQuery.size.height -
//                                     (mediaQuery.size.height * (100 / 800)) -
//                                     (statusBar))
//                                 : (mediaQuery.size.height -
//                                     (mediaQuery.size.height * (70 / 800)) -
//                                     (statusBar)),
//                         child: BlocBuilder<AttendanceNewDataCubit,
//                             AttendanceNewDataState>(
//                           builder: (context, state) {
//                             if (state is AttendanceNewDataSuccess) {
//                               // return BlocBuilder<UsersDataCubit,
//                               //     UsersDataState>(
//                               //   builder: (context, state) {
//                               return ListView.builder(
//                                   // itemCount: new_attendance.length,
//                                   itemCount: new_attendance.length,
//                                   // itemCount: state.response.users.length,
//                                   itemBuilder: (context, index) {
//                                     // for (int i = j; i < users.length; i++) {
//                                     //   if (new_attendance.any((element) =>
//                                     //       element.employee_id == users[i].id)) {
//                                     //     print(j.toString() +
//                                     //         ' ' +
//                                     //         users[j].firstName +
//                                     //         '///**');
//                                     //     j = i + 1;
//                                     //     // print(j.toString() + '///**');
//                                     //   }
//                                     // }
//                                     if (j > new_attendance.length) {
//                                       j = -1;
//                                       i = -1;
//                                     }
//                                     j = i + 1;
//                                     for (; i < users.length;) {
//                                       i++;
//                                       // print('i: ${i} j: ${j} ///**');
//                                       // print(
//                                       //     'i: ${i} ${users[i].firstName} ///**');
//                                       // print('new attendance contains: ' +
//                                       //     users[i].firstName +
//                                       //     new_attendance
//                                       //         .any((element) =>
//                                       //             element.employee_id ==
//                                       //             users[i].id)
//                                       //         .toString() +
//                                       //     '///**');
//                                       if (new_attendance.any((element) =>
//                                               element.employee_id ==
//                                               users[i].id) ==
//                                           true) {
//                                         print('i: ${i} j: ${j} ///**');
//                                         return Container(
//                                           decoration: BoxDecoration(
//                                               // color: Colors.blue,
//                                               borderRadius:
//                                                   BorderRadius.circular(5)),
//                                           margin: (landscape)
//                                               ? EdgeInsets.all(5)
//                                               : EdgeInsets.all(10),
//                                           width: (landscape)
//                                               ? MediaQuery.of(context)
//                                                       .size
//                                                       .height *
//                                                   0.9
//                                               : MediaQuery.of(context)
//                                                       .size
//                                                       .width *
//                                                   0.9,
//                                           height: (landscape)
//                                               ? MediaQuery.of(context)
//                                                       .size
//                                                       .width *
//                                                   1 /
//                                                   10
//                                               : MediaQuery.of(context)
//                                                       .size
//                                                       .height *
//                                                   1 /
//                                                   10,
//                                           child: TextButton(
//                                             style: ButtonStyle(
//                                               shape: MaterialStateProperty.all<
//                                                   RoundedRectangleBorder>(
//                                                 RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             0)),
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               // print(users
//                                               //         .indexWhere((employee) =>
//                                               //             employee.id ==
//                                               //             new_attendance[index].id)
//                                               //         .toString() +
//                                               //     '///**');
//                                               // employee_index = users.indexWhere(
//                                               //     (employee) =>
//                                               //         employee.id ==
//                                               //         users[index].id);
//                                               showDialog(
//                                                   context: context,
//                                                   builder:
//                                                       (BuildContext context) {
//                                                     return AlertDialog(
//                                                       title: const Text(
//                                                         'Employee\'s info',
//                                                         // style: GoogleFonts.lato(),
//                                                       ),
//                                                       content:
//                                                           SingleChildScrollView(
//                                                         child: BlocBuilder<
//                                                             UsersDataCubit,
//                                                             UsersDataState>(
//                                                           builder:
//                                                               (context, state) {
//                                                             if (state
//                                                                 is UsersDataError) {
//                                                               return const Center(
//                                                                   child:
//                                                                       CircularProgressIndicator());
//                                                             } else if (state
//                                                                 is UsersDataSuccess) {
//                                                               return Container(
//                                                                 width: mediaQuery
//                                                                         .size
//                                                                         .width /
//                                                                     1.8,
//                                                                 height: mediaQuery
//                                                                         .size
//                                                                         .height /
//                                                                     2.5,
//                                                                 child:
//                                                                     SingleChildScrollView(
//                                                                   child: Column(
//                                                                     children: [
//                                                                       // Container(
//                                                                       //   child: Image.network(users[users.indexWhere((employee) =>
//                                                                       //           employee.id ==
//                                                                       //           new_attendance[index].employee_id)]
//                                                                       //       .image),
//                                                                       //   width: mediaQuery.size.width /
//                                                                       //       1.8,
//                                                                       //   height: mediaQuery.size.height /
//                                                                       //       4.5,
//                                                                       // ),
//                                                                       // SizedBox(
//                                                                       //   height:
//                                                                       //       10,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Id : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].id}",
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Name : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].firstName} ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].lastName}",
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Age : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].age}",
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Gender : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].gender}",
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Email : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].email}",
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Phone : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].phone}",
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Salary : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].salary}",
//                                                                       //   // style:
//                                                                       //   //     GoogleFonts.lato(
//                                                                       //   //         fontSize: 15),
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Salary Type : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].salary_type}",
//                                                                       //   // style:
//                                                                       //   //     GoogleFonts.lato(
//                                                                       //   //         fontSize: 15),
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Address : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].address}",
//                                                                       //   // style:
//                                                                       //   //     GoogleFonts.lato(
//                                                                       //   //         fontSize: 15),
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Position : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].position}",
//                                                                       //   // style:
//                                                                       //   //     GoogleFonts.lato(
//                                                                       //   //         fontSize: 15),
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "department Id : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].departmentId}",
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "shift Id : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].shiftId}",
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Rating : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].rating}",
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "Hiring Date : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].hiring_date}",
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "check-in : ${new_attendance[index].time_in}",
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                       // Text(
//                                                                       //   "check-out : ${new_attendance[index].time_out}",
//                                                                       // ),
//                                                                       // const SizedBox(
//                                                                       //   height:
//                                                                       //       5,
//                                                                       // ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             } else {
//                                                               return const Center(
//                                                                   child: Text(
//                                                                       "Something wrong happened"));
//                                                             }
//                                                           },
//                                                         ),
//                                                       ),
//                                                       actions: <Widget>[
//                                                         Row(
//                                                           children: [
//                                                             TextButton(
//                                                               child: Text('OK'),
//                                                               onPressed: () {
//                                                                 Navigator.of(
//                                                                         context)
//                                                                     .pop(); // Close the dialog
//                                                               },
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     );
//                                                   });
//                                             },
//                                             child: Container(
//                                               alignment: Alignment.centerLeft,
//                                               child: Row(children: [
//                                                 // Text('new_attendance.length: ' +
//                                                 //     new_attendance.length
//                                                 //         .toString() +
//                                                 //     ' ' +
//                                                 //     'users.length: ' +
//                                                 //     users.length.toString()),
//                                                 // Text('${i}'),
//                                                 Text(
//                                                   '${users[i].id} ${users[i].firstName} ${users[i].lastName} ',
//                                                   // j.toString(),
//                                                   // : '${users[attendance[int.parse(day_of_attending)].employees[index] - 1].id} ${users[attendance[int.parse(day_of_attending)].employees[index] - 1].firstName} ${users[attendance[int.parse(day_of_attending)].employees[index] - 1].lastName}',
//                                                   // style: TextStyle(color: Colors.black),
//                                                   style: getTextBlack(context),
//                                                 ),
//                                                 // Text(
//                                                 //   '${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].id} ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].firstName} ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].lastName}',
//                                                 //   // : '${users[attendance[int.parse(day_of_attending)].employees[index] - 1].id} ${users[attendance[int.parse(day_of_attending)].employees[index] - 1].firstName} ${users[attendance[int.parse(day_of_attending)].employees[index] - 1].lastName}',
//                                                 //   // style: TextStyle(color: Colors.black),
//                                                 //   style: getTextBlack(context),
//                                                 // ),
//                                                 Spacer(),
//                                                 // Text(
//                                                 //   'working hours:${int.parse(new_attendance[index].time_out) - int.parse(new_attendance[index].time_in)}',
//                                                 //   // 'ahmed',
//                                                 //   // style: TextStyle(color: Colors.black),
//                                                 //   style: getTextBlack(context),
//                                                 // ),
//                                               ]),
//                                             ),
//                                           ),

//                                           // child:
//                                           //     Text(new_attendance[index].id.toString()),
//                                         );
//                                       }
//                                     }
//                                   });
//                             } else if (state is AttendanceNewDataError) {
//                               return Center(
//                                 child: Text(state.errorMessage),
//                               );
//                             } else {
//                               return FutureBuilder<void>(
//                                 future: context
//                                     .read<AttendanceNewDataCubit>()
//                                     .getAttendanceNewData(),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                                   } else {
//                                     return Center(
//                                       child: Text(
//                                           "An error occurred while loading data."),
//                                     );
//                                   }
//                                 },
//                               );
//                             }
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               },
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Container(
//                   width: (landscape)
//                       ? mediaQuery.size.height * (49 / 360)
//                       : mediaQuery.size.width * (49 / 360),
//                   height: (landscape)
//                       ? mediaQuery.size.height * (49 / 360)
//                       : mediaQuery.size.width * (49 / 360),
//                   margin: EdgeInsets.only(
//                     left: (landscape)
//                         ? mediaQuery.size.height * (288 / 360)
//                         : mediaQuery.size.width * (288 / 360),
//                     right: (landscape)
//                         ? mediaQuery.size.height * (23 / 360)
//                         : mediaQuery.size.width * (23 / 360),
//                     bottom: (landscape)
//                         ? mediaQuery.size.height * (33 / 800)
//                         : mediaQuery.size.width * (33 / 800),
//                   ),
//                   decoration: BoxDecoration(
//                       color: Color.fromRGBO(241, 242, 246, 1),
//                       borderRadius: BorderRadius.circular(100)),
//                   child: IconButton(
//                     onPressed: () async {
//                       context.read<SearchCubit>().close_search();
//                       selectedUsersItem = items[0];
//                       emploees_to_be_attended = "";
//                       adding_employee_to_attendance = true;
//                       for (int i = 0; i < new_attendance.length; i++) {
//                         emploees_to_be_attended += "id=neq." +
//                             new_attendance[i].employee_id.toString() +
//                             "&";
//                       }
//                       // search_employee.clear();
//                       // search_employee_check_in.clear();
//                       // search_employee_check_out.clear();
//                       search_text = "";
//                       _textEditingController.clear();
//                       context.read<UsersDataCubit>().getUsersData();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute<void>(
//                           builder: (BuildContext context) =>
//                               // Test()
//                               AddingNewAttendance(),
//                           // EmployeeList()
//                         ),
//                       );
//                     },
//                     icon: FittedBox(child: Icon(Icons.add)),
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Cubits/Search/search_cubit.dart';
import 'package:graduation_project/Cubits/Users%20data/users_data_cubit.dart';
import 'package:graduation_project/Cubits/attendance%20new%20data/attendance_new_data_cubit.dart';
import 'package:graduation_project/Screen/manger%20screens/attendance/choosing_new_employee_to_attendance.dart';
import 'package:graduation_project/data/Repository/get_attendance_new_repo.dart';
import 'package:graduation_project/data/Repository/get_users_Repo.dart';
import 'package:graduation_project/functions/style.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

// ignore: must_be_immutable
class AttendanceList2 extends StatelessWidget {
  AttendanceList2({super.key});

  List<String> items = [
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

  var male_gender_color = Colors.white;
  var female_gender_color = Colors.white;

  RangeValues salary_values = RangeValues(0, 100000);
  RangeLabels salary_labels = RangeLabels('0', '100000');

  RangeValues age_values = RangeValues(20, 90);
  RangeLabels age_labels = RangeLabels('20', '90');

  RangeValues rating_values = RangeValues(0.0, 5.0);
  RangeLabels rating_labels = RangeLabels('0.0', '5.0');

  String search_text = "";

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    final statusBar = MediaQuery.of(context).viewPadding.top;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: (landscape)
              ? mediaQuery.size.height * (100 / 800)
              : mediaQuery.size.height * (70 / 800),
          backgroundColor:
              // const Color.fromRGBO(56, 149, 164, 1),
              const Color.fromRGBO(50, 50, 160, 1),
          leading: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return Builder(builder: (context) {
                return (context.read<SearchCubit>().search == false)
                    ? IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          context.read<SearchCubit>().close_search();
                          context.read<SearchCubit>().close_sort();
                          selectedUsersItem = items[0];
                          search_users_text = "";
                          _textEditingController.clear();
                          female_gender_color = Colors.white;
                          male_gender_color = Colors.white;
                          Employer_age_start = 20;
                          Employer_age_end = 90;
                          Employer_salary_start = 0;
                          Employer_salary_end = 100000;
                          Employer_rating_start = 0.0;
                          Employer_rating_end = 5.0;
                          sort_ascending = true;
                          sort = false;
                          emploees_to_be_attended = "";
                          context.read<UsersDataCubit>().getUsersData();

                          Navigator.pop(
                            context,
                          );
                        },
                        icon: Icon(Icons.arrow_back),
                      )
                    : IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                          context.read<SearchCubit>().emit(Sort());
                          // sort = context.read<SearchCubit>().sort;
                          context.read<UsersDataCubit>().getUsersData();
                          if (sort_ascending == true) {
                            sort_ascending = false;
                          } else {
                            sort_ascending = true;
                          }

                          // print(sort.toString() + '//**');
                          // print(selectedUsersSortItem.toString() + '//**');
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
                            onPressed: () async {
                              context.read<SearchCubit>().search_icon();
                              context.read<SearchCubit>().close_sort();
                              selectedUsersItem = items[0];
                              search_users_text = "";
                              _textEditingController.clear();
                              female_gender_color = Colors.white;
                              male_gender_color = Colors.white;
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
                              // Future.delayed(Duration(milliseconds: 1500), () {
                              //   print('Function started!');
                              //   // Add your code here that you want to execute after 2 seconds
                              //   context.read<UsersDataCubit>().getUsersData();
                              // });
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
                              // selectedUsersItem = items[0];
                              selectedUsersSortItem = sort_items[0];
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
                      'Employees attended on day ${int.parse(day_of_new_attending) + 1}',
                      style: (landscape)
                          ? getTextWhiteHeader(context)
                          : getTextWhite(context),
                    ))
                  : (context.read<SearchCubit>().search == true)
                      ?
                      // search case
                      Row(
                          children: [
                            // IconButton(
                            //     color: Colors.white,
                            //     onPressed: () async {
                            //       // ignore: invalid_use_of_protected_member
                            //       context.read<SearchCubit>().emit(Sort());
                            //       sort = context.read<SearchCubit>().sort;
                            //       context.read<UsersDataCubit>().getUsersData();
                            //       if (sort_ascending == true) {
                            //         sort_ascending = false;
                            //       } else {
                            //         sort_ascending = true;
                            //       }
                            //       // selectedUsersItem = items[0];
                            //       // search_users_text = "";
                            //       // _textEditingController.clear();
                            //       // female_gender_color = Colors.white;
                            //       // male_gender_color = Colors.white;
                            //       // Employer_age_start = 20;
                            //       // Employer_age_end = 90;
                            //       // Employer_salary_start = 0;
                            //       // Employer_salary_end = 100000;
                            //       // // if (context.read<SearchCubit>().search == false)
                            //       //   // Future.delayed(Duration(milliseconds: 1500), () {
                            //       //   //   print('Function started!');
                            //       //   //   // Add your code here that you want to execute after 2 seconds
                            //       //   //   context.read<UsersDataCubit>().getUsersData();
                            //       //   // });
                            //       //   // context.read<UsersDataCubit>().getUsersData();
                            //     },
                            //     icon: (sort_ascending == true)
                            //         ? Icon(Icons.arrow_downward)
                            //         : Icon(Icons.arrow_upward)),
                            (selectedUsersItem == 'salary')
                                ? Expanded(
                                    child: Container(
                                      // height: mediaQuery.size.height * (50 / 800),
                                      child: Text(
                                        "${Employer_salary_start} - ${Employer_salary_end}",
                                        style: getTextWhite(context),
                                      ),
                                      //     RangeSlider(
                                      //   min: 0,
                                      //   max: 100000,
                                      //   divisions: (100000),
                                      //   values: salary_values,
                                      //   labels: salary_labels,
                                      //   onChanged: (value) {
                                      //     Employer_salary_start =
                                      //         (value.start.toInt() - 1).toString();
                                      //     Employer_salary_end =
                                      //         (value.end.toInt() + 1).toString();
                                      //     search_users_text = "salary";
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
                                : (selectedUsersItem == 'age')
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
                                            //         RangeSlider(
                                            //   min: 20,
                                            //   max: 90,
                                            //   divisions: (90),
                                            //   values: age_values,
                                            //   labels: age_labels,
                                            //   onChanged: (value) {
                                            //     Employer_age_start =
                                            //         value.start.toInt();
                                            //     Employer_age_end = value.end.toInt();
                                            //     search_users_text = 'age';
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
                                    : (selectedUsersItem == 'gender')
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
                                                    search_users_text = "male";
                                                    context
                                                        .read<UsersDataCubit>()
                                                        .getUsersData();
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
                                                    search_users_text =
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
                                        : (selectedUsersItem == 'rating')
                                            ? Expanded(
                                                child: Container(
                                                    // width: 400,
                                                    // height: 100,
                                                    child: Center(
                                                child: Text(
                                                  "${(Employer_rating_start).toString().substring(0, 3)} - ${(Employer_rating_end).toString().substring(0, 3)}",
                                                  style: getTextWhite(context),
                                                ),
                                              )))
                                            : Expanded(
                                                child: TextFormField(
                                                  controller:
                                                      _textEditingController,
                                                  style: getTextWhite(context),
                                                  onChanged: (text) {
                                                    search_users_text = "";
                                                    search_users_text = text;
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
                              value: selectedUsersItem,
                              // style: TextStyle(color: Colors.white),
                              style: getTextWhite(context),
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item, child: Text(item)))
                                  .toList(),
                              onChanged: (item) {
                                selectedUsersItem = item;
                                selectedUsersSortItem =
                                    (selectedUsersItem == 'gender')
                                        ? 'id'
                                        : selectedUsersItem;

                                search_users_text = "";
                                _textEditingController.clear();
                                female_gender_color = Colors.white;
                                male_gender_color = Colors.white;
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
                                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
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
                                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                  context.read<SearchCubit>().emit(Sort());
                                  sort = context.read<SearchCubit>().sort;
                                  context.read<UsersDataCubit>().getUsersData();
                                  if (sort_ascending == true) {
                                    sort_ascending = false;
                                  } else {
                                    sort_ascending = true;
                                  }
                                  // print('sort :' + sort.toString() + '//**');
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
                              items: sort_items
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item, child: Text(item)))
                                  .toList(),
                              onChanged: (item) {
                                selectedUsersSortItem = item;
                                sort_ascending = true;
                                // ignore: invalid_use_of_protected_member
                                context
                                    .read<SearchCubit>()
                                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
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
        body: Stack(
          children: [
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // ElevatedButton(
                      //     onPressed: () {
                      //       context
                      //           .read<AttendanceNewDataCubit>()
                      //           .getAttendanceNewData();
                      //     },
                      //     child: Text('data')),
                      Container(
                        height: (selectedUsersItem == 'age' ||
                                selectedUsersItem == 'salary')
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
                        child: BlocBuilder<AttendanceNewDataCubit,
                            AttendanceNewDataState>(
                          builder: (context, state) {
                            if (state is AttendanceNewDataSuccess) {
                              // return BlocBuilder<UsersDataCubit,
                              //     UsersDataState>(
                              //   builder: (context, state) {
                              return ListView.builder(
                                  // itemCount: new_attendance.length,
                                  itemCount: new_attendance.length,
                                  // itemCount: state.response.users.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          // color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      margin: (landscape)
                                          ? EdgeInsets.all(5)
                                          : EdgeInsets.all(10),
                                      width: (landscape)
                                          ? MediaQuery.of(context).size.height *
                                              0.9
                                          : MediaQuery.of(context).size.width *
                                              0.9,
                                      height: (landscape)
                                          ? MediaQuery.of(context).size.width *
                                              1 /
                                              10
                                          : MediaQuery.of(context).size.height *
                                              1 /
                                              10,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0)),
                                          ),
                                        ),
                                        onPressed: () {
                                          // print(users
                                          //         .indexWhere((employee) =>
                                          //             employee.id ==
                                          //             new_attendance[index].id)
                                          //         .toString() +
                                          //     '///**');
                                          // employee_index = users.indexWhere(
                                          //     (employee) =>
                                          //         employee.id ==
                                          //         users[index].id);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
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
                                                                    child: Image.network(users[users.indexWhere((employee) =>
                                                                            employee.id ==
                                                                            new_attendance[index].employee_id)]
                                                                        .image),
                                                                    width: mediaQuery
                                                                            .size
                                                                            .width /
                                                                        1.8,
                                                                    height: mediaQuery
                                                                            .size
                                                                            .height /
                                                                        4.5,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "Id : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].id}",
                                                                  ),
                                                                  Text(
                                                                    "Name : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].firstName} ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].lastName}",
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "Age : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].age}",
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "Gender : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].gender}",
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "Email : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].email}",
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "Phone : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].phone}",
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "Salary : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].salary}",
                                                                    // style:
                                                                    //     GoogleFonts.lato(
                                                                    //         fontSize: 15),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "Salary Type : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].salary_type}",
                                                                    // style:
                                                                    //     GoogleFonts.lato(
                                                                    //         fontSize: 15),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "Address : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].address}",
                                                                    // style:
                                                                    //     GoogleFonts.lato(
                                                                    //         fontSize: 15),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "Position : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].position}",
                                                                    // style:
                                                                    //     GoogleFonts.lato(
                                                                    //         fontSize: 15),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "department Id : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].departmentId}",
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "shift Id : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].shiftId}",
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "Rating : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].rating}",
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "Hiring Date : ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].hiring_date}",
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "check-in : ${new_attendance[index].time_in}",
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "check-out : ${new_attendance[index].time_out}",
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
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
                                            (adding_employee_to_attendance ==
                                                    false)
                                                ? Text(
                                                    // '${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].id}',
                                                    '${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].id} ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].firstName} ${users[users.indexWhere((employee) => employee.id == new_attendance[index].employee_id)].lastName}',
                                                    // : '${users[attendance[int.parse(day_of_attending)].employees[index] - 1].id} ${users[attendance[int.parse(day_of_attending)].employees[index] - 1].firstName} ${users[attendance[int.parse(day_of_attending)].employees[index] - 1].lastName}',
                                                    // style: TextStyle(color: Colors.black),
                                                    style:
                                                        getTextBlack(context),
                                                  )
                                                : Text(''),
                                            Spacer(),
                                            Text(
                                              'working hours:${int.parse(new_attendance[index].time_out) - int.parse(new_attendance[index].time_in)}',
                                              // 'ahmed',
                                              // style: TextStyle(color: Colors.black),
                                              style: getTextBlack(context),
                                            ),
                                          ]),
                                        ),
                                      ),

                                      // child:
                                      //     Text(new_attendance[index].id.toString()),
                                    );
                                  });
                            } else if (state is AttendanceNewDataError) {
                              return Center(
                                child: Text(state.errorMessage),
                              );
                            } else {
                              return FutureBuilder<void>(
                                future: context
                                    .read<AttendanceNewDataCubit>()
                                    .getAttendanceNewData(),
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
                      )
                    ],
                  ),
                );
              },
            ),
            Align(
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
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(241, 242, 246, 1),
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                    onPressed: () async {
                      context.read<SearchCubit>().close_search();
                      // selectedUsersItem = items[0];
                      emploees_to_be_attended = "";
                      adding_employee_to_attendance = true;
                      for (int i = 0; i < new_attendance.length; i++) {
                        emploees_to_be_attended += "id=neq." +
                            new_attendance[i].employee_id.toString() +
                            "&";
                      }
                      // search_employee.clear();
                      // search_employee_check_in.clear();
                      // search_employee_check_out.clear();

                      search_text = "";
                      _textEditingController.clear();
                      context.read<UsersDataCubit>().getUsersData();
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              // Test()
                              AddingNewAttendance(),
                          // EmployeeList()
                        ),
                      );
                    },
                    icon: FittedBox(child: Icon(Icons.add)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
