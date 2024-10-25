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

class EmployeesList extends StatefulWidget {
  const EmployeesList({super.key});

  @override
  State<EmployeesList> createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    dashboardController.employeesListData();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kwhite,
        appBar: CustomAppBar(
          dontHaveBackAsLeading: false,
          title: "Employees",
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(13.r),
            child: Column(
              children: [
                Obx(() => dashboardController.employeesListLoading == true
                    ? Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 100.h),
                        child: CircularProgressIndicator(
                          color: KOrange,
                        ),
                      )
                    : dashboardController.employeesList.isEmpty ||
                            dashboardController.employeesList == null
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
                            itemCount: dashboardController.employeesList.length,
                            itemBuilder: (context, index) {
                              return dashboardController.employeesList[index]
                                          ["isApprovated"] ==
                                      false
                                  ? SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          dashboardController
                                                  .selectedEmployee.value =
                                              dashboardController
                                                  .employeesList[index];
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
                                                        BorderRadius.circular(
                                                            13.r),
                                                    color: Kwhite,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Ktextcolor
                                                            .withOpacity(0.15),
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 0),
                                                        spreadRadius: 4,
                                                      )
                                                    ],
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                    .selectedEmployee[
                                                                "about"] ??
                                                            "",
                                                        maxLines: 8,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                    fontSize:
                                                                        11.sp,
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
                                                                            .selectedEmployee[
                                                                        "gender"] ??
                                                                    "",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    fontWeight:
                                                                        kFW700,
                                                                    color:
                                                                        KdarkText),
                                                              ),
                                                              SizedBox(
                                                                height: 8.h,
                                                              ),
                                                              Text(
                                                                "Date of Joining",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11.sp,
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
                                                                            .selectedEmployee[
                                                                        "dateOfJoining"] ??
                                                                    "",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    fontWeight:
                                                                        kFW700,
                                                                    color:
                                                                        KdarkText),
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
                                                                    fontSize:
                                                                        11.sp,
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
                                                                              .selectedEmployee[
                                                                          "dateOfBirth"] ??
                                                                      "",
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11.sp,
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
                                                                    fontSize:
                                                                        11.sp,
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
                                                                            .selectedEmployee[
                                                                        "gender"] ??
                                                                    "",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    fontWeight:
                                                                        kFW700,
                                                                    color:
                                                                        KdarkText),
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Address:",
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    kFW700,
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
                                                              Icon(Icons
                                                                  .location_on),
                                                              SizedBox(
                                                                width: 250.w,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                  child: Text(
                                                                    dashboardController
                                                                            .selectedEmployee["address"] ??
                                                                        "",
                                                                    maxLines:
                                                                        10,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        fontSize: 11
                                                                            .sp,
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
                                        padding: EdgeInsets.all(10.r),
                                        margin: EdgeInsets.only(top: 10.h),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    Ktextcolor.withOpacity(0.5),
                                                blurRadius: 1.r,
                                                offset: Offset(0, 0),
                                                spreadRadius: 1.r,
                                              )
                                            ],
                                            color: Kwhite),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      height: 55.h,
                                                      width: 55.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      13.r),
                                                          color: Kwhite),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                          child: Image.asset(
                                                            "assets/images/man.png",
                                                            height: 55.h,
                                                            width: 55.h,
                                                            fit: BoxFit.contain,
                                                          )),
                                                    ),
                                                    // Positioned(
                                                    //   right: 10,
                                                    //   top: 10,
                                                    //   child: CircleAvatar(
                                                    //     backgroundColor: Kgreen,
                                                    //     radius: 4.r,
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 220.w,
                                                      child: Text(
                                                        dashboardController
                                                                        .employeesList[
                                                                    index]
                                                                ["firstName"] +
                                                            dashboardController
                                                                    .employeesList[
                                                                index]["lastName"],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: kFW800,
                                                            color: KdarkText),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),

                                                    Text(
                                                      dashboardController
                                                                  .employeesList[
                                                              index]["role"] ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight: kFW600,
                                                          color: Ktextcolor),
                                                    ),

                                                    SizedBox(
                                                      height: 4.h,
                                                    ),

                                                    // SizedBox(
                                                    //   height: 10.h,
                                                    // ),
                                                    // Row(
                                                    //   children: [
                                                    //     GestureDetector(
                                                    //       onTap: () async {
                                                    //         String email = Uri.encodeComponent(
                                                    //             "${peoplesdata["rows"][index]["email"]} "
                                                    //             // "jane@vibhotech.com"
                                                    //             );
                                                    //         String subject =
                                                    //             Uri.encodeComponent("Hi");
                                                    //         String body = Uri.encodeComponent(
                                                    //             "Hi! I'm Flutter Developer");
                                                    //         print(
                                                    //             subject); //output: Hello%20Flutter
                                                    //         Uri mail = Uri.parse(
                                                    //             "mailto:$email?subject=$subject&body=$body");
                                                    //         if (await launchUrl(mail)) {
                                                    //           //email app opened
                                                    //         } else {
                                                    //           //email app is not opened
                                                    //         }
                                                    //       },
                                                    //       child: Text(
                                                    //         peoplesdata["rows"] != null
                                                    //             ? "${peoplesdata["rows"][index]["email"]} "
                                                    //             : "",
                                                    //         style: TextStyle(
                                                    //             fontSize: 11.sp,
                                                    //             fontWeight: kFW800,
                                                    //             color: KdarkText
                                                    //                 .withOpacity(0.5)),
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {},
                                                      child: SizedBox(
                                                        width: 230.w,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            // SizedBox(
                                                            //   width: 15.w,
                                                            // ),
                                                            SizedBox(
                                                              width: 150.w,
                                                              child: Text(
                                                                dashboardController
                                                                            .employeesList[index]
                                                                        [
                                                                        "email"] ??
                                                                    "",
                                                                maxLines: 2,
                                                                // peoplesdata["rows"] != null
                                                                //     ? "${peoplesdata["rows"][index]["email"]} "
                                                                //     : "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        kFW800,
                                                                    color:
                                                                        KdarkText),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  dashboardController
                                                                      .newChatpartner
                                                                      .value = dashboardController
                                                                              .employeesList[
                                                                          index]
                                                                      [
                                                                      "firstName"];
                                                                });
                                                                var payload = {
                                                                  "receiverId":
                                                                      dashboardController
                                                                              .employeesList[index]
                                                                          [
                                                                          "_id"]
                                                                  //    "66912b20cd8503daed4fd666"
                                                                };
                                                                dashboardController
                                                                    .socketioCreateChat(
                                                                        payload);
                                                                // telephony.sendSmsByDefaultApp(
                                                                //     to:
                                                                //         "${apiController.donorsData[index]["mobile"]}",
                                                                //     message:
                                                                //         "Hi !This is test message");
                                                              },
                                                              child: Icon(
                                                                Icons.chat,
                                                                size:
                                                                    kSixteenFont,
                                                                color: KOrange,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    // GestureDetector(
                                                    //   onTap: () async {
                                                    //     var url = Uri.parse(
                                                    //         "tel:${dashboardController.employeesList[index]["mobile"]}");
                                                    //     if (await canLaunchUrl(
                                                    //         url)) {
                                                    //       await launchUrl(url);
                                                    //     } else {
                                                    //       throw 'Could not launch $url';
                                                    //     }
                                                    //   },
                                                    //   child: SizedBox(
                                                    //     width: 230.w,
                                                    //     child: Row(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .spaceBetween,
                                                    //       crossAxisAlignment:
                                                    //           CrossAxisAlignment
                                                    //               .center,
                                                    //       children: [
                                                    //         Text(
                                                    //           "contact",

                                                    //           //   $.rows.[]Employee.phone_no
                                                    //           style: TextStyle(
                                                    //               fontSize:
                                                    //                   11.sp,
                                                    //               fontWeight:
                                                    //                   kFW800,
                                                    //               color:
                                                    //                   KdarkText),
                                                    //         ),
                                                    //         Icon(
                                                    //           Icons.phone,
                                                    //           size:
                                                    //               kSixteenFont,
                                                    //           color: Kgreen,
                                                    //         ),
                                                    //       ],
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                              // : const SizedBox();
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
