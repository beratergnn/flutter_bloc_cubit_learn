import 'package:bloc_learn/feature/travel/model/travel_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TravelCubit extends Cubit<TravelStates> {
  TravelCubit() : super(TravelLoading());
  late List<TravelModel> _allItems;
  Future<void> fetchItems() async {
    await Future.delayed(const Duration(seconds: 1));
    _allItems = TravelModel.mockItems;
    emit(TravelItemsLoaded(items: _allItems));
  }

  void searchByItems(String data) {
    final result =
        _allItems.where((element) => element.title.contains(data)).toList();
    emit(TravelItemsLoaded(items: result));
  }
}

abstract class TravelStates {}

class TravelLoading extends TravelStates {}

class TravelItemsLoaded extends TravelStates {
  final List<TravelModel> items;
  TravelItemsLoaded({required this.items});
}

class TravelItemsSeeAll extends TravelStates {
  final List<String> images;

  TravelItemsSeeAll({required this.images});
}
