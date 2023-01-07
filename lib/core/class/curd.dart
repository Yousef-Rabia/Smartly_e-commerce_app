import 'dart:convert';
import 'package:smartly/core/class/status_request.dart';
import 'package:dartz/dartz.dart';
import '../functions/check_internet.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkUrl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(Uri.parse(linkUrl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverFailure);
    }
  }
  Future<Either<StatusRequest, Map>> patchData(String linkUrl, Map data) async {

    try {
      if (await checkInternet()) {
        var response = await http.patch(Uri.parse(linkUrl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverFailure);
    }
  }
  Future<Either<StatusRequest, Map>> getData(String linkUrl,) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(linkUrl));
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody ={};
          responseBody["data"]=jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.offlineFailure);
    }
  }
  Future<Either<StatusRequest, Map>> deleteData(String linkUrl) async {
    try {
      if (await checkInternet()) {
        var response = await http.delete(Uri.parse(linkUrl));

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.offlineFailure);
    }
  }

}