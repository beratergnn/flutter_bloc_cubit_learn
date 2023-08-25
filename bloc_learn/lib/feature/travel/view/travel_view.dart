import 'package:bloc_learn/feature/travel/cubit/travel_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:bloc_learn/feature/travel/model/travel_model.dart';

class TravelView extends StatelessWidget {
  const TravelView({super.key});
  final data = 'Hey Jhon! \nWhere do you want to go today?';
  final data2 = 'Popular destinations near you';
  final data3 = 'See all';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TravelCubit>(
      create: (context) => TravelCubit()..fetchItems(),
      child: BlocConsumer<TravelCubit, TravelStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  context.sized.emptySizedHeightBoxLow3x,

                  TextField(
                    onChanged: (value) {
                      context.read<TravelCubit>().searchByItems(value);
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder()),
                  ),
                  context.sized.emptySizedHeightBoxLow,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      TextButton(
                        onPressed: () {},
                        child: Text(data3,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.red)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: context.sized.dynamicHeight(0.26),
                    child: ListView.builder(
                      itemCount:
                          state is TravelItemsLoaded ? state.items.length : 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Card(
                            child: SizedBox(
                                width: context.sized.dynamicWidth(0.37),
                                child: Image.asset(
                                  TravelModel.mockItems[index].imagePath,
                                  fit: BoxFit.cover,
                                ))); // Card
                      },
                    ), // ListView.builder
                  ), // SizedBox
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
