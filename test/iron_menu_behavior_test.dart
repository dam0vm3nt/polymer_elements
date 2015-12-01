@TestOn('browser')
library polymer_elements.test.iron_menu_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/test_menu.dart';

main() async {
  await initPolymer();

  group('menu a11y tests', () {
    TestMenu menu;
    group('basic', () {
      setUp(() async {
        menu = fixture('basic');
        await new Future(() {});
      });

      test('menu has role="menu"', () {
        expect(menu.getAttribute('role'), 'menu', reason: 'has role="menu"');
      });

      test('first item gets focus when menu is focused', () async {
        focus(menu);
        // wait for async in _onFocus
        await wait(200);
        expect(document.activeElement, menu.children.first,
            reason: 'document.activeElement is first item');
      });

      test('selected item gets focus when menu is focused', () async {
        menu.selected = 1;
        focus(menu);
        // wait for async in _onFocus
        await wait(200);
        expect(document.activeElement, menu.selectedItem,
            reason: 'document.activeElement is selected item');
      });
    });

    group('multi', () {
      setUp(() async {
        menu = fixture('multi');
        await new Future(() {});
      });

      test('last activated item in a multi select menu is focused', () async {
        menu.selected = 0;
        tap(menu.items[1]);
        // wait for async in _onFocus
        await wait(200);
        expect(document.activeElement, menu.items[1],
            reason: 'document.activeElement is last activated item');
      }, skip: 'fails in test runner');

      test('deselection in a multi select menu focuses deselected item',
          () async {
        menu.selected = 0;
        tap(menu.items[0]);
        // wait for async in _onFocus
        await wait(200);
        expect(document.activeElement, menu.items[0],
            reason: 'document.activeElement is last activated item');
      });
    });
  });
}
