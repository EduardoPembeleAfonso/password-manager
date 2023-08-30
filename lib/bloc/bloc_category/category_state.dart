part of 'category_bloc.dart';

@immutable
abstract class CategoryState extends Equatable {}

class Loading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class Created extends CategoryState {
  @override
  List<Object?> get props => [];
}

// Estado Inicial do bloc.
// Quando usuario nao esta autenticado muda o seu estatdo para nao autenticado
class UnCreated extends CategoryState {
  @override
  List<Object?> get props => [];
}


class CategoryError extends CategoryState {
  final String error;

  CategoryError(this.error);
  @override
  List<Object?> get props => [error];
}
