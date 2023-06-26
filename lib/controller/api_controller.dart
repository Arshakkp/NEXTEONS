import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:macchine_test/model/response_model.dart';

class ApiProvider extends GetxController {
  Rx<ResponseModel>? _data;
  ResponseModel? get responseData {
    return _data?.value;
  }

  RxBool _isLoading = true.obs;
  bool get isLoadding => _isLoading.value;

  Future<void> getData() async {
    final dio = Dio();
    const url = "https://ajcjewel.com:5000/api/global-gallery/list";
    var options = Options(headers: {
      "Authorization":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfdXNlcklkXyI6IjYzMDI2ZjIxNWE5ZDVjNDY1NzQ3MTMxYSIsIl9lbXBsb3llZUlkXyI6IjYzMDI2ZjIxYTI1MTZhMTU0YTUxY2YxOSIsIl91c2VyUm9sZV8iOiJzdXBlcl9hZG1pbiIsImlhdCI6MTY2NjQzMzUxMSwiZXhwIjoxNjk3OTY5NTExfQ.99AkZAY7MJ6nR82r_Sm4FRPZwMpf_zrIUbxtQne0oyw"
    });
    var body = {
      "statusArray": [1],
      "screenType": [],
      "responseFormat": [],
      "globalGalleryIds": [],
      "categoryIds": [],
      "docTypes": [],
      "types": [],
      "limit": 10,
      "skip": 0,
      "searchingText": ""
    };
    final response =
        await dio.post(url, data: json.encode(body), options: options);
    _data = ResponseModel.fromJson(response.data).obs;
    _isLoading = false.obs;
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
