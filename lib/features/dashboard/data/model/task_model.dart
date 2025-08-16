import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  String? title, desc;
  bool isDone = false;
  Timestamp? createdAt;

  TaskModel({this.id, this.title, this.desc, this.createdAt, this.isDone = false});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    isDone = json['isDone'] ?? false;
    createdAt = json['createdAt'];
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? desc,
    bool? isDone,
    Timestamp? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    data['isDone'] = isDone;
    data['createdAt'] = createdAt;
    return data;
  }
}
