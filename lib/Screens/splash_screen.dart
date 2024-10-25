import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eattendance/untils/export_file.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ProfileController profilecontroller = Get.put(ProfileController());
  // bool? isUserLoggedIn;
  // @override
  // void initState() {
  //   super.initState();

  //   //////////////////////////////

  //   Future.delayed(const Duration(seconds: 2), () async {
  //     // Get.toNamed(kSelectCompany);
  //     Get.toNamed(kSignIn);
  //   });
  //   /////////////////////////////
  // }
  bool? isUserLoggedIn;
  @override
  void initState() {
    super.initState();
/////////////////////////original code
    // isUserLoggedIn = UserSimplePreferences.getLoginStatus();
    // Future.delayed(const Duration(seconds: 2), () async {
    //   if (isUserLoggedIn != null && isUserLoggedIn == true) {
    //     await apiController.getProfile();

    //     apiController.profileData["employeeType"] == "Donor"
    //         ? Get.toNamed(kDonorBottomNavigation)
    //         : Get.toNamed(kNavigation);
    //   } else {
    //     Get.toNamed(kMobileSignUp);
    //   }
    // });
    ////////////////////////////////////////////////////
    // isUserLoggedIn = UserSimplePreferences.getLoginStatus();
    // Future.delayed(const Duration(seconds: 2), () async {
    //   await Get.toNamed(kNavigation);
    // });
    //////////////////////////////
    isUserLoggedIn = UserSimplePreferences.getLoginStatus();
    Future.delayed(const Duration(seconds: 3), () async {
      if (isUserLoggedIn != null && isUserLoggedIn == true) {
        // await profilecontroller.getEAProfile();
        Get.toNamed(kNavigation);
      } else {
        Get.toNamed(kSignIn);
      }
    });
    /////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      body: Container(
        margin: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Image.asset(
                "assets/images/eAttendancelogo.png",
                height: 150.h,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "e - Attendance",
              style: GoogleFonts.roboto(
                  fontSize: kTwentyFont, color: KOrange, fontWeight: kFW600),
            ),
          ],
        ),
      ),
    );
  }
}
