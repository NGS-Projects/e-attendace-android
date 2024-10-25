import 'package:flutter/material.dart';

import 'package:eattendance/untils/export_file.dart';
import 'package:shimmer/shimmer.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  ProfileController profilecontroller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      appBar: CustomAppBar(
        dontHaveBackAsLeading: true,
        title: "Menu",
      ),
      body: SingleChildScrollView(
          child: Obx(
        () => Container(
          margin: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profilecontroller.profileData["profilePic"] == null
                  ? InkWell(
                      onTap: () {
                        Get.toNamed(kProfileScreen);
                      },
                      child: CircleAvatar(
                        backgroundColor: Kwhite,
                        radius: 50.r,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200.r),
                          child: Image.asset(
                            "assets/images/profileImageStatic.png",
                            // height: 150.h,
                            height: 100.h,
                            width: 100.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Get.toNamed(kProfileScreen);
                      },
                      child: CircleAvatar(
                        backgroundColor: Kwhite,
                        radius: 50.r,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200.r),
                          child: CachedNetworkImage(
                            imageUrl: kBaseImageUrl +
                                profilecontroller.profileData["profilePic"],
                            placeholder: (context, url) => SizedBox(
                              height: 100.h,
                              width: 100.w,
                              child: Shimmer.fromColors(
                                baseColor: Colors.black12,
                                highlightColor: Colors.white.withOpacity(0.5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Kwhite.withOpacity(0.5),
                                  ),
                                  height: 100.h,
                                  width: 100.w,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => CircleAvatar(
                              backgroundColor: Kwhite,
                              radius: 50.r,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200.r),
                                child: Image.asset(
                                  "assets/images/profileImageStatic.png",
                                  // height: 150.h,
                                  height: 100.h,
                                  width: 100.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            height: 100.h,
                            width: 100.w,
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
                    ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "${profilecontroller.profileData["firstName"]} ${profilecontroller.profileData["lastName"]}",
                // apiController.profileData["employeeType"] == "Blood Needed"
                //     ? "Welcome " +
                //             apiController.profileData["attendeeFirstName"]
                //                 .toString()
                //                 .capitalizeFirst! ??
                //         "No name"
                //     : "Welcome " +
                //             apiController.profileData["firstName"]
                //                 .toString()
                //                 .capitalizeFirst! +
                //             " " +
                //             apiController.profileData["lastName"]
                //                 .toString()
                //                 .capitalizeFirst! ??
                //         "No name",
                // apiController.storedloginsData["firstName"] ??
                //     "No name" + apiController.storedloginsData["lastName"] ??
                //     "",
                // "Ram Nayak",
                style: GoogleFonts.roboto(
                    fontSize: 20.sp, color: KdarkText, fontWeight: kFW500),
              ),

              SizedBox(height: 20.h),
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed(kAddRating);
              //   },
              //   child: Container(
              //     // margin: EdgeInsets.only(top: 10.h),
              //     decoration: BoxDecoration(
              //         color: Kwhite,
              //         boxShadow: [
              //           BoxShadow(
              //             color: Ktextcolor.withOpacity(0.2),
              //             blurRadius: 5,
              //             offset: const Offset(0, 0),
              //             spreadRadius: 2,
              //           )
              //         ],
              //         borderRadius: BorderRadius.circular(10.r)),
              //     //margin: EdgeInsets.all(13.r),
              //     child: ListTile(
              //       title: Text(
              //         "Add Review",
              //         maxLines: 2,
              //         textAlign: TextAlign.left,
              //         overflow: TextOverflow.ellipsis,
              //         style: GoogleFonts.roboto(
              //             fontSize: 16.sp,
              //             fontWeight: kFW600,
              //             color: KdarkText),
              //       ),
              //       trailing: Image.asset(
              //         "assets/images/arrowCorner.png",
              //         height: 40.h,
              //         color: KOrangedred,
              //       ),
              //       // Image.asset(
              //       //   Actions[i]["Subimage"],
              //       //   height: 30.h,
              //       // ),
              //     ),
              //   ),
              // ),

              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Get.toNamed(kProfileScreen);
                },
                child: Container(
                  // margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                      color: Kwhite,
                      boxShadow: [
                        BoxShadow(
                          color: Ktextcolor.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 0),
                          spreadRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10.r)),
                  //margin: EdgeInsets.all(13.r),
                  child: ListTile(
                    title: Text(
                      "Profile",
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: kFW600,
                          color: KdarkText),
                    ),
                    trailing: Image.asset(
                      "assets/images/arrowCorner.png",
                      height: 40.h,
                      color: KOrange,
                    ),
                    // Image.asset(
                    //   Actions[i]["Subimage"],
                    //   height: 30.h,
                    // ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Get.toNamed(kPrivacyPolicy);
                },
                child: Container(
                  // margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                      color: Kwhite,
                      boxShadow: [
                        BoxShadow(
                          color: Ktextcolor.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 0),
                          spreadRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10.r)),
                  //margin: EdgeInsets.all(13.r),
                  child: ListTile(
                    title: Text(
                      "Privacy Policy",
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: kFW600,
                          color: KdarkText),
                    ),
                    trailing: Image.asset(
                      "assets/images/arrowCorner.png",
                      height: 40.h,
                      color: KOrange,
                    ),
                    // Image.asset(
                    //   Actions[i]["Subimage"],
                    //   height: 30.h,
                    // ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Get.toNamed(kTerms);
                },
                child: Container(
                  // margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                      color: Kwhite,
                      boxShadow: [
                        BoxShadow(
                          color: Ktextcolor.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 0),
                          spreadRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10.r)),
                  //margin: EdgeInsets.all(13.r),
                  child: ListTile(
                    title: Text(
                      "Terms and Conditions",
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: kFW600,
                          color: KdarkText),
                    ),
                    trailing: Image.asset(
                      "assets/images/arrowCorner.png",
                      height: 40.h,
                      color: KOrange,
                    ),
                    // Image.asset(
                    //   Actions[i]["Subimage"],
                    //   height: 30.h,
                    // ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              GestureDetector(
                onTap: () {
                  Get.toNamed(kHelpDesk);
                },
                child: Container(
                  // margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                      color: Kwhite,
                      boxShadow: [
                        BoxShadow(
                          color: Ktextcolor.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 0),
                          spreadRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10.r)),
                  //margin: EdgeInsets.all(13.r),
                  child: ListTile(
                    title: Text(
                      "Help Desk",
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: kFW600,
                          color: KdarkText),
                    ),
                    trailing: Image.asset(
                      "assets/images/arrowCorner.png",
                      height: 40.h,
                      color: KOrange,
                    ),
                    // Image.asset(
                    //   Actions[i]["Subimage"],
                    //   height: 30.h,
                    // ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Are You Sure',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: kFW700,
                                    color: KdarkText)),
                            content: Text('You Want To LogOut ?',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: kFW700,
                                    color: KdarkText.withOpacity(0.7))),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('No',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        fontWeight: kFW700,
                                        color: KdarkText)),
                              ),
                              TextButton(
                                // textColor: Color(0xFF6200EE),
                                onPressed: () async {
                                  ///
                                  /// Delete the database at the given path.
                                  ///
                                  // Future<void> deleteDatabase(String path) =>
                                  //     _databaseHelper.database;
                                  UserSimplePreferences.clearAllData();
                                  Get.offAllNamed(kSignIn);
                                },
                                child: Text('Yes',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        fontWeight: kFW700,
                                        color: KdarkText)),
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    // margin: EdgeInsets.only(top: 10.h),
                    decoration: BoxDecoration(
                        color: Kwhite,
                        boxShadow: [
                          BoxShadow(
                            color: Ktextcolor.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                            spreadRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10.r)),
                    //margin: EdgeInsets.all(13.r),
                    child: ListTile(
                      title: Text(
                        "Log out",
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: kFW600,
                            color: KOrange),
                      ),
                      trailing: Image.asset(
                        "assets/images/arrowCorner.png",
                        height: 40.h,
                        color: KOrange,
                      ),
                      // Image.asset(
                      //   Actions[i]["Subimage"],
                      //   height: 30.h,
                      // ),
                    ),
                  )),
              SizedBox(
                height: 80.h,
              )
            ],
          ),
        ),
      )),
    );
  }
}
