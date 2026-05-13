import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Track Order'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header Info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.neonBlue.withOpacity(0.3)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order #MV-9021', style: TextStyle(color: Colors.white60)),
                      SizedBox(height: 4),
                      Text('Estimated: 12 min', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Icon(Icons.timer, color: AppColors.neonBlue, size: 32),
                ],
              ),
            ).animate().fadeIn().slideY(begin: -0.2),
            
            const SizedBox(height: 40),
            
            // Stepper UI
            _buildTrackingStep(
              'Order Received',
              'We have received your order and sent it to the kitchen.',
              Icons.receipt_long,
              true,
              true,
            ),
            _buildTrackingStep(
              'Preparing',
              'Chef is preparing your futuristic meal with care.',
              Icons.restaurant,
              true,
              true,
            ),
            _buildTrackingStep(
              'Cooking',
              'Your meal is being cooked at precise temperatures.',
              Icons.local_fire_department,
              false,
              true,
            ),
            _buildTrackingStep(
              'Ready to Serve',
              'Order is ready! Waiter is on the way to your table.',
              Icons.room_service,
              false,
              false,
            ),
            
            const SizedBox(height: 40),
            
            // Support Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.help_outline, color: AppColors.neonPurple),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Need assistance?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('Call a waiter to your table.', style: TextStyle(color: Colors.white60, fontSize: 12)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('CALL', style: TextStyle(color: AppColors.neonBlue, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 800.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStep(String title, String subtitle, IconData icon, bool isCompleted, bool showConnector) {
    final color = isCompleted ? AppColors.neonBlue : Colors.white24;
    
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.neonBlue.withOpacity(0.1) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                  boxShadow: isCompleted ? [
                    BoxShadow(color: AppColors.neonBlue.withOpacity(0.3), blurRadius: 10),
                  ] : null,
                ),
                child: Icon(icon, color: isCompleted ? AppColors.neonBlue : Colors.white24, size: 24),
              ),
              if (showConnector)
                Expanded(
                  child: Container(
                    width: 2,
                    color: color,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: isCompleted ? Colors.white : Colors.white24,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isCompleted ? Colors.white60 : Colors.white24,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }
}
