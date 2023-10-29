import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/location.dart';
import '../repos/location_repo.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository;

  LocationBloc(this._locationRepository) : super(LocationInitial()) {
    on<LoadLocationEvent>((event, emit) async {
      emit(LocationLoadingState());
      try {
        final Location location = await _locationRepository.getLocation(event.latitude, event.longitude);
        emit(LocationLoadedState(location));
      } catch (e) {
        emit(LocationLoadErrorState(e.toString()));
      }
    });
  }
}
