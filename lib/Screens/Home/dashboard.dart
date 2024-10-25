import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:eattendance/untils/export_file.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ProfileController profilecontroller = Get.put(ProfileController());
  DashboardController dashboardController = Get.put(DashboardController());
  /////////////////////////////////////////////////////////////////////////////////////////////////////address
  ServiceController serviceController = Get.put(ServiceController());
  var isLaodingMapsData = "none".obs;
  bool isLoading = false;
  Future<void> getCurrentLocation() async {
    isLaodingMapsData.value = "started";
    Position? position = await _determinePosition();
    setState(() {
      serviceController.position = position;
      serviceController.latittude = serviceController.position!.latitude;
      serviceController.longitude = serviceController.position!.longitude;
      _getAddressFromLatLng(position!);
    });
  }

  String? _currentAddress;
  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(serviceController.position!.latitude,
            serviceController.position!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.postalCode}';
        serviceController.address.value = _currentAddress.toString();
        serviceController.addressLatitude.value =
            serviceController.position!.latitude.toString();
        serviceController.addressLongitude.value =
            serviceController.position!.longitude.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<Position?> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      } else {
        await _showMyDialog();
        if (isPermissionGiven == true) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }
        } else {
          Fluttertoast.showToast(
            msg: "Denined Location Will Failed To Upload Attendance",
          );
        }
      }
    } else {
      setState(() {
        isPermissionGiven = true;
      });
    }
    Position? newPosition;
    try {
      newPosition = await Geolocator.getCurrentPosition();
      serviceController.loacationIsEnabled(true);
      debugPrint(newPosition.toString());
    } catch (e) {
      debugPrint("$e");
      setState(() {
        isLoading = false;
      });
      serviceController.loacationIsEnabled(false);
    }
    setState(() {
      isLaodingMapsData.value = "ended";
    });
    return newPosition!;
  }

  bool isPermissionGiven = false;
  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 350.h,

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
                  Text('Location Permission',
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: 14.sp,
                          fontWeight: kFW900)),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                      'EAttendance App wants to collect Your Location Info to MarkUp your Attendance',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: kTenFont,
                          fontWeight: kFW500)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Image.asset(
                    "assets/images/location.png",
                    width: 150.w,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      CustomButton(
                          borderRadius: BorderRadius.circular(15.r),
                          margin: EdgeInsets.all(10.r),
                          width: 110.w,
                          height: 35.h,
                          Color: KOrange,
                          textColor: KOrange,
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          label: "Cancel",
                          isLoading: false,
                          onTap: () {
                            setState(() {
                              isPermissionGiven = false;
                            });
                            Navigator.of(context).pop();
                          }),
                      CustomButton(
                          borderRadius: BorderRadius.circular(15.r),
                          margin: EdgeInsets.all(10.r),
                          width: 110.w,
                          height: 35.h,
                          Color: KOrange,
                          textColor: Kwhite,
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          label: "Accept",
                          isLoading: false,
                          onTap: () {
                            setState(() {
                              isPermissionGiven = true;
                            });
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          );
        });
  }

  ////////////////////////////////////////////////////////////////////////address
  final _formKey = GlobalKey<FormState>();
  String selectedgender = "";
  // location

  int activeIndex = 0;

  // bool value = false;
  // // final Completer<GoogleMapController> _controller =
  // //     Completer<GoogleMapController>();
  // // GoogleMapController? _controller;

  // double lat = 37.42796133580664;
  // double lon = -122.085749655962;

  // String? _currentAddress;
  // String? _currentAddresspincode;
  // String? _destination;

  // var isLoading = "none";

  // var sourceLocation = "Your Location".obs;

  /////////////////////////////
  final List<String> bloodgroupss = ['SuperAdmin', 'Admin', 'Employee'];

  //
  final List<String> Genders = [
    'Male',
    'Female',
    'Others',
  ];

  String? selectedValue;
  String? selectedGenderValue;
  DateTime selectedDate = DateTime.now();
  DateTime choosenDate = DateTime.now();
  var selectDate = "Select Date".obs;

  bool passwordVisible = true;
  bool confirmpasswordVisible = true;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: GoogleFonts.roboto(
                  fontSize: kEighteenFont,
                  fontWeight: kFW600,
                  color: Ktextcolor),
            ),
            content: Text(
              'Do you want to exit this App',
              style: GoogleFonts.roboto(
                  fontSize: 13.sp, fontWeight: kFW600, color: KText),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: GoogleFonts.roboto(
                      fontSize: kTwelveFont,
                      fontWeight: kFW600,
                      color: KdarkText),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  'Yes',
                  style: GoogleFonts.roboto(
                      fontSize: kTwelveFont,
                      fontWeight: kFW600,
                      color: KOrange),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

/////////////////////////////////////////////////////
  void checkinCheck(double latA, double lonA, double latB, lonB) {
    // Coordinates of A and B
    // double latA = 17.458739523771314;
    // double lonA = 78.37052715528468;
    // double latB = 17.458526280598058;
    // double lonB = 78.372523040299;

    // Calculate the distance between A and B
    double distanceInMeters =
        Geolocator.distanceBetween(latA, lonA, latB, lonB);

    // Check if the distance is within 30 meters
    if (distanceInMeters <= 30) {
      print('Location B is within 30 meters of Location A.');
      var payload = {
        "date": DateFormat('MM/dd/yyyy').format(DateTime.now()),
        "startTime": DateFormat('HH:mm').format(DateTime.now()),
        "longitude": serviceController.addressLongitude.value,
        "latitude": serviceController.addressLatitude.value,
        "address": serviceController.address.value,
      };

      dashboardController.checkinAttendance(payload);
      dashboardController
          .todayStatusData(DateFormat('MM-dd-yyyy').format(DateTime.now()));
    } else {
      print('Location B is more than 30 meters away from Location A.');
    }

    print('Distance: $distanceInMeters meters');
  }

  ///
  void checkoutCheck(double latA, double lonA, double latB, lonB) {
    // Coordinates of A and B
    // double latA = 17.458739523771314;
    // double lonA = 78.37052715528468;
    // double latB = 17.458526280598058;
    // double lonB = 78.372523040299;

    // Calculate the distance between A and B
    double distanceInMeters =
        Geolocator.distanceBetween(latA, lonA, latB, lonB);

    // Check if the distance is within 30 meters
    if (distanceInMeters <= 30) {
      print('Location B is within 30 meters of Location A.');
      var payload = {
        "date": DateFormat('MM/dd/yyyy').format(DateTime.now()),
        "endTime": DateFormat('HH:mm').format(DateTime.now()),
        "longitude": serviceController.addressLongitude.value,
        "latitude": serviceController.addressLatitude.value,
        "address": serviceController.address.value,
      };

      // dashboardController
      //     .checkinAttendance(payload);
      dashboardController.checkoutAttendance(payload);
      dashboardController
          .todayStatusData(DateFormat('MM-dd-yyyy').format(DateTime.now()));
    } else {
      print('Location B is more than 30 meters away from Location A.');
    }

    print('Distance: $distanceInMeters meters');
  }

////////////////////////////////////
  @override
  void initState() {
    profilecontroller.getEAProfileTwo();
    profilecontroller.getEAProfileTwo();
    // profilecontroller.getEAProfile();
    getCurrentLocation();
    dashboardController
        .todayStatusData(DateFormat('MM-dd-yyyy').format(DateTime.now()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     automaticallyImplyLeading: false,
        //     backgroundColor: Kwhite,
        //     leadingWidth: 50.w,
        //     leading: Padding(
        //         padding: EdgeInsets.only(left: 15.w),
        //         child: CircleAvatar(
        //           backgroundColor: Kwhite,
        //           radius: 35.r,
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(200.r),
        //             child: Image.asset(
        //               "assets/images/profileImageStatic.png",
        //               // height: 150.h,
        //               height: 35.h,
        //               width: 35.w,
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //         )),
        //     title: SizedBox(
        //         width: 180.w,
        //         child: Text(
        //           "Welcome Ram Nayak",
        //           maxLines: 2,
        //           style: GoogleFonts.roboto(
        //               fontSize: kEighteenFont,
        //               color: kblack,
        //               fontWeight: kFW500),
        //         ))),
        // appBar: AppBar(
        //   backgroundColor: Kwhite,
        // ),
        backgroundColor: Kwhite,
        body: Obx(
          () =>
              //dashboardController.todayStatusLoading == true ||
              dashboardController.checkoutLoading == true ||
                      dashboardController.checkinLoading == true ||
                      profilecontroller.profiledataLoading == true
                  ? Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 100.h),
                      child: CircularProgressIndicator(
                        color: KOrange,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.r),
                            height: MediaQuery.of(context).size.height / 3.3,
                            width: double.infinity,
                            color: KOrange,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(kProfileScreen);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      profilecontroller
                                                  .profileData["profilePic"] ==
                                              null
                                          ? CircleAvatar(
                                              backgroundColor: Kwhite,
                                              radius: 22.r,
                                              child: Image.asset(
                                                "assets/images/profileImageStatic.png",
                                                // height: 150.h,
                                                height: 50.h,
                                                width: 50.w,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor: Kwhite,
                                              radius: 22.r,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        200.r),
                                                child: CachedNetworkImage(
                                                  imageUrl: kBaseImageUrl +
                                                      profilecontroller
                                                              .profileData[
                                                          "profilePic"],
                                                  placeholder: (context, url) =>
                                                      SizedBox(
                                                    height: 50.h,
                                                    width: 50.w,
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
                                                        height: 50.h,
                                                        width: 50.w,
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          CircleAvatar(
                                                    backgroundColor: Kwhite,
                                                    radius: 22.r,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200.r),
                                                      child: Image.asset(
                                                        "assets/images/profileImageStatic.png",
                                                        // height: 150.h,
                                                        height: 50.h,
                                                        width: 50.w,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  height: 50.h,
                                                  width: 50.w,
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
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hi! ,${profilecontroller.profileData["firstName"]} ${profilecontroller.profileData["lastName"]}",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: Kwhite,
                                                fontWeight: kFW600),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            "Mark your attendence",
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                color: Kwhite,
                                                fontWeight: kFW600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //  "date": "2024-09-11",
                          //"startTime": "09:00:00"

                          // InkWell(
                          //   onTap: () {
                          //     var payload = {
                          //       "date": DateFormat('MM/dd/yyyy').format(DateTime.now()),
                          //       "startTime": DateFormat('HH:mm').format(DateTime.now())
                          //     };

                          //     dashboardController.checkinAttendance(payload);
                          //   },
                          //   child:
                          Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 6,
                                  left: 16.w,
                                  right: 16.w,
                                  bottom: 16.h),
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
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
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    "${TimeOfDay.fromDateTime(DateTime.now()).format(context)} ",
                                    style: GoogleFonts.roboto(
                                        fontSize: 22.sp,
                                        color: KdarkText,
                                        fontWeight: kFW600),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    DateFormat('MMMM dd, yyyy - EEEE')
                                        .format(DateTime.now()),
                                    style: GoogleFonts.roboto(
                                        fontSize: kFourteenFont,
                                        color: Ktextcolor,
                                        fontWeight: kFW400),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Obx(
                                    () => serviceController.address.value == ""
                                        ? Text(
                                            "No Location Address Found",
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                color: Ktextcolor,
                                                fontWeight: kFW400),
                                          )
                                        : Text(
                                            serviceController.address.value,
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                color: Ktextcolor,
                                                fontWeight: kFW400),
                                          ),
                                  ),

                                  Container(
                                      height: 130.h,
                                      margin: EdgeInsets.only(top: 20.h),
                                      width: 130.w,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                KOrange,
                                                KOrange.withOpacity(0.3)
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter),
                                          shape: BoxShape.circle),
                                      child: Obx(() => dashboardController
                                                          .todayStatus[
                                                      "startTime"] !=
                                                  null &&
                                              dashboardController
                                                      .todayStatus["endTime"] !=
                                                  null
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ClipOval(
                                                  child: Image.asset(
                                                    "assets/images/finger_print.png",
                                                    // height: 150.h,
                                                    height: 50.h,
                                                    width: 50.w,
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  "COMPLETED",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: kFourteenFont,
                                                      color: Kwhite.withOpacity(
                                                          0.8),
                                                      fontWeight: kFW600),
                                                ),
                                              ],
                                            )
                                          : dashboardController.todayStatus[
                                                      "startTime"] ==
                                                  null
                                              ? InkWell(
                                                  onTap: () async {
                                                    if (serviceController
                                                            .address.value ==
                                                        "") {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "Please wait location loading..",
                                                      );
                                                    } else {
                                                      // if (profilecontroller
                                                      //             .profileData[
                                                      //         "companyName"] ==
                                                      //     "Nuhvin Global Services Private Limited") {
                                                      //   checkinCheck(
                                                      //       double.parse(profilecontroller
                                                      //                   .profileData[
                                                      //               "location"]
                                                      //           ["latitude"]),
                                                      //       double.parse(profilecontroller
                                                      //                   .profileData[
                                                      //               "location"]
                                                      //           ["longitude"]),
                                                      //       double.parse(
                                                      //           serviceController
                                                      //               .addressLatitude
                                                      //               .value),
                                                      //       double.parse(
                                                      //           serviceController
                                                      //               .addressLongitude
                                                      //               .value));
                                                      // } else {
                                                      var payload = {
                                                        "date": DateFormat(
                                                                'MM/dd/yyyy')
                                                            .format(
                                                                DateTime.now()),
                                                        "startTime": DateFormat(
                                                                'HH:mm')
                                                            .format(
                                                                DateTime.now()),
                                                        "longitude":
                                                            serviceController
                                                                .addressLongitude
                                                                .value,
                                                        "latitude":
                                                            serviceController
                                                                .addressLatitude
                                                                .value,
                                                        "address":
                                                            serviceController
                                                                .address.value,
                                                      };

                                                      dashboardController
                                                          .checkinAttendance(
                                                              payload);
                                                      dashboardController
                                                          .todayStatusData(
                                                              DateFormat(
                                                                      'MM-dd-yyyy')
                                                                  .format(DateTime
                                                                      .now()));
                                                    }
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipOval(
                                                        child: Image.asset(
                                                          "assets/images/finger_print.png",
                                                          // height: 150.h,
                                                          height: 50.h,
                                                          width: 50.w,
                                                          fit: BoxFit.fitHeight,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Text(
                                                        "CHECK IN",
                                                        style: GoogleFonts.roboto(
                                                            fontSize:
                                                                kFourteenFont,
                                                            color: Kwhite
                                                                .withOpacity(
                                                                    0.8),
                                                            fontWeight: kFW600),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    if (serviceController
                                                                .address
                                                                .value ==
                                                            "" ||
                                                        serviceController
                                                                .address
                                                                .value ==
                                                            null) {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "Please wait location loading..",
                                                      );
                                                    } else {
                                                      // if (profilecontroller
                                                      //             .profileData[
                                                      //         "companyName"] ==
                                                      //     "Nuhvin Global Services Private Limited") {
                                                      //   checkoutCheck(
                                                      //       double.parse(profilecontroller
                                                      //                   .profileData[
                                                      //               "location"]
                                                      //           ["latitude"]),
                                                      //       double.parse(profilecontroller
                                                      //                   .profileData[
                                                      //               "location"]
                                                      //           ["longitude"]),
                                                      //       double.parse(
                                                      //           serviceController
                                                      //               .addressLatitude
                                                      //               .value),
                                                      //       double.parse(
                                                      //           serviceController
                                                      //               .addressLongitude
                                                      //               .value));
                                                      // } else {
                                                      var payload = {
                                                        "date": DateFormat(
                                                                'MM/dd/yyyy')
                                                            .format(
                                                                DateTime.now()),
                                                        "endTime": DateFormat(
                                                                'HH:mm')
                                                            .format(
                                                                DateTime.now()),
                                                        "longitude":
                                                            serviceController
                                                                .addressLongitude
                                                                .value,
                                                        "latitude":
                                                            serviceController
                                                                .addressLatitude
                                                                .value,
                                                        "address":
                                                            serviceController
                                                                .address.value,
                                                      };

                                                      // dashboardController
                                                      //     .checkinAttendance(payload);
                                                      dashboardController
                                                          .checkoutAttendance(
                                                              payload);
                                                      dashboardController
                                                          .todayStatusData(
                                                              DateFormat(
                                                                      'MM-dd-yyyy')
                                                                  .format(DateTime
                                                                      .now()));
                                                    }
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipOval(
                                                        child: Image.asset(
                                                          "assets/images/finger_print.png",
                                                          // height: 150.h,
                                                          height: 50.h,
                                                          width: 50.w,
                                                          fit: BoxFit.fitHeight,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Text(
                                                        "CHECK OUT",
                                                        style: GoogleFonts.roboto(
                                                            fontSize:
                                                                kFourteenFont,
                                                            color: Kwhite
                                                                .withOpacity(
                                                                    0.8),
                                                            fontWeight: kFW600),
                                                      ),
                                                    ],
                                                  ),
                                                ))),
                                  SizedBox(
                                    height: 30.h,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Icon(Icons.av_timer_outlined),
                                          Text(
                                            dashboardController
                                                    .todayStatus["startTime"] ??
                                                "",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: KdarkText,
                                                fontWeight: kFW500),
                                          ),
                                          Text(
                                            "Check In",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: Ktextcolor,
                                                fontWeight: kFW500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      Column(
                                        children: [
                                          Icon(Icons.av_timer_outlined),
                                          Text(
                                            dashboardController
                                                    .todayStatus["endTime"] ??
                                                "",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: KdarkText,
                                                fontWeight: kFW500),
                                          ),
                                          Text(
                                            "Check Out",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: Ktextcolor,
                                                fontWeight: kFW500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      Column(
                                        children: [
                                          Icon(Icons.av_timer_outlined),
                                          dashboardController.todayStatus[
                                                          "startTime"] ==
                                                      null ||
                                                  dashboardController
                                                              .todayStatus[
                                                          "endTime"] ==
                                                      null
                                              ? Text("")
                                              : Text(
                                                  // Parse start and end times, and calculate the difference
                                                  (() {
                                                    Duration diff = DateFormat(
                                                            "HH:mm")
                                                        .parse(
                                                            dashboardController
                                                                    .todayStatus[
                                                                "endTime"])
                                                        .difference(DateFormat(
                                                                "HH:mm")
                                                            .parse(dashboardController
                                                                    .todayStatus[
                                                                "startTime"]));

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
                                          //   // Parse start and end times, and calculate the difference
                                          //   (DateFormat("HH:mm")
                                          //               .parse(
                                          //                   dashboardController
                                          //                           .todayStatus[
                                          //                       "endTime"])
                                          //               .difference(DateFormat(
                                          //                       "HH:mm")
                                          //                   .parse(dashboardController
                                          //                           .todayStatus[
                                          //                       "startTime"])))
                                          //           .inMinutes
                                          //           .toString() +
                                          //       ' minutes', // Format the difference to string

                                          //   style: GoogleFonts.roboto(
                                          //     fontSize: kTwelveFont,
                                          //     color: KdarkText,
                                          //     fontWeight: kFW500,
                                          //   ),
                                          // ),

                                          // Text(
                                          //   DateFormat("HH:mm")
                                          //       .parse(dashboardController
                                          //           .todayStatus["endTime"])
                                          //       .difference(DateFormat("HH:mm")
                                          //           .parse(dashboardController
                                          //                   .todayStatus[
                                          //               "startTime"])) as String,
                                          //   style: GoogleFonts.roboto(
                                          //       fontSize: kTwelveFont,
                                          //       color: KdarkText,
                                          //       fontWeight: kFW500),
                                          // ),
                                          Text(
                                            "Total Hours",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: Ktextcolor,
                                                fontWeight: kFW500),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  /////////////////////////////
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Text(
                                  //     "Attendance",
                                  //     style: GoogleFonts.roboto(
                                  //         fontSize: kEighteenFont,
                                  //         color: KdarkText,
                                  //         fontWeight: kFW500),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 2.h,
                                  // ),
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Text(
                                  //     "Current Month",
                                  //     style: GoogleFonts.roboto(
                                  //         fontSize: kTwelveFont,
                                  //         color: Ktextcolor,
                                  //         fontWeight: kFW400),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 12.h,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Stack(
                                  //       children: [
                                  //         Container(
                                  //             height: 90.h,
                                  //             width: 130,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10),
                                  //                 color: KOrange.withOpacity(
                                  //                     0.7))),
                                  //         Positioned(
                                  //           top: 4.h,
                                  //           child: Container(
                                  //             height: 86.h,
                                  //             padding: EdgeInsets.all(10.r),
                                  //             width: 130,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10),
                                  //                 color: Kwhite),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Text(
                                  //                   "00",
                                  //                   style: GoogleFonts.roboto(
                                  //                       fontSize: kEighteenFont,
                                  //                       color: KOrange,
                                  //                       fontWeight: kFW600),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 8.h,
                                  //                 ),
                                  //                 Row(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment
                                  //                           .spaceBetween,
                                  //                   children: [
                                  //                     Text(
                                  //                       "Early Leave",
                                  //                       style:
                                  //                           GoogleFonts.roboto(
                                  //                               fontSize:
                                  //                                   kTwelveFont,
                                  //                               color: KOrange
                                  //                                   .withOpacity(
                                  //                                       0.7),
                                  //                               fontWeight:
                                  //                                   kFW400),
                                  //                     ),
                                  //                     Icon(
                                  //                       Icons.arrow_forward_ios,
                                  //                       size: kTwelveFont,
                                  //                       color:
                                  //                           KOrange.withOpacity(
                                  //                               0.7),
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Stack(
                                  //       children: [
                                  //         Container(
                                  //             height: 90.h,
                                  //             width: 130,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10),
                                  //                 color: Colors.purple
                                  //                     .withOpacity(0.7))),
                                  //         Positioned(
                                  //           top: 4.h,
                                  //           child: Container(
                                  //             height: 86.h,
                                  //             padding: EdgeInsets.all(10.r),
                                  //             width: 130,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10),
                                  //                 color: Kwhite),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Text(
                                  //                   "00",
                                  //                   style: GoogleFonts.roboto(
                                  //                       fontSize: kEighteenFont,
                                  //                       color: Colors.purple,
                                  //                       fontWeight: kFW600),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 8.h,
                                  //                 ),
                                  //                 Row(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment
                                  //                           .spaceBetween,
                                  //                   children: [
                                  //                     Text(
                                  //                       "Absents",
                                  //                       style:
                                  //                           GoogleFonts.roboto(
                                  //                               fontSize:
                                  //                                   kTwelveFont,
                                  //                               color: Colors
                                  //                                   .purple
                                  //                                   .withOpacity(
                                  //                                       0.7),
                                  //                               fontWeight:
                                  //                                   kFW400),
                                  //                     ),
                                  //                     Icon(
                                  //                       Icons.arrow_forward_ios,
                                  //                       size: kTwelveFont,
                                  //                       color: Colors.purple
                                  //                           .withOpacity(0.7),
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     )
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 12.h,
                                  // ),
                                  //  Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Stack(
                                  //       children: [
                                  //         Container(
                                  //             height: 90.h,
                                  //             width: 130,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10),
                                  //                 color: Colors.blue
                                  //                     .withOpacity(0.7))),
                                  //         Positioned(
                                  //           top: 4.h,
                                  //           child: Container(
                                  //             height: 86.h,
                                  //             padding: EdgeInsets.all(10.r),
                                  //             width: 130,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10),
                                  //                 color: Kwhite),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Text(
                                  //                   "00",
                                  //                   style: GoogleFonts.roboto(
                                  //                       fontSize: kEighteenFont,
                                  //                       color: Colors.blue,
                                  //                       fontWeight: kFW600),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 8.h,
                                  //                 ),
                                  //                 Row(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment
                                  //                           .spaceBetween,
                                  //                   children: [
                                  //                     Text(
                                  //                       "Late",
                                  //                       style:
                                  //                           GoogleFonts.roboto(
                                  //                               fontSize:
                                  //                                   kTwelveFont,
                                  //                               color: Colors
                                  //                                   .blue
                                  //                                   .withOpacity(
                                  //                                       0.7),
                                  //                               fontWeight:
                                  //                                   kFW400),
                                  //                     ),
                                  //                     Icon(
                                  //                       Icons.arrow_forward_ios,
                                  //                       size: kTwelveFont,
                                  //                       color: Colors.blue
                                  //                           .withOpacity(0.7),
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Stack(
                                  //       children: [
                                  //         Container(
                                  //             height: 90.h,
                                  //             width: 130,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10),
                                  //                 color: Colors.redAccent
                                  //                     .withOpacity(0.7))),
                                  //         Positioned(
                                  //           top: 4.h,
                                  //           child: Container(
                                  //             height: 86.h,
                                  //             padding: EdgeInsets.all(10.r),
                                  //             width: 130,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10),
                                  //                 color: Kwhite),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Text(
                                  //                   "00",
                                  //                   style: GoogleFonts.roboto(
                                  //                       fontSize: kEighteenFont,
                                  //                       color: Colors.redAccent,
                                  //                       fontWeight: kFW600),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 8.h,
                                  //                 ),
                                  //                 Row(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment
                                  //                           .spaceBetween,
                                  //                   children: [
                                  //                     Text(
                                  //                       "Total Leaves",
                                  //                       style:
                                  //                           GoogleFonts.roboto(
                                  //                               fontSize:
                                  //                                   kTwelveFont,
                                  //                               color: Colors
                                  //                                   .redAccent
                                  //                                   .withOpacity(
                                  //                                       0.7),
                                  //                               fontWeight:
                                  //                                   kFW400),
                                  //                     ),
                                  //                     Icon(
                                  //                       Icons.arrow_forward_ios,
                                  //                       size: kTwelveFont,
                                  //                       color: Colors.redAccent
                                  //                           .withOpacity(0.7),
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     )
                                  //   ],
                                  // ),

                                  ////////////////////////////////
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Actions",
                                      style: GoogleFonts.roboto(
                                          fontSize: kEighteenFont,
                                          color: KdarkText,
                                          fontWeight: kFW500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  ActionsCards(),
                                  SizedBox(
                                    height: 60.h,
                                  ),

                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () {
                                  //         Get.toNamed(kApproveScreen);
                                  //       },
                                  //       child: Row(
                                  //         children: [
                                  //           Container(
                                  //             width: 140.w,
                                  //             padding: EdgeInsets.all(10),
                                  //             // margin: EdgeInsets.only(top: 10.h),
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.orange
                                  //                     .withOpacity(0.7),
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Ktextcolor
                                  //                         .withOpacity(0.0),
                                  //                     blurRadius: 5,
                                  //                     offset:
                                  //                         const Offset(0, 0),
                                  //                     spreadRadius: 2,
                                  //                   )
                                  //                 ],
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         10.r)),
                                  //             //margin: EdgeInsets.all(13.r),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Image.asset(
                                  //                   "assets/images/ok.png",
                                  //                   height: 23.h,
                                  //                   //color: Actions[i]["color"],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 12.h,
                                  //                 ),
                                  //                 Text(
                                  //                   "Quick Approvals",
                                  //                   maxLines: 2,
                                  //                   textAlign: TextAlign.left,
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   style: TextStyle(
                                  //                       fontSize: 13.sp,
                                  //                       fontWeight: kFW600,
                                  //                       color: Kwhite),
                                  //                 ),
                                  //                 Image.asset(
                                  //                   "assets/images/white_arrow.png",
                                  //                   height: 30.h,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     InkWell(
                                  //       onTap: () {
                                  //         Get.toNamed(kApplyLeaveScreen);
                                  //       },
                                  //       child: Row(
                                  //         children: [
                                  //           Container(
                                  //             width: 140.w,
                                  //             padding: EdgeInsets.all(10),
                                  //             // margin: EdgeInsets.only(top: 10.h),
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.purple
                                  //                     .withOpacity(0.7),
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Ktextcolor
                                  //                         .withOpacity(0.0),
                                  //                     blurRadius: 5,
                                  //                     offset:
                                  //                         const Offset(0, 0),
                                  //                     spreadRadius: 2,
                                  //                   )
                                  //                 ],
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         10.r)),
                                  //             //margin: EdgeInsets.all(13.r),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Image.asset(
                                  //                   "assets/images/ok.png",
                                  //                   height: 23.h,
                                  //                   //color: Actions[i]["color"],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 12.h,
                                  //                 ),
                                  //                 Text(
                                  //                   "Apply Leaves",
                                  //                   maxLines: 2,
                                  //                   textAlign: TextAlign.left,
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   style: TextStyle(
                                  //                       fontSize: 13.sp,
                                  //                       fontWeight: kFW600,
                                  //                       color: Kwhite),
                                  //                 ),
                                  //                 Image.asset(
                                  //                   "assets/images/white_arrow.png",
                                  //                   height: 30.h,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () {
                                  //         Get.toNamed(kAttendanceScreen);
                                  //       },
                                  //       child: Row(
                                  //         children: [
                                  //           Container(
                                  //             width: 140.w,
                                  //             padding: EdgeInsets.all(10),
                                  //             // margin: EdgeInsets.only(top: 10.h),
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.blue
                                  //                     .withOpacity(0.7),
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Ktextcolor
                                  //                         .withOpacity(0.0),
                                  //                     blurRadius: 5,
                                  //                     offset:
                                  //                         const Offset(0, 0),
                                  //                     spreadRadius: 2,
                                  //                   )
                                  //                 ],
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         10.r)),
                                  //             //margin: EdgeInsets.all(13.r),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Image.asset(
                                  //                   "assets/images/ok.png",
                                  //                   height: 23.h,
                                  //                   //color: Actions[i]["color"],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 12.h,
                                  //                 ),
                                  //                 Text(
                                  //                   "Attendance",
                                  //                   maxLines: 2,
                                  //                   textAlign: TextAlign.left,
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   style: TextStyle(
                                  //                       fontSize: 13.sp,
                                  //                       fontWeight: kFW600,
                                  //                       color: Kwhite),
                                  //                 ),
                                  //                 Image.asset(
                                  //                   "assets/images/white_arrow.png",
                                  //                   height: 30.h,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     InkWell(
                                  //       onTap: () {
                                  //         Get.toNamed(kLeavelistScreen);
                                  //       },
                                  //       child: Row(
                                  //         children: [
                                  //           Container(
                                  //             width: 140.w,
                                  //             padding: EdgeInsets.all(10),
                                  //             // margin: EdgeInsets.only(top: 10.h),
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.red
                                  //                     .withOpacity(0.7),
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Ktextcolor
                                  //                         .withOpacity(0.0),
                                  //                     blurRadius: 5,
                                  //                     offset:
                                  //                         const Offset(0, 0),
                                  //                     spreadRadius: 2,
                                  //                   )
                                  //                 ],
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         10.r)),
                                  //             //margin: EdgeInsets.all(13.r),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Image.asset(
                                  //                   "assets/images/ok.png",
                                  //                   height: 23.h,
                                  //                   //color: Actions[i]["color"],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 12.h,
                                  //                 ),
                                  //                 Text(
                                  //                   "Leaves History",
                                  //                   maxLines: 2,
                                  //                   textAlign: TextAlign.left,
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   style: TextStyle(
                                  //                       fontSize: 13.sp,
                                  //                       fontWeight: kFW600,
                                  //                       color: Kwhite),
                                  //                 ),
                                  //                 Image.asset(
                                  //                   "assets/images/white_arrow.png",
                                  //                   height: 30.h,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 8.h,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () {
                                  //         Get.toNamed(kEmployeesScreen);
                                  //       },
                                  //       child: Row(
                                  //         children: [
                                  //           Container(
                                  //             width: 140.w,
                                  //             padding: EdgeInsets.all(10),
                                  //             // margin: EdgeInsets.only(top: 10.h),
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.deepPurple
                                  //                     .withOpacity(0.8),
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Ktextcolor
                                  //                         .withOpacity(0.0),
                                  //                     blurRadius: 5,
                                  //                     offset:
                                  //                         const Offset(0, 0),
                                  //                     spreadRadius: 2,
                                  //                   )
                                  //                 ],
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         10.r)),
                                  //             //margin: EdgeInsets.all(13.r),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Image.asset(
                                  //                   "assets/images/ok.png",
                                  //                   height: 23.h,
                                  //                   //color: Actions[i]["color"],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 12.h,
                                  //                 ),
                                  //                 Text(
                                  //                   "Employees",
                                  //                   maxLines: 2,
                                  //                   textAlign: TextAlign.left,
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   style: TextStyle(
                                  //                       fontSize: 13.sp,
                                  //                       fontWeight: kFW600,
                                  //                       color: Kwhite),
                                  //                 ),
                                  //                 Image.asset(
                                  //                   "assets/images/white_arrow.png",
                                  //                   height: 30.h,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     InkWell(
                                  //       onTap: () {
                                  //         Get.toNamed(kNotApprovedEmployess);
                                  //       },
                                  //       child: Row(
                                  //         children: [
                                  //           Container(
                                  //             width: 140.w,
                                  //             padding: EdgeInsets.all(10),
                                  //             // margin: EdgeInsets.only(top: 10.h),
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.yellow
                                  //                     .withOpacity(0.8),
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Ktextcolor
                                  //                         .withOpacity(0.0),
                                  //                     blurRadius: 5,
                                  //                     offset:
                                  //                         const Offset(0, 0),
                                  //                     spreadRadius: 2,
                                  //                   )
                                  //                 ],
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         10.r)),
                                  //             //margin: EdgeInsets.all(13.r),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Image.asset(
                                  //                   "assets/images/ok.png",
                                  //                   height: 23.h,
                                  //                   //color: Actions[i]["color"],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 12.h,
                                  //                 ),
                                  //                 Text(
                                  //                   "Approve Employees",
                                  //                   maxLines: 2,
                                  //                   textAlign: TextAlign.left,
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   style: TextStyle(
                                  //                       fontSize: 13.sp,
                                  //                       fontWeight: kFW600,
                                  //                       color: Kwhite),
                                  //                 ),
                                  //                 Image.asset(
                                  //                   "assets/images/white_arrow.png",
                                  //                   height: 30.h,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () {
                                  //         Get.toNamed(kHRPermissions);
                                  //       },
                                  //       child: Row(
                                  //         children: [
                                  //           Container(
                                  //             width: 140.w,
                                  //             padding: EdgeInsets.all(10),
                                  //             // margin: EdgeInsets.only(top: 10.h),
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.deepOrange
                                  //                     .withOpacity(0.8),
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Ktextcolor
                                  //                         .withOpacity(0.0),
                                  //                     blurRadius: 5,
                                  //                     offset:
                                  //                         const Offset(0, 0),
                                  //                     spreadRadius: 2,
                                  //                   )
                                  //                 ],
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         10.r)),
                                  //             //margin: EdgeInsets.all(13.r),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Image.asset(
                                  //                   "assets/images/ok.png",
                                  //                   height: 23.h,
                                  //                   //color: Actions[i]["color"],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 12.h,
                                  //                 ),
                                  //                 Text(
                                  //                   "Admin Actions",
                                  //                   maxLines: 2,
                                  //                   textAlign: TextAlign.left,
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   style: TextStyle(
                                  //                       fontSize: 13.sp,
                                  //                       fontWeight: kFW600,
                                  //                       color: Kwhite),
                                  //                 ),
                                  //                 Image.asset(
                                  //                   "assets/images/white_arrow.png",
                                  //                   height: 30.h,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     InkWell(
                                  //       onTap: () {
                                  //         showDialog(
                                  //             context: context,
                                  //             builder: (BuildContext context) {
                                  //               return AlertDialog(
                                  //                 title: Text('Are You Sure',
                                  //                     maxLines: 1,
                                  //                     overflow:
                                  //                         TextOverflow.ellipsis,
                                  //                     style: GoogleFonts.roboto(
                                  //                         fontSize: 12.sp,
                                  //                         fontWeight: kFW700,
                                  //                         color: KdarkText)),
                                  //                 content: Text(
                                  //                     'You Want To LogOut ?',
                                  //                     maxLines: 2,
                                  //                     overflow:
                                  //                         TextOverflow.ellipsis,
                                  //                     style: GoogleFonts.roboto(
                                  //                         fontSize: 12.sp,
                                  //                         fontWeight: kFW700,
                                  //                         color: KdarkText
                                  //                             .withOpacity(
                                  //                                 0.7))),
                                  //                 actions: [
                                  //                   TextButton(
                                  //                     onPressed: () {
                                  //                       Get.back();
                                  //                     },
                                  //                     child: Text('No',
                                  //                         maxLines: 1,
                                  //                         overflow: TextOverflow
                                  //                             .ellipsis,
                                  //                         style: GoogleFonts
                                  //                             .roboto(
                                  //                                 fontSize:
                                  //                                     12.sp,
                                  //                                 fontWeight:
                                  //                                     kFW700,
                                  //                                 color:
                                  //                                     KdarkText)),
                                  //                   ),
                                  //                   TextButton(
                                  //                     // textColor: Color(0xFF6200EE),
                                  //                     onPressed: () async {
                                  //                       ///
                                  //                       /// Delete the database at the given path.
                                  //                       ///
                                  //                       // Future<void> deleteDatabase(String path) =>
                                  //                       //     _databaseHelper.database;

                                  //                       UserSimplePreferences
                                  //                           .clearAllData();
                                  //                       Get.toNamed(kSignIn);
                                  //                     },
                                  //                     child: Text('Yes',
                                  //                         maxLines: 1,
                                  //                         overflow: TextOverflow
                                  //                             .ellipsis,
                                  //                         style: GoogleFonts
                                  //                             .roboto(
                                  //                                 fontSize:
                                  //                                     12.sp,
                                  //                                 fontWeight:
                                  //                                     kFW700,
                                  //                                 color:
                                  //                                     KdarkText)),
                                  //                   )
                                  //                 ],
                                  //               );
                                  //             });

                                  //         // timercontroller.stopTimer();
                                  //         // UserSimplePreferences.clearAllData();
                                  //         // Get.toNamed(kSelectType);
                                  //       },
                                  //       child: Row(
                                  //         children: [
                                  //           Container(
                                  //             width: 140.w,
                                  //             padding: EdgeInsets.all(10),
                                  //             // margin: EdgeInsets.only(top: 10.h),
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.deepOrange
                                  //                     .withOpacity(0.8),
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Ktextcolor
                                  //                         .withOpacity(0.0),
                                  //                     blurRadius: 5,
                                  //                     offset:
                                  //                         const Offset(0, 0),
                                  //                     spreadRadius: 2,
                                  //                   )
                                  //                 ],
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         10.r)),
                                  //             //margin: EdgeInsets.all(13.r),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Image.asset(
                                  //                   "assets/images/ok.png",
                                  //                   height: 23.h,
                                  //                   //color: Actions[i]["color"],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 12.h,
                                  //                 ),
                                  //                 Text(
                                  //                   "Admin Actions",
                                  //                   maxLines: 2,
                                  //                   textAlign: TextAlign.left,
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   style: TextStyle(
                                  //                       fontSize: 13.sp,
                                  //                       fontWeight: kFW600,
                                  //                       color: Kwhite),
                                  //                 ),
                                  //                 Image.asset(
                                  //                   "assets/images/white_arrow.png",
                                  //                   height: 30.h,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
        ));
  }
}
