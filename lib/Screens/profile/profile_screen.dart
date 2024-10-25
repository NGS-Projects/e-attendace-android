import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:eattendance/untils/export_file.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
// ignore_for_file: camel_case_types, prefer_if_null_operators

import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profilecontroller = Get.put(ProfileController());
  @override
  void initState() {
    profilecontroller.getEAProfileTwo();
    profilecontroller.getEAProfileTwo();
    // TODO: implement initState
    super.initState();
  }

  bool showimagenullMessage = false;
  File? selectedImage;
  File? selectedResume;
  File? selectedLetter;
  File? selectedImagetwo;
  String base64Image = "";
  // bool isLoading = false;
  Map typesData = {};
  List<String> options = [];
  int choosenTypeData = 0;
  String choosenOption = "";
  String? selectedValue;
  String description = "";
  int? totalAmount;
  String? str;
  Future<void> chooseLetter(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 10);
    }
    if (image != null) {
      setState(() {
        selectedLetter = File(image.path);
        base64Image = base64Encode(selectedLetter!.readAsBytesSync());
        profilecontroller.uploadExperienceLetters(selectedLetter!); //
        print(selectedLetter!.readAsBytesSync().lengthInBytes);
        final kb = selectedLetter!.readAsBytesSync().lengthInBytes / 1024;
        print(kb);
        final mb = kb / 1024;
        print(mb);
        print("ram b jk dslnkv flk dlkcdslc k");
        showimagenullMessage = false;
      });
    }
  }

  Future<void> chooseresume(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 10);
    }
    if (image != null) {
      setState(() {
        selectedResume = File(image.path);
        base64Image = base64Encode(selectedResume!.readAsBytesSync());
        profilecontroller.uploadResume(selectedResume!); //
        print(selectedResume!.readAsBytesSync().lengthInBytes);
        final kb = selectedResume!.readAsBytesSync().lengthInBytes / 1024;
        print(kb);
        final mb = kb / 1024;
        print(mb);
        print("ram b jk dslnkv flk dlkcdslc k");
        showimagenullMessage = false;
      });
    }
  }

  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 10);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        profilecontroller.editProfilePicture(selectedImage!); //
        print(selectedImage!.readAsBytesSync().lengthInBytes);
        final kb = selectedImage!.readAsBytesSync().lengthInBytes / 1024;
        print(kb);
        final mb = kb / 1024;
        print(mb);
        print("ram b jk dslnkv flk dlkcdslc k");
        showimagenullMessage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kwhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: Kwhite,
          leadingWidth: 60.w,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 15.w,
                  ),
                  Icon(Icons.arrow_back_ios),
                ],
              )),
          title: Text(
            "Profile",
            style: GoogleFonts.roboto(
                fontSize: 18.sp, color: KdarkText, fontWeight: kFW600),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(kEditProfile);
              },
              child: Text(
                "Edit Profile     ",
                style: GoogleFonts.roboto(
                    fontSize: 14.sp, color: KdarkText, fontWeight: kFW600),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Obx(() => profilecontroller.profiledataLoading == true
              ? Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 100.h),
                  child: CircularProgressIndicator(
                    color: KOrange,
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(15.r),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: KOrange,
                            radius: 60.r,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Kwhite,
                                  radius: 58.r,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    backgroundColor: Kwhite,
                                    radius: 56.r,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(200.r),
                                      child: profilecontroller
                                                  .profileData["profilePic"] ==
                                              null
                                          ? selectedImage != null
                                              ? CircleAvatar(
                                                  backgroundColor: Kwhite,
                                                  radius: 56.r,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            200.r),
                                                    child: Image.file(
                                                      selectedImage!,
                                                      width: 120.w,
                                                      //   fit: BoxFit.cover,
                                                      fit: BoxFit.cover,
                                                      // height: 100.h,
                                                      // width: 100.w,
                                                      // fit: BoxFit.cover,
                                                    ),
                                                  ))
                                              : Image.asset(
                                                  "assets/images/profileImageStatic.png",
                                                  height: 100.h,
                                                  width: 100.w,
                                                  fit: BoxFit.cover,
                                                )
                                          : CircleAvatar(
                                              backgroundColor: Kwhite,
                                              radius: 56.r,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        200.r),
                                                child: CachedNetworkImage(
                                                  imageUrl: kBaseImageUrl +
                                                      profilecontroller
                                                              .profileData[
                                                          "profilePic"],
                                                  // authentication
                                                  //     .profileData["profile"],
                                                  placeholder: (context, url) =>
                                                      SizedBox(
                                                    height: 100.h,
                                                    width: 100.w,
                                                    child: Shimmer.fromColors(
                                                      baseColor: Colors.black12,
                                                      highlightColor: Colors
                                                          .white
                                                          .withOpacity(0.5),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Kwhite
                                                              .withOpacity(0.5),
                                                        ),
                                                        height: 100.h,
                                                        width: 100.w,
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          CircleAvatar(
                                                    backgroundColor: Kwhite,
                                                    radius: 56.r,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200.r),
                                                      child: Image.asset(
                                                        "assets/images/profileImageStatic.png",
                                                        // height: 150.h,
                                                        width: 120.w,
                                                        //   fit: BoxFit.cover,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  // height: 100.h,
                                                  width: 120.w,
                                                  //   fit: BoxFit.cover,
                                                  fit: BoxFit.cover,
                                                ),
                                                // Image.asset(
                                                //   "assets/images/profileImageStatic.png",
                                                //   // height: 150.h,
                                                //   height: 100.h,
                                                //   width: 100.w,
                                                //   fit: BoxFit.cover,
                                                // ),
                                              ),
                                            ),
                                    )),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 4.h,
                            right: 4.w,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                    ),
                                    backgroundColor: Kbackground,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Kbackground,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          height: 100.h,
                                          padding: EdgeInsets.only(top: 20.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  chooseImage("Gallery");
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.image_outlined,
                                                      color: KOrange,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text('Gallery',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    kFW700,
                                                                color:
                                                                    KdarkText)),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  chooseImage("camera");
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: KOrange,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text('camera',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    kFW700,
                                                                color:
                                                                    KdarkText)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Image.asset(
                                "assets/images/edit.png",
                                color: KOrange,
                                height: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "${profilecontroller.profileData["firstName"]} ${profilecontroller.profileData["lastName"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: kFW700,
                            color: KdarkText),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              " ${profilecontroller.profileData["role"]}  |  ",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: kFW400,
                              color: KlightText
                              //  Klightblack.withOpacity(0.8)
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  profilecontroller.profileData["empId"] ?? "",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: kFW900,
                                  color: KOrange),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),

                      Container(
                          margin: EdgeInsets.all(5.r),
                          padding: EdgeInsets.all(10.r),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.r),
                            color: Kwhite,
                            boxShadow: [
                              BoxShadow(
                                color: Ktextcolor.withOpacity(0.15),
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                                spreadRadius: 4,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "About",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: kFW700,
                                    color: KdarkText),
                              ),

                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                profilecontroller.profileData["about"] ?? "",
                                maxLines: 8,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    height: 1.1.h,
                                    fontSize: 11.sp,
                                    fontWeight: kFW500,
                                    color: KlightText),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "Personal Details",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: kFW700,
                                    color: KdarkText),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: kFW700,
                                            color: KOrange.withOpacity(0.7)),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        profilecontroller
                                                .profileData["gender"] ??
                                            "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: kFW700,
                                            color: KdarkText),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        "Date of Joining",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: kFW700,
                                            color: KOrange.withOpacity(0.7)),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        profilecontroller
                                                .profileData["dateOfJoining"] ??
                                            "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: kFW700,
                                            color: KdarkText),
                                      ),
                                    ],
                                  ),
                                  SizedBox(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date of Birth",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: kFW700,
                                            color: KOrange.withOpacity(0.7)),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      SizedBox(
                                        width: 100.w,
                                        child: Text(
                                          profilecontroller
                                                  .profileData["dateOfBirth"] ??
                                              "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: kFW700,
                                              color: KdarkText),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        "Mobile No:",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: kFW700,
                                            color: KOrange.withOpacity(0.7)),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        profilecontroller
                                                .profileData["mobile"] ??
                                            "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: kFW700,
                                            color: KdarkText),
                                      ),
                                    ],
                                  ),
                                  SizedBox()
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Address:",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: kFW700,
                                        color: KOrange.withOpacity(0.7)),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on),
                                      SizedBox(
                                        width: 250.w,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            profilecontroller
                                                    .profileData["address"] ??
                                                "",
                                            maxLines: 10,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: kFW700,
                                                color: KdarkText),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //////////////////////Role

                              ///////////////
                              ///////Mangers Tream
                              SizedBox(
                                height: 15.h,
                              ),

                              // Text(
                              //   "Interests",
                              //   style: TextStyle(
                              //       fontSize: 15.sp,
                              //       fontWeight: kFW700,
                              //       color: KdarkText),
                              // ),
                              // Container(
                              //   alignment: Alignment.center,
                              //   //height: MediaQuery.of(context).size.height * 0.0,
                              //   child: Wrap(
                              //       children: interests
                              //           .map((interest) => Container(
                              //                 margin: EdgeInsets.only(
                              //                     right: 10.w, top: 10.h),
                              //                 decoration: BoxDecoration(
                              //                     borderRadius:
                              //                         BorderRadius.circular(12.r),
                              //                     border: Border.all(
                              //                         color:
                              //                             Kgreen.withOpacity(0.2))),
                              //                 padding: EdgeInsets.symmetric(
                              //                     horizontal: MediaQuery.of(context)
                              //                             .size
                              //                             .width *
                              //                         0.040,
                              //                     vertical: MediaQuery.of(context)
                              //                             .size
                              //                             .height *
                              //                         0.0035),
                              //                 child: Text(interest,
                              //                     style: TextStyle(
                              //                         fontSize: 11.5.sp,
                              //                         fontWeight: kFW600,
                              //                         color: Klightblack.withOpacity(
                              //                             0.9))),
                              //               ))
                              //           .toList()),
                              // ),
                            ],
                          )),

                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Ktextcolor.withOpacity(0.3),
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: selectedResume != null
                              ? Image.file(
                                  selectedResume!,
                                  fit: BoxFit.cover,
                                  height: 130.h,
                                  width: double.infinity,
                                )
                              : profilecontroller.profileData["resume"] != null
                                  ? CachedNetworkImage(
                                      imageUrl: kBaseImageUrl +
                                          profilecontroller
                                              .profileData["resume"],
                                      // authentication
                                      //     .profileData["profile"],
                                      placeholder: (context, url) => SizedBox(
                                        height: 100.h,
                                        width: 100.w,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.black12,
                                          highlightColor:
                                              Colors.white.withOpacity(0.5),
                                          child: Container(
                                            height: 130.h,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(child: Text("No Imagedata")),
                                      // height: 100.h,
                                      fit: BoxFit.cover,
                                      height: 130.h,
                                      width: double.infinity,
                                    )
                                  : Text("")),
                      SizedBox(
                        height: 5.h,
                      ),
                      // data.leavetype != "Sick Leave"
                      //     ? SizedBox()
                      //     :
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                              ),
                              backgroundColor: Kbackground,
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Kbackground,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    height: 100.h,
                                    padding: EdgeInsets.only(top: 20.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            chooseresume("Gallery");
                                            Navigator.pop(context);
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.image_outlined,
                                                color: KOrange,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text('Gallery',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: kFW700,
                                                      color: KdarkText)),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            chooseresume("camera");
                                            Navigator.pop(context);
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                color: KOrange,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text('camera',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: kFW700,
                                                      color: KdarkText)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: DottedBorder(
                            dashPattern: [8, 2],
                            strokeWidth: 1,
                            color: KOrange,
                            child: Container(
                              height: 35.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.r),
                                color: Kwhite,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Upload Resume",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: KOrange,
                                        fontWeight: kFW600),
                                  )
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Ktextcolor.withOpacity(0.3),
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: selectedLetter != null
                              ? Image.file(
                                  selectedLetter!,
                                  fit: BoxFit.cover,
                                  height: 130.h,
                                  width: double.infinity,
                                )
                              : profilecontroller.profileData[
                                              "experinceLetters"] ==
                                          null ||
                                      profilecontroller
                                              .profileData["experinceLetters"]
                                              .length ==
                                          0
                                  ? const Text(
                                      "",
                                      textAlign: TextAlign.center,
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: profilecontroller
                                          .profileData["experinceLetters"]
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsetsDirectional.only(
                                              top: 10, bottom: 10.h),
                                          child: CachedNetworkImage(
                                            imageUrl: kBaseImageUrl +
                                                profilecontroller.profileData[
                                                    "experinceLetters"][index],
                                            // profilecontroller
                                            //     .profileData["resume"],
                                            // authentication
                                            //     .profileData["profile"],
                                            placeholder: (context, url) =>
                                                SizedBox(
                                              height: 100.h,
                                              width: 100.w,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white
                                                    .withOpacity(0.5),
                                                child: Container(
                                                  height: 130.h,
                                                  width: double.infinity,
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) => Center(
                                                    child:
                                                        Text("No Imagedata")),
                                            // height: 100.h,
                                            fit: BoxFit.cover,
                                            height: 130.h,
                                            width: double.infinity,
                                          ),
                                        );
                                      })),
                      SizedBox(
                        height: 5.h,
                      ),
                      // data.leavetype != "Sick Leave"
                      //     ? SizedBox()
                      //     :
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                              ),
                              backgroundColor: Kbackground,
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Kbackground,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    height: 100.h,
                                    padding: EdgeInsets.only(top: 20.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            chooseLetter("Gallery");
                                            Navigator.pop(context);
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.image_outlined,
                                                color: KOrange,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text('Gallery',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: kFW700,
                                                      color: KdarkText)),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            chooseLetter("camera");
                                            Navigator.pop(context);
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                color: KOrange,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text('camera',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: kFW700,
                                                      color: KdarkText)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: DottedBorder(
                            dashPattern: [8, 2],
                            strokeWidth: 1,
                            color: KOrange,
                            child: Container(
                              height: 35.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.r),
                                color: Kwhite,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Upload Experience",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: KOrange,
                                        fontWeight: kFW600),
                                  )
                                ],
                              ),
                            )),
                      ),
                      // CustomButton(
                      //   margin: EdgeInsets.only(top: 50.h),
                      //   borderRadius: BorderRadius.circular(10.r),
                      //   Color: KOrange,
                      //   textColor: Kwhite,
                      //   height: 42.h,
                      //   width: double.infinity,
                      //   label: "Log Out",
                      //   fontSize: kSixteenFont,
                      //   fontWeight: kFW500,
                      //   isLoading: false,
                      //   onTap: () {
                      //     showDialog(
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           return AlertDialog(
                      //             title: Text('Are You Sure',
                      //                 maxLines: 1,
                      //                 overflow: TextOverflow.ellipsis,
                      //                 style: GoogleFonts.roboto(
                      //                     fontSize: 12.sp,
                      //                     fontWeight: kFW700,
                      //                     color: KdarkText)),
                      //             content: Text('You Want To LogOut ?',
                      //                 maxLines: 2,
                      //                 overflow: TextOverflow.ellipsis,
                      //                 style: GoogleFonts.roboto(
                      //                     fontSize: 12.sp,
                      //                     fontWeight: kFW700,
                      //                     color: KdarkText.withOpacity(0.7))),
                      //             actions: [
                      //               TextButton(
                      //                 onPressed: () {
                      //                   Get.back();
                      //                 },
                      //                 child: Text('No',
                      //                     maxLines: 1,
                      //                     overflow: TextOverflow.ellipsis,
                      //                     style: GoogleFonts.roboto(
                      //                         fontSize: 12.sp,
                      //                         fontWeight: kFW700,
                      //                         color: KdarkText)),
                      //               ),
                      //               TextButton(
                      //                 // textColor: Color(0xFF6200EE),
                      //                 onPressed: () async {
                      //                   ///
                      //                   /// Delete the database at the given path.
                      //                   ///
                      //                   // Future<void> deleteDatabase(String path) =>
                      //                   //     _databaseHelper.database;

                      //                   UserSimplePreferences.clearAllData();
                      //                   Get.toNamed(kSignIn);
                      //                 },
                      //                 child: Text('Yes',
                      //                     maxLines: 1,
                      //                     overflow: TextOverflow.ellipsis,
                      //                     style: GoogleFonts.roboto(
                      //                         fontSize: 12.sp,
                      //                         fontWeight: kFW700,
                      //                         color: KdarkText)),
                      //               )
                      //             ],
                      //           );

                      //           // timercontroller.stopTimer();
                      //           // UserSimplePreferences.clearAllData();
                      //           // Get.toNamed(kSelectType);
                      //         });
                      //   },
                      // ),

                      SizedBox(
                        height: 100.h,
                      ),
                      // Row(
                      //   mainAxisAlignment:
                      //       MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "Show Location",
                      //       style: TextStyle(
                      //           fontSize: 13.sp,
                      //           fontWeight: kFW900,
                      //           color: selectedTheme == "Lighttheme"
                      //               ? KdarkText
                      //               : Kwhite),
                      //     ),
                      //     Switch(
                      //       onChanged: toggleSwitch,
                      //       value: UserSimplePreferences
                      //               .getMapShowStatic() ??
                      //           true,
                      //       activeColor: KOrange,
                      //       activeTrackColor: KOrange.withOpacity(0.7),
                      //       inactiveThumbColor: Klightgray,
                      //       inactiveTrackColor:
                      //           Klightgray.withOpacity(0.5),
                      //     )
                      //   ],
                      // ),
                    ],
                  ))),
        ));
  }
}
