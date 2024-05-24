#!/bin/bash

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

tar -czvf release.tar.gz ${FILES[@]}