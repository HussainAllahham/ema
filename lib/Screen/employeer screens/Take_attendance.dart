import 'dart:async';
import 'dart:convert';
import 'dart:io'; // Import dart:io for File class
import 'package:connectivity/connectivity.dart';
import 'package:emas/Screen/Splash_Screen.dart';
import 'package:emas/data/Repository/get_companies_name_repo.dart';
import 'package:emas/functions/distance_between_locations.dart';
import 'package:emas/functions/location.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class TakeAttendance extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CameraScreenState createState() => _CameraScreenState();
}

var photo;

class _CameraScreenState extends State<TakeAttendance> {
  CameraController? _controller;
  // ignore: prefer_final_fields
  List<dynamic> _capturedImages = [];
  late Timer _captureTimer;
  bool _isCameraOpen = false;
  // ignore: non_constant_identifier_names
  String last_message = '';
  int index = 0;
  var location_status;
  double employeer_long = 0, employeer_lat = 0;
  int employee_company_index = 0;
  double distance = 0;

  Future<void> _openFrontCamera() async {
    final cameras = await availableCameras();

    late CameraDescription frontCamera;

    for (final camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
        break;
      }
    }

    if (frontCamera.name != "") {
      _controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
      );

      await _controller!.initialize();

      setState(() {
        _isCameraOpen = true;
      });

      _startCaptureTimer();
    } else {
      // No front camera found
      // ignore: avoid_print
      print('No front camera found');
    }
  }

  void _closeCamera() {
    _controller?.dispose();
    _controller = null;
    setState(() {
      _isCameraOpen = false;
    });
    _stopCaptureTimer();
  }

  void _startCaptureTimer() async {
    _captureTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      final image = await _controller?.takePicture();
      // final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        _capturedImages.add(image.path); // On mobile, add file path
        await _uploadImage();
        setState(() {});
        // if ((await getIPAddress() == await getting_ip())) {
        //   await fetchData();
        //   setState(() {});
        // }
      }
    });
  }

  // void _startCaptureTimer() async {
  //   // _captureTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
  //   // final image = await _controller?.takePicture();
  //   final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (image != null) {
  //     _capturedImages.add(image.path); // On mobile, add file path
  //     await _uploadImage();
  //     setState(() {});
  //     // if ((await getIPAddress() == await getting_ip())) {
  //     //   await fetchData();
  //     //   setState(() {});
  //     // }
  //   }
  //   // });
  // }

  void _stopCaptureTimer() {
    // ignore: unnecessary_null_comparison
    if (_captureTimer != null && _captureTimer.isActive) {
      _captureTimer.cancel();
    }
  }

  // sending employer id
  // Future<void> id() async {
  //   const String apiUrl = 'http://192.168.1.43:5000/id';

  //   var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

  //   request.fields['id'] = '10002';

  //   try {
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       print('The id sended successfully');
  //     } else {
  //       print('Failed to send the id');
  //     }
  //   } catch (e) {
  //     print('Error sending the id: $e');
  //   }
  // }
  Future<void> sendId(id) async {
    const String apiUrl =
        // 'http://192.168.1.43:5000/id';
        'https://flask-face-recognition-heroku-deploy.onrender.com/id';

    // Create a MultipartRequest
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Add the 'id' field to the request
    request.fields['id'] = id;

    try {
      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        print('The id was sent successfully');
      } else {
        print('Failed to send the id. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending the id: $e');
    }
  }

  // Function to upload the selected image to the Flask API
  Future<void> _uploadImage() async {
    if (_capturedImages.last == null) {
      // ignore: avoid_print
      print('No image selected');
      return;
    }

    const String apiUrl =
        // 'http://192.168.1.43:5000/upload_photo';
        // "https://8b3ad53a-8061-4499-97c8-625199da0e44-00-181f33lfivk22.riker.replit.dev/upload_photo";
        // 'https://flask-face-recognition-using-deep-face.onrender.com/upload_photo';
        // 'https://flask-face-recognition-using-deep-face-1.onrender.com/upload_photo';
        // 'https://flask-face-recognition-using-deep-face-2.onrender.com/upload_photo';
        // 'https://flask-face-recognition-heroku-deploy.onrender.com/upload_photo';
        'https://flask-face-recognition-heroku-deploy.onrender.com/upload_photo';

    // Your upload logic
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    photo = await http.MultipartFile.fromPath('photo', _capturedImages.last!);
    request.files.add(photo);

    // if ((await getIPAddress() == await getting_ip())) {
    //   await fetchData();
    //   setState(() {});
    // }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('Image uploaded successfully');
      } else {
        // ignore: avoid_print
        print('Failed to upload image');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading image: $e');
    }
  }

  Future<String> fetchData() async {
    const String apiUrl =
        // 'http://192.168.1.43:5000/hello';
        // 'https://8b3ad53a-8061-4499-97c8-625199da0e44-00-181f33lfivk22.riker.replit.dev/hello';
        // 'https://flask-face-recognition-using-deep-face.onrender.com/hello';
        // 'https://flask-face-recognition-using-deep-face-1.onrender.com/hello';
        // 'https://flask-face-recognition-using-deep-face-2.onrender.com/hello';
        // 'https://flask-face-recognition-heroku-deploy.onrender.com/hello';
        'https://flask-face-recognition-heroku-deploy.onrender.com/hello';
    final Uri apiUri = Uri.parse(apiUrl);
    final response = await http.get(apiUri);
    if (response.statusCode == 200) {
      await getting_ip();
      // ignore: avoid_print
      print(json.decode(response.body)['message']);
      print(index.toString() + '//**');
      return json.decode(response.body)['message'][index];
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  // ignore: non_constant_identifier_names
  Future<String> getting_ip() async {
    // const String apiUrl = 'http://192.168.1.43:5000/ip';
    const String apiUrl =
        // 'http://192.168.1.43:5000/ip';
        // 'https://8b3ad53a-8061-4499-97c8-625199da0e44-00-181f33lfivk22.riker.replit.dev/ip';
        // 'https://flask-face-recognition-using-deep-face.onrender.com/ip';
        // 'https://flask-face-recognition-using-deep-face-1.onrender.com/ip';
        // 'https://flask-face-recognition-using-deep-face-2.onrender.com/ip';
        // 'https://flask-face-recognition-heroku-deploy.onrender.com/ip';
        'https://flask-face-recognition-heroku-deploy.onrender.com/ip';
    final Uri apiUri = Uri.parse(apiUrl);
    final response = await http.get(apiUri);
    if (response.statusCode == 200) {
      List test = json.decode(response.body)['ip'];
      for (int i = 0; i < test.length; i++) {
        if (test[i] == await getIPAddress()) {
          index = i;
        }
      }
      // ignore: avoid_print
      print("this is the index : " + index.toString());
      // ignore: avoid_print
      print('IPs' + (json.decode(response.body)['ip']).toString());
      return "";
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  // Function to open the image picker and select an image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery); // Use pickImage instead of getImage
    if (pickedFile != null) {
      // Check if pickedFile is not null
      _capturedImages.add(pickedFile.path);
      print(pickedFile.path + '//**');
      await _uploadImage();
      setState(() {});
      // if (await getIPAddress() == await getting_ip()) {
      //   await fetchData();
      //   setState(() {});
      // }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    _stopCaptureTimer();
    super.dispose();
    setState(() {
      _isCameraOpen = false;
    });
    setState(() {});
  }

  Future<String?> getIPAddress() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // Device is not connected to the internet
      return null;
    }

    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            // Return the IPv4 address
            // ignore: avoid_print
            print(addr.address);
            return addr.address;
          }
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print("Failed to get IP address: $e");
    }

    return null; // If no IP address is found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     // ignore: prefer_const_constructors
      //     // title: Text('Camera'),
      //     ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // const SizedBox(
          //   height: 10,
          // ),
          FutureBuilder<String>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error} Ahmed');
              } else {
                return Text(
                  'Data from API: ${snapshot.data}\n Your location is ${(distance != 0) ? distance.toString().substring(0, 5) : distance.toString()} distance from the company center',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                );
              }
            },
          ),
          Column(
            children: [
              ElevatedButton(
                // onPressed: _openCamera,
                onPressed: () {
                  sendId(employeer_id);
                  _openFrontCamera();
                },
                child: const Text('Open Camera'),
              ),
              ElevatedButton(
                onPressed: _closeCamera,
                child: const Text('Close Camera'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // print('employeer_id ' + employeer_id.toString() + '//**');
                  sendId(employeer_id);
                  _pickImage();
                  await getLocation().then((value) {
                    if (value.latitude is num) {
                      employeer_lat = value.latitude;
                      employeer_long = value.longitude;
                      // print("Lat : " +
                      //     employeer_lat.toString() +
                      //     " Long : " +
                      //     employeer_long.toString() +
                      //     '//**');
                      if (employeer_lat != 0) {
                        location_status = " Success";
                      } else {
                        location_status = " Faild";
                      }

                      // var distance = haversine();
                      // print('${lat}/././././.././/./././.');
                    }
                  });
                  // print('location status: ' + location_status + '//**');
                  // print('location lat: ' + employeer_lat.toString() + '//**');
                  // print('location long: ' + employeer_long.toString() + '//**');
                  // print('company index ' +
                  //     companies_name
                  //         .indexWhere((company) => company.name == Company_Name)
                  //         .toString() +
                  //     '//**');
                  employee_company_index = companies_name
                      .indexWhere((company) => company.name == Company_Name);
                  distance = haversine(
                      employeer_lat,
                      employeer_long,
                      double.parse(
                          companies_name[employee_company_index].Location[0]),
                      double.parse(
                          companies_name[employee_company_index].Location[1]));
                  // print(
                  //     'the distance between the employee and the company center is :' +
                  //         distance.toString() +
                  //         '//**');
                  // await fetchData();
                },
                child: const Text('Chose the first Image'),
              ),
              TextFormField(
                onChanged: (value) {
                  // employer_id = value;
                },
              )
              // ElevatedButton(
              //   onPressed: () async {
              //     // await _uploadImage();
              //     // await fetchData();
              //     // await getting_ip();
              //     await fetchData();
              //     setState(() {});
              //     // await getIPAddress();
              //     // print(getIPAddress());
              //   },
              //   child: const Text('Upload data'),
              // ),
            ],
          ),
          _isCameraOpen
              ? _controller != null && _controller!.value.isInitialized
                  // ignore: sized_box_for_whitespace
                  ? Container(
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.5,
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: CameraPreview(_controller!),
                      ),
                    )
                  : Container()
              : Container(),
          Container(
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.38,
            child: ListView.builder(
              itemCount: _capturedImages.length,
              itemBuilder: (context, index) {
                final dynamic capturedImage = _capturedImages[index];
                return Container(
                    margin: (index == 0)
                        ? const EdgeInsets.only(top: 0)
                        : const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.38,
                    // child: FittedBox(child: Image.file(File(capturedImage))));
                    child: (kIsWeb)
                        ? FittedBox(
                            child: Image.network(
                                capturedImage)) // On web, display using Image.network
                        : FittedBox(
                            child: Image.file(File(
                                capturedImage)))); // On mobile, display using Image.file
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TakeAttendance(),
  ));
}
