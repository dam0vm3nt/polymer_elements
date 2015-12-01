// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_tabs_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_elements/paper_tabs.dart';
import 'package:polymer_elements/paper_tab.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

/**
 * Original tests:
 * https://github.com/PolymerElements/paper-tabs/tree/master/test
 */

main() async {
  await initWebComponents();

  void checkSelectionBar(PaperTabs tabs, PaperTab tab) {
    Rectangle tabRect = tab.getBoundingClientRect();
    Rectangle rect =
        tabs.querySelector('#selectionBar').getBoundingClientRect();
    expect(tabRect.left.round(), equals(rect.left.round()));
  }

  group('defaults', () {
    PaperTabs tabs;

    setUp(() async {
      tabs = fixture('basic');
      await new Future(() {});
    });

    test('to nothing selected', () {
      expect(tabs.selected, isNull);
    });

    test('no tabs have iron-selected class', () {
      tabs.querySelectorAll('paper-tab').forEach((PaperTab tab) {
        expect(tab.classes.contains('iron-selected'), isFalse);
      });
    });

    test('to false as noink', () {
      expect(tabs.noink, isFalse);
    });

    test('to false as noBar', () {
      expect(tabs.noBar, isFalse);
    });

    test('to false as noSlide', () {
      expect(tabs.noSlide, isFalse);
    });

    test('to false as scrollable', () {
      expect(tabs.scrollable, isFalse);
    });

    test('to false as disableDrag', () {
      expect(tabs.disableDrag, isFalse);
    });

    test('to false as hideScrollButtons', () {
      expect(tabs.hideScrollButtons, isFalse);
    });

    test('to false as alignBottom', () {
      expect(tabs.alignBottom, isFalse);
    });

    test('has role tablist', () {
      expect(tabs.getAttribute('role'), equals('tablist'));
    });
  });

  group('hidden tabs', () {
    PaperTabs tabs;

    setUp(() async {
      tabs = fixture('hiddenTabs');
      await new Future(() {});
    });

    test('choose the correct bar position once made visible', () {
      tabs.attributes.remove('hidden');
      tabs.selected = '0';
      expect(tabs.jsElement['_width'], greaterThan(0));
      expect(tabs.jsElement['_left'], equals(0));
    });
  });

  group('set the selected attribute', () {
    PaperTabs tabs;
    int index = 0;

    setUp(() async {
      tabs = fixture('basic');
      await new Future(() {});
      tabs.selected = index.toString();
    });

    test('selected value', () {
      expect(tabs.selected, equals(index.toString()));
    });

    test('selected tab has iron-selected class', () {
      PaperTab tab = tabs.querySelectorAll('paper-tab')[index];
      expect(tab.classes.contains('iron-selected'), isTrue);
    });

    test('selected tab has selection bar position at the bottom of the tab',
        () async {
      await wait(1000);
      checkSelectionBar(tabs, tabs.querySelectorAll('paper-tab')[index]);
    });
  });

  group('select tab via click', () {
    PaperTabs tabs;
    PaperTab tab;
    int index = 1;

    setUp(() async {
      tabs = fixture('basic');
      await new Future(() {});
      tab = tabs.querySelectorAll('paper-tab')[index];
      tab.dispatchEvent(new CustomEvent('click', canBubble: true));
    });

    test('selected value', () {
      expect(tabs.selected, equals(index));
    });

    test('selected tab has iron-selected class', () {
      expect(tab.classes.contains('iron-selected'), isTrue);
    });

    test('selected tab has selection bar position at the bottom of the tab',
        () async {
      await wait(1000);
      checkSelectionBar(tabs, tabs.querySelectorAll('paper-tab')[index]);
    });

    test('pressing enter on tab causes a click', () {
      int clickCount = 0;

      var done = tab.on['click'].first.then((_) {
        clickCount++;

        expect(clickCount, equals(1));
      });

      pressEnter(tab);

      return done;
    });
  });

  group('noink attribute', () {
    PaperTabs tabs;

    setUp(() {
      tabs = fixture('basic');
    });

    test('noink attribute propagates to all descendant tabs', () {
      tabs.noink = true;
      tabs.querySelectorAll('paper-tab').forEach((PaperTab tab) {
        expect(tab.noink, isTrue);
      });

      tabs.noink = false;
      tabs.querySelectorAll('paper-tab').forEach((PaperTab tab) {
        expect(tab.noink, isFalse);
      });
    });
  });
}
