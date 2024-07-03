import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

import '../repo/location_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitEvent>((event, emit) async {
      emit(HomeLoadingState());

      LocationRepo loc = LocationRepo();

      try {
        bool permission = await loc.requestPermission();
        if (permission) {
          try {
            LocationData currentLoc = await loc.getCurrentLocation();
            Map<String, dynamic> weatherData =
                await loc.fetchData(currentLoc.latitude, currentLoc.longitude);
            if (weatherData.isEmpty) {
              emit(HomeErrorState(message: "Failed to fetch weather data."));
            } else {
              String currAddress = await loc.getAddress(
                  currentLoc.latitude, currentLoc.longitude);
              
              emit(HomeSuccessState(
                  currentLocation: currentLoc,
                  weatherData: weatherData,
                  currAddress: currAddress));
            }
          } catch (e) {
            emit(HomeErrorState(
                message: "Failed to get current location or weather data."));
          }
        } else {
          emit(HomeErrorState(message: "Location permission denied."));
        }
      } catch (e) {
        emit(HomeErrorState(message: "Error requesting location permission."));
      }
    });
  }
}
