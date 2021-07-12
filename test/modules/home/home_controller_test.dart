import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/modules/home/home_controller.dart';
import 'package:localstorage/shared/models/count_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('HomeController increment', () {
    test('Should increment', () async {
      //Arrange - inicialização
      late HomeController controller = HomeController(onUpdate: () {});
      SharedPreferences.setMockInitialValues({'count': ''});

      //Act - ação
      controller.increment();

      //Assert - valiação
      expect(controller.countModel.value, 1);
    });

    test('Should increment multiple times', () async {
      //Arrange
      late HomeController controller = HomeController(onUpdate: () {});
      SharedPreferences.setMockInitialValues({'count': ''});

      //Act
      controller.increment();
      controller.increment();
      controller.increment();

      //Assert
      expect(controller.countModel.value, 3);
    });
  });

  test('Should stop loading after getCount()', () async {
    //Arrange
    late HomeController controller = HomeController(onUpdate: () {});
    SharedPreferences.setMockInitialValues({'count': '{"value": 10}'});

    //Act
    await controller.getCount();

    //Assert
    expect(controller.isLoading, false);
  });

  group('HomeController local storage', () {
    test('Should get count from local storage', () async {
      //Arrange
      late HomeController controller = HomeController(onUpdate: () {});
      SharedPreferences.setMockInitialValues({'count': '{"value": 10}'});

      //Act
      await controller.getCount();

      //Assert
      expect(controller.countModel.value, 10);
    });

    test('Should save count in local storage', () async {
      //Arrange
      late HomeController controller = HomeController(onUpdate: () {});
      SharedPreferences.setMockInitialValues({'count': ''});

      final countModel = CountModel(value: 3);
      controller.countModel = countModel;

      //Act
      await controller.saveCount();
      final instance = await SharedPreferences.getInstance();
      final count = instance.getString("count");

      //Assert
      expect(count, '{"value":3}');
    });
  });
}
