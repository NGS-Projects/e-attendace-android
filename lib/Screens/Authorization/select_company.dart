import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eattendance/untils/export_file.dart';

class CompanySelect extends StatefulWidget {
  const CompanySelect({super.key});

  @override
  State<CompanySelect> createState() => _CompanySelectState();
}

class _CompanySelectState extends State<CompanySelect> {
  AuthController authcontroller = Get.put(AuthController());
  //
  final List<String> CompanyList = [
    'SDVVL Survey and Construction Private Limited',
    'Nuhvin Global Services Private Limited',
  ];

  String? selectedValue;
  String? selectedGenderValue;
  @override
  void initState() {
    super.initState();
/////////////////////////original code

    //////////////////////////////

    // Future.delayed(const Duration(seconds: 2), () async {
    //   // Get.toNamed(kSelectCompany);
    //   //  Get.toNamed(kSignUp);
    // });
    /////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: KdarkText,
            size: 20.sp,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          "",
          style: GoogleFonts.roboto(
              fontSize: kEighteenFont, fontWeight: kFW500, color: KdarkText),
        ),
      ),
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
                height: 80.h,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Welcome to e - Attendance",
              style: GoogleFonts.roboto(
                  fontSize: kTwentyFont, color: KOrange, fontWeight: kFW600),
            ),
            SizedBox(
              height: 40.h,
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
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: kblack.withOpacity(0.6), width: 0.5),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: kblack.withOpacity(0.6), width: 0.5),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: kblack.withOpacity(0.6), width: 0.5),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: KOrange, width: 1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: KOrange, width: 1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                hint: Text(
                  'Select Company',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: KTextgery.withOpacity(0.5),
                  ),
                ),
                items: CompanyList.map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                        ),
                      ),
                    )).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select Company.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    selectedGenderValue = value.toString();
                    setState(() {
                      authcontroller.selectedRegisterCompany.value =
                          selectedGenderValue!;
                    });
                    print(authcontroller.selectedRegisterCompany.value);
                    Get.toNamed(kSignUp);
                    // Get.toNamed(kSignUp);
                    // print(selectedGenderValue);
                  });

                  // authentication.registerDonorBloodController.value =
                  //     selectedValue as TextEditingValue;
                  //Do something when selected item is changed.
                },
                onSaved: (value) {
                  selectedGenderValue = value.toString();
                  print(selectedGenderValue);
                  setState(() {
                    authcontroller.selectedRegisterCompany.value =
                        selectedGenderValue!;
                  });
                  print(authcontroller.selectedRegisterCompany.value);
                  Get.toNamed(kSignUp);
                  // authentication.registerDonorBloodController.value =
                  //     selectedValue as TextEditingValue;
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: kblack.withOpacity(0.6),
                  ),
                  iconSize: 24,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            SizedBox(
              height: 120.h,
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(kSignIn);
                },
                child: RichText(
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: "Already have an account?  ",
                    style: GoogleFonts.roboto(
                      fontSize: kTwelveFont,
                      fontWeight: kFW500,
                      color: KText,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Sign In",
                        style: GoogleFonts.roboto(
                            fontSize: 15.sp, color: KText, fontWeight: kFW600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
