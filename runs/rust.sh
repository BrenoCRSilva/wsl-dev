#!/usr/bin/env bash

paru -S --noconfirm --needed rustup
rustup default stable
rustup toolchain install nightly
