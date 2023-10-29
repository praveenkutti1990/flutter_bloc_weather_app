import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repos/day_weather_repo.dart';
import '../models/day_weather.dart';

part 'day_weather_event.dart';
part 'day_weather_state.dart';

class DayWeatherBloc extends Bloc<DayWeatherEvent, DayWeatherState> {
  final DayWeatherRepository _dayWeatherRepository;

  DayWeatherBloc(this._dayWeatherRepository) : super(DayWeatherInitial()) {
    on<DayWeatherEvent>((event, emit) async {
      emit(DayWeatherLoadingState());
      try {
        final DayWeather dayWeather =
            await _dayWeatherRepository.getDayWeather();
        emit(DayWeatherLoadedState(dayWeather));
      } catch (e) {
        emit(DayWeatherErrorState(e.toString()));
      }
    });
  }
}
