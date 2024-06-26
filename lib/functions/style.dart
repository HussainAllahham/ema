import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

List icons = [
  'assets/images/Employee_list_logo.png', // 0
  'assets/images/Attendance_report_logo.png', // 1
  'assets/images/Departments_logo.png', // 2
  'assets/images/Shifts_logo.png', // 3
  'assets/images/company name logo.png', // 4
  'assets/images/employer name.png', // 5
  'assets/images/password.png', // 6
  'assets/images/phone number.png', // 7
  'assets/images/salary.png', // 8
  'assets/images/address.png', // 9
  'assets/images/posintion.png', // 10
  'assets/images/add_image.png' // 11
];

getTextWhite(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(
        context,
        valueWhen: [
          Condition.smallerThan(name: MOBILE, value: 14.0),
          Condition.largerThan(name: MOBILE, value: 16.0),
          Condition.smallerThan(name: TABLET, value: 18.0),
          Condition.largerThan(name: TABLET, value: 20.0),
          Condition.largerThan(name: DESKTOP, value: 24.0),
          Condition.largerThan(name: 'XL', value: 28.0),
        ],
        defaultValue: 12.0,
      ).value,
      color: Colors.white);
}

getTextBlack(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(
        context,
        valueWhen: [
          Condition.smallerThan(name: MOBILE, value: 14.0),
          Condition.largerThan(name: MOBILE, value: 16.0),
          Condition.smallerThan(name: TABLET, value: 18.0),
          Condition.largerThan(name: TABLET, value: 20.0),
          Condition.largerThan(name: DESKTOP, value: 24.0),
          Condition.largerThan(name: 'XL', value: 28.0),
        ],
        defaultValue: 12.0,
      ).value,
      color: Colors.black,
      fontWeight: FontWeight.w400);
}

getSmallTextBlack(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(
        context,
        valueWhen: [
          Condition.smallerThan(name: MOBILE, value: 6.0),
          Condition.largerThan(name: MOBILE, value: 8.0),
          Condition.smallerThan(name: TABLET, value: 10.0),
          Condition.largerThan(name: TABLET, value: 12.0),
          Condition.largerThan(name: DESKTOP, value: 14.0),
          Condition.largerThan(name: 'XL', value: 16.0),
        ],
        defaultValue: 12.0,
      ).value,
      color: Colors.red);
}

getTextGrey(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(
      context,
      valueWhen: [
        Condition.smallerThan(name: MOBILE, value: 14.0),
        Condition.largerThan(name: MOBILE, value: 16.0),
        Condition.smallerThan(name: TABLET, value: 18.0),
        Condition.largerThan(name: TABLET, value: 20.0),
        Condition.largerThan(name: DESKTOP, value: 24.0),
        Condition.largerThan(name: 'XL', value: 28.0),
      ],
      defaultValue: 12.0,
    ).value,
    // color: Colors.white
  );
}

getTextBlackHeader(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(
      context,
      valueWhen: [
        Condition.smallerThan(name: MOBILE, value: 20.0),
        Condition.largerThan(name: MOBILE, value: 24.0),
        Condition.smallerThan(name: TABLET, value: 26.0),
        Condition.largerThan(name: TABLET, value: 28.0),
        Condition.largerThan(name: DESKTOP, value: 32.0),
        Condition.largerThan(name: 'XL', value: 36.0),
        // Condition.largerThan(name: 'XXL', value: 36.0),
      ],
      defaultValue: 12.0,
    ).value,
    color: Colors.black,
    // fontWeight: FontWeight.bold
  );
}

getTextWhiteHeader(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(
      context,
      valueWhen: [
        Condition.smallerThan(name: MOBILE, value: 20.0),
        Condition.largerThan(name: MOBILE, value: 24.0),
        Condition.smallerThan(name: TABLET, value: 26.0),
        Condition.largerThan(name: TABLET, value: 28.0),
        Condition.largerThan(name: DESKTOP, value: 32.0),
        Condition.largerThan(name: 'XL', value: 36.0),
        // Condition.largerThan(name: 'XXL', value: 36.0),
      ],
      defaultValue: 12.0,
    ).value,
    color: Colors.white,
    // fontWeight: FontWeight.bold
  );
}

getLoginHeader(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(
      context,
      valueWhen: [
        Condition.smallerThan(name: MOBILE, value: 35.0),
        Condition.largerThan(name: MOBILE, value: 40.0),
        Condition.smallerThan(name: TABLET, value: 40.0),
        Condition.largerThan(name: TABLET, value: 44.0),
        Condition.largerThan(name: DESKTOP, value: 48.0),
        Condition.largerThan(name: 'XL', value: 52.0),
        // Condition.largerThan(name: 'XXL', value: 60.0),
      ],
      defaultValue: 12.0,
    ).value,
    color: Color(0xfff0a307),
    // fontWeight: FontWeight.bold
  );
}

getSplashScreen(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(
      context,
      valueWhen: [
        Condition.smallerThan(name: MOBILE, value: 35.0),
        Condition.largerThan(name: MOBILE, value: 40.0),
        Condition.smallerThan(name: TABLET, value: 40.0),
        Condition.largerThan(name: TABLET, value: 44.0),
        Condition.largerThan(name: DESKTOP, value: 48.0),
        Condition.largerThan(name: 'XL', value: 52.0),
        // Condition.largerThan(name: 'XXL', value: 60.0),
      ],
      defaultValue: 12.0,
    ).value,
    color: Colors.white,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w900,
  );
}
