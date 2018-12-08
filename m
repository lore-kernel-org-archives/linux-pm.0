From: Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v7 0/9] AXP8x3 AC and battery power supply support
Date: Sat,  8 Dec 2018 19:36:09 +0200
Message-ID: <20181208173618.31395-1-oskari@lemmela.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>
Cc: Quentin Schulz <quentin.schulz@bootlin.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Oskari Lemmela <oskari@lemmela.net>
List-Id: linux-pm@vger.kernel.org

AXP813 AC power supply support with input current and
voltage limiting support.

AXP803 AC and battery power supply support.

Changes in v7:
* Added re-align patch for mfd cells

Changes in v6:
* Collected tags
* Rebase to master
* Dropped AXP803 compatible patches

Changes in v5:
* Return correct input current limit for values 0x6 and 0x7
* Add specific compatibles for AXP803
* Change commit messages
* Add Vasily Khoruzhick Pinebook DTS patch

Changes in v4:
* Change order of axp20x-gpio in axp20x.c
* Fix indentation and spaces to tabs in axp20x.c

Changes in v3:
* Reorder ac_power_supply DT node
* Rename axp20x_ac_power_set_property function
* Split mfd commit 

Changes in v2:
* Reuse axp813 compatibles for axp803
* Refactor axp20x_ac_power.c

Chen-Yu Tsai (1):
  mfd: axp20x: Re-align mfd cell entries

Oskari Lemmela (7):
  dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
  ARM: dts: axp81x: add AC power supply subnode
  arm64: dts: allwinner: axp803: add AC and battery power supplies
  arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
  power: supply: add AC power supply driver for AXP813
  mfd: axp20x: Add AC power supply cell for AXP813
  mfd: axp20x: Add supported cells for AXP803

Vasily Khoruzhick (1):
  arm64: dts: allwinner: a64: pinebook: enable power supplies

 .../bindings/power/supply/axp20x_ac_power.txt |   3 +
 arch/arm/boot/dts/axp81x.dtsi                 |   5 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi     |  33 +++++
 .../dts/allwinner/sun50i-a64-pinebook.dts     |   8 ++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |   8 ++
 drivers/mfd/axp20x.c                          | 126 ++++++++++--------
 drivers/power/supply/axp20x_ac_power.c        |  94 +++++++++++++
 include/linux/mfd/axp20x.h                    |   1 +
 8 files changed, 222 insertions(+), 56 deletions(-)

-- 
2.17.1
