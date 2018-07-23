From: Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 0/4] power: supply: MAX17040: Add IRQ for low level and alert SOC changes
Date: Mon, 23 Jul 2018 00:08:12 -0400
Message-ID: <20180723040816.19455-1-matheus@castello.eng.br>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>
List-Id: linux-pm@vger.kernel.org

This series add IRQ handler for low level SOC alert, define a devicetree 
binding attribute to configure the alert level threshold and check for changes
in SOC for send uevents.

Max17040 have a pin for alert host about low level state of charge and this 
alert can be configured in a threshold from 1% up to 32% of SOC.

Tested on Raspberry Pi Zero W, with a SparkFun Lipo Fuel Gauge module based on
MAXIM MAX17043.

Matheus Castello (4):
  power: supply: max17040: Add IRQ handler for low SOC alert
  power: supply: max17040: Config alert SOC low level threshold from FDT
  dt-bindings: power: supply: Max17040: Add low level SOC alert threshold
  power: supply: max17040: Send uevent in SOC changes

 .../bindings/power/supply/max17040_battery.txt     | 24 ++++++
 drivers/power/supply/max17040_battery.c            | 95 ++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

-- 
2.13.3
