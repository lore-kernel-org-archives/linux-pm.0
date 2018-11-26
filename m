From: Priit Laes <plaes@plaes.org>
Subject: [PATCH 00/14] regulator: axp20x: Stop AXP209 from crashing when enabling LDO3
Date: Mon, 26 Nov 2018 17:27:41 +0200
Message-ID: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Priit Laes <plaes@plaes.org>
List-Id: linux-pm@vger.kernel.org

This series implements voltage ramping for AXP209 DCDC2 and LDO3
regulators and software based soft-start for AXP209 LDO3 regulator.

Both features are needed to work around a PMIC shutdown when
toggling LDO3 on certain boards with high capacitance on the
LDO3 output.

Similar features (or workarounds) have been also implemented
on u-boot side [1].

Also included in this series are various magic constant cleanups
and also fix for core regulator framework, where 'always-enabled'
constraint overrides the 'soft-start' and 'ramp-delay' features.

[1] https://lists.denx.de/pipermail/u-boot/2018-November/348612.html

Olliver Schinagl (14):
  regulator: axp20x: use defines for masks
  regulator: axp20x: name voltage ramping define properly
  regulator: core: enable power when setting up constraints
  regulator: axp20x: add support for set_ramp_delay for AXP209
  dt-bindings: mfd: axp20x: add support for regulator-ramp-delay for AXP209
  regulator: axp20x: add software based soft_start for AXP209 LDO3
  dt-bindings: mfd: axp20x: Add software based soft_start for AXP209 LDO3
  regulator: dts: enable soft-start and ramp delay for the OLinuXino Lime2
  regulator: dts: add full voltage range to LDO4 on the Lime2
  regulator: dts: set proper lradc vref on OLinuXino Lime2
  mfd: axp20x: Clean up included headers
  mfd: axp20x: use explicit bit defines
  power: supply: axp20x: add missing include bitops.h
  power: supply: axp288: use the BIT() macro

 Documentation/devicetree/bindings/mfd/axp20x.txt |   8 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |  13 +-
 drivers/mfd/axp20x.c                             |  13 +-
 drivers/power/supply/axp20x_usb_power.c          |   1 +-
 drivers/power/supply/axp288_charger.c            |  35 +-
 drivers/regulator/axp20x-regulator.c             | 875 ++++++++++++----
 drivers/regulator/core.c                         |  22 +-
 include/linux/mfd/axp20x.h                       |   4 +-
 8 files changed, 753 insertions(+), 218 deletions(-)

base-commit: 2e6e902d185027f8e3cb8b7305238f7e35d6a436
-- 
git-series 0.9.1
