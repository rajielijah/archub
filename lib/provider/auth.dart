import 'dart:convert';
import 'dart:io';

import 'package:archub/model/http_exception.dart';
import 'package:archub/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart' as config;

class Auth with ChangeNotifier {
  String _token;
  String _accessTokenType;
  String walletNumber, walletBalance;
  String weblink;
  String transactionref;
  // dynamic socketIo;

  User user = User();
  User sourceId = User();

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get accessTokenType {
    if (_accessTokenType != null) {
      return _accessTokenType;
    }
    return null;
  }

  Future<void> signUp(User user, token) async {
    var data = jsonEncode({
      "fullName": user.fullName,
      "email": user.email,
      "userType": "USER",
      "otp": token,
      "password": user.password
    });
    print(data);
    try {
      final response = await http.post(
        "${config.baseUrl}/users",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] != "success") {
        if (resData["status"] == "error") {
          throw HttpException(resData["message"]['message'][0]);
        } else {
          throw HttpException(resData["error"]);
        }
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> editProfile(fullName, city, country, phoneNumber, bio, skill, social) async {
    var data = jsonEncode({
    "city":city,
    "country":country,
    "phoneNumber": phoneNumber,
    "skills":skill,
    "socialLinks":social,
    "bio":bio
});
   print(data);
    print(data);
    try {
      final response = await http.put(
        "${config.baseUrl}/users/update-profile",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] != "success") {
        if (resData["status"] == "error") {
          throw HttpException(resData["message"]['message'][0]);
        } else {
          throw HttpException(resData["error"]);
        }
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getProfile() async {
    
    // print(data);
    try {
      final response = await http.get(
        "${config.baseUrl}/users",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] != "success") {
        if (resData["status"] == "error") {
          throw HttpException(resData["message"]['message'][0]);
        } else {
          throw HttpException(resData["error"]);
        }
      }

      if (resData["message"] == "success") {
        // _token = resData["data"]["token"];
        User userdata = User();
        userdata.id = resData["data"]["user"]['_id'];
        
        userdata.fullName = resData["data"]["user"]['fullName'];
        userdata.phone = resData["data"]["user"]['phoneNumber'];
        userdata.email = resData["data"]["user"]['email'];
        userdata.pictureUrl = resData["data"]["user"]['image'];
        userdata.location = resData["data"]["user"]['location'];
        userdata.country = resData["data"]["user"]['country'];
        userdata.city = resData["data"]["user"]['city'];
        userdata.bio = resData["data"]["user"]['bio'];
        userdata.followers = resData["data"]["user"]['followers'];
        userdata.following = resData["data"]["user"]['following'];
        userdata.skills = resData["data"]["user"]['skills'];
        userdata.role = resData["data"]["user"]['role'];
        userdata.socialLinks = resData["data"]["user"]['socialLinks'];
 
        user = userdata;

      }
      print("here is $token");

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': token,
        'userId': user.id,
        "userPhone": user.phone,
        "userEmail": user.email,
        "fullName": user.fullName,
        "pictureUrl": user.pictureUrl,
        "location" : user.location,
        "country" : user.country,
        "city" : user.city,
        "skills" : user.skills,
        "socialLinks" : user.socialLinks
      });
      prefs.setString("userData", userData);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getUserSourceId(id) async {
    
    // print(data);
    try {
      final response = await http.get(
        "${config.baseUrl}/users/$id",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] != "success") {
        if (resData["status"] == "error") {
          throw HttpException(resData["message"]['message'][0]);
        } else {
          throw HttpException(resData["error"]);
        }
      }

      if (resData["message"] == "success") {
        // _token = resData["data"]["token"];
        User userdata = User();
        userdata.id = resData["data"]["user"]['_id'];
        
        userdata.fullName = resData["data"]["user"]['fullName'];
        userdata.phone = resData["data"]["user"]['phoneNumber'];
        userdata.email = resData["data"]["user"]['email'];
        userdata.pictureUrl = resData["data"]["user"]['image'];
        userdata.location = resData["data"]["user"]['location'];
        userdata.country = resData["data"]["user"]['country'];
        userdata.city = resData["data"]["user"]['city'];
        userdata.bio = resData["data"]["user"]['bio'];
        userdata.followers = resData["data"]["user"]['followers'];
        userdata.following = resData["data"]["user"]['following'];
        userdata.skills = resData["data"]["user"]['skills'];
        userdata.role = resData["data"]["user"]['role'];

        sourceId = userdata;

      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getOtp(User user) async {
    var data = jsonEncode({
    "email": user.email
    });
    print(data);
    try {
      final response = await http.post(
        "${config.baseUrl}/send-token",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);
      print('//////get data');
      print(resData);
      print(response.statusCode);
      print(data);
      if (resData["message"] != "success") {
        if(resData["status"] != 200){
          throw HttpException(resData["message"]);
        }
        
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(String email, String password) async {
    var data = jsonEncode({"loginId": email, "password": password});
    try {
      final response = await http.post(
        "${config.baseUrl}/users/login",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(utf8.decode(response.bodyBytes));

      print(resData);
      print(response.statusCode);
      print(data);
      if (resData["message"] != "success") {
        throw HttpException(resData["message"]);
      }

      if (resData["message"] == "success") {
        _token = resData["data"]["token"];
        User userdata = User();
        userdata.id = resData["data"]["userDetails"]['_id'];
        
        userdata.fullName = resData["data"]["userDetails"]['fullName'];
        // userdata.phone = resData["data"]["userDetails"]['_id'];
        userdata.email = resData["data"]["userDetails"]['email'];
        userdata.pictureUrl = resData["data"]["userDetails"]['image'];

        user = userdata;

        // _autoLogout();

      }
      print("here is $token");

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': token,
        'userId': user.id,
        "userPhone": user.phone,
        "userEmail": user.email,
        "fullName": user.fullName,
        // "pictureUrl": user.pictureUrl,
      });
      prefs.setString("userData", userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> forgot(String email) async {
    var data = jsonEncode({
    "email":email
});
    try {
      final response = await http.post(
        "${config.baseUrl}/users/forgot-password",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(utf8.decode(response.bodyBytes));

      print(resData);
      print(response.statusCode);
      print(data);
      if (resData["message"] != "success") {
        throw HttpException(resData["message"]);
      }

      if (resData["message"] == "success") {
       throw HttpException(resData['data']["message"]);
        // _autoLogout();

      }
      print("here is $token");
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> resetPassworddata(usertoken, newpassword) async {
    var data = jsonEncode({
    "token" : usertoken,
    "newPassword" : newpassword
   });
    try {
      final response = await http.post(
        "${config.baseUrl}/users/reset-password",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(utf8.decode(response.bodyBytes));

      print(resData);
      print(response.statusCode);
      print(data);
      if (resData["message"] != "success") {
        throw HttpException(resData["message"]);
      }

      // if (resData["message"] == "success") {
      //  throw HttpException(resData['data']["message"]);
      //   // _autoLogout();

      // }
      print("here is $token");
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> resetPassword(String oldpassword, newpassword) async {
    var data = jsonEncode({
    "oldPassword":oldpassword,
    "newPassword":newpassword
});
    print(token);
    try {
      final response = await http.post(
        "${config.baseUrl}/users/change-password",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (response.statusCode != 200) {
        throw HttpException(resData["message"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> uploadimage(String image
    // File image,
  ) async {
    var data = jsonEncode({
    "base64": "$image"
  });
  print(data);

    try {

      final response = await http.patch(
        "${config.baseUrl}/users/upload-profile-picture",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (response.statusCode != 200) {
        throw HttpException(resData["message"]);
      }
    // print("*******");
    // // print(image.path);
    //   var request = http.MultipartRequest('PATCH',
    //       Uri.parse("https://archub.herokuapp.com/api/users/upload-profile-picture"));
    //   request.files.add(await http.MultipartFile.fromPath('image', image.path));
    //   // if (image1 != null) {
    //   //   request.files.add(
    //   //       await http.MultipartFile.fromPath('other_photos', image1.path));
    //   // }
    //   // request.fields['name'] = name;
    //   // request.fields['description'] = desc;
    //   // request.fields['price'] = price;
    //   // request.fields['category_id'] = category_id.toString();
    //   // request.fields['scale_id'] = scale_id.toString();
    //   // request.fields['qty'] = qty.toString();
    //   request.headers.addAll({"Authorization": "Bearer $token"});
    //   var response = await request.send();

    //   // print("????*******");
    //   if (response.statusCode != 200) {
    //     print(response.reasonPhrase);
    //     // print("Error Uploading Product");
    //     throw HttpException("Error Uploading Product");
        
    //   }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> verifyOtp(String phone, String phoneToken) async {
    var data = jsonEncode({"phone": phone, "otp": phoneToken});

    try {
      final response = await http.post(
        "${config.baseUrl}/onboarding/complete",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      print(data);
      if (resData['status'] != "success") {
        throw HttpException(resData["message"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> resendOtp(int userId) async {
    var data = jsonEncode({
      "user_id": userId,
    });

    try {
      final response = await http.post(
        "${config.baseUrl}/resend_phone_token",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      print(data);
      if (resData["success"] == null) {
        throw HttpException(resData["error"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(milliseconds: 2000), () {
      // print(prefs.getString('userData'));
      if (!prefs.containsKey("userData")) {
        return false;
      }

      final extractedUserData = json.decode(prefs.getString("userData"));

      _token = extractedUserData["token"];
      user.id = extractedUserData["userId"];
      user.email = extractedUserData["userEmail"];
      user.phone = extractedUserData["userPhone"];
      user.fullName = extractedUserData["fullName"];
      user.pictureUrl = extractedUserData["pictureUrl"];
      user.city = extractedUserData["city"];
      user.country = extractedUserData["country"];
      user.location = extractedUserData["location"];
      user.skills = extractedUserData["skills"];
      user.socialLinks = extractedUserData["socialLinks"];

      notifyListeners();
      // _autoLogout();
      return true;
    });
  }

  void logout() async {
    _token = null;
    user = null;
    // if (_authTimer != null) {
    //   _authTimer.cancel();
    //   _authTimer = null;
    // }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
    this.user = User();
  }
}
