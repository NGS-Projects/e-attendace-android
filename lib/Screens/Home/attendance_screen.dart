import 'package:eattendance/untils/export_file.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  TextEditingController rejectReasonController = TextEditingController();

  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();
  FocusNode _focustwoNode = FocusNode();
  FocusNode _focusthreeNode = FocusNode();
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    // dashboardController
    //     .todayStatusData(DateFormat('MM-dd-yyyy').format(DateTime.now()));
    setState(() {
      dashboardController.selectedAttendanceMonth.value =
          DateTime.now().month.toString();
      dashboardController.selectedAttendanceYear.value =
          DateTime.now().year.toString();
    });

    dashboardController.employeesMonthAttendanceData();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _showKeyboard(node) {
    FocusScope.of(context).requestFocus(node);
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _handleTapOutside() {
    _hideKeyboard();
  }

  bool isExpanded = false;
  String clickedOption = "all";
  // var approvalConfirm = {};

  var reasonDecline = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        dontHaveBackAsLeading: true,
        title: "Attendance Screen",
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(16.r),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                  padding: EdgeInsets.only(
                      left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon(
                      //   Icons.arrow_back_ios,
                      //   color: KOrange,
                      //   size: 20.sp,
                      // ),
                      // SizedBox(
                      //   width: 10.w,
                      // ),
                      Obx(
                        () => Text(
                          "${dashboardController.selectedAttendanceMonth}-${dashboardController.selectedAttendanceYear}",
                          style: TextStyle(
                              fontSize: kEighteenFont,
                              fontWeight: kFW500,
                              color: KOrange),
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          showMonthPicker(
                            // dismissible: false,
                            backgroundColor: Kwhite,
                            selectedMonthBackgroundColor:
                                KOrange.withOpacity(0.5),
                            roundedCornersRadius: 10,
                            headerColor: KOrange,
                            unselectedMonthTextColor: Ktextcolor,
                            context: context,
                            // firstDate: DateTime.parse(
                            //     dashboardController.profiledata["date_of_joining"]),
                            initialDate: DateTime.now(),
                            lastDate: DateTime.now(),
                            confirmWidget: Text(
                              "OK",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: KOrange.withOpacity(0.7),
                              ),
                            ),
                            cancelWidget: Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: KOrange.withOpacity(0.7),
                              ),
                            ),
                          ).then((date) {
                            if (date != null) {
                              if (date.isAfter(DateTime.now())) {
                                // date.isAfter(DateTime.now()
                                //  if(date.month>DateTime.now().month){
                                Fluttertoast.showToast(
                                    msg: "Upcomming Months can't be selected");
                              } else {
                                print(date);
                                date.month;
                                print(date.month);
                                setState(() {
                                  dashboardController.selectedAttendanceMonth
                                      .value = date.month.toString();
                                  dashboardController.selectedAttendanceYear
                                      .value = date.year.toString();
                                });

                                dashboardController
                                    .employeesMonthAttendanceData();
                                // setState(() {
                                //   attendanceController.controller.selectedDate = date;
                                //   attendanceController.controller.displayDate = date;
                                //   attendanceController.selectedDate.value = date;
                                //   attendanceController.getCalenderInfo(date);
                                // });
                              }
                            }
                          });
                        },
                        child: Icon(
                          Icons.calendar_month,
                          color: KOrange,
                          size: 20.sp,
                        ),
                      ),
                      // SizedBox(
                      //   width: 10.w,
                      // ),
                      // Icon(
                      //   Icons.arrow_forward_ios,
                      //   color: KOrange,
                      //   size: 20.sp,
                      // ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 25.h,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           setState(() {
                //             clickedOption = "all";
                //           });
                //         },
                //         child: Container(
                //           margin: EdgeInsets.only(right: 10.w),
                //           padding: EdgeInsets.only(
                //               left: 15.w, right: 15.w, top: 8.h, bottom: 8.h),
                //           decoration: clickedOption == "all"
                //               ? BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10.r),
                //                   border: Border.all(color: KOrange),
                //                   color: KOrange)
                //               : BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10.r),
                //                   border: Border.all(color: Ktextcolor)),
                //           child: Text(
                //             "all",
                //             style: TextStyle(
                //                 fontSize: 12.sp,
                //                 fontWeight:
                //                     clickedOption == "all" ? kFW700 : kFW500,
                //                 color: clickedOption == "all" ? Kwhite : null),
                //           ),
                //         ),
                //       ),
                //       InkWell(
                //         onTap: () {
                //           setState(() {
                //             clickedOption = "early_leave";
                //           });
                //         },
                //         child: Container(
                //           margin: EdgeInsets.only(right: 10.w),
                //           padding: EdgeInsets.only(
                //               left: 15.w, right: 15.w, top: 8.h, bottom: 8.h),
                //           decoration: clickedOption == "early_leave"
                //               ? BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10.r),
                //                   border: Border.all(color: KOrange),
                //                   color: KOrange)
                //               : BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10.r),
                //                   border: Border.all(color: Ktextcolor)),
                //           child: Text(
                //             "early leave",
                //             style: TextStyle(
                //                 fontSize: 12.sp,
                //                 fontWeight: clickedOption == "early_leave"
                //                     ? kFW700
                //                     : kFW500,
                //                 color: clickedOption == "early_leave"
                //                     ? Kwhite
                //                     : null),
                //           ),
                //         ),
                //       ),
                //       InkWell(
                //         onTap: () {
                //           setState(() {
                //             clickedOption = "late";
                //           });
                //         },
                //         child: Container(
                //           padding: EdgeInsets.only(
                //               left: 15.w, right: 15.w, top: 8.h, bottom: 8.h),
                //           decoration: clickedOption == "late"
                //               ? BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10.r),
                //                   border: Border.all(color: KOrange),
                //                   color: KOrange)
                //               : BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10.r),
                //                   border: Border.all(color: Ktextcolor)),
                //           child: Text(
                //             "late",
                //             style: TextStyle(
                //                 fontSize: 12.sp,
                //                 fontWeight:
                //                     clickedOption == "late" ? kFW700 : kFW500,
                //                 color: clickedOption == "late" ? Kwhite : null),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20.h,
                // ),
                Obx(
                  () => dashboardController.employeesMonthAttendanceLoading ==
                          true
                      ? Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 100.h),
                          child: CircularProgressIndicator(
                            color: KOrange,
                          ),
                        )
                      : dashboardController
                                  .employeesMonthAttendanceList.isEmpty ||
                              dashboardController
                                      .employeesMonthAttendanceList ==
                                  null
                          ? Text(
                              "No Attendance",
                              style: GoogleFonts.roboto(
                                  fontSize: kSixteenFont,
                                  color: KdarkText,
                                  fontWeight: kFW500),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: dashboardController
                                  .employeesMonthAttendanceList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            margin: EdgeInsets.only(top: 5.h),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Ktextcolor,
                                                    width: 1.2.w),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${DateTime.parse(dashboardController.employeesMonthAttendanceList[index]["date"]).day}",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: kSixteenFont,
                                                      color: KdarkText,
                                                      fontWeight: kFW500),
                                                ),
                                                Text(
                                                  "${DateFormat('EEE').format(DateTime.parse(dashboardController.employeesMonthAttendanceList[index]["date"]))}",

                                                  // "Fri",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 11.sp,
                                                      color: Ktextcolor,
                                                      fontWeight: kFW400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Icon(
                                            Icons.av_timer_outlined,
                                            color: Ktextcolor,
                                          ),
                                          Text(
                                            dashboardController
                                                        .employeesMonthAttendanceList[
                                                    index]["startTime"] ??
                                                "",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: KdarkText,
                                                fontWeight: kFW500),
                                          ),
                                          Text(
                                            "Check In",
                                            style: GoogleFonts.roboto(
                                                fontSize: 11.sp,
                                                color: Ktextcolor,
                                                fontWeight: kFW400),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Icon(
                                            Icons.av_timer_outlined,
                                            color: Ktextcolor,
                                          ),
                                          Text(
                                            dashboardController
                                                        .employeesMonthAttendanceList[
                                                    index]["endTime"] ??
                                                "",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: KdarkText,
                                                fontWeight: kFW500),
                                          ),
                                          Text(
                                            "Check Out",
                                            style: GoogleFonts.roboto(
                                                fontSize: 11.sp,
                                                color: Ktextcolor,
                                                fontWeight: kFW400),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Icon(
                                            Icons.av_timer_outlined,
                                            color: Ktextcolor,
                                          ),
                                          dashboardController.employeesMonthAttendanceList[
                                                          index]["startTime"] ==
                                                      null ||
                                                  dashboardController
                                                              .employeesMonthAttendanceList[
                                                          index]["endTime"] ==
                                                      null
                                              ? Text("")
                                              : Text(
                                                  // Parse start and end times, and calculate the difference
                                                  (() {
                                                    Duration diff = DateFormat(
                                                            "HH:mm")
                                                        .parse(dashboardController
                                                                .employeesMonthAttendanceList[
                                                            index]["endTime"])
                                                        .difference(DateFormat(
                                                                "HH:mm")
                                                            .parse(dashboardController
                                                                        .employeesMonthAttendanceList[
                                                                    index]
                                                                ["startTime"]));

                                                    // Calculate hours and minutes from the Duration
                                                    int hours = diff.inHours;
                                                    int minutes = diff.inMinutes
                                                        .remainder(
                                                            60); // Remainder to get minutes

                                                    // Return formatted string with hours and minutes
                                                    return '$hours h: $minutes  ${minutes == 1 ? 'm' : 'm'}';
                                                  })(),
                                                  style: GoogleFonts.roboto(
                                                    fontSize: kTwelveFont,
                                                    color: KdarkText,
                                                    fontWeight: kFW500,
                                                  ),
                                                ),
                                          // Text(
                                          //   // "10 HRS",
                                          //   style: GoogleFonts.roboto(
                                          //       fontSize: kTwelveFont,
                                          //       color: KdarkText,
                                          //       fontWeight: kFW500),
                                          // ),
                                          Text(
                                            "Total Hours",
                                            style: GoogleFonts.roboto(
                                                fontSize: 11.sp,
                                                color: Ktextcolor,
                                                fontWeight: kFW400),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Present",
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                color: Colors.green,
                                                fontWeight: kFW500),
                                          ),
                                          // Container(
                                          //   padding: EdgeInsets.only(
                                          //       left: 10.w,
                                          //       top: 3.h,
                                          //       right: 10.w,
                                          //       bottom: 3.h),
                                          //   margin: EdgeInsets.only(top: 5.h),
                                          //   decoration: BoxDecoration(
                                          //       border: Border.all(
                                          //           color: KOrange.withOpacity(
                                          //               0.5),
                                          //           width: 1.2.w),
                                          //       borderRadius:
                                          //           BorderRadius.circular(
                                          //               10.r)),
                                          //   child: Text(
                                          //     "Regular",
                                          //     style: GoogleFonts.roboto(
                                          //         fontSize: 11.sp,
                                          //         color: KOrange,
                                          //         fontWeight: kFW500),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                )
              ],
            )),
      ),
    );
  }
}
