
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttercleancode/core/error/exception.dart';
import 'package:fluttercleancode/core/error/failures.dart';
import 'package:fluttercleancode/core/network/network_info.dart';
import 'package:fluttercleancode/features/number_trivia/data/datasourses/number_trivia_local_data_source.dart';
import 'package:fluttercleancode/features/number_trivia/data/datasourses/number_trivia_remote_data_source.dart';
import 'package:fluttercleancode/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:fluttercleancode/features/number_trivia/domain/repository_abstract/number_trivia_repository.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }


  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
