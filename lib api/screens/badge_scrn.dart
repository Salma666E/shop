import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants/colors.dart';
import '/cubit/shop_home/home_cubit.dart';
import '/cubit/shop_home/home_states.dart';
import '/models/cart_mdl.dart';
import '/screens/order_scrn.dart';
import '/widgets/components.dart';

class BadgeScrn extends StatelessWidget {
  const BadgeScrn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("My Cart"),
          ),
          body: ConditionalBuilder(
            condition: state is! CartLoadingState &&
                ((HomeCubit.get(context).cartModel) != null),
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => badgeItem(context,
                  HomeCubit.get(context).cartModel!.data!.cartItems[index]),
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              itemCount:
                  HomeCubit.get(context).cartModel!.data!.cartItems.length,
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget badgeItem(context, CartItems model) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          OrderScreen(),
        );
      },
      child: Padding(
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
                  image: NetworkImage(model.product!.image.toString()),
                  height: 130.0,
                  width: 150,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      model.product!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14.0, height: 1.3),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${model.product!.price.round()}',
                          style: const TextStyle(
                              fontSize: 12.0, color: defaultColor),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            '${model.product!.oldPrice.round()}',
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => HomeCubit.get(context)
                              .changeFavorites(model.product!.id),
                          icon: Icon(
                            HomeCubit.get(context).favList[model.product!.id] ==
                                    true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 30,
                            color: defaultColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => HomeCubit.get(context).changeCart(
                            id: model.id as int,
                          ),
                          icon: const Icon(
                            Icons.badge,
                            size: 30,
                            color: defaultColor,
                            // HomeCubit.get(context).cart[model.id] as bool
                            //     ? defaultColor
                            //     : grey,
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
      ),
    );
  }
}
