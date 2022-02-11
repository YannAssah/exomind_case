import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exomind_case/Model/forecast.dart';
import 'package:exomind_case/services/api_handler.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final ApiHandler _apiHandler;

  ForecastBloc(this._apiHandler) : super(ForecastInitial()) {
    // ignore: void_checks
    on<GetForecast>((event, emit) async* {
      final forecast = await _apiHandler.fetchAll();
      yield ForecastLoaded(forecast);
    });
  }
}
