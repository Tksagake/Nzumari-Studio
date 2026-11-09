# Nzumari Studio

**Compose · Preserve · Evolve · Distribute**

Nzumari Studio is an open-source music notation and composition application built on the MuseScore Studio codebase and rebranded for the Nzumari project by Vivace Music Consultancy.

The current work focuses on the desktop application's identity and native presentation: application naming, Nzumari visual assets, splash screen and light/dark colour themes. The established notation workspace and MuseScore engraving and composition functionality remain the foundation.

> **Project status:** This is an active source-code fork. The Nzumari identity and theme changes are being developed on the `nzumari/architecture-foundation` branch. A downloadable source archive is not a ready-to-run Windows installer; the application must be compiled before it can be launched. Build and platform packaging changes are not considered verified until native builds have been completed.

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

Git is sufficient to clone the project. From PowerShell or a terminal:

```powershell
git clone --recurse-submodules --branch nzumari/architecture-foundation https://github.com/Tksagake/Nzumari-Studio.git
cd Nzumari-Studio
```

The `--recurse-submodules` option is important: it checks out the framework submodule required by the project.

To update an existing checkout to the latest version of this branch:

```powershell
git switch nzumari/architecture-foundation
git pull
git submodule update --init --recursive
```

You can also browse the [Nzumari Studio repository](https://github.com/Tksagake/Nzumari-Studio) or download the branch as a ZIP from GitHub. A ZIP is suitable for inspecting the source, but Git is recommended if you intend to pull updates or contribute changes.

## Building on Windows

**You do not need Visual Studio or Qt just to clone the source.** They are build dependencies: they are needed only when compiling the C++ application.

For a Windows build, the toolchain generally includes:

- **Git** — source control and submodule checkout.
- **A Microsoft C++ compiler (MSVC)** — available through Visual Studio Build Tools; installing the full Visual Studio IDE is optional.
- **Qt 6** — the Qt libraries and matching MSVC 64-bit prebuilt component required by this MuseScore Studio codebase.
- **CMake and the remaining project dependencies** — follow the versions and installation steps in the upstream developer documentation.

Do not install an arbitrary Qt 6 release or a MinGW build of Qt. MuseScore Studio requires a Qt version and compiler combination that match the source branch. Check the current [MuseScore Qt and Qt Creator setup guide](https://github.com/musescore/MuseScore/wiki/Install-Qt-and-Qt-Creator) and [Windows build instructions](https://github-wiki-see.page/m/musescore/MuseScore/wiki/Compiling-in-other-IDEs) before installing the build toolchain.

Once the required dependencies are installed, use the build procedure documented for this codebase:

```powershell
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Release
```

To launch the compiled application using the build script:

```powershell
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Release run
```

The first build can take considerable time and disk space. On a machine with limited memory, a full MuseScore build may be impractical; a prebuilt CI artifact or release package would be preferable. **This repository branch does not currently promise a prebuilt installer.**

For macOS and Linux, consult the upstream platform-specific build instructions and ensure the correct dependencies are installed for the checked-out source.

## Upstream project and attribution

Nzumari Studio is derived from [MuseScore Studio](https://github.com/musescore/MuseScore). The upstream project provides the notation engine and much of the desktop application architecture. This fork retains the upstream licensing and attribution obligations.

- [MuseScore Studio developer documentation](https://musescore.org/en/handbook/developers-handbook)
- [MuseScore Studio Git workflow](https://musescore.org/en/developers-handbook/git-workflow)
- [MuseScore Studio build and dependency guides](https://github.com/musescore/MuseScore/wiki)

## License

Nzumari Studio is distributed under the GNU General Public License, version 3.0 (GPL-3.0), in accordance with the upstream MuseScore Studio codebase. See [LICENSE.txt](LICENSE.txt) for the applicable license text and notices.
