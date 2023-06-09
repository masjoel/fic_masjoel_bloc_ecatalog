// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic_masjoel_ecatalog/data/datasources/product_data_source.dart';
import 'package:fic_masjoel_ecatalog/data/models/response/product_response_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductDataSource dataSource;
  ProductsBloc(
    this.dataSource,
  ) : super(ProductsInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductsLoading());
      final result = await dataSource.getAllProduct();
      result.fold(
        (error) => emit(ProductsError(message: error)),
        (result) => emit(ProductsLoaded(data: result)),
      );
    });
  }
}
