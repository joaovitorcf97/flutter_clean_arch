import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  final String id;
  final String title;
  final DateTime createdAt;

  const Habit({required this.id, required this.title, required this.createdAt});

  @override
  List<Object?> get props => [id, title, createdAt];
}
