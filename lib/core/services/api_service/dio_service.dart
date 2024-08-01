import 'package:dio/dio.dart';
import 'package:cresce_cuts/core/const/api_routs.dart';
class DioService{

final Dio dio=Dio(
  BaseOptions(
    
      baseUrl:apiBaseUrl
    )
);
}