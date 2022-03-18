import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/shop_home/home_cubit.dart';
import '/cubit/shop_home/home_states.dart';
import '/screens/single_category_scrn.dart';
import '/widgets/components.dart';
import '/constants/colors.dart';
import '/models/category_mdl.dart';
import '/models/home_mdl.dart';

class ProductsScrn extends StatelessWidget {
  const ProductsScrn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SuccessFavoritesDataState) {
          if (state.favModel == false) {
            showToast(
                text: state.favModel.message.toString(),
                state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel != null &&
              HomeCubit.get(context).categoriesModel != null,
          builder: (context) => productsBuilder(
              HomeCubit.get(context).homeModel!,
              HomeCubit.get(context).categoriesModel!,
              context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel catModel, context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
//Start Categories Section
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          categoriesItem(catModel.data!.data[index], context),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10.0,
                          ),
                      itemCount: catModel.data!.data.length),
                ),
//End Categories Section
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.48,
            children: List.generate(model.data!.products.length,
                (index) => productItem(model.data!.products[index], context)),
          ),
        ],
      ),
    );
  }

  Widget categoriesItem(ProductDataOfCategory proCatDtata, context) {
    return InkWell(
      onTap: () => navigateTo(
        context,
        SingleCategoryScrn(proCatDtata.id, proCatDtata.name),
      ),
      child: Card(
        elevation: 5,
        shadowColor: grey,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(proCatDtata.image),
              height: 100.0,
              width: 100.0,
              fit: BoxFit.cover,
            ),
            Container(
              width: 100.0,
              color: Colors.black.withOpacity(.8),
              child: Text(
                proCatDtata.name,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productItem(ProductModel mdl, context) {
    return Card(
      elevation: 10,
      shadowColor: grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Image(
                  image: NetworkImage(mdl.image!),
                  width: double.infinity,
                  height: 150.0,
                ),
              ),
              if (mdl.discount != 0)
                Positioned(
                  top: 44,
                  left: -3,
                  child: Transform.rotate(
                    angle: -45,
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4.5),
                      color: defaultColor,
                      child: const Text(
                        ' SALE  ',
                        style: TextStyle(fontSize: 12.0, color: white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mdl.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14.0, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${mdl.price.round()}',
                      style:
                          const TextStyle(fontSize: 12.0, color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (mdl.discount != 0)
                      Text(
                        '${mdl.oldPrice.round()}',
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () =>
                          HomeCubit.get(context).changeFavorites(mdl.id as int),
                      icon: Icon(
                        HomeCubit.get(context).favList[mdl.id] == true
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
    );
  }
}
