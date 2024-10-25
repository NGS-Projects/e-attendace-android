import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eattendance/untils/export_file.dart';
// ignore_for_file: camel_case_types, deprecated_member_use, non_constant_identifier_names

class Bottom_navigation extends StatefulWidget {
  const Bottom_navigation({super.key});

  @override
  State<Bottom_navigation> createState() => _Bottom_navigationState();
}

class _Bottom_navigationState extends State<Bottom_navigation> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  DateTime timeBackPressed = DateTime.now();
  bool? isUserLoggedIn;

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
                // <-- SEE HERE
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            extendBody: true,
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int index) {
                setState(
                  () {
                    _pageIndex = index;
                  },
                );
                // if (index == 1 || index == 2 || index == 3) {
                //   isUserLoggedIn = UserSimplePreferences.getLoginStatus();
                //   Future.delayed(const Duration(seconds: 0), () async {
                //     if (isUserLoggedIn != null && isUserLoggedIn == true) {
                //       await apiController.getProfile();

                //       apiController.profileData["employeeType"] == "Donor"
                //           ? Get.toNamed(kDonorBottomNavigation)
                //           : Get.toNamed(kNavigation);
                //     } else {
                //       Get.toNamed(kMobileSignUp);
                //     }
                //   });
                //   // authentication.reportNameController.clear();
                //   // authentication.reportEmailController.clear();
                //   // authentication.reportMobilenumberController.clear();
                //   // authentication.reportFullAddressController.clear();
                //   // authentication.reportTextController.clear();
                // }
              },
              children: _buildThreePageViewChildren(),
            ),
            bottomNavigationBar: Container(
              color: Kwhite,
              // margin: EdgeInsets.all(5.r),
              // padding: EdgeInsets.all(10.r),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: BottomNavigationBar(
                  elevation: 0,
                  backgroundColor: Kwhite,
                  selectedItemColor: KOrange,
                  unselectedItemColor: KText,
                  selectedLabelStyle:
                      GoogleFonts.roboto(fontWeight: FontWeight.w600),
                  type: BottomNavigationBarType.fixed,
                  items: _buildThreeItems(),
                  onTap: (int index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  currentIndex: _pageIndex,
                ),
              ),
            )));
  }

  List<Widget> _buildThreePageViewChildren() {
    return <Widget>[
      DashboardScreen(),
      AttendanceScreen(),
      LeavesList(),
      MenuScreen()
    ];
  }

  List<BottomNavigationBarItem> _buildThreeItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Container(
            margin: EdgeInsets.only(bottom: 5.h),
            child: Icon(
              Icons.home,
              color: _pageIndex == 0 ? KOrange : Ktextcolor,
            )
            //            Image.asset(
            //   "assets/images/home.png",

            //   width: 25,
            // ),
            // SvgPicture.asset(_pageIndex == 0 ? HOMES : HOMES,
            //     width: _pageIndex == 0 ? 27.w : 27.w,
            //     color: _pageIndex == 0 ? KPink : kgray),
            ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Container(
            margin: EdgeInsets.only(bottom: 5.h),
            child: Icon(
              Icons.calendar_today,
              color: _pageIndex == 1 ? KOrange : Ktextcolor,
            )
            // SvgPicture.asset(_pageIndex == 1 ? Scheme : Scheme,
            //     width: _pageIndex == 1 ? 27.w : 27.w,
            //     color: _pageIndex == 1 ? KPink : kgray),
            ),
        label: 'Attendance',
      ),
      BottomNavigationBarItem(
        icon: Container(
            margin: EdgeInsets.only(bottom: 5.h),
            child: Icon(
              Icons.edit_document,
              color: _pageIndex == 2 ? KOrange : Ktextcolor,
            )
            //  SvgPicture.asset(_pageIndex == 2 ? Reporte : Reporte,
            //     width: _pageIndex == 2 ? 27.w : 27.w,
            //     color: _pageIndex == 2 ? KPink : kgray),
            ),
        label: 'Leaves',
      ),
      BottomNavigationBarItem(
        icon: Container(
            margin: EdgeInsets.only(bottom: 5.h),
            child: Icon(
              Icons.menu,
              color: _pageIndex == 3 ? KOrange : Ktextcolor,
            )
            //  SvgPicture.asset(_pageIndex == 2 ? Reporte : Reporte,
            //     width: _pageIndex == 2 ? 27.w : 27.w,
            //     color: _pageIndex == 2 ? KPink : kgray),
            ),
        label: 'Menu',
      ),
    ];
  }
}
