part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreatedRequested extends CategoryEvent {
  final String name;
  final String image;
  CreatedRequested(this.name, this.image);
}

class UpdatedRequested extends CategoryEvent {
  final String name;
  final String image;
  final String id;

  UpdatedRequested(this.name, this.image, this.id);
}

class DeletedRequested extends CategoryEvent {
  final String id;

  DeletedRequested(this.id);
}
