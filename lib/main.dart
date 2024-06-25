import 'package:bloc/bloc.dart';
import 'package:emas/modules/employee/employee.dart';
import 'package:emas/modules/on_boarding/on_boarding_screen.dart';
import 'package:emas/shared/cubit/bloc_obsrever.dart';
import 'package:emas/shared/network/local/cach_helper.dart';
import 'package:emas/shared/network/remot/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  bool? onBoarding = CachHelper.getBool(key: 'onboarding');
  runApp(MyApp(
    onboarding: onBoarding,
  ));
}

class MyApp extends StatelessWidget {
  final bool? onboarding;
  MyApp({
    super.key,
    this.onboarding,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: HexColor('#3232A0'),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      home: onboarding == true ? EmployeeScreen() : OnBoardingScreen(),
    );
  }
}
