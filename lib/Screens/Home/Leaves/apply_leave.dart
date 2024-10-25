// ignore_for_file: camel_case_types, unused_field

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eattendance/untils/export_file.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Apply_leave extends StatefulWidget {
  const Apply_leave({super.key});

  @override
  State<Apply_leave> createState() => _Apply_leaveState();
}

class leavesdata {
  int leavetypeid = 0;
  String leavetype = '';
  String fromdate = '';
  String todate = '';
  String reason = '';
}

class _Apply_leaveState extends State<Apply_leave> {
  //  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  LeavesController leavescontroller = Get.put(LeavesController());
  // late SingleValueDropDownController _cnt;
  // late MultiValueDropDownController _cntMulti;

  // @override
  // void initState() {
  //   _cnt = SingleValueDropDownController();
  //   _cntMulti = MultiValueDropDownController();
  //   super.initState();
  // }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController reasoncontroller = TextEditingController();
  bool isLoading = false;
  String imageData = "string";
  String imageName = "string";
  // List appliedLeaves = [];
  leavesdata data = leavesdata();

  ///Sickleave Handler

  // List<DateTime> appledLeavesDates = [];
  // getAppliedLeaves() {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   appledLeavesDates.clear();
  //   for (int i = 0; i < appliedLeaves.length; i++) {
  //     if (appliedLeaves[i]["from_date"] != "0000-00-00" &&
  //         appliedLeaves[i]["to_date"] != "0000-00-00") {
  //       List<DateTime> betweenDates = getLeavesInBetween(
  //           DateTime.parse(appliedLeaves[i]["from_date"]),
  //           DateTime.parse(appliedLeaves[i]["to_date"]));
  //       for (int j = 0; j < betweenDates.length; j++) {
  //         setState(() {
  //           appledLeavesDates.add(betweenDates[j]);
  //         });
  //       }
  //     }
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // getLeavesInBetween(DateTime startDate, DateTime endDate) {
  //   final daysToGenerate = endDate.difference(startDate).inDays + 1;
  //   return List.generate(
  //       daysToGenerate, (i) => startDate.add(Duration(days: i)));
  // }

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  String newrange = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${args.value.startDate} -'
            // ignore: lines_longer_than_80_chars
            ' ${args.value.endDate ?? args.value.startDate}';
        splitrange(_range);
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
    debugPrint("Done");
  }

  void splitrange(_range) {
    List<String> dates = _range.split(' - ');

    // Parse the date strings into DateTime objects
    DateTime startDate = DateTime.parse(dates[0]);
    DateTime endDate = DateTime.parse(dates[1]);

    // Format the dates to remove the time part
    String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
    String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);

    // Create the new date range string without time
    String formattedDateRange = '$formattedStartDate - $formattedEndDate';
    setState(() {
      newrange = formattedDateRange;
    });
    print(formattedDateRange);
  }
//   String dateRange = '2024-09-24 00:00:00.000 - 2024-09-25 00:00:00.000';

//   // Split the range into two dates
//  // Output: 2024-09-24 - 2024-09-25
// }

  /////////////////////

  /////////////////

  // getLeavesListFromApi() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Map data = await Services.leavelist();
  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //   } else {
  //     appliedLeaves = data["rows"];
  //     getAppliedLeaves();
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  // String? str;
  // List myLeavesTypes = [];
  // List<String> options = [];
  // getLeavesListTypes() async {
  //   options.clear();
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Map data = await Services.getLeavesListTypes();
  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //   } else {
  //     myLeavesTypes = data["rows"];
  //     for (int i = 0; i < myLeavesTypes.length; i++) {
  //       if (myLeavesTypes[i]["is_active"] == 1) {
  //         options.add(myLeavesTypes[i]["leave_type_name"]);
  //       }
  //     }
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  Map Requestdata = {};
  List holydays = [];
  Map UpcommingHolydaysdata = {};

  final List<String> Genders = [
    'Annual Leave',
    'Casual Leave',
    'Loss of Pay',
  ];

  String? selectedValue;
  String? selectedGenderValue;

// DateTime.parse(
  //    holydays[index]["date"])
  List<DateTime> myLeavesHolidaysList = [];

  List<DateTime> myLeavesList = [];

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  File? selectedImage;
  String base64Image = "";
  bool showimagenullMessage = false;

  ///upload documents////////////////////////////////////
  Future<void> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 6,
      );
      // .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          //.pickImage(source: ImageSource.gallery);
          .pickImage(source: ImageSource.gallery, imageQuality: 6);
      //  .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        print(selectedImage!.readAsBytesSync().lengthInBytes);
        final kb = selectedImage!.readAsBytesSync().lengthInBytes / 1024;
        print(kb);
        final mb = kb / 1024;
        print(mb);
        print("ram b jk dslnkv flk dlkcdslc k");
        showimagenullMessage = false;
      });
//       Future getImageSize() async {
// // final pickedImage = await picker.getImage(source: ImageSource.gallery);
//         final bytes = selectedImage!.readAsBytesSync().lengthInBytes;
//         final kb = bytes / 1024;
//         final mb = kb / 1024;
//         print("Below kilo bytes,...........................................");
//         print(kb);
//       }
      // var value = await Services.profileimage(File(image.path));
      // if (jsonDecode(value["msg"]) != null) {
      //   Fluttertoast.showToast(msg: value["msg"]);
      // } else {
      //   // Get.toNamed(Kapply_leaves);
      // }
    }
  }

  ///

  @override
  void initState() {
    // getLeavesListTypes();
    // getLeavesListFromApi();
    // _cnt = SingleValueDropDownController();
    // _cntMulti = MultiValueDropDownController();
    super.initState();
  }

  FocusNode _focusNode = FocusNode();

  void _showKeyboard(node) {
    FocusScope.of(context).requestFocus(node);
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _handleTapOutside() {
    _hideKeyboard();
  }

  //dropdown
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTapOutside,
      child: Scaffold(
        // resizeToAvoidBottomInset: true,

        backgroundColor: Kwhite,
        appBar: CustomAppBar(
          dontHaveBackAsLeading: false,
          title: "Apply Leave",
        ),
        body: SafeArea(
          child: Container(
              margin: EdgeInsets.all(13.r),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Leave type",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: kFW700,
                              color: KdarkText)),
                      SizedBox(height: 10.h),
                      Container(
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
                        child: DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kblack.withOpacity(0.6), width: 0.5),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kblack.withOpacity(0.6), width: 0.5),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kblack.withOpacity(0.6), width: 0.5),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: KOrange, width: 1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: KOrange, width: 1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          hint: Text(
                            'Select Leave Type',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: KTextgery.withOpacity(0.5),
                            ),
                          ),
                          items: Genders.map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                  ),
                                ),
                              )).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select Leave Type.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              selectedGenderValue = value.toString();
                              print(selectedGenderValue);
                            });

                            // authentication.registerDonorBloodController.value =
                            //     selectedValue as TextEditingValue;
                            //Do something when selected item is changed.
                          },
                          onSaved: (value) {
                            selectedGenderValue = value.toString();
                            print(selectedGenderValue);
                            // authentication.registerDonorBloodController.value =
                            //     selectedValue as TextEditingValue;
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: kblack.withOpacity(0.6),
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),

                      // CustomDropDown(
                      //   label: 'Leave type',
                      //   hintText: 'Leave type',
                      //   isMandatory: true,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'This filed not be Empty';
                      //     }
                      //     return null;
                      //   },
                      //   onChanged: (dynamic str) {
                      //     setState(() {
                      //       data.leavetype = str;
                      //       data.leavetypeid = myLeavesTypes
                      //           .where((element) => element["leave_type_name"] == str)
                      //           .toList()[0]["leave_type_id"];
                      //     });
                      //   },
                      //   options: options,
                      // ),
                      ////last code
                      // Container(
                      //   height: 40.h,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     color: Kwhite,
                      //     borderRadius: BorderRadius.circular(10.r),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         spreadRadius: 2,
                      //         blurRadius: 10,
                      //         offset: const Offset(0, 6),
                      //         color: Ktextcolor.withOpacity(0.2),
                      //       )
                      //     ],
                      //   ),
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButtonFormField2<String>(
                      //       decoration: InputDecoration(
                      //         fillColor: Kwhite,
                      //         filled: true,
                      //         contentPadding: const EdgeInsets.symmetric(
                      //             vertical: 5, horizontal: 10),
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10.r),
                      //             borderSide: BorderSide.none),
                      //       ),
                      //       isExpanded: true,
                      //       hint: Text(
                      //         'Select Type',
                      //         style: TextStyle(
                      //           fontSize: 14,
                      //           color: Theme.of(context).hintColor,
                      //         ),
                      //       ),
                      //       items: leavesController.options
                      //           .map((String item) =>
                      //               DropdownMenuItem<String>(
                      //                 value: item,
                      //                 child: Text(
                      //                   item,
                      //                   style: TextStyle(
                      //                       fontSize: 12.sp,
                      //                       fontWeight: kFW700,
                      //                       color: selectedTheme ==
                      //                               "Lighttheme"
                      //                           ? KdarkText
                      //                           : Kwhite),
                      //                 ),
                      //               ))
                      //           .toList(),
                      //       value: leavesController.str.value,
                      //       validator: (value) {
                      //         if (value == null) {
                      //           return 'Please select Type.';
                      //         }
                      //         return null;
                      //       },
                      //       //     onChanged: (dynamic str) {
                      //       //   setState(() {
                      //       //     data.leavetype = str;
                      //       //     data.leavetypeid = myLeavesTypes
                      //       //         .where((element) => element["leave_type_name"] == str)
                      //       //         .toList()[0]["leave_type_id"];
                      //       //   });
                      //       // },
                      //       onChanged: (String? value) {
                      //         setState(() {
                      //           leavesController.str.value = value!;
                      //           data.leavetype = leavesController.str.value;
                      //           data.leavetypeid = leavesController
                      //               .myLeavesTypes
                      //               .where((element) =>
                      //                   element["leave_type_name"] ==
                      //                   leavesController.str.value)
                      //               .toList()[0]["leave_type_id"];
                      //           debugPrint(
                      //               "leave Type ID = ${data.leavetypeid}");
                      //         });
                      //       },
                      //       buttonStyleData: const ButtonStyleData(
                      //         padding: EdgeInsets.symmetric(horizontal: 16),
                      //         height: 40,
                      //         width: 140,
                      //       ),
                      //       menuItemStyleData: const MenuItemStyleData(
                      //         height: 40,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      ////////////////////////////////////////////////////////////////////////////////////////
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Kwhite,
                      //     borderRadius: BorderRadius.circular(10.r),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         spreadRadius: 2,
                      //         blurRadius: 10,
                      //         offset: const Offset(0, 6),
                      //         color: Ktextcolor.withOpacity(0.2),
                      //       )
                      //     ],
                      //   ),
                      //   child:

                      ////////////////////////////////////////
                      // DropDownTextField(

                      //     clearOption: false,
                      //     textFieldFocusNode: textFieldFocusNode,
                      //     searchFocusNode: searchFocusNode,
                      //     // searchAutofocus: true,
                      //     dropDownItemCount: options.length,
                      //     searchShowCursor: false,
                      //     enableSearch: false,
                      //     searchKeyboardType: TextInputType.number,
                      //     dropDownList:
                      //     DropDownValueModel(name: 'name1', value: "value1")
                      //     ,

                      //     // DropDownValueModel(name: 'name1', value: "value1"),
                      //     // DropDownValueModel(
                      //     //     name: 'name2',
                      //     //     value: "value2",
                      //     //     toolTipMsg:
                      //     //         "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                      //     // DropDownValueModel(name: 'name3', value: "value3"),
                      //     // DropDownValueModel(
                      //     //     name: 'name4',
                      //     //     value: "value4",
                      //     //     toolTipMsg:
                      //     //         "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                      //     // DropDownValueModel(name: 'name5', value: "value5"),
                      //     // DropDownValueModel(name: 'name6', value: "value6"),
                      //     // DropDownValueModel(name: 'name7', value: "value7"),
                      //     //  DropDownValueModel(name: 'name8', value: "value8"),
                      //     onChanged: (dynamic str) {
                      //       setState(() {
                      //         data.leavetype = str;
                      //         data.leavetypeid = myLeavesTypes
                      //             .where(
                      //                 (element) => element["leave_type_name"] == str)
                      //             .toList()[0]["leave_type_id"];
                      //       });
                      //     }
                      //     //  onChanged: (val) {},
                      //     ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //         Column(
                      //           children: [
                      //             Text("Annual Applied Leaves",
                      //                 style: TextStyle(
                      //                     fontSize: 12.sp,
                      //                     fontWeight: kFW700,
                      //                     color: selectedTheme == "Lighttheme"
                      //                         ? KdarkText
                      //                         : Kwhite)),
                      //             SizedBox(
                      //               height: 10.h,
                      //             ),
                      //             Text(
                      //                 leavesController.myLeaveBalance["anual_eaves"]
                      //                         ["anual_applied"]
                      //                     .toString(),
                      //                 style: TextStyle(
                      //                     fontSize: 12.sp,
                      //                     fontWeight: kFW700,
                      //                     color: selectedTheme == "Lighttheme"
                      //                         ? KdarkText
                      //                         : Kwhite))
                      //           ],
                      //         ),
                      //         Column(
                      //           children: [
                      //             Text("Sick Applied Leaves",
                      //                 style: TextStyle(
                      //                     fontSize: 12.sp,
                      //                     fontWeight: kFW700,
                      //                     color: selectedTheme == "Lighttheme"
                      //                         ? KdarkText
                      //                         : Kwhite)),
                      //             SizedBox(
                      //               height: 10.h,
                      //             ),
                      //             Text(
                      //                 leavesController.myLeaveBalance["sick_leaves"]
                      //                         ["sick_applied"]
                      //                     .toString(),
                      //                 style: TextStyle(
                      //                     fontSize: 12.sp,
                      //                     fontWeight: kFW700,
                      //                     color: selectedTheme == "Lighttheme"
                      //                         ? KdarkText
                      //                         : Kwhite))
                      //           ],
                      //         ),
                      //         // Column(children: [
                      //         //   Text("Appled Leave", style: TextStyle(
                      //         //                       fontSize: 12.sp,
                      //         //                       fontWeight: kFW700,
                      //         //                       color: selectedTheme == "Lighttheme"
                      //         //                           ? KdarkText
                      //         //                           : Kwhite))
                      //         // ],)
                      //       ]),
                      // ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      Text("Select Date",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: kFW700,
                              color: KdarkText)),
                      SizedBox(height: 10.h),
                      Container(
                          margin: EdgeInsets.all(1.r),
                          padding: EdgeInsets.only(bottom: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Kwhite,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(3, 3),
                                color: Ktextcolor.withOpacity(0.2),
                              )
                            ],
                          ),
                          child: SfDateRangePicker(
                            enablePastDates: true,
                            monthViewSettings: DateRangePickerMonthViewSettings(
                                blackoutDates: myLeavesHolidaysList,
                                //  getListOfLeavesHoliday
                                // attendanceController.holydaysdates,
                                specialDates: myLeavesList),
                            monthCellStyle: const DateRangePickerMonthCellStyle(
                                blackoutDateTextStyle: TextStyle(
                                    color: kblack, fontWeight: FontWeight.bold),
                                textStyle: TextStyle(
                                    color: KlightText,
                                    fontWeight: FontWeight.bold),
                                // specialDatesDecoration: BoxDecoration(color: KOrange),
                                specialDatesTextStyle: TextStyle(
                                    color: KOrange,
                                    fontWeight: FontWeight.bold)),
                            startRangeSelectionColor: KOrange,
                            selectionColor: KOrange,
                            rangeSelectionColor: KOrange.withOpacity(0.3),
                            endRangeSelectionColor: KOrange,
                            onSelectionChanged: _onSelectionChanged,
                            view: DateRangePickerView.month,
                            selectionMode: DateRangePickerSelectionMode.range,
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      // Container(
                      //   padding: EdgeInsets.all(15.r),
                      //   // =======
                      //   //                       ),
                      //   //                       SizedBox(
                      //   //                         height: 20.h,
                      //   //                       ),
                      //   //                       CustomFormField(
                      //   //                         maxLines: 8,
                      //   //                         readOnly: false,
                      //   //                         labelText: "Reason",
                      //   //                         controller: reasoncontroller,
                      //   //                         hintText: "Reason",
                      //   //                         validator: (value) {
                      //   //                           if (value!.isEmpty) {
                      //   //                             return 'Please enter Reason';
                      //   //                           }
                      //   //                           return null;
                      //   //                         },
                      //   //                         onChanged: (value) {
                      //   //                           setState(() {
                      //   //                             data.reason = value;
                      //   //                           });
                      //   //                         },
                      //   //                       ),
                      //   //                       SizedBox(
                      //   //                         height: 30.h,
                      //   //                       ),
                      //   //                       CustomButton(
                      //   //                           margin: const EdgeInsets.all(15),
                      //   //                           height: 38.h,
                      //   // >>>>>>> master
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //       boxShadow: [
                      //         BoxShadow(
                      //           spreadRadius: 2,
                      //           blurRadius: 10,
                      //           offset: const Offset(0, 6),
                      //           color: Ktextcolor.withOpacity(0.2),
                      //         )
                      //       ],
                      //       borderRadius: BorderRadius.circular(10.r),
                      //       color: Kwhite),
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               CircleAvatar(
                      //                 radius: 5.r,
                      //                 backgroundColor: KOrange,
                      //               ),
                      //               SizedBox(
                      //                 width: 10.w,
                      //               ),
                      //               SizedBox(
                      //                 width: MediaQuery.of(context).size.width /
                      //                     1.4,
                      //                 child: Text(
                      //                   newrange == ""
                      //                       ? "select date"
                      //                       : newrange,
                      //                   // _range,
                      //                   // "Applied Leaves",
                      //                   overflow: TextOverflow.ellipsis,
                      //                   maxLines: 1,
                      //                   style: TextStyle(
                      //                       fontSize: 12.sp,
                      //                       fontWeight: kFW700,
                      //                       color: KdarkText),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       // SizedBox(
                      //       //   height: 15.h,
                      //       // ),
                      //       // Row(
                      //       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       //   crossAxisAlignment: CrossAxisAlignment.start,
                      //       //   children: [

                      //       //   ],
                      //       // ),
                      //       // SizedBox(
                      //       //   height: 5.h,
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      Text("Upload Document",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: kFW700,
                              color: KdarkText)),
                      SizedBox(height: 10.h),
                      // data.leavetype != "Sick Leave"
                      //     ? SizedBox()
                      //     :
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
                        child: selectedImage != null
                            ? Column(
                                children: [
                                  Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                    height: 130.h,
                                    width: double.infinity,
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                ],
                              )
                            : Text(
                                "",
                                textAlign: TextAlign.center,
                              ),
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
                                    "Upload Document",
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
                      CustomFormFields(
                        ontap: () {
                          //  Get.toNamed(kSearchPlaces);
                        },
                        controller: leavescontroller.EAleaveReasonController,
                        enabled: true,
                        labelColor: KText,
                        obscureText: false,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        fontSize: kFourteenFont,
                        fontWeight: FontWeight.w500,
                        hintText: "reason",
                        maxLines: 6,
                        readOnly: false,
                        label: 'Enter Reason',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Reason';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      leavescontroller.EAleaveReasonController.text == "" ||
                              selectedGenderValue == null ||
                              _range == "" ||
                              selectedImage == null
                          ? CustomButton(
                              height: 38.h,
                              width: double.infinity,
                              textColor: Kwhite.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20.r),
                              Color: KOrange.withOpacity(0.7),
                              fontSize: 13.sp,
                              fontWeight: kFW600,
                              label: "Submit",
                              isLoading: false,
                              onTap: () {
                                Fluttertoast.showToast(
                                  msg: "Please fill all fields",
                                );
                              })
                          : CustomButton(
                              height: 38.h,
                              width: double.infinity,
                              textColor: Kwhite,
                              borderRadius: BorderRadius.circular(20.r),
                              Color: KOrange,
                              fontSize: 13.sp,
                              fontWeight: kFW600,
                              label: "Submit",
                              isLoading: false,
                              onTap: () {
                                if (leavescontroller
                                            .EAleaveReasonController.text ==
                                        "" ||
                                    selectedGenderValue == null ||
                                    _range == "" ||
                                    selectedImage == null) {
                                  Fluttertoast.showToast(
                                    msg: "Please fill all fields",
                                  );
                                } else {
                                  var payload = {
                                    "leaveType": selectedGenderValue,
                                    "dateRange": _range,
                                    "reason": leavescontroller
                                        .EAleaveReasonController.text
                                  };

                                  leavescontroller.applyLeave(
                                      payload, selectedImage!);
                                }
                              }),

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4.5,
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(Map value, Map checkAvilablity) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              // height: 240.h,
              height: 245.h,

              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              // margin: EdgeInsets.only(left: .w,right: 20.w
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Image.asset(
                    "assets/images/leaves.png",
                    color: KOrange,
                    width: 50.w,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Leave Apply Status',
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: 14.sp,
                          fontWeight: kFW900)),
                  SizedBox(
                    height: 8.h,
                  ),
                  value["message"] != null
                      ? Text(value["message"],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: KdarkText,
                              fontSize: 11.sp,
                              fontWeight: kFW500))
                      : value["leave_status"] != null
                          ? Text("Leave Applied Successfully",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: KdarkText,
                                  fontSize: 11.sp,
                                  fontWeight: kFW500))
                          : const SizedBox(),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // checkAvilablity["msg"] != ""
                  //     ? Text(checkAvilablity["msg"],
                  //         maxLines: 2,
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //             color: KdarkText,
                  //             fontSize: kTenFont,
                  //             fontWeight: kFW500))
                  //     : value["leave_status"] != null
                  //         ? Text("Leave Type - " + value["leave_type"],
                  //             maxLines: 2,
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //                 color: KdarkText,
                  //                 fontSize: kTenFont,
                  //                 fontWeight: kFW500))
                  //         : const SizedBox(),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                          borderRadius: BorderRadius.circular(15.r),
                          margin: EdgeInsets.all(10.r),
                          width: 110.w,
                          height: 35.h,
                          Color: KOrange,
                          textColor: Kwhite,
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          label: "Ok",
                          isLoading: false,
                          onTap: () {
                            setState(() {
                              selectedValue = null;
                              data.leavetype = "";
                              data.leavetypeid = 0;

                              // leavesController.str.value = "Select Type";
                            });
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
