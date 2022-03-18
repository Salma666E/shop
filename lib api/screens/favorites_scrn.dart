import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/shop_home/home_cubit.dart';
import '/cubit/shop_home/home_states.dart';
import '/constants/colors.dart';
import '/models/favorite_mdl.dart';

class FavoritesScrn extends StatelessWidget {
  const FavoritesScrn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! FavoritesLoadingState &&
              ((HomeCubit.get(context).favoriteModel) != null),
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return favListItem(context,
                  HomeCubit.get(context).favoriteModel!.data!.data[index]);
            },
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
            itemCount: HomeCubit.get(context).favoriteModel!.data!.data.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget favListItem(context, detailsData _favmodel) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: SizedBox(
          height: 150.0,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0, right: 2.0),
                child: Image(
                  image: NetworkImage(_favmodel.product!.image.toString()),
                  height: 130.0,
                  width: 200,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      _favmodel.product!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14.0, height: 1.3),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_favmodel.product!.price.round()}',
                          style: const TextStyle(
                              fontSize: 12.0, color: defaultColor),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        if (_favmodel.product!.discount != 0)
                          Text(
                            '${_favmodel.product!.oldPrice.round()}',
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => HomeCubit.get(context)
                              .changeFavorites(_favmodel.product!.id),
                          icon: Icon(
                            HomeCubit.get(context)
                                        .favList[_favmodel.product!.id] ==
                                    true
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
