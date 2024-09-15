import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_duplicate/data/models/menu_model.dart';
import 'package:payuung_pribadi_duplicate/presentation/cubit/wellness_cubit.dart';
import 'package:payuung_pribadi_duplicate/presentation/widgets/menu_item_widget.dart';
import 'package:payuung_pribadi_duplicate/presentation/widgets/menu_section_widget.dart';
import 'package:payuung_pribadi_duplicate/presentation/widgets/wellness_item_widget.dart';
import 'package:payuung_pribadi_duplicate/services/styles.dart';
import 'package:payuung_pribadi_duplicate/utils/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import 'profile_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PanelController controller = PanelController();
  int currentIndex = 0;
  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appbar(context),
      body: Stack(
        children: [
          body(context),
          SlidingUpPanel(
            controller: controller,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            backdropOpacity: 0,
            backdropEnabled: false,
            onPanelOpened: () {},
            maxHeight: 320,
            minHeight: 80,
            panelBuilder: () {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GridView.builder(
                      itemCount: bottomNavbar.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        height: 90,
                      ),
                      itemBuilder: (context, index) {
                        final menu = bottomNavbar[index];
                        return MenuItemWidget(
                          name: menu.name,
                          image: menu.image,
                          onTap: () {
                            setIndex(index);
                          },
                          size: const Size(30, 30),
                          isActive: index == currentIndex,
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

AppBar appbar(BuildContext context) {
  return AppBar(
    backgroundColor: primaryColor,
    elevation: 0,
    title: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selamat pagi',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        Text(
          'Ahmad',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.notifications_outlined,
          color: Colors.white,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            ProfilePage.routeName,
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade500,
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}

SingleChildScrollView body(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30.0,
          margin: const EdgeInsets.only(top: 8.0),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 1.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuSection(
                title: 'Produk Keuangan',
                child: GridView.builder(
                  itemCount: financeProducts.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    height: 90,
                  ),
                  itemBuilder: (context, index) {
                    final menu = financeProducts[index];
                    return MenuItemWidget(
                      name: menu.name,
                      image: menu.image,
                      onTap: () {},
                    );
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              MenuSection(
                title: 'Kategori Pilihan',
                child: GridView.builder(
                  itemCount: selectedCategories.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    height: 90,
                  ),
                  itemBuilder: (context, index) {
                    final menu = selectedCategories[index];
                    return MenuItemWidget(
                      name: menu.name,
                      image: menu.image,
                      onTap: () {},
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              MenuSection(
                title: 'Explore Wellness',
                child: BlocBuilder<WellnessCubit, WellnessState>(
                  builder: (context, state) {
                    if (state is WellnessLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is WellnessLoaded) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                          crossAxisSpacing: 16,
                          height: 200,
                          mainAxisSpacing: 16,
                          crossAxisCount: 2,
                        ),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.wellness.length,
                        itemBuilder: (context, index) {
                          final wellness = state.wellness[index];
                          final bool isHaveDiscount =
                              wellness.discountPrice != null &&
                                  wellness.discount != null;
                          return WellnessItem(
                            wellness: wellness,
                            isHaveDiscount: isHaveDiscount,
                          );
                        },
                      );
                    } else if (state is WellnessError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return const Center(child: Text('No products'));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
