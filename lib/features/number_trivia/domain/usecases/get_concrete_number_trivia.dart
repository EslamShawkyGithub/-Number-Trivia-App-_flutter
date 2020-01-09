import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttercleancode/core/error/failures.dart';
import 'package:fluttercleancode/core/usecases/uscase.dart';
import 'package:fluttercleancode/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:fluttercleancode/features/number_trivia/domain/repository_abstract/number_trivia_repository.dart';

// class usecase used in logic code
class GetConcreteNumberTrivia extends Usecase<NumberTrivia,Params>{

  // because we get data from repository
  final NumberTriviaRepository repository;

  // Constructor
  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {

    return await repository.getConcreteNumberTrivia(params.number);
  }

}

class Params extends Equatable {

  final int number ;

  Params({@required this.number}):super([number]);
}