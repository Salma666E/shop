import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/shop_home/home_cubit.dart';
import '/cubit/shop_home/home_states.dart';
import '/screens/single_category_scrn.dart';
import '/widgets/components.dart';
import '/models/category_mdl.dart';

class CategoriesScrn extends StatelessWidget {
  const CategoriesScrn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! CategoriesLoadingState &&
              ((HomeCubit.get(context).categoriesModel) != null),
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => categoryItem(context,
                HomeCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
            itemCount:
                HomeCubit.get(context).categoriesModel!.data!.data.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget categoryItem(context, ProductDataOfCategory model) => InkWell(
        onTap: () {
          navigateTo(
            context,
            SingleCategoryScrn(model.id, model.name),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    2.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${model.image}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                '${model.name}',
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                // HomeCubit.get(context).appDirection == TextDirection.ltr ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                size: 14.0,
              ),
            ],
          ),
        ),
      );
}
