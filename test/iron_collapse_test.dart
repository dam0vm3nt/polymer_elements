// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_collapse_test;

import 'dart:async';
import 'package:polymer_elements/iron_collapse.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    IronCollapse collapse;
    var delay = new Duration(milliseconds: 750);
    var collapseHeight;

    setUp(() {
      collapse = fixture('basic');
    });

    test('opened attribute', () {
      expect(collapse.opened, true);
    });

    test('horizontal attribute', () {
      expect(collapse.horizontal, false);
    });

    test('default opened height', () {
      return new Future.delayed(delay, () {
        // store height
        collapseHeight = collapse.getComputedStyle().height;
        // verify height not 0px
        expect(collapseHeight, isNot('0px'));
      });
    });

    test('set opened to false', () {
      collapse.opened = false;
      return new Future.delayed(delay, () {
        var h = collapse.getComputedStyle().height;
        // verify height is 0px
        expect(h, '0px');
      });
    });

    test('set opened to true', () {
      collapse.opened = true;
      return new Future.delayed(delay, () {
        var h = collapse.getComputedStyle().height;
        // verify height
        expect(h, collapseHeight);
      });
    });
  });

  group('horizontal', () {
    IronCollapse collapse;
    var delay = 500;
    var width;

    setUp(() {
      collapse = fixture('horizontal');
    });

    test('opened attribute', () {
      expect(collapse.opened, true);
    });

    test('horizontal attribute', () {
      expect(collapse.horizontal, true);
    });

    test('default opened width', () async {
      await wait(delay);
      // store height
      width = collapse.getComputedStyle().width;
      // verify height not 0px
      expect(width, isNot('0px'));
    });

    test('set opened to false', () async {
      collapse.opened = false;
      await wait(delay);
      var w = collapse.getComputedStyle().width;
      // verify height is 0px
      expect(w, '0px');
    });

    test('set opened to true', () async {
      collapse.opened = true;
      await wait(delay);
      var w = collapse.getComputedStyle().width;
      // verify height
      expect(w, width);
    });
  });
}
