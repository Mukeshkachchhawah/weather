part of 'weather_app_bloc.dart';

@immutable
class WeatherAppState {}

class WeatherAppInitialState extends WeatherAppState {}

class WeatherAppLoginState extends WeatherAppState {}

class WeatherAppErrorState extends WeatherAppState {
  String erroMessage;
  WeatherAppErrorState({required this.erroMessage});
}

class WeatherAppLodadeState extends WeatherAppState {
  DataModals mdata;
  WeatherAppLodadeState({required this.mdata});
}
