import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercleancode/core/error/exception.dart';
import 'package:fluttercleancode/features/number_trivia/data/datasourses/number_trivia_local_data_source.dart';
import 'package:fluttercleancode/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences{}
  
  void main(){

    MockSharedPreferences mockSharedPreferences;
    NumberTriviaLocalDataSourceImpl dataSource;

    setUp((){

      mockSharedPreferences = MockSharedPreferences();
      dataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences,
      );

    });

    group('getLastNumberTrivia',() {

      final tNumberTriviaModel =
          NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

      test('should return NumberTrivia from SharedPreferences when there is one in the cache', () async{

        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));

        final result = await dataSource.getLastNumberTrivia();

        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(tNumberTriviaModel));

      });

      test('should throw a CacheException when there is not a cached value', () {

        when(mockSharedPreferences.getString(any))
            .thenReturn(null);

        final call =  dataSource.getLastNumberTrivia;

        expect(() => call(), throwsA(isInstanceOf<CacheException>()));

      });

    });

    group('cacheNumberTrivia', () {
      final tNumberTriviaModel =
      NumberTriviaModel(number: 1, text: 'test trivia');

      test('should call SharedPreferences to cache the data', () {
        // act
        dataSource.cacheNumberTrivia(tNumberTriviaModel);
        // assert
        final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
        verify(mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA,
          expectedJsonString,
        ));
      });
    });

  }
