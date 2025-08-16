import '../../exports.dart';

extension PaddingExt on Widget {
  Widget applyDefaultPadding() => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: .05.sw,
      vertical: .01.sh,
    ),
    child: this ,
  );
}