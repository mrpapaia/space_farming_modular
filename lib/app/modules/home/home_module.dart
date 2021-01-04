import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:space_farming_modular/app/modules/home/pages/home_add_farm/home_add_farm_controller.dart';
import 'package:space_farming_modular/app/modules/home/pages/home_add_farm/home_add_farm_page.dart';

import 'package:space_farming_modular/app/modules/home/pages/home_bot_create/home_bot_create_controller.dart';
import 'package:space_farming_modular/app/modules/home/pages/home_bot_create/home_bot_create_page.dart';
import 'package:space_farming_modular/app/modules/home/pages/home_info_bot/home_info_bot_controller.dart';
import 'package:space_farming_modular/app/modules/home/pages/home_info_bot/home_info_bot_page.dart';

import 'package:space_farming_modular/app/shared/repositories/botijaorepository.dart';

import 'package:space_farming_modular/app/shared/repositories/farmrepository.dart';
import 'package:space_farming_modular/app/shared/repositories/interfaces/irepositorybotijao.dart';

import 'package:space_farming_modular/app/shared/repositories/interfaces/irepositoryfarm.dart';
import 'package:space_farming_modular/app/shared/repositories/interfaces/irepositoryuser.dart';
import 'package:space_farming_modular/app/shared/repositories/userrepository.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds {
    return [
      Bind(
        (i) => HomeController(
            i.get(), i.get(), i.get(), i.args.data[0], i.args.data[1]),
      ),
      Bind(
        (i) => HomeInfoBotController(
            user: i.args.data[0], botijao: i.args.data[1]),
      ),
      Bind(
        (i) => HomeAddFarmController(i.get(), i.get(), i.args.data[0]),
      ),
      Bind<IRepositoryBotijao>(
        (i) => BotijaoRepository(FirebaseFirestore.instance),
      ),
      Bind<IRepositoryUserP>(
        (i) => UserPRepository(FirebaseFirestore.instance),
      ),
      Bind<IRepositoryFarm>(
        (i) => FarmRepository(FirebaseFirestore.instance),
      ),
      Bind(
        (i) => HomeBotCreateController(
            repository: i.get(), path: i.args.data[0], botijao: i.args.data[1]),
      ),
    ];
  }

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => HomePage(),
        ),
        ModularRouter(
          "/info",
          child: (_, args) => HomeInfoBotPage(),
        ),
        ModularRouter(
          "/add",
          child: (_, args) => HomeBotCreatePage(),
        ),
        ModularRouter(
          "/addFarm",
          child: (_, args) => HomeAddFarmPage(),
        ),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
