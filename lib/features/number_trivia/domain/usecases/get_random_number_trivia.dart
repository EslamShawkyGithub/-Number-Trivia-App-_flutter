import 'package:dartz/dartz.dart';
import 'package:fluttercleancode/core/error/failures.dart';
import 'package:fluttercleancode/core/usecases/uscase.dart';
import 'package:fluttercleancode/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:fluttercleancode/features/number_trivia/domain/repository_abstract/number_trivia_repository.dart';

class GetRandomNumberTrivia extends Usecase <NumberTrivia , NoParams>{

  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);



  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams noParams) {
    // TODO: implement call
    return repository.getRandomNumberTrivia();
  }

}

