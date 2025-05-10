
abstract class ApiResponse<T> {
  const ApiResponse();

  R when<R>({
    required R Function(Successful<T> successful) successful,
    required R Function(Error<T> error) error,
  });
}

class Successful<T> extends ApiResponse<T> {
  final T? data;
  Successful({this.data}) : super();

  @override
  R when<R>({
    required R Function(Successful<T> successful) successful,
    required R Function(Error<T> error) error,
  }) {
    return successful(this);
  }
}

class Error<T> extends ApiResponse<T> {
  final AfriException error;
  Error({required this.error}) : super();

  @override
  R when<R>({
    required R Function(Successful<T> successful) successful,
    required R Function(Error<T> error) error,
  }) {
    return error(this);
  }
}


class AfriException{
  final String exectionMsg;
  final StackTrace stackTrace;
  const AfriException(this.exectionMsg, this.stackTrace);
}
