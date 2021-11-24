import 'dart:convert';
import 'dart:io';

import 'package:archub/model/http_exception.dart';
import 'package:archub/model/job_model.dart';
import 'package:archub/model/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart' as config;

class JobProvider with ChangeNotifier {
  List<JobModel> jobmodel = [];
  List<NotificationModel> notifyList = [];

  Future<void> getUsersJob() async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    try {
      jobmodel = [];
      final response = await http.get(
        "${config.baseUrl}/jobs/user",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] == "success") {
        List<dynamic> entities = resData["data"]['jobs'];
        entities.forEach((entity) {
          JobModel itemcategory = JobModel();

          itemcategory.id = entity['_id'];
          itemcategory.userId = entity['userId'];
          itemcategory.companyName = entity['companyName'];
          itemcategory.staffCapacity = entity['staffCapacity'];
          itemcategory.contactEmail = entity['contactEmail'];
          itemcategory.inEquiryPhoneNumber = entity['inEquiryPhoneNumber'];
          itemcategory.country = entity['country'];
          itemcategory.city = entity['city'];
          itemcategory.jobTitle = entity['jobTitle'];
          itemcategory.salary = entity['salary'];
          itemcategory.jobDescription = entity['jobDescription'];
          itemcategory.applicationShouldBeSentTo =
              entity['applicationShouldBeSentTo'];
          itemcategory.submitResume = entity['submitResume'];
          itemcategory.logo = entity['logo'];
          itemcategory.createdAt = entity['createdAt'];

          jobmodel.add(itemcategory);
        });
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> creatJob(
      JobModel jobModel, jobsent, jobinstructions, submitResume, image) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    print(token);
    var data = jsonEncode({
      "companyName": "${jobModel.companyName}",
      "contactEmail": "${jobModel.contactEmail}",
      "inEquiryPhoneNumber": "${jobModel.inEquiryPhoneNumber}",
      "country": "${jobModel.country}",
      "city": "${jobModel.city}",
      "jobTitle": "${jobModel.jobTitle}",
      "salary": "${jobModel.salary}",
      "jobDescription": "${jobModel.jobDescription}",
      "applicationShouldBeSentTo": "$jobsent",
      "additionalInstructions": "$jobinstructions",
      "submitResume": "$submitResume",
      "base64": "$image"
    });
    print(data);
    try {
      final response = await http.post(
        "${config.baseUrl}/jobs",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      // print(data);
      if (resData["message"] != "success") {
        throw HttpException("Error uploading job");
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> applyJob(image, id) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    print(token);
    var data = jsonEncode({"base64": "$image"});
    print(data);
    try {
      final response = await http.post(
        "${config.baseUrl}/jobs/$id/apply",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      // print(data);
      if (resData["message"] != "success") {
        throw HttpException("Error Apply job");
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getNotification() async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    try {
      notifyList = [];
      final response = await http.get(
        "${config.baseUrl}/users/notifications/center",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      // print(data);
      if (resData["message"] != "success") {
        throw HttpException("Error Apply job");
      }
      if (resData["message"] == "success") {
        List<dynamic> entities = resData["data"]['notifications'];
        entities.forEach((entity) {
          NotificationModel itemcategory = NotificationModel();

          itemcategory.id = entity['_id'];
          itemcategory.userId = entity['userId'];
          itemcategory.notificationId = entity['notificationId'];
          itemcategory.senderImage = entity['senderImage'];
          itemcategory.message = entity['message'];

          notifyList.add(itemcategory);
        });
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteNotification(id) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    try {
      notifyList = [];
      final response = await http.delete(
        "${config.baseUrl}/users/notifications/$id",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      // print(data);
      if (resData["message"] != "success") {
        throw HttpException("Error in deleting Notification");
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> reportPost(postId, ownerOfPostId, reason) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    var data = jsonEncode({
      "postId": postId,
      "ownerOfPostId": ownerOfPostId,
      "reason": reason
    });
    try {
      notifyList = [];
      final response = await http.post(
        "${config.baseUrl}/reports",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data
      );
      var resData = jsonDecode(response.body);

      print(resData);
      // print(data);
      if (resData["message"] != "success") {
        throw HttpException("Error in deleting Notification");
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

//   {
//                  "_id": "614b2ead809478001d1c0c17",
//                  "userId": "6127a86a5ff5b247c84c2f6c",
//                  "notificationId": "614a9d5cd26ebf001d636c99",
//                  "message": "You Applied to Tera Job",
//                  "senderImage": "http://res.cloudinary.com/dasek9hic/image/upload/v1632279899/xkrray4vbzktfqhocc4x.jpg",
//                  "__v": 0
//              }

  // Future<void> uploadFarmProduct({
  //   String name,
  //   String price,
  //   String desc,
  //   int category_id,
  //   int scale_id,
  //   int qty,
  //   File image,
  //   File image1,
  //   File image2,
  //   File image3,
  // }) async {

  //   try {

  //     var request = http.MultipartRequest('POST',
  //         Uri.parse("Https://farmfocus.herokuapp.com/api/farmer/add-product"));
  //     request.files.add(await http.MultipartFile.fromPath('image', image.path));
  //     if (image1 != null) {
  //       request.files.add(
  //           await http.MultipartFile.fromPath('other_photos', image1.path));
  //     }
  //     if (image2 != null) {
  //       request.files.add(
  //           await http.MultipartFile.fromPath('other_photos', image2.path));
  //     }
  //     if (image3 != null) {
  //       request.files.add(
  //           await http.MultipartFile.fromPath('other_photos', image3.path));
  //     }
  //     request.fields['name'] = name;
  //     request.fields['description'] = desc;
  //     request.fields['price'] = price;
  //     request.fields['category_id'] = category_id.toString();
  //     request.fields['scale_id'] = scale_id.toString();
  //     request.fields['qty'] = qty.toString();
  //     request.headers.addAll({"Authorization": "Bearer " + _token});
  //     var response = await request.send();

  //     if (response.statusCode != 200) {
  //       throw HttpException("Error Uploading Product");
  //     }

  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }

}
