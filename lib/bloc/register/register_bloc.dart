// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fic_masjoel_ecatalog/data/models/response/register_response_model.dart';
import 'package:meta/meta.dart';

import 'package:fic_masjoel_ecatalog/data/datasources/auth_datasource.dart';
import 'package:fic_masjoel_ecatalog/data/models/request/register_request_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDatasource datasource;

  RegisterBloc(
    this.datasource,
  ) : super(RegisterInitial()) {
    on<DoRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      final result = await datasource.register(event.model);
      result.fold((error) => emit(RegisterError(message: error)),
          (data) => emit(RegisterLoaded(model: data)));
      // emit(RegisterLoaded());
    });
  }
}
