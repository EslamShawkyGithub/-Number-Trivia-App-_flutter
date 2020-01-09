import 'dart:convert';
import 'package:fluttercleancode/core/error/exception.dart';
import 'package:fluttercleancode/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class NumberTriviaLocalDataSource{

  // Gets the cached [NumberTriviaModel] which was gotten the last time
  // the user had an internet connection.
  // Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia (NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource{

  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});


  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {

      final stringJson = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
      if(stringJson != null){
        return Future.value(NumberTriviaModel.fromJson(json.decode(stringJson)));
      }

      else{
        throw CacheException();
      }

  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(CACHED_NUMBER_TRIVIA, json.encode(
        triviaToCache.toJson()),
    );
  }


}