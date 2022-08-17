class UserLogin {
  Account? account;
  String? message;
  bool? status;

  UserLogin({this.account, this.message, this.status});

  UserLogin.fromJson(Map<String, dynamic> json) {
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (account != null) {
      data['account'] = account!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Account {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? email;
  String? deletedAt;
  String? password;
  String? token;

  Account(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.email,
      this.password,
      this.token});

  Account.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;

    data['email'] = email;
    data['password'] = password;
    data['token'] = token;
    return data;
  }
}
