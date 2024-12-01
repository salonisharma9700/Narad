class ApiResponse {
  final String summary;

  ApiResponse({required this.summary});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      summary: json['summary'],
    );
  }
}
