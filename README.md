# Nzumari Studio

**Compose · Preserve · Evolve · Distribute**

Nzumari Studio is an open-source music notation and composition application built on the MuseScore Studio codebase and developed by Vivace Music Consultancy.

The project is being developed as a Nzumari-branded desktop composition environment while retaining MuseScore's established notation workspace, engraving engine and core composition capabilities.

## Current development status

The active Nzumari desktop identity and native theme work is on the [nzumari/architecture-foundation branch](https://github.com/Tksagake/Nzumari-Studio/tree/nzumari/architecture-foundation), with implementation tracked in [Pull Request #1](https://github.com/Tksagake/Nzumari-Studio/pull/1).

This repository is an active source-code fork. **The branch download is source code, not a ready-to-run Windows installer.** A native Windows build must complete before an Nzumari executable or installer can be distributed. Platform builds and packaging are not yet verified.

## Features

Nzumari Studio retains the core MuseScore Studio capabilities, including:

- WYSIWYG music notation and score editing
- Note entry and comprehensive score-editing tools
- High-quality music engraving and printing
- MusicXML import and export
- MIDI import and export
- MEI import and export
- MIDI input for note entry
- Integrated playback using the application's synthesizer
- PDF export and printing

## Get the source

Git is sufficient to clone the active Nzumari development branch. From PowerShell:

```powershell
git clone --recurse-submodules --branch nzumari/architecture-foundation https://github.com/Tksagake/Nzumari-Studio.git
cd Nzumari-Studio
```

The `--recurse-submodules` option checks out the framework submodule required by the project.

To update an existing checkout:

```powershell
git switch nzumari/architecture-foundation
git pull
git submodule update --init --recursive
```

## Building on Windows

VS Code is an editor; Python and Node.js are useful development tools, but they do not provide the native C++ compiler or Qt libraries needed to build MuseScore Studio.

A Windows desktop build requires a compatible Microsoft C++ toolchain (MSVC), the matching Qt 6 development packages, CMake, and the other dependencies specified by the upstream build system. Do not install arbitrary Qt or compiler versions: use the versions supported by the checked-out MuseScore codebase.

Start with the upstream [developer environment setup](https://github.com/musescore/MuseScore/wiki/Set-up-developer-environment) and [Windows compilation guidance](https://github.com/musescore/MuseScore/wiki/Compiling-in-other-IDEs). The standard release build entry point used by this codebase is:

```powershell
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Release
```

To run the compiled application:

```powershell
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Release run
```

A full native build can require substantial RAM, disk space and build time. A GitHub Actions Windows build that publishes downloadable artifacts is a practical alternative to compiling on a modest development PC. No downloadable Nzumari Windows installer is currently published.

## Upstream project and attribution

Nzumari Studio is derived from [MuseScore Studio](https://github.com/musescore/MuseScore). The upstream project supplies the notation engine and much of the desktop application architecture. This fork retains the upstream licensing and attribution obligations.

- [MuseScore Studio developer documentation](https://musescore.org/en/handbook/developers-handbook)
- [MuseScore Studio Git workflow](https://musescore.org/en/developers-handbook/git-workflow)
- [MuseScore Studio build documentation](https://github.com/musescore/MuseScore/wiki)

## License

Nzumari Studio is distributed under the GNU General Public License, version 3.0 (GPL-3.0), in accordance with the upstream MuseScore Studio codebase. See [LICENSE.txt](LICENSE.txt) for the license text and notices.
