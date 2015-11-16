// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_badge_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_elements/paper_badge.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('badge is positioned correctly', () {
      DivElement f = fixture('basic');
      PaperBadge badge = f.querySelector('paper-badge');
      HtmlElement actualbadge = badge.querySelector('#badge');
      expect(actualbadge.text, equals("1"));
      expect(badge.target.getAttribute('id'), 'target');
      badge.updatePosition();

      Completer done = new Completer();

      wait(1).then((_) {
        Rectangle divRect = f.querySelector('#target').getBoundingClientRect();
        expect(divRect.width, equals(100));
        expect(divRect.height, equals(20));

        Rectangle contentRect = badge.getBoundingClientRect();
        expect(contentRect.width, equals(22));
        expect(contentRect.height, equals(22));
        // The target div is 100 x 20, and the badge is centered on the
        // top right corner.
        expect(contentRect.left, equals(100 - 11));
        expect(contentRect.top, equals(0 - 11));
        // Also check the math, just in case.
        expect(contentRect.left, equals(divRect.width - 11));
        expect(contentRect.top, equals(divRect.top - 11));
        done.complete();
      });

      return done.future;
    });
    test('badge is positioned correctly after being dynamically set', () {
      DivElement f = fixture('dynamic');
      PaperBadge badge = f.querySelector('paper-badge');
      badge.updatePosition();

      expect(badge.target.getAttribute('id'), isNot('target'));

      Completer done = new Completer();

      wait(1).then((_) {
        Rectangle contentRect = badge.getBoundingClientRect();
        expect(contentRect.left, isNot(100 - 11));
        badge.forId = 'target';
        expect(badge.target.getAttribute('id'), 'target');
        badge.updatePosition();

        wait(1).then((_) {
          Rectangle divRect =
              f.querySelector('#target').getBoundingClientRect();
          expect(divRect.width, equals(100));
          expect(divRect.height, equals(20));

          Rectangle contentRect = badge.getBoundingClientRect();
          expect(contentRect.width, equals(22));
          expect(contentRect.height, equals(22));
          // The target div is 100 x 20, and the badge is centered on the
          // top right corner.
          expect(contentRect.left, equals(100 - 11));
          expect(contentRect.top, equals(0 - 11));
          // Also check the math, just in case.
          expect(contentRect.left, equals(divRect.width - 11));
          expect(contentRect.top, equals(divRect.top - 11));
          done.complete();
        });
      });

      return done.future;
    });
  });

  test('badge is positioned correctly when nested in a target element',
      () async {
    var f = fixture('nested');
    var badge = f.querySelector('paper-badge');

    expect(badge.target.getAttribute('id'), 'target');

    badge.updatePosition();

    await wait(1);
    var divRect = f.querySelector('#target').getBoundingClientRect();
    expect(divRect.width, 100);
    expect(divRect.height, 20);

    var contentRect = badge.getBoundingClientRect();
    expect(contentRect.width, 22);
    expect(contentRect.height, 22);

    // The target div is 100 x 20, and the badge is centered on the
    // top right corner.
    expect(contentRect.left, 100 - 11);
    expect(contentRect.top, 0 - 11);

    // Also check the math, just in case.
    expect(contentRect.left, divRect.width - 11);
    expect(contentRect.top, divRect.top - 11);
  });

  group('badge is inside a custom element', () {
    test('badge is positioned correctly', () {
      HtmlElement f = fixture('custom');

      PaperBadge badge = f.querySelector('paper-badge');
      HtmlElement actualbadge = badge.querySelector('#badge');
      expect(actualbadge.text, equals("1"));
      badge.updatePosition();

      Completer done = new Completer();

      wait(1).then((_) {
        Rectangle divRect = f.querySelector("#button").getBoundingClientRect();
        expect(divRect.width, equals(100));
        expect(divRect.height, equals(20));

        Rectangle contentRect = badge.getBoundingClientRect();
        expect(contentRect.width, equals(22));
        expect(contentRect.height, equals(22));
        // The target div is 100 x 20, and the badge is centered on the
        // top right corner.
        expect(contentRect.left, equals(100 - 11));
        expect(contentRect.top, equals(0 - 11));
        // Also check the math, just in case.
        expect(contentRect.left, equals(divRect.width - 11));
        expect(contentRect.top, equals(divRect.top - 11));

        done.complete();
      });
    });
  });
}
