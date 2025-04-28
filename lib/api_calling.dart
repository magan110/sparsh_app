class Profile {
  String? userID;
  String? password;
  String? appRegId;

  Profile({this.userID, this.password, this.appRegId});

  Profile.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    password = json['password'];
    appRegId = json['appRegId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['password'] = this.password;
    data['appRegId'] = this.appRegId;
    return data;
  }
}