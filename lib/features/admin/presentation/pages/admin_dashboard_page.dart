import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:menuverse/core/theme/colors.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Restaurant Admin'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.surface,
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.neonBlue, AppColors.neonPurple]),
              ),
              child: Center(
                child: Text(
                  'MenuVerse Admin',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            _buildDrawerItem(Icons.dashboard, 'Dashboard', true),
            _buildDrawerItem(Icons.restaurant_menu, 'Menu Management', false),
            _buildDrawerItem(Icons.table_bar, 'Table Management', false),
            _buildDrawerItem(Icons.analytics, 'Analytics', false),
            _buildDrawerItem(Icons.people, 'Staff Management', false),
            const Spacer(),
            _buildDrawerItem(Icons.logout, 'Logout', false),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overview', style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 20),
            
            // Stats Cards
            Row(
              children: [
                _buildStatCard('Total Orders', '124', Icons.receipt_long, AppColors.neonBlue),
                const SizedBox(width: 16),
                _buildStatCard('Revenue', '\$2.4k', Icons.attach_money, AppColors.success),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatCard('Active Tables', '8/12', Icons.table_restaurant, AppColors.warning),
                const SizedBox(width: 16),
                _buildStatCard('Avg Time', '22m', Icons.timer, AppColors.neonPurple),
              ],
            ),
            
            const SizedBox(height: 32),
            Text('Revenue Trend', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            
            // Chart
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(20),
              ),
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(1, 1),
                        const FlSpot(2, 4),
                        const FlSpot(3, 2),
                        const FlSpot(4, 5),
                        const FlSpot(5, 3),
                        const FlSpot(6, 4),
                      ],
                      isCurved: true,
                      color: AppColors.neonBlue,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.neonBlue.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            Text('Popular Dishes', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            
            _buildPopularDish('Cyber Ramen', '45 orders', '85%'),
            _buildPopularDish('Neon Sushi Roll', '38 orders', '92%'),
            _buildPopularDish('Quantum Burger', '29 orders', '78%'),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, bool isSelected) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? AppColors.neonBlue : Colors.white60),
      title: Text(
        title,
        style: TextStyle(color: isSelected ? AppColors.neonBlue : Colors.white, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
      ),
      onTap: () {},
      selected: isSelected,
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: Colors.white60, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularDish(String name, String orders, String trend) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.neonBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.fastfood, color: AppColors.neonBlue, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(orders, style: const TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
          Text(trend, style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold)),
          const Icon(Icons.trending_up, color: AppColors.success, size: 16),
        ],
      ),
    );
  }
}
