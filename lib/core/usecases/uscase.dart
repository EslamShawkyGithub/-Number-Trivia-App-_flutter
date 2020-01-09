import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercleancode/core/error/failures.dart';

// Parameters have to be put into a container object so that they can be
abstract class Usecase <Type,Params>{

  // Parameters included in this abstract base class method definition.
  Future<Either<Failure,Type>> call (Params params);

}
class NoParams extends Equatable {

}