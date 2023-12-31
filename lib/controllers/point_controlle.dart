import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PointController extends GetxController {
  final supabase = Supabase.instance.client;

  Future<void> updateUserPoint({
    required String id,
    required int point,
  }) async {
    try {
      await supabase.from('points').update({'point': point}).eq('id', id);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getLeaderBoardData() async {}
}
