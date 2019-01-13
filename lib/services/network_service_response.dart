class NetworkServiceResponse<T> {
  T content;
  bool success;
  String message;
  dynamic meta;

  NetworkServiceResponse({this.content, this.success, this.message, this.meta});
}

class MappedNetworkServiceResponse<T> {
  dynamic mappedResult;
  dynamic metaLinks;
  NetworkServiceResponse<T> networkServiceResponse;
  MappedNetworkServiceResponse({this.mappedResult, this.networkServiceResponse, this.metaLinks});
}
