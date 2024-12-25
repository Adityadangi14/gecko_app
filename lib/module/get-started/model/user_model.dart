class UserModel {
  bool? success;
  User? user;

  UserModel({this.success, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? iD;
  String? userName;
  String? email;
  String? pID;
  String? profilePicture;
  String? authType;
  bool? areTagsChoosen;

  User(
      {this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.iD,
      this.userName,
      this.email,
      this.pID,
      this.profilePicture,
      this.authType,
      this.areTagsChoosen});

  User.fromJson(Map<String, dynamic> json) {
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    iD = json['ID'];
    userName = json['UserName'];
    email = json['Email'];
    pID = json['PID'];
    profilePicture = json['ProfilePicture'];
    authType = json['AuthType'];
    areTagsChoosen = json['AreTagsChoosen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['ID'] = iD;
    data['UserName'] = userName;
    data['Email'] = email;
    data['PID'] = pID;
    data['ProfilePicture'] = profilePicture;
    data['AuthType'] = authType;
    data['AreTagsChoosen'] = areTagsChoosen;
    return data;
  }
}
