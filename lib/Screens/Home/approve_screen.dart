import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:eattendance/untils/export_file.dart';
import 'package:readmore/readmore.dart';

class Approve extends StatefulWidget {
  const Approve({super.key});

  @override
  State<Approve> createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  // hrapprovalleavesList
  /////////////////////////
  TextEditingController rejectReasonController = TextEditingController();
  LeavesController leavescontroller = Get.put(LeavesController());
  @override
  void initState() {
    leavescontroller.hrapprovalleavesList();
    // TODO: implement initState
    super.initState();
  }

  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();
  FocusNode _focustwoNode = FocusNode();
  FocusNode _focusthreeNode = FocusNode();

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
  String clickedOption = "Pending";
  // var approvalConfirm = {};

  var reasonDecline = "";
  /////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      appBar: CustomAppBar(
        dontHaveBackAsLeading: false,
        title: "Approvals",
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: _handleTapOutside,
          child: Container(
            margin: EdgeInsets.all(13.r),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            clickedOption = "Pending";
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          padding: EdgeInsets.only(
                              left: 15.w, right: 15.w, top: 8.h, bottom: 8.h),
                          decoration: clickedOption == "Pending"
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: KOrange),
                                  color: KOrange)
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: Ktextcolor)),
                          child: Text(
                            "Pending",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: clickedOption == "Pending"
                                    ? kFW700
                                    : kFW500,
                                color:
                                    clickedOption == "Pending" ? Kwhite : null),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            clickedOption = "Approved";
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          padding: EdgeInsets.only(
                              left: 15.w, right: 15.w, top: 8.h, bottom: 8.h),
                          decoration: clickedOption == "Approved"
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: KOrange),
                                  color: KOrange)
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: Ktextcolor)),
                          child: Text(
                            "Approved",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: clickedOption == "Approved"
                                    ? kFW700
                                    : kFW500,
                                color: clickedOption == "Approved"
                                    ? Kwhite
                                    : null),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            clickedOption = "Denied";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 15.w, right: 15.w, top: 8.h, bottom: 8.h),
                          decoration: clickedOption == "Denied"
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: KOrange),
                                  color: KOrange)
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: Ktextcolor)),
                          child: Text(
                            "Denied",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight:
                                    clickedOption == "Denied" ? kFW700 : kFW500,
                                color:
                                    clickedOption == "Denied" ? Kwhite : null),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //                 var approvalleavesList = [].obs;
                // var approvalleavesListLoading = false.obs;
                SizedBox(
                  height: 5.h,
                ),
                Obx(() => leavescontroller.approvalleavesListLoading == true
                    ? Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 100.h),
                        child: CircularProgressIndicator(
                          color: KOrange,
                        ),
                      )
                    : leavescontroller.approvalleavesList.isEmpty ||
                            leavescontroller.approvalleavesList == null
                        ? Text(
                            "No Requests",
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                color: KdarkText,
                                fontWeight: kFW500),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                leavescontroller.approvalleavesList.length,
                            itemBuilder: (context, index) {
                              return clickedOption !=
                                      leavescontroller.approvalleavesList[index]
                                          ["status"]
                                  ? SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          leavescontroller
                                                  .selectedapprovalleavesList
                                                  .value =
                                              leavescontroller
                                                  .approvalleavesList[index];
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
                                                        "Name",
                                                        style: TextStyle(
                                                            fontSize: 15.sp,
                                                            fontWeight: kFW700,
                                                            color: KdarkText),
                                                      ),

                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text(
                                                        leavescontroller.selectedapprovalleavesList[
                                                                    "head"]
                                                                //[
                                                                ["firstName"] +
                                                            " " +
                                                            leavescontroller
                                                                    .selectedapprovalleavesList[
                                                                "head"]["lastName"],
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
                                                        leavescontroller
                                                                    .selectedapprovalleavesList[
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                      .selectedapprovalleavesList[
                                                                  "reason"] ??
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              height: 1.1.h,
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  kFW500,
                                                              color:
                                                                  KlightText),
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
                                          margin: EdgeInsets.only(top: 10.h),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              color: KOrange.withOpacity(0.1)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
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
                                                              MainAxisAlignment
                                                                  .start,
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
                                                                  leavescontroller.approvalleavesList[index]
                                                                              [
                                                                              "head"]
                                                                          //[
                                                                          [
                                                                          "firstName"] ??
                                                                      "",
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          kFW700,
                                                                      color:
                                                                          kblack),
                                                                ),
                                                                SizedBox(
                                                                    width: 2.w),
                                                                Text(
                                                                  leavescontroller.approvalleavesList[index]
                                                                              [
                                                                              "head"]
                                                                          [
                                                                          "lastName"] ??
                                                                      "",
                                                                  // "-",
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          kFW700,
                                                                      color:
                                                                          kblack),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  leavescontroller
                                                                              .approvalleavesList[index]
                                                                          [
                                                                          "dateRange"] ??
                                                                      "",
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          kTenFont,
                                                                      fontWeight:
                                                                          kFW600,
                                                                      color: kblack
                                                                          .withOpacity(
                                                                              0.5)),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    ReadMoreText(
                                                      leavescontroller
                                                                  .approvalleavesList[
                                                              index]["reason"] ??
                                                          "",

                                                      // trimLines: 1,
                                                      colorClickableText:
                                                          KOrange,
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight: kFW700,
                                                          color: kblack
                                                              .withOpacity(
                                                                  0.7)),
                                                      trimMode: TrimMode.Line,
                                                      trimCollapsedText:
                                                          'See more',
                                                      trimExpandedText:
                                                          '...See less',
                                                      moreStyle: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight: kFW700,
                                                          color: KOrange),
                                                      lessStyle: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight: kFW700,
                                                          color: KOrange),
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
                                                    clickedOption == "Pending"
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              // approvalConfirm
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  var payload =
                                                                      {
                                                                    "status":
                                                                        "Approved",
                                                                  };
                                                                  // {  : “Approved” or  “Denied” }
                                                                  leavescontroller.approveEmployees(
                                                                      payload,
                                                                      leavescontroller
                                                                              .approvalleavesList[index]
                                                                          [
                                                                          "_id"]);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 28.h,
                                                                  width: 120.w,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(8
                                                                              .r),
                                                                      border: Border.all(
                                                                          color: Kgreen.withOpacity(
                                                                              0.3),
                                                                          width:
                                                                              1)),
                                                                  child: Text(
                                                                    "Approve",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            kTenFont,
                                                                        color:
                                                                            Kgreen,
                                                                        fontWeight:
                                                                            kFW600),
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
                                                                onTap: () {
                                                                  var payload =
                                                                      {
                                                                    "status":
                                                                        "Denied",
                                                                  };
                                                                  // {  : “Approved” or  “Denied” }
                                                                  leavescontroller.approveEmployees(
                                                                      payload,
                                                                      leavescontroller
                                                                              .approvalleavesList[index]
                                                                          [
                                                                          "_id"]);
                                                                },
                                                                // onTap: () {    // vvip code
                                                                //   updateLeaveClaimStats(
                                                                //       "Reject",
                                                                //       claimController.leavesData[index]["reason"],
                                                                //       //   "Leave Denied",
                                                                //       claimController.leavesData[index]["employee_leaves_lid"]
                                                                //       // claimController.leaveSingleDataView[
                                                                //       //     "employee_leaves_lid"]
                                                                //       );
                                                                // },
                                                                child:
                                                                    Container(
                                                                  //  work here
                                                                  height: 28.h,
                                                                  width: 120.w,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(8
                                                                              .r),
                                                                      border: Border.all(
                                                                          color: KRed.withOpacity(
                                                                              0.3),
                                                                          width:
                                                                              1)),
                                                                  child: Text(
                                                                    "Decline",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            kTenFont,
                                                                        color:
                                                                            KRed,
                                                                        fontWeight:
                                                                            kFW600),
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
                                                              //           //   "Leave Denied",
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

                                                        : const SizedBox(),
                                                    /////////////////////////////////////////////////////
                                                    _selectedIndex != index
                                                        ? const SizedBox()
                                                        : clickedOption ==
                                                                "Pending"
                                                            ? isExpanded
                                                                ? Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            10.h,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                200.w,
                                                                            height:
                                                                                30.h,
                                                                            child:
                                                                                // CustomFormField(
                                                                                //     controller: rejectReasonController,
                                                                                //     maxLines: 1,
                                                                                //     readOnly: false,
                                                                                //     labelText: "Reason",
                                                                                //     hintText: ""),
                                                                                TextFormField(
                                                                              focusNode: _focusNode,
                                                                              onTap: () {
                                                                                _showKeyboard(_focusNode);
                                                                              },
                                                                              // textCapitalization: TextCapitalization.characters,
                                                                              style: TextStyle(
                                                                                fontSize: 12.sp,
                                                                                fontWeight: kFW600,
                                                                                color: KdarkText,
                                                                              ),
                                                                              textAlignVertical: TextAlignVertical.center,
                                                                              decoration: InputDecoration(
                                                                                focusColor: Colors.white,
                                                                                contentPadding: const EdgeInsets.only(left: 20.0, bottom: 6.0, top: 8.0),
                                                                                // contentPadding: const EdgeInsets.symmetric(
                                                                                //     vertical: 13.0, horizontal: 10.0),

                                                                                border: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.circular(20.r),
                                                                                ),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: const BorderSide(color: Ktextcolor, width: 0.5),
                                                                                  borderRadius: BorderRadius.circular(30.r),
                                                                                ),
                                                                                errorBorder: OutlineInputBorder(
                                                                                  borderSide: const BorderSide(color: Ktextcolor, width: 0.5),
                                                                                  borderRadius: BorderRadius.circular(30.r),
                                                                                ),
                                                                                disabledBorder: OutlineInputBorder(
                                                                                  borderSide: const BorderSide(color: Ktextcolor, width: 0.5),
                                                                                  borderRadius: BorderRadius.circular(30.r),
                                                                                ),
                                                                                focusedErrorBorder: OutlineInputBorder(
                                                                                  borderSide: const BorderSide(color: Ktextcolor, width: 1),
                                                                                  borderRadius: BorderRadius.circular(30.r),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: const BorderSide(color: Ktextcolor, width: 0.5),
                                                                                  borderRadius: BorderRadius.circular(30.r),
                                                                                ),
                                                                                fillColor: Colors.grey,

                                                                                hintText: "Reason",

                                                                                //make hint text
                                                                                hintStyle: TextStyle(
                                                                                  color: KlightText,
                                                                                  fontSize: kTenFont,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),

                                                                                //create lable
                                                                                labelText: 'Reason',
                                                                                //lable style
                                                                                labelStyle: TextStyle(
                                                                                  color: KlightText,
                                                                                  fontSize: kTwelveFont,
                                                                                  fontWeight: FontWeight.w800,
                                                                                ),
                                                                              ),
                                                                              validator: (value) {
                                                                                (input) => input.isValidEmail() ? null : "Check your Employee Id";
                                                                                if (value!.isEmpty) {
                                                                                  return 'Please enter Employee Id';
                                                                                }
                                                                                return null;
                                                                              },
                                                                              onChanged: (String value) {
                                                                                reasonDecline = value;
                                                                              },
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            // onTap:
                                                                            //     () {
                                                                            //   setState(() {
                                                                            //     // Toggle the expansion state
                                                                            //     isExpanded = !isExpanded;
                                                                            //   });
                                                                            // },
                                                                            onTap:
                                                                                () async {},
                                                                            child:
                                                                                Container(
                                                                              height: 28.h,
                                                                              width: 60.w,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: KRed.withOpacity(0.3), width: 1)),
                                                                              child: Text(
                                                                                "Submit",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(fontSize: kTenFont, color: KRed, fontWeight: kFW600),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  )
                                                                : SizedBox()
                                                            : SizedBox(),

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
                            }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
