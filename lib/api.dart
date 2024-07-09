import 'dart:convert';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:test_int_kr/class.dart';
import 'package:test_int_kr/exception.dart';
import 'package:test_int_kr/typedef.dart';
import 'package:http/http.dart' as http;

class Api {
  static final Map<String, String> _header = {
    'Content-Type': 'application/json',
    'token': ''
  };
  static EitherResponse getApi(String url, [String? token]) async {
    if (token != null) {
      _header['token'] = token;
    }
    final uri = Uri.parse(url);
    dynamic fetchedData;
    try {
      fetchedData = await http.get(uri, headers: _header);
      final body = getResponse(fetchedData);
      return Right(body);
    } on SocketException {
      return Left(NetWorkNotFoundException());
    } on http.BaseRequest {
      return Left(RequestTimeOutException());
    } catch (e) {
      return Left(BadRequestException());
    }
  }

  static EitherResponse postApi(Map rowData, String url,
      [String? token]) async {
    if (token != null) {
      Api._header['token'] = token;
    }
    final uri = Uri.parse(url);
    final body = jsonEncode(rowData);
    try {
      dynamic fetchedData;
      final response = await http.post(uri, body: body, headers: _header);
      fetchedData = getResponse(response);
      return Right(fetchedData);
    } on SocketException {
      return Left(NetWorkNotFoundException());
    } on http.BaseResponse {
      return Left(BadRequestException());
    } catch (e) {
      return Left(RequestTimeOutException());
    }
  }

  static Future<Data> postApis(Map rawData) async {
    String baseUrl = '';
    String register = '';
    final uri = Uri.parse(baseUrl + register);
    final body = jsonEncode(rawData);
    try {
      final response = await http.post(uri, body: body, headers: _header);
      if (response.statusCode == 200) {
        return Data(data: jsonDecode(response.body));
      } else {
        return Data(error: 'error message');
      }
    } catch (e) {
      return Data(error: 'error message');
    }
  }

  EitherResponse get(String url, [String? token]) async {
    final uri = Uri.parse(url);

    if (token != null) {
      _header['token'] = token;
    }
    try {
      dynamic fetchedData;
      fetchedData = await http.get(uri, headers: _header);
      final response = getResponse(fetchedData);
      return Right(response);
    } on SocketException {
      return Left(NetWorkNotFoundException());
    }
  }

  static getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 300:
        return throw Left(RequestTimeOutException());

      case 400:
        return throw Left(NetWorkNotFoundException());

      default:
        return throw Left(BadRequestException());
    }
  }
}
  // final rawData = {"email": "eve.holt@reqres.in", "password": "pistol"};
  //   Navigator.pop(context);
  //   Api().registerUser(rawData).then((value) => {
  //         if (value.data != null)
  //           {
  //             setState(() {
  //               if (value.data != null) {
  //                 token = value.data['token'];
  //               } else {
  //                 token = 'Error message';
  //               }
  //             })
  //           }
  //       });
