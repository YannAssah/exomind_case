import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exomind_case/bloc_implementation/constant.dart';
import 'package:exomind_case/bloc_implementation/data/repository/forecast_rep.dart';
import 'package:meta/meta.dart';
import 'package:exomind_case/bloc_implementation/data/model/forecast.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc(ForecastState initialState) : super(initialState);

  // ForecastBloc() : super(ForecastLoading()) {
  //   on<ForecastEvent>((event, emit) {
  //     // ignore: todo
  //     // TODO: implement event handler

  //   });

  // }

  ForecastState get initialState => ForecastLoading();

  @override
  Stream<ForecastState> mapEventToState(
    ForecastEvent event,
  ) async* {
    // Distinguish between different events, even though this app has only one
    if (event is GetForecast) {
      // Outputting a state from the asynchronous generator
      yield ForecastLoading();
      Forecast rennes = await ForecastRepository().decodeOneForecast(cities[0]);

      Future.delayed(const Duration(seconds: 10));
      Forecast paris = await ForecastRepository().decodeOneForecast(cities[1]);

      Future.delayed(const Duration(seconds: 10));
      Forecast nantes = await ForecastRepository().decodeOneForecast(cities[2]);

      Future.delayed(const Duration(seconds: 10));
      Forecast bordeaux =
          await ForecastRepository().decodeOneForecast(cities[3]);

      Future.delayed(const Duration(seconds: 10));
      Forecast lyon = await ForecastRepository().decodeOneForecast(cities[4]);

      //List<Forecast> test = await ForecastRepository().decodeAllForecast();
      List<Forecast> result = [rennes, paris, nantes, bordeaux, lyon];
      yield ForecastLoaded(result);
    }
  }
}
