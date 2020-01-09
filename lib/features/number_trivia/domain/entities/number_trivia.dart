import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Equatable to compare == between two objects in value
// also not need to override method get hashCode or method bool operator ==(Object other) it used in runtime compare
// this class return in constructor super ([list from properties])
class NumberTrivia extends Equatable {
  final String text;
  final int number;

  NumberTrivia({
    @required this.text,
    @required this.number,
  }) :super([text,number]);
}