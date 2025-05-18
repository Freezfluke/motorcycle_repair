import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motorcycle_repair/constants/font_size.dart';
import 'package:motorcycle_repair/presentation/viewModels/auth_viewmodel.dart';
import 'package:motorcycle_repair/widgets/amimation_list_top.dart';
import 'package:motorcycle_repair/widgets/animation_float_top.dart';
import 'package:motorcycle_repair/widgets/font.dart';
import 'package:motorcycle_repair/widgets/icon.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);
    final List<Map<String, dynamic>> categories = [
      {'name': 'Plumbing', 'icon': Icons.water_drop},
      {'name': 'Repair', 'icon': Icons.build},
      {'name': 'Cleaning', 'icon': Icons.cleaning_services},
      {'name': 'Painting', 'icon': Icons.format_paint},
      {'name': 'Labour', 'icon': Icons.engineering},
      {'name': 'Van', 'icon': Icons.local_shipping},
    ];
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Theme.of(context).cardColor,
        ),
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: SlideUpOnLoad(
                  offsetY: 60.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildUserProfileCard(context, vm),
                      _cardBanner(context, vm),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: categories.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemBuilder: (context, index) {
                            return _categoryCard(
                              context,
                              title: categories[index]['name'],
                              icon: categories[index]['icon'],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }

  Widget _buildUserProfileCard(BuildContext context, AuthViewModel vm) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const IconWidget(
              icon: Icons.person,
            ),
            title: TextWidget.title(
                message: "${vm.currentUser?.name} ${vm.currentUser?.lastName}"),
            subtitle: _buildLocationRow(vm),
            trailing: _buildNotificationButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(AuthViewModel vm) {
    return Row(
      children: <Widget>[
        const IconWidget(
          icon: Icons.maps_home_work,
          size: FontSize.iconSmall,
          color: Colors.black45,
        ),
        const SizedBox(width: 5),
        TextWidget(
          message: "${vm.currentUser?.role}",
        ),
      ],
    );
  }

  Widget _buildNotificationButton() {
    return ClipOval(
      child: Material(
        color: Colors.black12,
        child: InkWell(
          splashColor: Colors.grey,
          onTap: () {
            // Notification tapped
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const IconWidget(
              icon: Icons.notifications,
              size: FontSize.iconSmall,
              color: Colors.black45,
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardBanner(BuildContext context, AuthViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const TextWidget.title(message: "Welcome to our app"),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              const Positioned.fill(
                child: Image(
                  image: NetworkImage(
                    'https://etspakistan.com/wp-content/uploads/2017/11/12.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: ElevatedButton(
                  onPressed: () {
                    vm.logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: const TextWidget(
                    message: "Book Now",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(
                1,
                1,
              ),
            )
          ],
          // border: Border.all(color: Colors.blue),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
