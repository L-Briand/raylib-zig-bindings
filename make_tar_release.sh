#!/bin/bash

if [ -f "release.tar.gz" ] ; then rm "release.tar.gz"; fi

FILES=(
  "bindings/bindings.zig"
  "bindings/raylib.zig"
  "bindings/raygui.zig"
  "bindings/rcamera.zig"
  "bindings/rlgl.zig"
  "build.zig"
  "build.zig.zon"
  "raylib.build.zig"
  "LICENSE"
)

tar -czf release.tar.gz ${FILES[@]}