import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants/colors.dart';
import '/cubit/shop_home/home_cubit.dart';
import '/cubit/shop_home/home_states.dart';
import '/cubit/single_category/single_category_cubit.dart';
import '/cubit/single_category/single_category_states.dart';
import '/models/home_mdl.dart';

class SingleCategoryScrn extends StatelessWidget {
  final int id;
  final String title;
  const SingleCategoryScrn(this.id, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SingleCategoryCubit()..getCategories(id, context),
      child: BlocConsumer<SingleCategoryCubit, SingleCategoryStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          var model = SingleCategoryCubit.get(context).singleCategoryModel;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                title,
              ),
            ),
            body: ConditionalBuilder(
              condition: model != null,
              builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => singleProductItem(
                  model: model!.data!.data[index],
                  context: context,
                  index: index,
                ),
                separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                itemCount: model!.data!.data.length,
              ),
              fallback: (context) =>const Center(
                child:  CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget singleProductItem({
    required ProductModel model,
    required BuildContext context,
    required int index,
  }) =>
      InkWell(
        onTap: () {
          // navigateTo(context, SingleCategoryScrn(),);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 150.0,
            child: Row(
              children: [
                Container(
                  height: 130.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      2.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.image}',
                      ),
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      // if (model.discount != 0)
                      //   Padding(
                      //     padding: const EdgeInsetsDirectional.only(
                      //       bottom: 10.0,
                      //     ),
                      //     child: Container(
                      //       child: Text(
                      //         model.discount.toString(),
                      //       ),
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 5.0,
                      //       ),
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      Text(
                        model.name.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                          height: 1.4,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Spacer(),
                      BlocConsumer<HomeCubit, HomeStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  children:
                                  [
                                    Row(
                                      children: [
                                        Text(
                                          '${model.price.round()}',
                                         
                                        ),
                                      ],
                                    ),
                                    if (model.discount != 0)
                                      Row(
                                        children: [
                                          Text(
                                            '${model.oldPrice.round()}',
                                           
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0,
                                            ),
                                            child: Container(
                                              width: 1.0,
                                              height: 10.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '${model.discount}%',
                                          
                                          ),
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                      ),
                                  ],
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: ()
                                {
                                  HomeCubit.get(context).changeFavorites(
                                     model.id as int,
                                  );
                                },
                                heroTag : '2',
                                backgroundColor:
                                HomeCubit.get(context).favList[model.id] as bool
                                    ? defaultColor
                                    : null,
                                mini: true,
                                child: const Icon(Icons.favorite,
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  HomeCubit.get(context).changeCart(
                                    id: model.id as int,
                                  );
                                },
                                heroTag : '1',
                                backgroundColor: HomeCubit.get(context).cart[model.id] as bool
                                    ? defaultColor
                                    : null,
                                mini: true,
                                child: const Icon(Icons.badge,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
