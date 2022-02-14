import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exomind_case/bloc_implementation/constant.dart';
import 'package:exomind_case/bloc_implementation/data/repository/forecast_rep.dart';
//import 'package:meta/meta.dart';
import 'package:exomind_case/bloc_implementation/data/model/forecast.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

enum ForecastEventTrigger { load, display }

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc() : super(ForecastLoading());

  // ForecastBloc() : super(ForecastLoading()) {
  //   on<GetForecast>((event, emit) {
  //     // ignore: todo
  //     // TODO: implement event handler
  //     mapEventToState(event);
  //   });
  // }

  ForecastState get initialState => ForecastLoading();

  Stream<ForecastState> mapEventToState(
    ForecastEvent event,
  ) async* {
    // Distinguish between different events, even though this app has only one
    if (event is GetForecast) {
      // Outputting a state from the asynchronous generator
      yield ForecastLoading();
      Forecast rennes = await ForecastRepository().decodeOneForecast(cities[0]);
      print(rennes.name);

      Future.delayed(const Duration(seconds: 1));
      Forecast paris = await ForecastRepository().decodeOneForecast(cities[1]);
      print(paris.name);

      Future.delayed(const Duration(seconds: 1));
      Forecast nantes = await ForecastRepository().decodeOneForecast(cities[2]);
      print(nantes.name);

      Future.delayed(const Duration(seconds: 1));
      Forecast bordeaux =
          await ForecastRepository().decodeOneForecast(cities[3]);
      print(bordeaux.name);

      Future.delayed(const Duration(seconds: 1));
      Forecast lyon = await ForecastRepository().decodeOneForecast(cities[4]);
      print(lyon.name);

      //List<Forecast> test = await ForecastRepository().decodeAllForecast();
      List<Forecast> result = [rennes, paris, nantes, bordeaux, lyon];
      yield ForecastLoaded(result);
    }
  }
}
