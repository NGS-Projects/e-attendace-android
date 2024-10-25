// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eattendance/untils/export_file.dart';

import 'package:intl/intl.dart';
//import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController dOBController = TextEditingController();
  ProfileController profilecontroller = Get.put(ProfileController());
  DateTime selectedDOB = DateTime.now();
  DateTime selectedDOJ = DateTime.now();

  @override
  void initState() {
    setState(() {
      // startTime = apiController.profileData["startTime"];
      // closeTime = apiController.profileData["endTime"];
      profilecontroller.EAeditaboutController.text =
          profilecontroller.profileData["about"] ?? "";
      profilecontroller.EAEditMobileontroller.text =
          profilecontroller.profileData["mobile"] ?? "";
      if (profilecontroller.profileData["dateOfBirth"] != null) {
        selectedDOB = DateFormat('dd/MM/yyyy')
            .parse(profilecontroller.profileData["dateOfBirth"]);
      }

      if (profilecontroller.profileData["dateOfJoining"] != null) {
        selectedDOJ = DateFormat('dd/MM/yyyy')
            .parse(profilecontroller.profileData["dateOfJoining"]);
      }
      // if (profilecontroller.profileData["dateOfBirth"] == null) {
      // } else {
      //   selectedDOB = DateFormat('MM-dd-yyyy')
      //       .parse(profilecontroller.profileData["dateOfBirth"]);
      // }
      // ;
      // if (profilecontroller.profileData["dateOfJoining"] == null) {
      // } else {
      //   selectedDOJ = DateFormat('MM-dd-yyyy')
      //       .parse(profilecontroller.profileData["dateOfJoining"]);
      // }
      profilecontroller.EAeditaddressController.text =
          profilecontroller.profileData["address"] ?? "";
      // DateFormat.yMMMEd()

      //  selectedDOJ = DateTime(profilecontroller.profileData["dateOfJoining"]);
      // DateFormat('dd/MM/yyyy')
      //     // DateFormat.yMMMEd()
      //     .format(profilecontroller.profileData["dateOfJoining"]) as DateTime;
      // profilecontroller.profileData["dateOfJoining"] ?? "";
      // authentication.editBloodBankEmailController.text =
      //     apiController.profileData["email"] ?? "No Mail";
      // authentication.editBloodBanklocationsController.text =
      //     apiController.profileData["address"] ?? "No Location";
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      appBar: CustomAppBar(
        dontHaveBackAsLeading: false,
        title: "Edit Profile",
      ),
      // appBar: AppBar(
      //   backgroundColor: Kwhite,
      //   leading: GestureDetector(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: KTextdark,
      //     ),
      //   ),
      //   titleSpacing: 0,
      //   title: Text(
      //     "Edit Profile",
      //     style: GoogleFonts.roboto(
      //         fontSize: 22.sp, color: KdarkText, fontWeight: kFW600),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomFormFields(
                controller: profilecontroller.EAeditaboutController,
                ontap: () {
                  //  Get.toNamed(kSearchPlaces);
                },
                enabled: true,
                labelColor: KText,
                obscureText: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                fontSize: kFourteenFont,
                fontWeight: FontWeight.w500,
                hintText: "About",
                maxLines: 1,
                readOnly: false,
                label: 'Enter About',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter About';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),

              CustomFormFields(
                keyboardType: TextInputType.phone,
                controller: profilecontroller.EAEditMobileontroller,
                ontap: () {
                  //  Get.toNamed(kSearchPlaces);
                },
                enabled: true,
                labelColor: KText,
                obscureText: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                fontSize: kFourteenFont,
                fontWeight: FontWeight.w500,
                hintText: "Mobile Number",
                maxLines: 1,
                readOnly: false,
                label: 'Enter Mobile Number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Mobile Number';
                  }
                  return null;
                },
              ),
              //

              SizedBox(
                height: 20.h,
              ),

              CustomFormFields(
                hintColor: DateFormat.yMMMd().format(selectedDOB) ==
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
                        initialDate: selectedDOB,
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

                      if (picked != null && picked != selectedDOB) {
                        // if (picked.isAfter(DateTime.now())) {
                        //   // date.isAfter(DateTime.now()
                        //   //  if(date.month>DateTime.now().month){
                        //   Fluttertoast.showToast(
                        //       msg: "Upcomming Months can't be selected");
                        // } else {
                        setState(() {
                          selectedDOB = picked;
                          //  choosenDate = selectedDate;
                          // selectedDOB = DateFormat('MM/dd/yyyy')
                          //     // DateFormat.yMMMEd()
                          //     .format(selectedDOB) as DateTime;
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
                    DateFormat.yMMMd().format(selectedDOB) ==
                            DateFormat.yMMMd().format(DateTime.now())
                        ? "Select Date"
                        : DateFormat('dd/MM/yyyy')
                            // DateFormat.yMMMEd()
                            .format(selectedDOB)
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
                  if (DateFormat.yMMMd().format(selectedDOB) ==
                      DateFormat.yMMMd().format(DateTime.now())) {
                    return 'Please select Date of Birth';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),

              CustomFormFields(
                hintColor: DateFormat.yMMMd().format(selectedDOJ) ==
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
                        initialDate: selectedDOJ,
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

                      if (picked != null && picked != selectedDOJ) {
                        // if (picked.isAfter(DateTime.now())) {
                        //   // date.isAfter(DateTime.now()
                        //   //  if(date.month>DateTime.now().month){
                        //   Fluttertoast.showToast(
                        //       msg: "Upcomming Months can't be selected");
                        // } else {
                        setState(() {
                          selectedDOJ = picked;
                          //  choosenDate = selectedDate;
                          // selectedDOB = DateFormat('MM/dd/yyyy')
                          //     // DateFormat.yMMMEd()
                          //     .format(selectedDOB) as DateTime;
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
                    DateFormat.yMMMd().format(selectedDOJ) ==
                            DateFormat.yMMMd().format(DateTime.now())
                        ? "Select Date"
                        : DateFormat('dd/MM/yyyy')
                            // DateFormat.yMMMEd()
                            .format(selectedDOJ)
                // DateFormat.yMMMEd().format(selectedDate)
                ,
                readOnly: false,
                onChanged: (value) {},
                label: 'Date of Joining',
                // hintText: "Full Name",
                // maxLines: 1,
                // readOnly: false,
                // label: 'Full Name',
                validator: (value) {
                  if (DateFormat.yMMMd().format(selectedDOJ) ==
                      DateFormat.yMMMd().format(DateTime.now())) {
                    return 'Please select Date of Joining';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomFormFields(
                controller: profilecontroller.EAeditaddressController,
                // controller: authcontroller.EASignupEmpIDController,
                ontap: () {
                  //  Get.toNamed(kSearchPlaces);
                },
                enabled: true,
                labelColor: KText,
                obscureText: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                fontSize: kFourteenFont,
                fontWeight: FontWeight.w500,
                hintText: "Address",
                maxLines: 1,
                readOnly: false,
                label: 'Enter Address',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Address';
                  }
                  return null;
                },
              ),
              CustomButton(
                  margin: EdgeInsets.only(top: 50.h),
                  borderRadius: BorderRadius.circular(10.r),
                  Color: KOrange,
                  textColor: Kwhite,
                  height: 42.h,
                  width: double.infinity,
                  label: "Update",
                  fontSize: kSixteenFont,
                  fontWeight: kFW500,
                  isLoading: false,
                  onTap: () {
                    var payload = {
                      "about": profilecontroller.EAeditaboutController.text,
                      "dateOfBirth": DateFormat('dd/MM/yyyy')
                          // DateFormat.yMMMEd()
                          .format(selectedDOB),
                      "dateOfJoining": DateFormat('dd/MM/yyyy')
                          // DateFormat.yMMMEd()
                          .format(selectedDOJ),
                      "mobile": profilecontroller.EAEditMobileontroller.text,
                      "address": profilecontroller.EAeditaddressController.text
                      // "Name": apicontroller.editfirstNameController.text,
                      // "lastName": authentication
                      //     .editDonorLastNameController.text,
                      // "email": authentication
                      //     .editBloodBankEmailController.text,
                      // "address": authentication
                      //     .editBloodBanklocationsController.text,
                      // "bloodGroup": authentication
                      //     .donorRegisterBloodGroup.value,
                      // "gender":
                      //     authentication.donorRegisterGender.value,
                      // "dateOfBirth": selectDate.value,
                    };

                    profilecontroller.eaeditProfileForm(payload);
                    // var payload = {
                    //   "firstName": authentication
                    //       .editDonorfirstNameController.text,
                    //   "lastName": authentication
                    //       .editDonorLastNameController.text

                    // };
                    // if (_formKey.currentState!.validate()) {
                    //   authentication.donorEditProfile(
                    //       payload, selectedImage!);
                    // }
                  }

                  // Fluttertoast.showToast(
                  //   msg: "Registered Successfully",
                  // );

                  ),

              // Obx(() => authentication.editFormLoading == true
              //     ? Center(
              //         child: CircularProgressIndicator(
              //           color: Kpink,
              //         ),
              //       )
              //     : authentication.profileData["employeeType"] == "Donor"
              //         ? CustomButton(
              //             borderRadius: BorderRadius.circular(10.r),
              //             Color: Kpink,
              //             textColor: Kwhite,
              //             height: 42.h,
              //             width: double.infinity,
              //             label: "Update",
              //             fontSize: kSixteenFont,
              //             fontWeight: kFW500,
              //             isLoading: false,
              //             onTap: () {
              //               var payload = {
              //                 "firstName": authentication
              //                     .editDonorfirstNameController.text,
              //                 "lastName": authentication
              //                     .editDonorLastNameController.text,
              //                 "email": authentication
              //                     .editBloodBankEmailController.text,
              //                 "address": authentication
              //                     .editBloodBanklocationsController.text,
              //                 "bloodGroup": authentication
              //                     .donorRegisterBloodGroup.value,
              //                 "gender":
              //                     authentication.donorRegisterGender.value,
              //                 "dateOfBirth": selectDate.value,
              //                 //////////////////////
              //                 // "bloodBankName": authentication
              //                 //     .editBloodBankNameController.text,
              //                 // "email": authentication
              //                 //     .editBloodBankEmailController.text,
              //                 // "address": authentication
              //                 //     .editBloodBanklocationsController.text,
              //                 // "startTime": startTime,
              //                 // "endTime": closeTime,
              //               };

              //               authentication.editProfileForm(payload);
              //               // var payload = {
              //               //   "firstName": authentication
              //               //       .editDonorfirstNameController.text,
              //               //   "lastName": authentication
              //               //       .editDonorLastNameController.text

              //               // };
              //               // if (_formKey.currentState!.validate()) {
              //               //   authentication.donorEditProfile(
              //               //       payload, selectedImage!);
              //               // }
              //             }

              //             // Fluttertoast.showToast(
              //             //   msg: "Registered Successfully",
              //             // );

              //             )
              //         : CustomButton(
              //             borderRadius: BorderRadius.circular(10.r),
              //             Color: Kpink,
              //             textColor: Kwhite,
              //             height: 42.h,
              //             width: double.infinity,
              //             label: "Update",
              //             fontSize: kSixteenFont,
              //             fontWeight: kFW500,
              //             isLoading: false,
              //             onTap: () {
              //               var payload = {
              //                 "bloodBankName": authentication
              //                     .editBloodBankNameController.text,
              //                 "email": authentication
              //                     .editBloodBankEmailController.text,
              //                 "address": authentication
              //                     .editBloodBanklocationsController.text,
              //                 // Latest Comments
              //                 // "startTime": startTime,
              //                 // "endTime": closeTime,
              //                 // "firstName": authentication
              //                 //     .registerDonorfirstNameController.text,
              //                 //"Ram Nayak",

              //                 //16.5196953
              //               };

              //               authentication.editProfileForm(payload);
              //               // authentication.donorEditProfileBank(
              //               //     payload, selectedImage!);

              //               // "phone": authentication.loginMobileController.text,
              //               //  "8297297247"
              //             }

              //             // Fluttertoast.showToast(
              //             //   msg: "Registered Successfully",
              //             // );

              //             )),

              // CustomButton(
              //   //margin: EdgeInsets.all(10.r),
              //   borderRadius: BorderRadius.circular(10.r),
              //   Color: Kpink,
              //   textColor: Kwhite,
              //   height: 42.h,
              //   width: double.infinity,
              //   label: "Update Profile",
              //   fontSize: kSixteenFont,
              //   fontWeight: kFW500,
              //   isLoading: false,
              //   onTap: () async {
              //     Fluttertoast.showToast(
              //       msg: "Registered Successfully",
              //     );
              //     Get.back();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
