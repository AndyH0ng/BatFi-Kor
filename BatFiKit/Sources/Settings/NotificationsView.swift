//
//  NotificationsView.swift
//
//
//  Created by Adam on 05/05/2023.
//

import AppShared
import Defaults
import L10n
import SettingsKit
import SwiftUI

struct NotificationsView: View {
    @Default(.showChargingStausChanged) private var showChargingStausChanged
    @Default(.showOptimizedBatteryCharging) private var showOptimizedBatteryCharging
    @Default(.blinkMagSafeWhenDischarging) private var blinkMagSafeWhenDischarging
    @Default(.showBatteryLowNotification) private var showBatteryLowNotification
    @Default(.batteryLowNotificationThreshold) private var batteryLowNotificationThreshold
    @Default(.showRemindersToDischargeAndChargeBattery) private var showRemindersToDischargeAndChargeBattery

    @State private var showingPopover = false

    var body: some View {
        let l10n = L10n.Settings.self
        Container(contentWidth: settingsContentWidth) {
            Section(title: l10n.Section.notifications, bottomDivider: false) {
                Toggle(isOn: $showChargingStausChanged) {
                    Text(l10n.Button.Label.chargingStatusDidChange)
                }
                Toggle(isOn: $showOptimizedBatteryCharging) {
                    Text(l10n.Button.Label.showAlertsWhenOptimizedChargingIsEngaged)
                }
                Toggle(isOn: $showRemindersToDischargeAndChargeBattery) {
                    Text(l10n.Button.Label.batteryCalibrationRecommended)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Toggle(isOn: $showBatteryLowNotification) {
                        Text(l10n.Label.batteryLowThreshold(batteryLowNotificationThreshold))
                            .monospacedDigit()
                    }
                    SettingsSliderContainer(
                        minLabel: percentageFormatter.string(for: 0.05) ?? "5%",
                        maxLabel: percentageFormatter.string(for: 0.3) ?? "30%",
                        min: 5,
                        max: 30,
                        step: 5,
                        value: .convert(from: $batteryLowNotificationThreshold)
                    )
                    .disabled(!showBatteryLowNotification)
                    .frame(width: 180)
                }
            }

            Section(title: l10n.Section.magSafe, bottomDivider: false) {
                Toggle(isOn: $blinkMagSafeWhenDischarging) {
                    Text(l10n.Button.Label.blinkMagSafeWhenDischarging)
                }
            }
        }
    }

    static let pane: Pane<Self> = Pane(
        identifier: NSToolbarItem.Identifier("notifications"),
        title: L10n.Settings.Tab.Title.notifications,
        toolbarIcon: NSImage(
            systemSymbolName: "bell.badge",
            accessibilityDescription: L10n.Settings.Accessibility.Title.notifications
        )!
    ) {
        Self()
    }
}
