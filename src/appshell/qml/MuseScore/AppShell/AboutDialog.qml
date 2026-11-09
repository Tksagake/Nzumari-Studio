/*
 * SPDX-License-Identifier: GPL-3.0-only
 * MuseScore-Studio-CLA-applies
 *
 * Nzumari Studio
 *
 * Copyright (C) 2021-2026 MuseScore Limited and others
 * Nzumari Studio branding and integration
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 */

import QtQuick
import QtQuick.Layouts

import Muse.Ui
import Muse.UiComponents

import MuseScore.AppShell

StyledDialogView {
    id: root

    title: qsTrc("appshell/about", "About Nzumari Studio")

    contentHeight: content.implicitHeight
    contentWidth: 400

    margins: 40

    AboutModel {
        id: aboutModel
    }

    ColumnLayout {
        id: content

        anchors.fill: parent
        spacing: 24

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 14

            Image {
                id: logo
                Layout.preferredWidth: 76
                Layout.preferredHeight: 76

                source: "resources/nzumari-icon.svg"
                sourceSize: Qt.size(152, 152)
                fillMode: Image.PreserveAspectFit
            }

            Column {
                Layout.alignment: Qt.AlignVCenter
                spacing: 2

                StyledTextLabel {
                    text: "Nzumari Studio"
                    font: ui.theme.headerBoldFont
                }

                StyledTextLabel {
                    text: qsTrc("appshell/about", "Compose · Preserve · Evolve · Distribute")
                    font: ui.theme.bodyFont
                    opacity: 0.72
                }
            }
        }

        StyledTextLabel {
            Layout.fillWidth: true
            text: qsTrc("appshell/about", "A composition environment for writing, shaping and developing music. Nzumari Studio builds on the MuseScore Studio notation and engraving codebase.")
            wrapMode: Text.WordWrap
        }

        Column {
            spacing: 8
            Layout.fillWidth: true

            StyledTextLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTrc("appshell/about", "Nzumari Studio version: %1").arg(aboutModel.museScoreVersion())
                font: ui.theme.bodyBoldFont
            }

            Row {
                spacing: 4
                anchors.horizontalCenter: parent.horizontalCenter

                StyledTextLabel {
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTrc("appshell/about", "Upstream revision: %1").arg(aboutModel.museScoreRevisionLink())
                }

                FlatButton {
                    anchors.verticalCenter: parent.verticalCenter
                    icon: IconCode.COPY

                    onClicked: {
                        aboutModel.copyRevisionToClipboard()
                    }
                }
            }
        }

        StyledTextLabel {
            Layout.fillWidth: true
            text: qsTrc("appshell/about", "Build date: %1").arg(aboutModel.museScoreBuildDateTime())
            wrapMode: Text.WordWrap
            maximumLineCount: 2
        }

        StyledTextLabel {
            Layout.fillWidth: true
            text: qsTrc("appshell/about", "Nzumari Studio is an independent product. MuseScore Studio is developed by MuseScore Limited and contributors. This derivative work is published under the GNU General Public License version 3.")
            wrapMode: Text.WordWrap
        }

        StyledTextLabel {
            Layout.fillWidth: true
            text: qsTrc("appshell/about", "MuseScore Studio copyright © 1999–2026 MuseScore Limited and others. Nzumari Studio branding and integration are maintained separately.")
            wrapMode: Text.WordWrap
        }
    }
}
