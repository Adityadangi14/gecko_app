class BlogModel {
  List<BlogData>? data;
  bool? success;
  bool? isNextPageExist;

  BlogModel({this.data, this.success});

  BlogModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BlogData>[];
      json['data'].forEach((v) {
        data!.add(BlogData.fromJson(v));
      });
    }
    success = json['success'];
    isNextPageExist = json['isNextPageExist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['isNextPageExist'] = isNextPageExist;
    return data;
  }
}

class BlogData {
  String? blogUrl;
  Company? company;
  String? description;
  int? iD;
  String? pubTime;
  String? tThumbnailBlurhash;
  List<Tags>? tags;
  String? thumbnailUrl;
  String? title;

  BlogData(
      {this.blogUrl,
      this.company,
      this.description,
      this.iD,
      this.pubTime,
      this.tThumbnailBlurhash,
      this.tags,
      this.thumbnailUrl,
      this.title});

  BlogData.fromJson(Map<String, dynamic> json) {
    blogUrl = json['BlogUrl'];
    company =
        json['Company'] != null ? Company.fromJson(json['Company']) : null;
    description = json['Description'];
    iD = json['ID'];
    pubTime = json['PubTime'];
    tThumbnailBlurhash = json['TThumbnailBlurhash'];
    if (json['Tags'] != null) {
      tags = <Tags>[];
      json['Tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    thumbnailUrl = json['ThumbnailUrl'];
    title = json['Title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BlogUrl'] = blogUrl;
    if (company != null) {
      data['Company'] = company!.toJson();
    }
    data['Description'] = description;
    data['ID'] = iD;
    data['PubTime'] = pubTime;
    data['TThumbnailBlurhash'] = tThumbnailBlurhash;
    if (tags != null) {
      data['Tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['ThumbnailUrl'] = thumbnailUrl;
    data['Title'] = title;
    return data;
  }
}

class Company {
  String? companyName;
  String? companyLogoURL;
  int? iD;

  Company({this.companyName, this.companyLogoURL, this.iD});

  Company.fromJson(Map<String, dynamic> json) {
    companyName = json['CompanyName'];
    companyLogoURL = json['CompanyLogoURL'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CompanyName'] = companyName;
    data['CompanyLogoURL'] = companyLogoURL;
    data['ID'] = iD;
    return data;
  }
}

class Tags {
  String? tagName;
  int? iD;

  Tags({this.tagName, this.iD});

  Tags.fromJson(Map<String, dynamic> json) {
    tagName = json['TagName'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TagName'] = tagName;
    data['ID'] = iD;
    return data;
  }
}
