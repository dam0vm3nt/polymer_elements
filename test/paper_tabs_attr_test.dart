// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_tabs_attr_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_elements/paper_tabs.dart';
import 'package:polymer_elements/paper_tab.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'package:polymer/polymer.dart' show PolymerDom;

/**
 * Original tests:
 * https://github.com/PolymerElements/paper-tabs/tree/master/test
 */

main() async {
  await initWebComponents();

  group('set the selected attribute', () {
    PaperTabs tabs;

    setUp(() async {
      tabs = fixture('basic');
      await new Future(() {});
    });

    test('selected value', () {
      expect(tabs.selected, equals('bar'));
    });

    test('selected tab has iron-selected class', () {
      PolymerDom.flush();
      expect(
          tabs.querySelector('[name=bar]').classes, contains('iron-selected'));
    });
  });

  group('select tab via click', () {
    PaperTabs tabs;
    PaperTab tab;

    setUp(() async {
      tabs = fixture('basic');
      await new Future(() {});
      tab = tabs.querySelector('[name=zot]');
      tab.dispatchEvent(new CustomEvent('click', canBubble: true));
    });

    test('selected value', () {
      expect(tabs.selected, equals('zot'));
    });

    test('selected tab has iron-selected class', () {
      PolymerDom.flush();
      expect(tab.classes.contains('iron-selected'), isTrue);
    });
  });
}
