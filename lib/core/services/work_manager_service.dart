
import 'package:to_do_app/core/services/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  //dy function bttnfz

  void registerMyTask() {
    Workmanager().registerPeriodicTask(
      "id1",
      "show simple notfication",
      frequency: Duration(hours: 123), // معناها ان كل ربع ساعه هنده التاسك اللي تحت اللي هي نتوفيكشن
    );
  }

  //b3ml intilize l workmanager
  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: true);
    registerMyTask();
  }
}

@pragma('vm:entry-point')
void actionTask() {
  // show simple notfication
  Workmanager().executeTask((taskName, inputData) {
    // background services kol moda m3ina httnd7
    LocalNotificationService.showBasicNotification();
    return Future.value(true);
  });
}
