import 'package:emas/Screen/Login_Screen.dart';
import 'package:emas/data/Repository/cach_helper.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String title;
  final String body;
  BoardingModel({
    required this.title,
    required this.body,
  });
}

List<BoardingModel> boarding = [
  BoardingModel(
    title: 'Welcome to the (EAMS)',
    body: 'Your Comprehensive Solution for Workforce Optimization!',
  ),
  BoardingModel(
    title: 'Welcome to the (EAMS)',
    body: 'Your Comprehensive Solution for Workforce Optimization!',
  ),
  BoardingModel(
    title: '',
    body:
        'Let EAMS be your partner in shaping a workplace where administrative tasks are simplified, and your focus remains on fostering a thriving, collaborative, and successful team.',
  ),
];

var boardController = PageController();
bool isLast = false;
void sumbit(context) {
  CachHelper.saveBool(key: 'onboarding', value: true).then((value) {
    if (value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => false,
      );
      bool onboard = CachHelper.getBool(key: 'onboarding')!;
      print(onboard);
    }
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: (index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              controller: boardController,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  ondordItem(context, boarding[index]),
              itemCount: boarding.length,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          sumbit(context);
                        },
                        child: Row(
                          children: [
                            isLast
                                ? Text(
                                    'Get Start',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )
                                : Text(
                                    'Skip',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(
                        controller: boardController,
                        count: boarding.length,
                        effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: HexColor('3232A0'),
                          dotHeight: 10,
                          expansionFactor: 2,
                          dotWidth: 10,
                          spacing: 5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget ondordItem(context, BoardingModel model) => SafeArea(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/onboard.jpeg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  '${model.title}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '${model.body}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
