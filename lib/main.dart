// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:g_auths/auths.dart';
import 'package:g_entities/entities.dart';
import 'package:g_firestore/firestore.dart';
import 'package:g_pages/pages.dart';
import 'package:get/get.dart';
import 'package:tankdrum_learning/entities/sys_config.dart';
import 'package:tankdrum_learning/pages/player_page/player.page.dart';
import 'package:tankdrum_learning/pages/select_song_page/select_song.page.dart';

import 'entities/_generated/e_creator.dart';
import 'entities/root.dart';
import 'pages/_generated/page_list.dart';
import 'src/i18n/translator.dart';

void main() {
  runApp(const TankDrumApp(SelectSongPage()));
}

class TankDrumApp extends RunningApp {
  const TankDrumApp(home, {Key? key}) : super(home, key: key);
  @override
  Translations createTranslations() {
    return Translator();
  }

  @override
  GetPage unknownRoute() {
    return PlayerPage.page;
  }

  @override
  Future<void> init() async {
    Pages.isLoggedIn = () => AuthService.isLoggedIn;
    await SysConfig.loadConfig();
    initApp();
  }

  initApp() async {
    GEntity.instance.entityCreator = ECreator();
    GEntity.instance.rootEntity = () => Root();
    if (!GetPlatform.isWeb) {
      await Firebase.initializeApp();
    }
    await GFirestore.init();
    await GEntity.init();
  }

  @override
  List<GetPage> getPageList() {
    return pageList;
  }
}
