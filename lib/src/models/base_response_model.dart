part of 'models.dart';

BaseResponse baseResponseFromJson(String str) =>
    BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  BaseResponse({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  final int? statusCode;
  final String? status;
  final String? message;
  final dynamic data;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "data": data,
      };
}
