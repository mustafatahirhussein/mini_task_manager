import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension DateFormatExt on Timestamp {
  String get formattedDate {
    return DateFormat.yMMMd().format(toDate());
  }
}