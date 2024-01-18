class FetchUsersException implements Exception {
  final int errorCode;
  final String errorMessage;

  FetchUsersException({required this.errorCode, required this.errorMessage});

  @override
  String toString() => "Error $errorCode: $errorMessage";
}
