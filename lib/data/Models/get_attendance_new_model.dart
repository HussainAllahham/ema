class GetAttendanceNewModel {
  // int id;
  // int? employee_id;
  // String? date;
  // String? time_in;
  // String? time_out;
  // int? hours_worked;
  // int? overtime_hours;
  int id;
  int employee_id;
  int date;
  String time_in;
  String time_out;
  String company_name;

  GetAttendanceNewModel({
    required this.id,
    required this.employee_id,
    required this.date,
    required this.time_in,
    required this.time_out,
    required this.company_name,
    // this.hours_worked,
    // this.overtime_hours,
  });

  factory GetAttendanceNewModel.fromJson(Map<String, dynamic> json) {
    return GetAttendanceNewModel(
      id: json['id'] as int,
      employee_id: json['employee_id'] as int,
      date: json['date'] as int,
      time_in: json['time_in'] as String,
      time_out: json['time_out'] as String,
      company_name: json['company_name'] as String,
      // id: json['id'] as int,
      // employee_id: json['employee_id'] as int?,
      // date: json['date'] as String?,
      // time_in: json['time_in'] as String?,
      // time_out: json['time_out'] as String?,
      // hours_worked: json['hours_worked'] as int?,
      // overtime_hours: json['overtime_hours'] as int?,
    );
  }
  map(GetAttendanceNewModel Function(dynamic json) param0) {}
}
