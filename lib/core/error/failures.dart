import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{

  // this class return in constructor super ([list from properties])
  Failure([List properties = const <dynamic> []]) : super (properties);


}

class ServerFailure extends Failure{}

class CacheFailure extends Failure{}