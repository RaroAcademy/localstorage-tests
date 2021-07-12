import 'package:localstorage/shared/models/count_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  final Function onUpdate;
  var countModel = CountModel(value: 0);
  var isLoading = true;
  HomeController({required this.onUpdate});

  Future<void> saveCount() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = await instance.setString("count", countModel.toJson());
      if (response) {
        print("Salvo com sucesso");
      } else {
        print("Não foi possível realizar essa operação");
      }
      onUpdate();
    } catch (e) {
      print(e);
    }
  }

  void increment() {
    final count = countModel.value + 1;
    countModel = countModel.copyWith(value: count);
    saveCount();
  }

  Future<void> getCount() async {
    isLoading = true;
    onUpdate();
    await Future.delayed(Duration(seconds: 2));
    
    final instance = await SharedPreferences.getInstance();
    final response = instance.getString("count");
    if (response != null) {
      final count = CountModel.fromJson(response);
      countModel = count;
    }
    isLoading = false;
    onUpdate(); 
  }
}
