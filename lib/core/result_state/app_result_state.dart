class AppResultState<T> {
  final T? data;
  final String? error;

  const AppResultState._({this.data, this.error});

  factory AppResultState.success(T data) => AppResultState._(data: data);
  factory AppResultState.error(String error) => AppResultState._(error: error);
}
