From: Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v2 0/6] AXP8x3 AC and battery power supply support
Date: Sun,  7 Oct 2018 00:18:30 +0300
Message-ID: <20181006211836.28253-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004193410.7265-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Lee Jones <lee.jones@linaro.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

AXP813 AC power supply support with input current and
voltage limiting support.

AXP803 AC and battery power supply support.

Changes in v2:
* Reuse axp813 compatibles for axp803
* Refactor axp20x_ac_power.c

Oskari Lemmela (6):
  dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
  ARM: dts: axp81x: add AC power supply subnode
  arm64: dts: allwinner: axp803: add AC and battery power supplies
  arm64: dts: allwinner: a64: sopine: enable power supplies
  mfd: axp20x: add support AXP803 AC and battery power supplies
  power: supply: add AC power supply driver for AXP813

 .../bindings/power/supply/axp20x_ac_power.txt |  3 +
 arch/arm/boot/dts/axp81x.dtsi                 |  5 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi     | 31 +++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 ++
 drivers/mfd/axp20x.c                          | 22 ++++-
 drivers/power/supply/axp20x_ac_power.c        | 92 +++++++++++++++++++
 include/linux/mfd/axp20x.h                    |  1 +
 7 files changed, 161 insertions(+), 1 deletion(-)

-- 
2.17.1
