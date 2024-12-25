class TagsModel {
  bool? success;
  List<Tags>? tags;

  TagsModel({this.success, this.tags});

  TagsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  int? id;
  String? tagName;

  Tags({this.id, this.tagName});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagName = json['tagName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tagName'] = tagName;
    return data;
  }
}
