import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoardModel {
  int id = 0;
  String name = '';
  double points = 0;

  LeaderBoardModel(
      {required this.id, required this.name, required this.points});

  LeaderBoardModel.fromDocument(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;

    this.id = map["id"];
    this.name = map["name"];
    this.points = map["point_score"];
  }

  factory LeaderBoardModel.fromJson(json) {
    // print('hh $json');
    return LeaderBoardModel(
        id: json['id'], name: json['name'], points: json['point_score']);
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "point_score": points};
}
