import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/modal/data_modal.dart';

part 'weather_app_event.dart';
part 'weather_app_state.dart';

class WeatherAppBloc extends Bloc<WeatherAppEvent, WeatherAppState> {
   
  WeatherAppBloc() : super(WeatherAppInitialState()) {
    on<GetWeatherAppDataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
