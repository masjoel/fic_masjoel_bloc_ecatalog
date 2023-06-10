// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fic_masjoel_ecatalog/data/models/request/product_request_model.dart';
import 'package:meta/meta.dart';

import 'package:fic_masjoel_ecatalog/data/datasources/product_data_source.dart';
import 'package:fic_masjoel_ecatalog/data/models/response/product_response_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductDataSource dataSource;
  AddProductBloc(
    this.dataSource,
  ) : super(AddProductInitial()) {
    on<DoAddProductEvent>((event, emit) async {
      emit(AddProductLoading());
      final result = await dataSource.createProduct(event.model);
      result.fold((error) => emit(AddProductError(message: error)),
          (data) => emit(AddProductLoaded(model: data)));
    });
  }
}
