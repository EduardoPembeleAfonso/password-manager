import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:password_manager/data/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository}) : super(UnCreated()) {
    on<CreatedRequested>((event, emit) async {
      emit(Loading());
      try {
        await categoryRepository.createCategory(
            name: event.name, image: event.image);
        emit(Created());
      } catch (e) {
        emit(CategoryError(e.toString()));
        emit(UnCreated());
      }
    });

    on<UpdatedRequested>((event, emit) async {
      emit(Loading());
      try {
        await categoryRepository.updateCategory(
            newName: event.name, newImage: event.image, categoryId: event.id);
        emit(Created());
      } catch (e) {
        emit(CategoryError(e.toString()));
        emit(UnCreated());
      }
    });

    on<DeletedRequested>((event, emit) async {
      emit(Loading());
      await categoryRepository.deleteCategory(categoryId: event.id);
      emit(UnCreated());
    });
  }
}
