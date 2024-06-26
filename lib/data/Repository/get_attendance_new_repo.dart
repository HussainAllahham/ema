import 'dart:convert';
import 'package:graduation_project/Screen/Splash_Screen.dart';
import 'package:graduation_project/data/Models/get_attendance_new_model.dart';

// import 'package:graduation_project/data/Repository/get_attendance_repo.dart';
import 'package:http/http.dart' as http;

// import 'get_users_Repo.dart';

List<GetAttendanceNewModel> new_attendance = [];
bool attending_employee_to_day = false;
// List attended_employees_id = [];
// List check_in_employees = [];
// List check_out_employees = [];
// List<GetUsersModel> attended_employees = [];
// List index_of_attended_employees_in_this_company = [];
// List index_of_attendance_list_for_attended_employees_in_this_company =
//     []; // رقم العنصر الحاضر في مصفوفه الحضور و ذلك لمعرفه رقم العنصر في مصفوفه تاريخ الحضور و مصفوفه تاريخ الانصراف
// String? selectedAttendanceItem = 'day';
String url = "";
// var day_or_month_index;
// bool day_indexing = false;
// String? selectedAttendanceDayItem = '';
String? selectedAttendanceCheckInItem = '';
String? selectedAttendanceCheckOutItem = '';
// bool attending_employee_to_day = false;
var postAttendanceData;
String day_of_new_attending = "";
String id_of_added_employee = "";
var response;
bool return_all_data = false;

class GetAttendanceNewRepo {
  final supabaseUrl = 'https://oarqjspwajbojrddcvky.supabase.co/rest/v1';
  final supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hcnFqc3B3YWpib2pyZGRjdmt5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTE3Mzk2NTQsImV4cCI6MjAyNzMxNTY1NH0.NJ-QaQKrveyPpE2G9-8kizBh6ByFShdQ47xs2Bx8wmQ';
  Future<String?> getAttendanceNewData() async {
    try {
      if (attending_employee_to_day == true) {
        response = await http.post(
          Uri.parse('$supabaseUrl/new_attendance_2'),
          body: jsonEncode(postAttendanceData),
          headers: {
            'Content-Type': 'application/json',
            'apikey': supabaseKey,
          },
        );
        // response = await http.post(
        //   Uri.parse('$supabaseUrl/new_attendance_2'),
        //   body: jsonEncode(postAttendanceData),
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'apikey': supabaseKey,
        //   },
        // );
        print('posted ///**');
        attending_employee_to_day = false;
      }

      // if (selectedAttendanceItem == 'day') {
      //   url = '$supabaseUrl/attendance_days';
      // } else {
      //   url = '$supabaseUrl/attendance_months';
      // }
      // print('data :' + day_of_new_attending + '///**');
      if (return_all_data == true) {
        url =
            '$supabaseUrl/new_attendance_2?date=eq.${int.parse(day_of_new_attending) + 1}';
      } else {
        url =
            '$supabaseUrl/new_attendance_2?date=eq.${int.parse(day_of_new_attending) + 1}&company_name=eq.${Company_Name}';
      }
      var attendance_response = await http.get(
        Uri.parse(url),
        headers: {'apikey': supabaseKey},
      );
      // print('day_of_attending :' + day_of_new_attending + '///**');
      // print('data' + '///**');
      // print('data ///**');
      // http.Response attendance_response = await http.get(Uri.parse(
      //     (selectedAttendanceItem == 'day')
      //         ? 'http://localhost:3000/attendance_days'
      //         : 'http://localhost:3000/attendance_months'));

      if (attendance_response.statusCode == 200) {
        List<dynamic> decodedResponse = jsonDecode(attendance_response.body);

        new_attendance = decodedResponse
            .map((json) => GetAttendanceNewModel.fromJson(json))
            .toList();
        // print(new_attendance.length.toString() + '///**');
        // print(users.length.toString() + '///**');

        new_attendance.sort((a, b) => a.id - b.id);
        // print(attendance[31].employees);
        return "ahmed";
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
