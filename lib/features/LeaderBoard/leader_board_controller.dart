import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderBoardController extends GetxController {
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

      print(leaderBoard);
    } catch (error) {
      rethrow;
    }
  }
}
