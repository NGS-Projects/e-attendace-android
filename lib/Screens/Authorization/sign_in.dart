import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:eattendance/untils/export_file.dart';
import 'package:intl/intl.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthController authcontroller = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  String selectedgender = "";
  // location

  int activeIndex = 0;

  bool value = false;
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();
  // GoogleMapController? _controller;

  double lat = 37.42796133580664;
  double lon = -122.085749655962;

  String? _currentAddress;
  String? _currentAddresspincode;
  String? _destination;

  var isLoading = "none";

  var sourceLocation = "Your Location".obs;

  /////////////////////////////

  //
  final List<String> Genders = [
    'Male',
    'Female',
    'Others',
  ];

  String? selectedValue;
  String? selectedGenderValue;
  DateTime selectedDate = DateTime.now();
  DateTime choosenDate = DateTime.now();
  var selectDate = "Select Date".obs;

  bool passwordVisible = true;
  bool confirmpasswordVisible = true;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: GoogleFonts.roboto(
                  fontSize: kEighteenFont,
                  fontWeight: kFW600,
                  color: Ktextcolor),
            ),
            content: Text(
              'Do you want to exit this App',
              style: GoogleFonts.roboto(
                  fontSize: 13.sp, fontWeight: kFW600, color: KText),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: GoogleFonts.roboto(
                      fontSize: kTwelveFont,
                      fontWeight: kFW600,
                      color: KdarkText),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  'Yes',
                  style: GoogleFonts.roboto(
                      fontSize: kTwelveFont,
                      fontWeight: kFW600,
                      color: KOrange),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Kwhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 20.w, right: 20.w, bottom: 20.h, top: 10.h),
                child: Form(
                  key: _formKey,
                  // autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60.h,
                      ),

                      Text(
                        "Sign In",
                        style: GoogleFonts.roboto(
                            fontSize: 30.sp,
                            color: KOrange,
                            fontWeight: kFW600),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      // SizedBox(

                      Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Enter your Credentials to Login into your account",
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                color: KText,
                                fontWeight: kFW400),
                          ),

                          ///////////

                          SizedBox(
                            height: 20.h,
                          ),
                          CustomFormFields(
                            controller: authcontroller.EASigninEMPIDController,
                            ontap: () {
                              //  Get.toNamed(kSearchPlaces);
                            },
                            enabled: true,
                            labelColor: KText,
                            obscureText: false,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            fontSize: kFourteenFont,
                            fontWeight: FontWeight.w500,
                            hintText: "Employee ID",
                            maxLines: 1,
                            readOnly: false,
                            label: 'Enter Emp ID',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Emp ID';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          //
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                //  letterSpacing: 1,
                                color: KTextgery,
                                fontSize: kFourteenFont,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Kwhite,
                                boxShadow: [
                                  BoxShadow(
                                    color: kblack.withOpacity(0.2),
                                    blurRadius: 2.r,
                                    offset: Offset(1, 1),
                                    spreadRadius: 1.r,
                                  )
                                  // BoxShadow(
                                  //   color: Color(0x3FD3D1D8),
                                  //   blurRadius: 30,
                                  //   offset: Offset(15, 15),
                                  //   spreadRadius: 2,
                                  // )
                                ]),
                            child: TextFormField(
                              controller:
                                  authcontroller.EASignINpasswordController,
                              // controller: EASigninEMPIDController,
                              onTap: () {},
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: kFW500,
                                  color: kblack),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.start,
                              obscuringCharacter: '●',
                              // style: TextStyle(fontSize: 20),
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                focusColor: Kwhite,
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 8),
                                // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kblack.withOpacity(0.6),
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kblack.withOpacity(0.6),
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kblack.withOpacity(0.6),
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: KOrange, width: 1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: KOrange, width: 1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                fillColor: Kwhite,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 20.sp,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        passwordVisible = !passwordVisible;
                                      },
                                    );
                                  },
                                ),

                                hintText: "Enter Password",
                                alignLabelWithHint: true,
                                //make hint text
                                hintStyle: GoogleFonts.roboto(
                                  color: KTextgery.withOpacity(0.5),
                                  fontSize: 14.sp,
                                  fontWeight: kFW500,
                                ),

                                //create lable
                              ),
                              // decoration: InputDecoration(
                              //   focusColor: Colors.white,

                              //   contentPadding: const EdgeInsets.only(
                              //       left: 20.0, bottom: 6.0, top: 8.0),

                              //   border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(20.r),
                              //   ),
                              //   enabledBorder: OutlineInputBorder(
                              //     borderSide: const BorderSide(
                              //         color: Ktextcolor, width: 0.5),
                              //     borderRadius: BorderRadius.circular(30.r),
                              //   ),
                              //   errorBorder: OutlineInputBorder(
                              //     borderSide: const BorderSide(
                              //         color: Ktextcolor, width: 0.5),
                              //     borderRadius: BorderRadius.circular(30.r),
                              //   ),
                              //   disabledBorder: OutlineInputBorder(
                              //     borderSide: const BorderSide(
                              //         color: Ktextcolor, width: 0.5),
                              //     borderRadius: BorderRadius.circular(30.r),
                              //   ),
                              //   focusedErrorBorder: OutlineInputBorder(
                              //     borderSide:
                              //         const BorderSide(color: Ktextcolor, width: 1),
                              //     borderRadius: BorderRadius.circular(30.r),
                              //   ),
                              //   focusedBorder: OutlineInputBorder(
                              //     borderSide: const BorderSide(
                              //         color: Ktextcolor, width: 0.5),
                              //     borderRadius: BorderRadius.circular(30.r),
                              //   ),
                              //   fillColor: Colors.grey,

                              //   hintText: "**************",

                              //   //make hint text
                              //   hintStyle: TextStyle(
                              //     color: selectedTheme == "Lighttheme"
                              //         ? Klightgray.withOpacity(0.5)
                              //         : Kwhite,
                              //     fontSize: kTwelveFont,
                              //     fontWeight: FontWeight.w700,
                              //   ),

                              //   suffixIcon: IconButton(
                              //     icon: Icon(
                              //       passwordVisible
                              //           ? Icons.visibility
                              //           : Icons.visibility_off,
                              //       size: 20.sp,
                              //     ),
                              //     onPressed: () {
                              //       setState(
                              //         () {
                              //           passwordVisible = !passwordVisible;
                              //         },
                              //       );
                              //     },
                              //   ),

                              //   //create lable
                              //   labelText: 'Password',
                              //   //lable style
                              //   labelStyle: TextStyle(
                              //     color: selectedTheme == "Lighttheme"
                              //         ? Klightgray
                              //         : Kwhite,
                              //     fontSize: kTwelveFont,
                              //     fontWeight: FontWeight.w800,
                              //   ),
                              // ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              onChanged: (String value) {},
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(kForgotpassword);
                              },
                              child: Text(
                                "Forgot password ?",
                                style: GoogleFonts.roboto(
                                  color: KText,
                                  fontSize: 14.sp,
                                  fontWeight: kFW500,
                                ),
                              ),
                            ),
                          ),

                          CustomButton(
                              margin: EdgeInsets.only(top: 50.h),
                              borderRadius: BorderRadius.circular(10.r),
                              Color: KOrange,
                              textColor: Kwhite,
                              height: 42.h,
                              width: double.infinity,
                              label: "Sign In",
                              fontSize: kSixteenFont,
                              fontWeight: kFW500,
                              isLoading: false,
                              onTap: () {
                                var payload = {
                                  "empId": authcontroller
                                      .EASigninEMPIDController.text,
                                  "password": authcontroller
                                      .EASignINpasswordController.text
                                };

                                if (_formKey.currentState!.validate()) {
                                  authcontroller.mobileRegistration(payload);
                                }
                              }),
                          SizedBox(
                            height: 45.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(kSelectCompany);
                              },
                              child: RichText(
                                textScaleFactor: 1,
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: "Don't have an account?  ",
                                  style: GoogleFonts.roboto(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW500,
                                    color: KText,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Sign Up",
                                      style: GoogleFonts.roboto(
                                          fontSize: 15.sp,
                                          color: KText,
                                          fontWeight: kFW600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

                      //FindDonor()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
