import 'package:eattendance/untils/export_file.dart';

class Routes {
  static List<GetPage<dynamic>> routes = [
    GetPage(
        name: kSplash,
        transition: Transition.rightToLeft,
        page: () => SplashScreen()),
    GetPage(
        name: kSignUp,
        transition: Transition.rightToLeft,
        page: () => SignUp()),
    GetPage(
        name: kSignIn,
        transition: Transition.rightToLeft,
        page: () => SignIn()),
    GetPage(
        name: kDashboard,
        transition: Transition.rightToLeft,
        page: () => DashboardScreen()),
    GetPage(
        name: kApproveScreen,
        transition: Transition.rightToLeft,
        page: () => Approve()),
    GetPage(
        name: kApplyLeaveScreen,
        transition: Transition.rightToLeft,
        page: () => Apply_leave()),
    GetPage(
        name: kAttendanceScreen,
        transition: Transition.rightToLeft,
        page: () => AttendanceScreen()),
    GetPage(
        name: kLeavelistScreen,
        transition: Transition.rightToLeft,
        page: () => LeavesList()),
    GetPage(
        name: kForgotpassword,
        transition: Transition.rightToLeft,
        page: () => ForgotPassword()),
    GetPage(
        name: kSelectCompany,
        transition: Transition.rightToLeft,
        page: () => CompanySelect()),
    GetPage(
        name: kProfileScreen,
        transition: Transition.rightToLeft,
        page: () => ProfileScreen()),
    GetPage(
        name: kEmployeesScreen,
        transition: Transition.rightToLeft,
        page: () => EmployeesList()),
    GetPage(
        name: kBiometricRegistration,
        transition: Transition.rightToLeft,
        page: () => BiometricsRegister()),
    GetPage(
        name: kEditProfile,
        transition: Transition.rightToLeft,
        page: () => EditProfile()),
    GetPage(
        name: kNotApprovedEmployess,
        transition: Transition.rightToLeft,
        page: () => NotEmployeesList()),
    GetPage(
        name: kHRPermissions,
        transition: Transition.rightToLeft,
        page: () => GiveHrPermission()),
    GetPage(
        name: kNavigation,
        transition: Transition.rightToLeft,
        page: () => Bottom_navigation()),
    GetPage(
        name: kChatScreen,
        transition: Transition.rightToLeft,
        page: () => ChatScreen()),
    GetPage(
        name: kHelpDesk,
        transition: Transition.rightToLeft,
        page: () => HelpDesk()),
    GetPage(
        name: kPrivacyPolicy,
        transition: Transition.rightToLeft,
        page: () => PrivacyPolicies()),
    GetPage(
        name: kTerms,
        transition: Transition.rightToLeft,
        page: () => TermsAndCOnditions()),

    // kChatScreen
  ];
}
// kForgotpassword