import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PointController extends GetxController {
  final supabase = Supabase.instance.client;
  final leaderBoard = [].obs;

  @override
  void onInit() {
    super.onInit();
    getLeaderBoardData();
  }

  Future<void> getLeaderBoardData() async {
    final supabase = Supabase.instance.client;
    try {
      leaderBoard.value = await supabase
          .from('points')
          .select('*, users(profile_picture_url, username)')
          .order('point', ascending: false);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateUserPoint({
    required String id,
    required int point,
  }) async {
    try {
      final currentPoint = await supabase.from('points').select().eq('id', id);
      print(currentPoint);
      await supabase
          .from('points')
          .update({'point': currentPoint[0]['point'] + point}).eq('id', id);
    } catch (error) {
      rethrow;
    }
  }
}
