From: David Lechner <david@lechnology.com>
Subject: [PATCH v2 0/3] LEGO MINDSTORMS EV3 Battery
Date: Tue, 11 Apr 2017 16:05:20 -0500
Message-ID: <1491944723-32174-1-git-send-email-david@lechnology.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:36278 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752551AbdDKVF7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 17:05:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Sebastian Reichel <sre@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org

This series adds support for the LEGO MINDSTORMS EV3 battery.

v2 changes:
* use devm_power_supply_register()

David Lechner (3):
  dt-bindings: power: supply: New bindings for LEGO MINDSTORMS EV3
    battery
  power: supply: New driver for LEGO MINDSTORMS EV3 battery
  ARM: dts: da850: Add node for LEGO MINDSTORMS EV3 Battery

 .../bindings/power/supply/lego_ev3_battery.txt     |  21 ++
 arch/arm/boot/dts/da850-lego-ev3.dts               |  28 +++
 drivers/power/supply/Kconfig                       |   6 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/lego_ev3_battery.c            | 228 +++++++++++++++++++++
 5 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
 create mode 100644 drivers/power/supply/lego_ev3_battery.c

-- 
2.7.4
