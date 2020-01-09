import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercleancode/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:fluttercleancode/features/number_trivia/domain/repository_abstract/number_trivia_repository.dart';
import 'package:fluttercleancode/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {


  void main() {
    // object from usecase
    GetConcreteNumberTrivia usecase;
    // object from class mock test
    MockNumberTriviaRepository mockNumberTriviaRepository;

    // to instantiate the objects
    setUp(() {
      mockNumberTriviaRepository = MockNumberTriviaRepository();
      usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
    }
    );

    final tNumber = 1;

    final tNumberTrivia = NumberTrivia(text: "test", number: 1);

    // method test will take description and body
    test('should get trivia for the number from the repository', () async {
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async {
        return Right(tNumberTrivia);
      });

      final result = await usecase(Params(number: tNumber));

// UseCase should simply return any thing was returned from the Repository
      expect(result, Right(NumberTrivia));

// Verify that the method has been called on the Repository
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));

// Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    });
  }
}
