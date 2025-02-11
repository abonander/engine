// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:test/test.dart';

void main() {
  test('RRect.contains()', () {
    final RRect rrect = RRect.fromRectAndCorners(
      const Rect.fromLTRB(1.0, 1.0, 2.0, 2.0),
      topLeft: const Radius.circular(0.5),
      topRight: const Radius.circular(0.25),
      bottomRight: const Radius.elliptical(0.25, 0.75),
      bottomLeft: Radius.zero,
    );

    expect(rrect.contains(const Offset(1.0, 1.0)), isFalse);
    expect(rrect.contains(const Offset(1.1, 1.1)), isFalse);
    expect(rrect.contains(const Offset(1.15, 1.15)), isTrue);
    expect(rrect.contains(const Offset(2.0, 1.0)), isFalse);
    expect(rrect.contains(const Offset(1.93, 1.07)), isFalse);
    expect(rrect.contains(const Offset(1.97, 1.7)), isFalse);
    expect(rrect.contains(const Offset(1.7, 1.97)), isTrue);
    expect(rrect.contains(const Offset(1.0, 1.99)), isTrue);
  });

  test('RRect.contains() large radii', () {
    final RRect rrect = RRect.fromRectAndCorners(
      const Rect.fromLTRB(1.0, 1.0, 2.0, 2.0),
      topLeft: const Radius.circular(5000.0),
      topRight: const Radius.circular(2500.0),
      bottomRight: const Radius.elliptical(2500.0, 7500.0),
      bottomLeft: Radius.zero,
    );

    expect(rrect.contains(const Offset(1.0, 1.0)), isFalse);
    expect(rrect.contains(const Offset(1.1, 1.1)), isFalse);
    expect(rrect.contains(const Offset(1.15, 1.15)), isTrue);
    expect(rrect.contains(const Offset(2.0, 1.0)), isFalse);
    expect(rrect.contains(const Offset(1.93, 1.07)), isFalse);
    expect(rrect.contains(const Offset(1.97, 1.7)), isFalse);
    expect(rrect.contains(const Offset(1.7, 1.97)), isTrue);
    expect(rrect.contains(const Offset(1.0, 1.99)), isTrue);
  });

  test('RRect.scaleRadii() properly constrained radii should remain unchanged', () {
    final RRect rrect = RRect.fromRectAndCorners(
      const Rect.fromLTRB(1.0, 1.0, 2.0, 2.0),
      topLeft: const Radius.circular(0.5),
      topRight: const Radius.circular(0.25),
      bottomRight: const Radius.elliptical(0.25, 0.75),
      bottomLeft: Radius.zero,
    ).scaleRadii();

    // check sides
    expect(rrect.left, 1.0);
    expect(rrect.top, 1.0);
    expect(rrect.right, 2.0);
    expect(rrect.bottom, 2.0);

    // check corner radii
    expect(rrect.tlRadiusX, 0.5);
    expect(rrect.tlRadiusY, 0.5);
    expect(rrect.trRadiusX, 0.25);
    expect(rrect.trRadiusY, 0.25);
    expect(rrect.blRadiusX, 0.0);
    expect(rrect.blRadiusY, 0.0);
    expect(rrect.brRadiusX, 0.25);
    expect(rrect.brRadiusY, 0.75);
  });

  test('RRect.scaleRadii() sum of radii that exceed side length should properly scale', () {
    final RRect rrect = RRect.fromRectAndCorners(
      const Rect.fromLTRB(1.0, 1.0, 2.0, 2.0),
      topLeft: const Radius.circular(5000.0),
      topRight: const Radius.circular(2500.0),
      bottomRight: const Radius.elliptical(2500.0, 7500.0),
      bottomLeft: Radius.zero,
    ).scaleRadii();

    // check sides
    expect(rrect.left, 1.0);
    expect(rrect.top, 1.0);
    expect(rrect.right, 2.0);
    expect(rrect.bottom, 2.0);

    // check corner radii
    expect(rrect.tlRadiusX, 0.5);
    expect(rrect.tlRadiusY, 0.5);
    expect(rrect.trRadiusX, 0.25);
    expect(rrect.trRadiusY, 0.25);
    expect(rrect.blRadiusX, 0.0);
    expect(rrect.blRadiusY, 0.0);
    expect(rrect.brRadiusX, 0.25);
    expect(rrect.brRadiusY, 0.75);
  });
}
