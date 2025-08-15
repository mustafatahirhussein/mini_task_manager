import '../../exports.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final Color? color;
  final double? fontSize;
  final double? height;
  final FontStyle? fontStyle;

  const AppText.subHeader({
    super.key,
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.color,
    this.fontSize,
    this.height,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.left,
      style: TextStyle(
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? 13.sp,
        height: height ?? 0,
        fontStyle: fontStyle ?? FontStyle.normal,
      ),
    );
  }
}
