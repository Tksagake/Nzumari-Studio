# Nzumari Studio — product and architecture direction

## Product definition

Nzumari Studio is a desktop composition environment built on the MuseScore Studio codebase. It is not a plugin skin, a web wrapper, or a replacement notation engine.

MuseScore remains the mature notation, engraving, playback, import/export and score-editing foundation. Nzumari supplies the product layer around it: identity, cloud-backed projects, version history, IdeaPad, collaboration and extensibility.

The desktop application and Nzumari Cloud are two coordinated surfaces of one composition workspace.

## Product principles

1. **Notation integrity:** preserve MuseScore's score model, engraving quality, file compatibility and editing semantics.
2. **Cloud-connected, locally capable:** a score must remain editable when connectivity is unavailable; cloud sync resumes safely when connectivity returns.
3. **Project continuity:** a project created in Nzumari Cloud must resolve to the same project identity when opened in Nzumari Studio.
4. **Version-aware composition:** meaningful score states are addressable, inspectable and recoverable; version history is not merely a list of file uploads.
5. **Persistent IdeaPad:** IdeaPad belongs to the workspace/project context and remains available across sessions, not as a disposable plugin window.
6. **Concurrency by design:** simultaneous work and offline edits must not silently overwrite one another.
7. **Upstream compatibility:** product features should be isolated from MuseScore core wherever practical.

## System boundaries

### MuseScore-derived desktop core

Owns:
- Native score editing and notation model.
- Engraving, layout, playback and audio.
- MusicXML, MIDI, MSCZ and other supported import/export.
- Local document lifecycle, undo/redo and autosave.
- Desktop shell and native interaction.

### Nzumari Studio integration layer

A proposed set of downstream modules/adapters, subject to validation against MuseScore's actual module conventions:
- **Identity adapter:** sign-in, device registration, token lifecycle and account switching.
- **Workspace/project adapter:** map a local score/document to a stable Nzumari project ID.
- **Sync engine:** upload/download, resumable transfer, conflict detection and retry.
- **Version service:** create and retrieve immutable project revisions and metadata.
- **IdeaPad host:** persistent project-aware composition assistant surface.
- **Collaboration adapter:** presence, invitations, permissions and concurrent-edit coordination.
- **Extension host:** discover and manage supported Nzumari integrations without coupling them to engraving internals.

These are architectural responsibilities, not claims that the modules already exist.

### Nzumari Cloud

Owns:
- User, organisation and device identity.
- Project metadata and access control.
- Canonical project identity and membership.
- Revision metadata, history and restore operations.
- Sync coordination and collaboration sessions.
- IdeaPad conversations and authorised project context.
- Plugin/integration entitlements and settings.

The cloud should not become the only copy of an actively edited score. The desktop keeps a durable local working copy.

## Project identity and lifecycle

A project should have a stable cloud identifier independent of its filename or local path. A local document is associated with that identifier through a durable project manifest/metadata record.

Expected flow:

1. A user creates a project in Nzumari Cloud or Nzumari Studio.
2. Cloud creation returns a stable project ID and initial metadata.
3. Studio creates or opens the corresponding local score workspace.
4. Studio records the project ID locally and associates the score with the cloud project.
5. IdeaPad opens in that project context with explicitly authorised context.
6. Local saves remain fast and local; sync publishes changes asynchronously.
7. Version history records recoverable revisions and their provenance.

The project ID must survive renames, local moves, and changes to the document's filename. Duplicate local copies must be detected rather than silently treated as the same active writer.

## Versioning and concurrency model

Do not assume that a cloud revision is equivalent to a raw file upload. The initial safe model should be revision-based with optimistic concurrency:

- Every published revision has an immutable revision ID and parent revision.
- Each client tracks the latest known server revision and its local working state.
- A publish includes the expected parent/base revision.
- The server accepts the publish only if the base is still current, or applies an explicitly defined merge policy.
- If the base is stale, the server returns a conflict; it must not silently overwrite the newer revision.
- The client preserves both local and remote states and offers compare, recover, or deliberate resolution.
- Autosave and cloud publish are separate operations.

For true simultaneous editing, a later design decision is required: score-aware operation transformation/CRDT, a server-authoritative edit stream, or a controlled single-writer/multi-reader lease model. Generic text CRDT assumptions cannot safely be applied to a structured notation document without proving operation semantics for measures, voices, tuplets, spanners, instruments, and structural edits.

The first milestone should deliver safe multi-device concurrency and conflict preservation. Live multi-user co-editing follows only after the score-operation model is validated.

## IdeaPad

IdeaPad is a first-class workspace surface, not a MuseScore plugin window. It should:
- Persist across application restarts.
- Know the active project and selected score context.
- Respect project permissions and user consent.
- Request structured, validated score operations through a narrow editing interface.
- Preview proposed edits and apply them through MuseScore's native command/undo system.
- Preserve provenance for AI-assisted changes.
- Work without requiring the notation engine to depend directly on a specific model provider.

The existing Bach Editor prototype is a reference for the Nzumari/Bach API and score-editing workflow. It is not the architecture boundary for the full desktop product.

## Proposed implementation sequence

### Phase 0 — repository and build foundation
- Verify fork ancestry and upstream remotes.
- Pin and initialise both Git submodules.
- Establish reproducible Windows development/build instructions.
- Record baseline build and test status before product changes.

### Phase 1 — native product identity
- Product naming, application metadata, icons, splash, installer identity and resource strategy.
- A restrained Nzumari visual system using the established brand palette.
- Keep upstream resource changes small and traceable.

### Phase 2 — project and identity foundation
- Authentication/device pairing.
- Stable project ID and local manifest.
- Cloud project creation/opening flow.
- Local-first save and durable sync queue.

### Phase 3 — versioning and recovery
- Immutable revisions and parent links.
- Optimistic concurrency checks.
- Conflict preservation, revision browser and restore.
- Cross-device sync tests, including offline/online transitions.

### Phase 4 — persistent IdeaPad
- Workspace host and project context.
- Provider-neutral AI service boundary.
- Structured score operation schema, validation, preview and native undo.
- Audit/provenance for applied changes.

### Phase 5 — collaboration and extensions
- Presence, invitations and permissions.
- Explicitly selected live co-editing consistency model.
- Extension discovery, permissions, lifecycle and compatibility contracts.

## Technical observations from the initial source audit

The current upstream tree already separates major responsibilities into modules. The root CMake configuration exposes modules such as appshell, engraving, notation, playback and project. The project module contains project creation, open/save scenarios, sessions, readers/writers and autosave. The app shell has QML resources and UI dependencies. This is promising for a downstream product layer.

The root repository also uses Git submodules:
- `muse` → `musescore/muse_framework`
- `muse_deps` → `musescore/muse_deps`

The build instructions require a recursive clone so the framework is present. The current upstream build documentation specifies a modern CMake/Qt/compiler toolchain; validate the exact Windows kit before attempting a full build.

## Decisions still requiring implementation-time validation

- Exact module registration and dependency conventions for a new Nzumari module.
- Which existing MuseScore project/session interfaces can host a cloud project adapter without patching core project semantics.
- Secure Windows credential storage and cross-platform equivalent.
- Cloud API contracts and whether existing Nzumari APIs already expose project/revision primitives.
- Whether score-aware merge is feasible for the chosen collaboration scope.
- Packaging, updater and signing strategy for a branded downstream desktop build.

Do not invent API endpoints or duplicate backend capabilities before auditing the existing Nzumari Cloud implementation.
