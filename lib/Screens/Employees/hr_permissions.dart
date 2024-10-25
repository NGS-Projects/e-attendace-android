import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eattendance/untils/export_file.dart';

// class EmployeesList extends StatefulWidget {
//   const EmployeesList({super.key});

//   @override
//   State<EmployeesList> createState() => _EmployeesListState();
// }

// class _EmployeesListState extends State<EmployeesList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
// ignore_for_file: camel_case_types

class GiveHrPermission extends StatefulWidget {
  const GiveHrPermission({super.key});

  @override
  State<GiveHrPermission> createState() => _GiveHrPermissionState();
}

class _GiveHrPermissionState extends State<GiveHrPermission> {
  DashboardController dashboardController = Get.put(DashboardController());
  bool readvalue = false;
  bool writevalue = false;
  @override
  void initState() {
    dashboardController.superadmintoadminPermissions();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kwhite,
        appBar: CustomAppBar(
          dontHaveBackAsLeading: false,
          title: "Admin Permissions",
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(13.r),
            child: Column(
              children: [
                Obx(() => dashboardController.adminPermissionsListLoading ==
                        true
                    ? Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 100.h),
                        child: CircularProgressIndicator(
                          color: KOrange,
                        ),
                      )
                    : dashboardController.adminPermissionsList.isEmpty ||
                            dashboardController.adminPermissionsList == null
                        ? Text(
                            "No Admins",
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                color: KdarkText,
                                fontWeight: kFW500),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                dashboardController.adminPermissionsList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: KOrange.withOpacity(0.1)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/profileImageStatic.png",
                                                  height: 35.h,
                                                  width: 35.h,
                                                  fit: BoxFit.contain,
                                                ),
                                                SizedBox(width: 5.w),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          dashboardController
                                                                  .adminPermissionsList[
                                                              index]["firstName"],
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  kFW700,
                                                              color: kblack),
                                                        ),
                                                        SizedBox(width: 2.w),
                                                        Text(
                                                          dashboardController
                                                                  .adminPermissionsList[
                                                              index]["lastName"],
                                                          // "-",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  kFW700,
                                                              color: kblack),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      dashboardController
                                                              .adminPermissionsList[
                                                          index]["role"],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: kTenFont,
                                                          fontWeight: kFW600,
                                                          color: kblack
                                                              .withOpacity(
                                                                  0.5)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),

                                            // Text(
                                            //   claimController
                                            //           .leavesData[
                                            //       index]["reason"],
                                            //   maxLines: 2,
                                            //   overflow:
                                            //       TextOverflow
                                            //           .ellipsis,
                                            //   style: TextStyle(
                                            //       height: 1.2,
                                            //       letterSpacing:
                                            //           0.5,
                                            //       wordSpacing:
                                            //           0.5,
                                            //       fontSize: 13.sp,
                                            //       fontWeight:
                                            //           kFW900,
                                            //       color: selectedTheme ==
                                            //               "Lighttheme"
                                            //           ? KdarkText
                                            //           : Kwhite),
                                            // ),
                                            SizedBox(
                                              height: 7.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Checkbox(
                                                      activeColor: KOrange,
                                                      checkColor: Kwhite,
                                                      value: readvalue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          this.readvalue =
                                                              value!;
                                                        });
                                                        print(readvalue);
                                                      },
                                                    ),
                                                    Text(
                                                      "Read",
                                                      style: GoogleFonts.roboto(
                                                          fontSize:
                                                              kTwelveFont.sp,
                                                          color: KdarkText,
                                                          fontWeight: kFW500),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Checkbox(
                                                      activeColor: KOrange,
                                                      checkColor: Kwhite,
                                                      value: writevalue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          this.writevalue =
                                                              value!;
                                                        });
                                                        print(writevalue);
                                                      },
                                                    ),
                                                    Text(
                                                      "Write",
                                                      style: GoogleFonts.roboto(
                                                          fontSize:
                                                              kTwelveFont.sp,
                                                          color: KdarkText,
                                                          fontWeight: kFW500),
                                                    ),
                                                  ],
                                                ),
                                                // approvalConfirm
                                                GestureDetector(
                                                  onTap: () async {
                                                    var payload = {
                                                      /////////////////////////////////////////////////

                                                      "read": readvalue,
                                                      "write": writevalue,
                                                    };

                                                    dashboardController
                                                        .updateAdminPermissions(
                                                            payload,
                                                            dashboardController
                                                                    .adminPermissionsList[
                                                                index]["_id"]);
                                                  },
                                                  child: Container(
                                                    height: 28.h,
                                                    width: 120.w,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        border: Border.all(
                                                            color: Kgreen
                                                                .withOpacity(
                                                                    0.3),
                                                            width: 1)),
                                                    child: Text(
                                                      "Submit",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: kTenFont,
                                                          color: Kgreen,
                                                          fontWeight: kFW600),
                                                    ),
                                                  ),
                                                )
                                                // Custom_OutlineButton(
                                                //     height: 28.h,
                                                //     width: 105.w,
                                                //     textColor: Kgreen,
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             8.r),
                                                //     Color: Kgreen.withOpacity(
                                                //         0.3),
                                                //     fontSize: kTenFont,
                                                //     fontWeight: kFW600,
                                                //     label: "Approve",
                                                //     isLoading: false,

                                                //   )
                                                ,

                                                // Custom_OutlineButton(
                                                //     height: 28.h,
                                                //     width: 105.w,
                                                //     textColor: KOrange,
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             8.r),
                                                //     Color: KOrange,
                                                //     fontSize: kTenFont,
                                                //     fontWeight: kFW600,
                                                //     label: "Decline",
                                                //     isLoading: false,
                                                //     onTap: () {
                                                //       updateLeaveClaimStats(
                                                //           "Reject",
                                                //           claimController
                                                //                       .leavesData[
                                                //                   index]
                                                //               ["reason"],
                                                //           //   "Leave Rejected",
                                                //           claimController
                                                //                       .leavesData[
                                                //                   index][
                                                //               "employee_leaves_lid"]
                                                //           // claimController.leaveSingleDataView[
                                                //           //     "employee_leaves_lid"]
                                                //           );
                                                //     },
                                                //   )
                                              ],
                                            )
                                            // Align(
                                            //     alignment: Alignment.bottomRight,
                                            //     child: Custom_OutlineButton(
                                            //         height: 28.h,
                                            //         width: 105.w,
                                            //         textColor: KOrange,
                                            //         borderRadius:
                                            //             BorderRadius.circular(8.r),
                                            //         Color: KOrange,
                                            //         fontSize: kTenFont,
                                            //         fontWeight: kFW600,
                                            //         label: "View More",
                                            //         isLoading: false,
                                            //         onTap: () async {
                                            //           claimController.viewSingleLeave(
                                            //               claimController
                                            //                   .leavesData[index],
                                            //               claimController
                                            //                       .peoplesdata["rows"]
                                            //                       .where((element) =>
                                            //                           element[
                                            //                               "emp_id"] ==
                                            //                           claimController
                                            //                                       .leavesData[
                                            //                                   index]
                                            //                               ["emp_id"])
                                            //                       .toList()
                                            //                       .isNotEmpty
                                            //                   ? claimController
                                            //                       .peoplesdata["rows"]
                                            //                       .where((element) =>
                                            //                           element[
                                            //                               "emp_id"] ==
                                            //                           claimController
                                            //                                   .leavesData[
                                            //                               index]["emp_id"])
                                            //                       //   .toList()[0]["Employee"]
                                            //                       .toList()[0]["username"]
                                            //                   : "Self");
                                            //           var x = await Get.toNamed(
                                            //               KApproval_view);
                                            //           // : {"data":leavesData[index],"name" :  claimController.peoplesdata["rows"].where((element) => element["emp_id"]==leavesData[index]["emp_id"]).toList().isNotEmpty?  claimController.peoplesdata["rows"].where((element) => element["emp_id"]==leavesData[index]["emp_id"]).toList()[0]["username"]:"Slef" });
                                            //           setState(() {
                                            //             getData();
                                            //           });
                                            //         }),
                                            //   )

                                            ,
                                            /////////////////////////////////////////////////////

                                            //////////////////////////////////////////////////////////////////
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          ))
                //  const  SpinKitFadingCircle(
                //     color: KOrange,
                //     size: 25,
                //   ),
              ],
            ),
          ),
        ));
  }
}
