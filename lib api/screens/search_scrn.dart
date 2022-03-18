import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants/colors.dart';
import '/cubit/search/search_cubit.dart';
import '/cubit/search/search_states.dart';
import '/cubit/shop_home/home_cubit.dart';
import '/models/search_mdl.dart';

class SearchScrn extends StatelessWidget {
  SearchScrn({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter text for search...';
                          }
                        },
                        onFieldSubmitted: (String text) {
                          SearchCubit.get(context).getSearchData(text);
                        },
                        decoration: const InputDecoration(
                          labelText: "Search Text",
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return searchListItem(
                                  context,
                                  SearchCubit.get(context)
                                      .searchModel!
                                      .data!
                                      .data[index]);
                            },
                            separatorBuilder: (context, index) => Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                            itemCount: SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data
                                .length,
                          ),
                        ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }

  Widget searchListItem(context, Product _favmodel) => Padding(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          height: 150.0,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0, right: 2.0),
                child: Image(
                  image: NetworkImage(_favmodel.image.toString()),
                  height: 130.0,
                  width: 200,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      _favmodel.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14.0, height: 1.3),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_favmodel.price.round()}',
                          style: const TextStyle(
                              fontSize: 12.0, color: defaultColor),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => HomeCubit.get(context)
                              .changeFavorites(_favmodel.id),
                          icon: Icon(
                            HomeCubit.get(context).favList[_favmodel.id] == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 30,
                            color: defaultColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
