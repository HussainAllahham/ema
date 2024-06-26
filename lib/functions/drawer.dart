import 'package:flutter/material.dart';
import 'package:graduation_project/Screen/Login_Screen.dart';
import 'package:graduation_project/Screen/Splash_Screen.dart';
import 'package:graduation_project/Screen/setting.dart';
import 'package:graduation_project/data/Repository/get_companies_name_repo.dart';
import 'package:graduation_project/functions/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class myDrawer extends StatelessWidget {
  const myDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    for (int i = 0; i < companies_name.length; i++) {
                      if (companies_name[i].name == Company_Name) {
                        editted_company_index = i;
                        editted_company_id = companies_name[i].id;
                      }
                    }
                    Navigator.pop(
                      context,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => Setting(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.settings,
                    color: const Color.fromRGBO(50, 50, 160, 1),
                  )),
              Expanded(
                child: Container(
                  // color: Colors.white,
                  child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 1 / 3,
                        height: MediaQuery.of(context).size.height * 1 / 15,
                        // color: Colors.yellow,
                        child: FittedBox(
                            child: Text(
                          (Manger_logedin == true) ? "Admin" : "Employer",
                          style: TextStyle(
                              color: const Color.fromRGBO(50, 50, 160, 1),
                              fontWeight: FontWeight.w400),
                        ))),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 1 / 5,
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Company Name : ${Company_Name}",
                  textAlign: TextAlign.left,
                ),
                if (Manger_logedin == true)
                  Text(
                    "User Name : ${Manger_Name}",
                    textAlign: TextAlign.start,
                  ),
                if (Manger_logedin != true)
                  Text(
                    "User Name : ${User_Name}",
                    textAlign: TextAlign.start,
                  ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 2,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                selectedCompany = null;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => LoginScreen(),
                  ),
                );
                final prefs = await SharedPreferences.getInstance();
                //manger logout
                prefs.setBool('Manger_logedin', false);
                prefs.setString('Manger_Name', "");
                Manger_Name = "";
                User_Name = "";
                //user logout
                prefs.setBool('customer_logedin', false);
                prefs.setString('User_Name', "");
                prefs.setString('Company_Name', "");
                lat = 0;
              },
              child: Text(
                "Logout",
                style: getTextWhite(context),
              ),
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  elevation: 10,
                  backgroundColor: const Color.fromRGBO(50, 50, 160, 1),
                  // Colors.green[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// import 'package:graduation_project/Screen/Login_Screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:SportApp/Screens/LoginScreen.dart';

// class myDrawer extends StatefulWidget {
//   myDrawer({super.key});

//   @override
//   State<myDrawer> createState() => _myDrawerState();
// }

// var phone;
// var name;
// var first_name;
// var last_name;
// bool? google_logedin;
// bool? phone_logedin;

// class _myDrawerState extends State<myDrawer> {
//   // final GoogleSignIn _googleSignIn = GoogleSignIn();
//   @override
//   void initState() {
//     super.initState();
//     Future<String> login_data() async {
//       final prefs = await SharedPreferences.getInstance();

//       google_logedin = prefs.getBool('google_logedin') ?? false;

//       phone_logedin = prefs.getBool('phone_logedin') ?? false;
//       String phone_number = prefs.getString('phone_number').toString();
//       print("*//**//*/**/*/**//**/**//*${phone_number}");

//       String google_name = prefs.getString('google_name') ?? "";
//       String google_number = prefs.getString('google_number') ?? "";

//       for (int i = 0; i < google_name.length; i++) {
//         if (google_name[i] == " ") {
//           first_name = google_name.substring(0, i);
//           last_name = google_name.substring(i, google_name.length);
//           i = google_name.length;
//         }
//       }
//       // name = google_name;
//       // print("*//**//*/**/*/**//**/**//*${google_logedin}");

//       if (google_logedin == true) {
//         name = google_name;
//         phone = google_number;
//         setState(() {});
//         print("*//**//*/**/*/**//**/**//*${name}");
//         return phone;
//       } else {
//         phone = phone_number;
//         first_name = null;
//         last_name = null;
//         print("*//**//*/**/*/**//**/**//*${phone}");
//         setState(() {});
//         return name;
//       }
//     }

//     login_data();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.grey[850],
//       child: Padding(
//         padding: const EdgeInsets.only(top: 50.0, left: 20),
//         child: Container(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Phone Number :${phone ?? " "}",
//               // style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             if (google_logedin == true)
//               Text(
//                 "First Name :${first_name ?? " "}",
//                 // style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
//               ),
//             SizedBox(
//               height: 20,
//             ),
//             if (google_logedin == true)
//               Text(
//                 "Last Name :${last_name ?? " "}",
//                 // style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
//               ),
//             Spacer(),
//             Center(
//                 child: Padding(
//               padding: const EdgeInsets.only(bottom: 30, right: 20),
//               child: Container(
//                 width: double.infinity,
//                 child: FloatingActionButton.extended(
//                   onPressed: () async {
//                     await signOut();
//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute<void>(
//                             builder: (BuildContext context) => LoginScreen()),
//                         ModalRoute.withName("/"));
//                     final prefs = await SharedPreferences.getInstance();
//                     prefs.setBool('google_logedin', false);
//                     prefs.setBool('phone_logedin', false);
//                   },
//                   label: Text('Signout'),
//                   backgroundColor: const Color(0xfff0a307),
//                 ),
//               ),
//             ))
//           ],
//         )),
//       ),
//     );
//   }

//   Future<void> signOut() async {
//     // await _googleSignIn.signOut();
//   }
// }
