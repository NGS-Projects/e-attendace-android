import 'package:eattendance/untils/export_file.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  AuthController authcontroller = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _focusNodeTwo.addListener(() {
      setState(() {
        _isFocusedTwo = _focusNodeTwo.hasFocus;
      });
    });

    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10), // Adjust duration as needed
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent * _animation.value,
          );
        }
      });

    _animationController.repeat();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNodeTwo.dispose();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool isSelected = false;

  /////////////////////////////////////////////////////////////////////
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNodeTwo = FocusNode();
  bool _isFocused = false;
  bool _isFocusedTwo = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _focusNode.addListener(() {
  //     setState(() {
  //       _isFocused = _focusNode.hasFocus;
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  // }
  //
  //
  ////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios)),
              SizedBox(
                height: 25.h,
              ),
              Center(
                child: Image.asset(
                  "assets/images/eAttendancelogo.png",
                  width: 150.w,
                  height: 60.h,
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              Text(
                "Forgot Password",
                style: GoogleFonts.roboto(
                    fontSize: 26.sp, fontWeight: kFW600, color: KdarkText),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Enter your registered E-Mail and we will send a link to reset your password",
                style: GoogleFonts.roboto(
                    fontSize: 13.sp,
                    fontWeight: kFW400,
                    color: KdarkText.withOpacity(0.7)),
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomFormFields(
                controller: authcontroller.EAForgotpasswordController,
                enabled: true,
                labelColor: KText,
                obscureText: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                fontSize: kFourteenFont,
                fontWeight: FontWeight.w500,
                hintText: "Enter Enter Email",
                maxLines: 1,
                readOnly: false,
                label: 'Enter Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
              ),
              // CustomFormField(
              //   enabled: true,
              //   contentPadding: const EdgeInsets.symmetric(
              //     vertical: 16,
              //   ),
              //   fontSize: kFourteenFont,
              //   fontWeight: FontWeight.w500,
              //   hintText: "  Enter Password",
              //   maxLines: 1,
              //   readOnly: false,
              //   label: "Password",
              //   obscureText: false,
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter Password';
              //     }
              //     return null;
              //   },
              // ),

              SizedBox(
                height: 35.h,
              ),

              CustomButton(
                  margin: EdgeInsets.only(top: 50.h),
                  borderRadius: BorderRadius.circular(10.r),
                  Color: KOrange,
                  textColor: Kwhite,
                  height: 42.h,
                  width: double.infinity,
                  label: "Submit",
                  fontSize: kSixteenFont,
                  fontWeight: kFW500,
                  isLoading: false,
                  onTap: () {
                    var payload = {
                      "email": authcontroller.EAForgotpasswordController.text,
                    };

                    authcontroller.forgotPasswordUpdate(payload);

                    // Get.back();
                  }),

              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Text(
                    "Didn’t receive link? ",
                    style: GoogleFonts.roboto(
                        fontSize: 13.sp, fontWeight: kFW400, color: KdarkText),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                    onTap: () {
                      var payload = {
                        "email": authcontroller.EAForgotpasswordController.text,
                      };

                      authcontroller.forgotPasswordUpdate(payload);
                    },
                    child: Text(
                      "Resend",
                      style: GoogleFonts.roboto(
                          fontSize: 13.sp, fontWeight: kFW500, color: KOrange),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
