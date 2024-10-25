import 'package:eattendance/untils/export_file.dart';

class LeavesList extends StatefulWidget {
  const LeavesList({super.key});

  @override
  State<LeavesList> createState() => _LeavesListState();
}

class _LeavesListState extends State<LeavesList> {
  LeavesController leavescontroller = Get.put(LeavesController());
  @override
  void initState() {
    leavescontroller.empLeavesList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        dontHaveBackAsLeading: true,
        title: "Leaves History",
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(16.r),
        child: Obx(
          () => leavescontroller.leavesListLoading == true
              ? Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 100.h),
                  child: CircularProgressIndicator(
                    color: KOrange,
                  ),
                )
              : leavescontroller.leavesList.isEmpty ||
                      leavescontroller.leavesList == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200.h,
                          ),
                          Text(
                            "No Leaves",
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                color: KdarkText,
                                fontWeight: kFW500),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: leavescontroller.leavesList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              leavescontroller.selectleaves.value =
                                  leavescontroller.leavesList[index];
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
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(13.r),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            "Leave Type",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: kFW700,
                                                color: KdarkText),
                                          ),

                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            leavescontroller.selectleaves[
                                                    "leaveType"] ??
                                                "",
                                            maxLines: 8,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                height: 1.1.h,
                                                fontSize: 11.sp,
                                                fontWeight: kFW500,
                                                color: KlightText),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Text(
                                            "From Date - ToDate",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: kFW700,
                                                color: KdarkText),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            leavescontroller.selectleaves[
                                                    "dateRange"] ??
                                                "",
                                            // leavescontroller.selectedapprovalleavesList[
                                            //             "head"]
                                            //         //[
                                            //         ["firstName"] +
                                            //     " " +
                                            //     leavescontroller
                                            //             .selectedapprovalleavesList[
                                            //         "head"]["lastName"],
                                            maxLines: 8,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                height: 1.1.h,
                                                fontSize: 11.sp,
                                                fontWeight: kFW500,
                                                color: KlightText),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Text(
                                            "Reason",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: kFW700,
                                                color: KdarkText),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          SizedBox(
                                            width: 200.w,
                                            child: Text(
                                              leavescontroller
                                                      .selectleaves["reason"] ??
                                                  "",
                                              // leavescontroller.selectedapprovalleavesList[
                                              //             "head"]
                                              //         //[
                                              //         ["firstName"] +
                                              //     " " +
                                              //     leavescontroller
                                              //             .selectedapprovalleavesList[
                                              //         "head"]["lastName"],
                                              maxLines: 12,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  height: 1.1.h,
                                                  fontSize: 11.sp,
                                                  fontWeight: kFW500,
                                                  color: KlightText),
                                            ),
                                          ),

                                          //////////////////////Role

                                          ///////////////
                                          ///////Mangers Tream
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                        ],
                                      ));
                                });
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 10.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: KOrange,
                                                radius: 5.r,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                leavescontroller
                                                            .leavesList[index]
                                                        ["leaveType"] ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: kFourteenFont,
                                                    fontWeight: kFW600,
                                                    color: kblack),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          SizedBox(
                                            width: 200.w,
                                            child: Text(
                                              "Applied from  ${leavescontroller.leavesList[index]["dateRange"] ?? ""}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: kFW500,
                                                  color: Ktextcolor),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            "14th, March",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: kFW500,
                                                color: KTextgery),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 5.h,
                                            left: 12.w,
                                            right: 12.w,
                                            bottom: 5.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            color: leavescontroller
                                                            .leavesList[index]
                                                        ["status"] ==
                                                    "Approved"
                                                ? Colors.green
                                                : leavescontroller.leavesList[
                                                            index]["status"] ==
                                                        "Denied"
                                                    ? KRed
                                                    : kyellow),
                                        child: Text(
                                          leavescontroller.leavesList[index]
                                                  ["status"] ??
                                              "",
                                          style: TextStyle(
                                              fontSize: kTwelveFont,
                                              fontWeight: kFW500,
                                              color: Kwhite),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider()
                                ],
                              )
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     Column(
                              //       children: [
                              //         Container(
                              //           padding: EdgeInsets.all(8),
                              //           margin: EdgeInsets.only(top: 5.h),
                              //           decoration: BoxDecoration(
                              //               border: Border.all(
                              //                   color: Ktextcolor, width: 1.2.w),
                              //               borderRadius:
                              //                   BorderRadius.circular(10.r)),
                              //           child: Column(
                              //             mainAxisAlignment: MainAxisAlignment.center,
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.center,
                              //             children: [
                              //               Text(
                              //                 "19",
                              //                 style: GoogleFonts.roboto(
                              //                     fontSize: kSixteenFont,
                              //                     color: KdarkText,
                              //                     fontWeight: kFW500),
                              //               ),
                              //               Text(
                              //                 "Fri",
                              //                 style: GoogleFonts.roboto(
                              //                     fontSize: 11.sp,
                              //                     color: Ktextcolor,
                              //                     fontWeight: kFW400),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //     Column(
                              //       children: [
                              //         Icon(
                              //           Icons.av_timer_outlined,
                              //           color: Ktextcolor,
                              //         ),
                              //         Text(
                              //           "09 : 10 AM",
                              //           style: GoogleFonts.roboto(
                              //               fontSize: kTwelveFont,
                              //               color: KdarkText,
                              //               fontWeight: kFW500),
                              //         ),
                              //         Text(
                              //           "Clock In",
                              //           style: GoogleFonts.roboto(
                              //               fontSize: 11.sp,
                              //               color: Ktextcolor,
                              //               fontWeight: kFW400),
                              //         ),
                              //       ],
                              //     ),
                              //     Column(
                              //       children: [
                              //         Icon(
                              //           Icons.av_timer_outlined,
                              //           color: Ktextcolor,
                              //         ),
                              //         Text(
                              //           "09 : 10 AM",
                              //           style: GoogleFonts.roboto(
                              //               fontSize: kTwelveFont,
                              //               color: KdarkText,
                              //               fontWeight: kFW500),
                              //         ),
                              //         Text(
                              //           "Clock Out",
                              //           style: GoogleFonts.roboto(
                              //               fontSize: 11.sp,
                              //               color: Ktextcolor,
                              //               fontWeight: kFW400),
                              //         ),
                              //       ],
                              //     ),
                              //     Column(
                              //       children: [
                              //         Icon(
                              //           Icons.av_timer_outlined,
                              //           color: Ktextcolor,
                              //         ),
                              //         Text(
                              //           "09 : 10 AM",
                              //           style: GoogleFonts.roboto(
                              //               fontSize: kTwelveFont,
                              //               color: KdarkText,
                              //               fontWeight: kFW500),
                              //         ),
                              //         Text(
                              //           "Clock Out",
                              //           style: GoogleFonts.roboto(
                              //               fontSize: 11.sp,
                              //               color: Ktextcolor,
                              //               fontWeight: kFW400),
                              //         ),
                              //       ],
                              //     ),
                              //     Column(
                              //       children: [
                              //         Text(
                              //           "Absent",
                              //           style: GoogleFonts.roboto(
                              //               fontSize: kFourteenFont,
                              //               color: KRed,
                              //               fontWeight: kFW500),
                              //         ),
                              //         Container(
                              //           padding: EdgeInsets.only(
                              //               left: 10.w,
                              //               top: 3.h,
                              //               right: 10.w,
                              //               bottom: 3.h),
                              //           margin: EdgeInsets.only(top: 5.h),
                              //           decoration: BoxDecoration(
                              //               border: Border.all(
                              //                   color: KOrange.withOpacity(0.5),
                              //                   width: 1.2.w),
                              //               borderRadius:
                              //                   BorderRadius.circular(10.r)),
                              //           child: Text(
                              //             "Regular",
                              //             style: GoogleFonts.roboto(
                              //                 fontSize: 11.sp,
                              //                 color: KOrange,
                              //                 fontWeight: kFW500),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),

                              ),
                        );
                      }),
        ),
      )),
    );
  }
}
