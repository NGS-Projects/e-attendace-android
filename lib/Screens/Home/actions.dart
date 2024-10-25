import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:eattendance/untils/export_file.dart';

class ActionsCards extends StatefulWidget {
  const ActionsCards({super.key});

  @override
  State<ActionsCards> createState() => _ActionsCardsState();
}

class _ActionsCardsState extends State<ActionsCards> {
  ProfileController profilecontroller = Get.put(ProfileController());
  List Categories = [
    {
      "name": "Qucik Approvals",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/attendance1.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      // "Subimage": "assets/images/attendance1.png",
      "Containercolor": Colors.orange.withOpacity(0.7),
      //"color": KPurple,
      "route": kApproveScreen,
    },
    {
      "name": "Apply Leaves",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/leaves.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      //  "Subimage": "assets/images/arrow.svg",
      "Containercolor": Colors.purple.withOpacity(0.7),
      // "color": KOrange,
      "route": kApplyLeaveScreen,
    },
    {
      "name": "Employees",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/claims1.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      //  "Subimage": "assets/images/arrow.svg",
      "Containercolor": Colors.deepPurple.withOpacity(0.8),
      // // "color": Kgreen,
      "route": kEmployeesScreen,
    },
    // {
    //   "name": "Performance",
    //   "Subname": "Lorem Ipsum",
    //   "image": "assets/images/data.png",
    //   "Subimage": "assets/images/arrow.png",
    //   "color": KDarkskyblue,
    //    "route": KReimbursement
    // },
    {
      "name": "Approve Employees",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/Payslip1.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      //  "Subimage": "assets/images/arrow.svg",
      "Containercolor": Colors.yellow.withOpacity(0.8),
      // "color": KDarkblue,
      "route": kNotApprovedEmployess,
    },

    // {
    //   "name": "Timesheet",
    //   "Subname": "Lorem Ipsum",
    //   "image": "assets/images/sheet.png",
    //   "arrowimage": "assets/images/right_corner_arrow.png",
    //   //  "Subimage": "assets/images/arrow.svg",
    //   "Containercolor": KlightBlue,
    //   "color": KOrange,
    //   "route": KTime_sheet
    // },
    {
      "name": "Admin Permissions",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/prople2.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      //  "Subimage": "assets/images/arrow.svg",
      "Containercolor": Colors.deepOrange.withOpacity(0.8),
      // "color": Kpink,
      "route": kHRPermissions,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      for (int i = 0; i < Categories.length; i++)
        // if (profilecontroller.profileData["role"] )
        profilecontroller.profileData["role"] == "Employee" &&
                    Categories[i]["name"] == "Qucik Approvals" ||
                profilecontroller.profileData["role"] == "Employee" &&
                    Categories[i]["name"] == "Admin Permissions" ||
                profilecontroller.profileData["role"] == "Employee" &&
                    Categories[i]["name"] == "Approve Employees"
            ? SizedBox()
            : profilecontroller.profileData["role"] == "Admin" &&
                        Categories[i]["name"] == "Admin Permissions" ||
                    profilecontroller.profileData["role"] == "Admin" &&
                        Categories[i]["name"] == "Approve Employees"
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      // Get.toNamed(kApproveScreen);
                      Get.toNamed(Categories[i]["route"]);
                    },
                    child: Container(
                      width: 140.w,
                      margin: EdgeInsets.all(3),
                      padding: EdgeInsets.all(10),
                      // margin: EdgeInsets.only(top: 10.h),
                      decoration: BoxDecoration(
                          color: Categories[i]["Containercolor"],
                          boxShadow: [
                            BoxShadow(
                              color: Ktextcolor.withOpacity(0.0),
                              blurRadius: 5,
                              offset: const Offset(0, 0),
                              spreadRadius: 2,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10.r)),
                      //margin: EdgeInsets.all(13.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/ok.png",
                            height: 23.h,
                            //color: Actions[i]["color"],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            Categories[i]["name"],
                            // "Quick Approvals",
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: kFW600,
                                color: Kwhite),
                          ),
                          Image.asset(
                            "assets/images/white_arrow.png",
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                  )
    ]);
  }
}
