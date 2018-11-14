From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 0/5] Add new features for SC27XX fuel gauge driver
Date: Wed, 14 Nov 2018 17:07:03 +0800
Message-ID: <cover.1542185618.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

This patch set adds some new features for SC27XX fuel gauge driver.

1. Read calibration data from eFuse device to calibrate fuel gauge.
2. Add low voltage alarm to adjust the battery capacity in lower
voltage stage.
3. Add power management interfaces
4. Save last optimized battery capacity to be used as the initial
battery capacity if system is not first power-on.

Baolin Wang (2):
  dt-bindings: power: supply: Add nvmem properties to calibrate FGU
  power: supply: sc27xx: Add fuel gauge calibration

Yuanjiang Yu (3):
  power: supply: sc27xx: Add fuel gauge low voltage alarm
  power: supply: sc27xx: Add suspend/resume interfaces
  power: supply: sc27xx: Save last battery capacity

 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    4 +
 drivers/power/supply/sc27xx_fuel_gauge.c           |  453 +++++++++++++++++++-
 2 files changed, 444 insertions(+), 13 deletions(-)

-- 
1.7.9.5
