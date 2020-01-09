import 'package:dartz/dartz.dart';
import 'package:fluttercleancode/core/error/failures.dart';
import 'package:fluttercleancode/features/number_trivia/domain/entities/number_trivia.dart';

// class repository to send data to usecase
abstract class NumberTriviaRepository {

  Future<Either<Failure,NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure,NumberTrivia>> getRandomNumberTrivia();

}