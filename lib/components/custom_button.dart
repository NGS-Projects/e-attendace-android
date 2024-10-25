// ignore_for_file: must_be_immutable
import 'package:eattendance/untils/export_file.dart';

class CustomButton extends StatelessWidget {
  String label;
  double? height;
  double? width;
  double? fontSize;
  FontWeight? fontWeight;
  final Color;
  final textColor;
  var Padding;
  var margin;
  BorderRadiusGeometry? borderRadius;

  bool isLoading;
  dynamic onTap;

  CustomButton(
      {Key? key,
      this.height,
      this.width,
      this.Padding,
      this.Color,
      this.textColor,
      this.margin,
      this.fontSize,
      this.fontWeight,
      this.borderRadius,
      required this.label,
      required this.isLoading,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: margin,
          padding: Padding,
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Ktextcolor.withOpacity(0.5),
                blurRadius: 5.r,
                offset: Offset(0, 5),
                spreadRadius: 1.r,
              )
            ],
            color: Color,
            borderRadius: borderRadius,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: fontSize, color: textColor, fontWeight: fontWeight),
          ),
        ));
  }
}
