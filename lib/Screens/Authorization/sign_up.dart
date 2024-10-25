import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:eattendance/untils/export_file.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
  final List<String> bloodgroupss = ['Admin', 'Employee'];

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),

                    Text(
                      "Sign Up",
                      style: GoogleFonts.roboto(
                          fontSize: 30.sp, color: KOrange, fontWeight: kFW600),
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
                          "Create an account now to get started on your health and happiness journey.",
                          style: GoogleFonts.roboto(
                              fontSize: kSixteenFont,
                              color: KText,
                              fontWeight: kFW400),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),

                        CustomFormFields(
                          controller: authcontroller.EASignupFnameController,
                          enabled: true,
                          labelColor: KText,
                          obscureText: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          fontSize: kFourteenFont,
                          fontWeight: FontWeight.w500,
                          hintText: "Enter First Name",
                          maxLines: 1,
                          readOnly: false,
                          label: 'First Name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter First Name';
                            }
                            return null;
                          },
                        ),
                        ///////////
                        SizedBox(
                          height: 20.h,
                        ),

                        CustomFormFields(
                          controller: authcontroller.EASignupLnameController,
                          enabled: true,
                          labelColor: KText,
                          obscureText: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          fontSize: kFourteenFont,
                          fontWeight: FontWeight.w500,
                          hintText: "Enter Last Name",
                          maxLines: 1,
                          readOnly: false,
                          label: 'Last Name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Last Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        /////

                        CustomFormFields(
                          controller: authcontroller.EASignupEmailController,
                          enabled: true,
                          labelColor: KText,
                          obscureText: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          fontSize: kFourteenFont,
                          fontWeight: FontWeight.w500,
                          hintText: "Enter Enter Email",
                          maxLines: 1,
                          readOnly: false,
                          label: 'Enter Email',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomFormFields(
                          controller: authcontroller.EASignupEmpIDController,
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

                        CustomFormFields(
                          controller: authcontroller.EASignuppasswordController,
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
                          hintText: "Password",
                          maxLines: 1,
                          readOnly: false,
                          label: 'Enter Password',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                        ),
                        //

                        SizedBox(
                          height: 20.h,
                        ),

                        CustomFormFields(
                          hintColor: DateFormat.yMMMd().format(selectedDate) ==
                                  DateFormat.yMMMd().format(DateTime.now())
                              ? KTextgery.withOpacity(0.5)
                              : KdarkText,
                          labelColor: KText,
                          suffix: InkWell(
                              onTap: () async {
                                // setState(() {
                                //   isFormOpen.value = true;
                                // });
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(1924, 8),
                                  //  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          // background: white,
                                          primary: KOrange,
                                          //onPrimary: white,
                                          onSurface: Colors.black,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                              // primary: Kbluedark,
                                              ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (picked != null && picked != selectedDate) {
                                  // if (picked.isAfter(DateTime.now())) {
                                  //   // date.isAfter(DateTime.now()
                                  //   //  if(date.month>DateTime.now().month){
                                  //   Fluttertoast.showToast(
                                  //       msg: "Upcomming Months can't be selected");
                                  // } else {
                                  setState(() {
                                    selectedDate = picked;
                                    choosenDate = selectedDate;
                                    selectDate.value = DateFormat('MM/dd/yyyy')
                                        // DateFormat.yMMMEd()
                                        .format(selectedDate);
                                  });
                                  //  }
                                  // setState(() {
                                  //   selectedDate = picked;
                                  //   choosenDate = selectedDate;
                                  // }
                                  // );
                                }
                              },
                              child: Icon(
                                Icons.calendar_today,
                                color: kblack.withOpacity(0.6),
                              )),
                          enabled: true,

                          obscureText: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          // fontSize: kFourteenFont,
                          // fontWeight: FontWeight.w500,
                          fontSize: kFourteenFont,
                          fontWeight: FontWeight.w500,
                          textColor: KdarkText,
                          keyboardType: TextInputType.none,
                          textStyle: GoogleFonts.roboto(color: kblack),
                          maxLines: 1,

                          hintText:
                              // selectedDate == DateTime.now()
                              DateFormat.yMMMd().format(selectedDate) ==
                                      DateFormat.yMMMd().format(DateTime.now())
                                  ? "Select Date"
                                  : DateFormat('dd/MM/yyyy')
                                      // DateFormat.yMMMEd()
                                      .format(selectedDate)
                          // DateFormat.yMMMEd().format(selectedDate)
                          ,
                          readOnly: false,
                          onChanged: (value) {},
                          label: 'Date of Birth',
                          // hintText: "Full Name",
                          // maxLines: 1,
                          // readOnly: false,
                          // label: 'Full Name',
                          validator: (value) {
                            if (DateFormat.yMMMd().format(selectedDate) ==
                                DateFormat.yMMMd().format(DateTime.now())) {
                              return 'Please select Date of Birth';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 20.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Select Role",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                //  letterSpacing: 1,
                                color: KText,
                                fontWeight: FontWeight.w500),
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
                          child: DropdownButtonFormField2<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kblack.withOpacity(0.6), width: 0.5),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kblack.withOpacity(0.6), width: 0.5),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kblack.withOpacity(0.6), width: 0.5),
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
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            hint: Text(
                              'Select Role',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: KTextgery.withOpacity(0.5),
                              ),
                            ),
                            items: bloodgroupss
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select Role';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                                print(selectedValue);
                              });

                              // authentication.registerDonorBloodController.value =
                              //     selectedValue as TextEditingValue;
                              //Do something when selected item is changed.
                            },
                            onSaved: (value) {
                              selectedValue = value.toString();
                              print(selectedValue);
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
                          height: 20.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Gender",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                //  letterSpacing: 1,
                                color: KText,
                                fontWeight: FontWeight.w500),
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
                          child: DropdownButtonFormField2<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kblack.withOpacity(0.6), width: 0.5),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kblack.withOpacity(0.6), width: 0.5),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kblack.withOpacity(0.6), width: 0.5),
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
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            hint: Text(
                              'Select Gender',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: KTextgery.withOpacity(0.5),
                              ),
                            ),
                            items:
                                Genders.map((item) => DropdownMenuItem<String>(
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
                                return 'Please select Gender.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedGenderValue = value.toString();
                                print(selectedGenderValue);
                              });

                              // authentication.registerDonorBloodController.value =
                              //     selectedValue as TextEditingValue;
                              //Do something when selected item is changed.
                            },
                            onSaved: (value) {
                              selectedGenderValue = value.toString();
                              print(selectedGenderValue);
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
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              activeColor: KOrange,
                              checkColor: Kwhite,
                              value: value,
                              onChanged: (value) {
                                setState(() {
                                  this.value = value!;
                                });
                                print(value);
                              },
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Accept Terms and conditions",
                                style: GoogleFonts.roboto(
                                    fontSize: kTwelveFont.sp,
                                    color: KdarkText,
                                    fontWeight: kFW500),
                              ),
                            ),
                          ],
                        ),

                        CustomButton(
                            margin: EdgeInsets.only(top: 50.h),
                            borderRadius: BorderRadius.circular(10.r),
                            Color: KOrange,
                            textColor: Kwhite,
                            height: 42.h,
                            width: double.infinity,
                            label: "Sign Up",
                            fontSize: kSixteenFont,
                            fontWeight: kFW500,
                            isLoading: false,
                            onTap: () {
                              setState(
                                () {
                                  authcontroller
                                      .registerAutenticationBody.value = {
                                    /////////////////////////////////////////////////

                                    "email": authcontroller
                                        .EASignupEmailController.text,
                                    "password": authcontroller
                                        .EASignuppasswordController.text,
                                    "firstName": authcontroller
                                        .EASignupFnameController.text,
                                    "lastName": authcontroller
                                        .EASignupLnameController.text,
                                    "empId": authcontroller
                                        .EASignupEmpIDController.text,
                                    "dateOfBirth": selectDate.value,
                                    "role": selectedValue,
                                    "gender": selectedGenderValue,
                                    "companyName": authcontroller
                                        .selectedRegisterCompany.value,
                                    "termsAndCondition": "${value}",

                                    ///

                                    //////////////////////////////
                                  };
                                },
                              );
                              if (_formKey.currentState!.validate()) {
                                Get.toNamed(kBiometricRegistration);
                              }
                            }),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
