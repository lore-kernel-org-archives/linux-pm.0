From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2] Add Mediatek thermal support
Date: Tue, 21 Jul 2015 09:59:23 +0200
Message-ID: <1437465566-16299-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37580 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbGUH7b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 03:59:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>

This series adds support for the thermal sensors included in the
MT8173 SoC. Currently only basic temperature reading is supported
without any interrupt support.

The cpufreq driver for MT8173 is currently under review, so there's no
real cooling device available in mainline. Until this is available the
thermal driver can be tested with the following dts snippet. It creates
a fake gpio fan and a fake trip point which is so low that it can easily
be reached with a "cat /dev/zero > /dev/null" on the command line.

Please review and let me know what's missing to be included in mainline.

Changes since v1:
- Use "mediatek," prefix for custom properties
- Drop "thermal: consistently use int for temperatures" dependency

Sascha

	fan: gpio_fan {
		compatible = "gpio-fan";
		gpios = <&pio 24 0>;
		gpio-fan,speed-map = <0    0
				      4500 1>;
		#cooling-cells = <2>;
	};

	thermal-zones {
		cpu_thermal: cpu_thermal {
			polling-delay-passive = <1000>; /* milliseconds */
			polling-delay = <1000>; /* milliseconds */

			thermal-sensors = <&thermal 0>;

			trips {
				cpu_passive: cpu_passive {
					temperature = <47000>; /* millicelsius */
					hysteresis = <2000>; /* millicelsius */
					type = "passive";
				};

				cpu_crit {
					temperature = <90000>; /* millicelsius */
					hysteresis = <2000>; /* millicelsius */
					type = "critical";
				};
			};

			cooling-maps {
				map0 {
					trip = <&cpu_passive>;
					cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
				};
			};
		};
	};

----------------------------------------------------------------
Sascha Hauer (3):
      dt-bindings: thermal: Add binding document for Mediatek thermal controller
      thermal: Add Mediatek thermal controller support
      ARM64: dts: mt8173: Add thermal/auxadc device nodes

 .../bindings/thermal/mediatek-thermal.txt          |  38 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  18 +
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/mtk_thermal.c                      | 602 +++++++++++++++++++++
 5 files changed, 667 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
 create mode 100644 drivers/thermal/mtk_thermal.c

