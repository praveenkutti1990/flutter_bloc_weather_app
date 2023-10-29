import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'get_cords_state.dart';

class GetCordsCubit extends Cubit<GetCordsState> {
  GetCordsCubit() : super(GetCordsState(lat: 0.0, lon: 0.0, loaded: false));

  void getCordinates() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      emit(GetCordsState(
          lat: position.latitude, lon: position.longitude, loaded: true));
    } catch (e) {
      emit(GetCordsState(lat: 0.0, lon: 0.0, loaded: false));
    }
  }
}
