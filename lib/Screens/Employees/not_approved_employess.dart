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

class NotEmployeesList extends StatefulWidget {
  const NotEmployeesList({super.key});

  @override
  State<NotEmployeesList> createState() => _NotEmployeesListState();
}

class _NotEmployeesListState extends State<NotEmployeesList> {
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    dashboardController.notApprovedemployeesListData();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kwhite,
        appBar: CustomAppBar(
          dontHaveBackAsLeading: false,
          title: "Approve Employees",
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(13.r),
            child: Column(
              children: [
                Obx(() => dashboardController.notemployeesListLoading == true
                    ? Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 100.h),
                        child: CircularProgressIndicator(
                          color: KOrange,
                        ),
                      )
                    : dashboardController.notemployeesList.isEmpty ||
                            dashboardController.notemployeesList == null
                        ? Text(
                            "No Employees",
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                color: KdarkText,
                                fontWeight: kFW500),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                dashboardController.notemployeesList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    dashboardController
                                            .selectednotemployees.value =
                                        dashboardController
                                            .notemployeesList[index];
                                  });
                                  showModalBottomSheet<dynamic>(
                                      enableDrag: true,
                                      elevation: 0,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                            margin: EdgeInsets.all(5.r),
                                            padding: EdgeInsets.all(10.r),
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13.r),
                                              color: Kwhite,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Ktextcolor.withOpacity(
                                                      0.15),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 0),
                                                  spreadRadius: 4,
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                  dashboardController
                                                              .selectednotemployees[
                                                          "about"] ??
                                                      "",
                                                  maxLines: 8,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Gender",
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  kFW700,
                                                              color: KOrange
                                                                  .withOpacity(
                                                                      0.7)),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Text(
                                                          dashboardController
                                                                      .selectednotemployees[
                                                                  "gender"] ??
                                                              "",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  kFW700,
                                                              color: KdarkText),
                                                        ),
                                                        SizedBox(
                                                          height: 8.h,
                                                        ),
                                                        Text(
                                                          "Date of Joining",
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  kFW700,
                                                              color: KOrange
                                                                  .withOpacity(
                                                                      0.7)),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Text(
                                                          dashboardController
                                                                      .selectednotemployees[
                                                                  "dateOfJoining"] ??
                                                              "",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  kFW700,
                                                              color: KdarkText),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Date of Birth",
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  kFW700,
                                                              color: KOrange
                                                                  .withOpacity(
                                                                      0.7)),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        SizedBox(
                                                          width: 100.w,
                                                          child: Text(
                                                            dashboardController
                                                                        .selectednotemployees[
                                                                    "dateOfBirth"] ??
                                                                "",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    kFW700,
                                                                color:
                                                                    KdarkText),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 8.h,
                                                        ),
                                                        Text(
                                                          "Gender:",
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  kFW700,
                                                              color: KOrange
                                                                  .withOpacity(
                                                                      0.7)),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Text(
                                                          dashboardController
                                                                      .selectednotemployees[
                                                                  "gender"] ??
                                                              "",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  kFW700,
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Address:",
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight: kFW700,
                                                          color: KOrange
                                                              .withOpacity(
                                                                  0.7)),
                                                    ),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(Icons.location_on),
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Text(
                                                              dashboardController
                                                                          .selectednotemployees[
                                                                      "address"] ??
                                                                  "",
                                                              maxLines: 10,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  fontWeight:
                                                                      kFW700,
                                                                  color:
                                                                      KdarkText),
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
                                            ));

                                        // Container(
                                        //   width: double.infinity,
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       2,
                                        //   decoration: BoxDecoration(
                                        //       borderRadius:
                                        //           BorderRadius.circular(
                                        //               10.0),
                                        //       color: Kwhite,
                                        //       boxShadow: [
                                        //         BoxShadow(
                                        //           color: kblack
                                        //               .withOpacity(0.2),
                                        //           blurRadius: 2.r,
                                        //           offset: Offset(1, 1),
                                        //           spreadRadius: 1.r,
                                        //         )

                                        //       ]),

                                        // );
                                        // Favourited(

                                        //     //name1: widget.menuItems[index]
                                        //     // cartapicontroller.cartidData.isEmpty ||
                                        //     //         cartapicontroller.cartidData[0]["CartItems"].isEmpty ||
                                        //     //         cartapicontroller.cartidData[0]["CartItems"] == null
                                        //     //     ? "no data"
                                        //     //     : cartapicontroller.cartidData[0]["CartItems"].where((element) => element["item_id"] == categoryapicontroller.menubyrestaurantData["rows"][menuindex]["item_id"]).toList().isNotEmpty
                                        //     //         ? cartapicontroller.cartidData[0]["CartItems"].where((element) => element["item_id"] == categoryapicontroller.menubyrestaurantData["rows"][menuindex]["item_id"]).toList()[0]["quantity"].toString()
                                        //     //         : "no data"
                                        //     //  cartapicontroller
                                        //     //             .cartidData
                                        //     //             .isEmpty ||
                                        //     //         cartapicontroller
                                        //     //             .cartidData[0][
                                        //     //                 "CartItems"]
                                        //     //             .isEmpty ||
                                        //     //         cartapicontroller.cartidData[0]["CartItems"] ==
                                        //     //             null
                                        //     //     ? "no data"
                                        //     //     : cartapicontroller
                                        //     //         .cartidData[0]
                                        //     //             [
                                        //     //             "CartItems"]
                                        //     //         .where((element) =>
                                        //     //             element["item_id"] ==
                                        //     //             categoryapicontroller.menubyrestaurantData["rows"][menuindex]["item_id"])
                                        //     //         .toList()[0]["quantity"]
                                        //     //         .toString()
                                        //     );
                                      });
                                },
                                child: Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                    .notemployeesList[
                                                                index]["firstName"],
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
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
                                                                    .notemployeesList[
                                                                index]["lastName"],
                                                            // "-",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
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
                                                                .notemployeesList[
                                                            index]["role"],
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  // approvalConfirm
                                                  GestureDetector(
                                                    onTap: () async {
                                                      var payload = {
                                                        /////////////////////////////////////////////////

                                                        "isApprovated": true,
                                                      };

                                                      dashboardController
                                                          .approveEmployees(
                                                              payload,
                                                              dashboardController
                                                                      .notemployeesList[
                                                                  index]["_id"]);
                                                    },
                                                    child: Container(
                                                      height: 28.h,
                                                      width: 120.w,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                          border: Border.all(
                                                              color: Kgreen
                                                                  .withOpacity(
                                                                      0.3),
                                                              width: 1)),
                                                      child: Text(
                                                        "Approve",
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
                                                  GestureDetector(
                                                    onTap: () {},
                                                    // onTap: () {    // vvip code
                                                    //   updateLeaveClaimStats(
                                                    //       "Reject",
                                                    //       claimController.leavesData[index]["reason"],
                                                    //       //   "Leave Rejected",
                                                    //       claimController.leavesData[index]["employee_leaves_lid"]
                                                    //       // claimController.leaveSingleDataView[
                                                    //       //     "employee_leaves_lid"]
                                                    //       );
                                                    // },
                                                    child: Container(
                                                      //  work here
                                                      height: 28.h,
                                                      width: 120.w,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                          border: Border.all(
                                                              color: KRed
                                                                  .withOpacity(
                                                                      0.3),
                                                              width: 1)),
                                                      child: Text(
                                                        "Decline",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: kTenFont,
                                                            color: KRed,
                                                            fontWeight: kFW600),
                                                      ),
                                                    ),
                                                  )
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
                                    )),
                              );
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
