From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v11] Add Mediatek thermal support
Date: Wed, 18 Nov 2015 09:24:23 +0100
Message-ID: <1447835066-10482-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45790 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbbKRIYb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 03:24:31 -0500
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

Sascha

changes since v10:
- Some style cleanup
- Add comment to make clear why we use the sensors in banks even if we
  currently only use the maximum of all banks

changes since v9:
- rebase on v4.3
- Add support for reading the calibration values from nvmem fuses
- Only register a single thermal zone instead of four as it seems
  that's everything needed

changes since v8:
- Add commit description to binding patch
- rebase on v4.3-rc2

changes since v7:
- re-add some used defines removed in v5
- Use MT8173_THERMAL_ZONE_* defines as array indices in static initializers

changes since v6:
- remove dot in Hanyi Wus name

changes since v5:
- update copyright
- remove unused defines

Changes since v4:
- give calibration constants more meaningful names (offset, slope)
- Use define instead of 0x00c for register access.

Changes since v3:
- add include/dt-bindings/thermal/mt8173.h for to be able to use sensor names
  in dts files
- fix disabling wrong clock in error path
- remove now unused reset-names property from binding document
- rename MT8173_NUM_BANKS -> MT8173_NUM_ZONES
- rename MT8173_NUM_SENSING_POINTS -> MT8173_NUM_SENSORS_PER_ZONE
- rename struct thermal_zone_device *tz -> struct thermal_zone_device *tzd

Changes since v2:
- sort #includes alphabetically
- Add prefix to register defines
- drop some members from struct mtk_thermal
- simplify raw_to_mcelsius()
- add and use more register bit defines
- use device_reset() instead of devm_reset_control_get()/reset_control_reset()
- misc other stuff

Changes since v1:
- Use "mediatek," prefix for custom properties
- Drop "thermal: consistently use int for temperatures" dependency

-------------

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

			thermal-sensors = <&thermal>;

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
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABCAAGBQJWQHCkAAoJEPFlmONMx+ezneEP/265kyAMT71c7/HewE7kA1aZ
3/ah5w7gtOjBlY0y3VNaVCs0u0gJEUqa/JFIBRvXm61mNoDt/uKH1hP5IroHVFHa
uW9wc1nOgr8G185IZRYszIePwchoKE0lBLTpt1DplK8NwUv6k9NXdAlXlDrLkejQ
fDnvGbIq0Ok5OLntjp81hGUxOYcyfoQrqHTLUWohzsovRwVegVOMOh08gwnWNJuI
DKMaKlv4XpUiX8roeUEgQdrVnTLsddR85mvPonLcjIwpCMNooLygNKDmlTHf3C4g
VFpdoUH04cc1XdxtxJ6oAetCq+/C6z9BA22nVWm+tRecN8VU+ywjB9xo2qUR+xjv
aqEhKZMq8eTWNKWYUIhBh/LBPtoqZb5rYoS+Z76xFD/e+/umviscoh/QhavuohvZ
bEMGIY4jziUMccFzklzZGyfxPPcVx9yIwB0+q4IgkWxGYznFyXcuNi4+J3xcxtid
xYq1B6kcbca7G2UgEtt+JMSl9ukZYSeOAXGgYGQWsP0VyZWohvm+bH7FX455eHyX
FLd+b3CpUEyxT3yL7ZpuJeiwzpnpsOgbqSu5Djzd5KpgUNnl4QCRAFAv4L9BqKZM
L1ugFAhFJFcBIhjhgthws5WLhAY/hEI2gDaesYq2Wu5GgXiqZNIJyp7D1EA9RRpO
RQjaXpX7u47O5HgQpfBA
=4rKu
-----END PGP SIGNATURE-----

commit 53fcb89e372f49218e33889286a1812595e38cf3
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue May 12 09:22:29 2015 +0200

    ARM64: dts: mt8173: Add thermal/auxadc device nodes

    This adds the thermal controller and auxadc nodes to the Mediatek MT8173
    dtsi file.

    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
    Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 06a1564..e2ddd03 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -277,6 +277,11 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};

+		auxadc: auxadc@11001000 {
+			compatible = "mediatek,mt8173-auxadc";
+			reg = <0 0x11001000 0 0x1000>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt8173-uart",
 				     "mediatek,mt6577-uart";
@@ -487,6 +492,18 @@
 			clock-names = "source", "hclk";
 			status = "disabled";
 		};
+
+		thermal: thermal@1100b000 {
+			#thermal-sensor-cells = <0>;
+			compatible = "mediatek,mt8173-thermal";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+			clock-names = "therm", "auxadc";
+			resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
+			mediatek,auxadc = <&auxadc>;
+			mediatek,apmixedsys = <&apmixedsys>;
+		};
 	};
 };
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABCAAGBQJWTDT9AAoJEPFlmONMx+ez3RMQAKgHbBxQNJGKeINIetHYbKjS
chdOWL5OWtRwgi/vQbwq0b35qdvRhPMS5Ufgipjf4xO1BVSu5EOKWFuzgMQ6wh0r
xdFVe1VR188TcEDgc5YfJNMwiJ/eYreATE7EWF5uufXVVk9TAQLKl6b4o/Si2KtU
4Zy2uGQT6ZkwlMn8R1XDRoy0sSW3mnzs4it43YI/dJXYTw8S/OJlPFkUNT8jSFKU
LyIAhnU/Zux9Ueh4YNmRu/csiwuKI+Wpkbyu6fFb224SOmfE9Nz3hAQTmIIMV/FS
WwZ7V3CKCmh4xG7fRmjUu/naHnmWx6esVvdXPPKwr2qRDNX9ELRhq88R5Cue/wrX
gJgFTch6cBDRuNyAfCk1T29FebR0Y9BCuWLpUXGUj1/Rh+wSj/q7q6wNeKwW9TJ5
hIDdMio0fcR1ahmqIwG1NU3zJXpLNDnimD0MVtz/vfE85qBtahnClC9+4kcN0W3r
I6n0qQ/YxFp/xNJuHiBKRfw15RuTKyJBT6VtI+/lNd8YejPwdtqESrEJhL3yN9JM
bJ5sEZeGSOSi0KCXgC2bUq/aYEiedKhEsT0EoqnuIZu4wxk7/DL5Fb+F8py5gllZ
9haA2ryZYDEGLcZbhb8z0wHJD5MDLNFv5MRQw+TpG3oP75Jj5/Ejp+jjmBV9nBZM
PkyZGMUNPcEmvuXPqTR/
=Lp5z
-----END PGP SIGNATURE-----

commit 54d2d3b91b271f0edba2d8dbdf34eb76e37286c7
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue May 12 09:22:29 2015 +0200

    ARM64: dts: mt8173: Add thermal/auxadc device nodes
    
    This adds the thermal controller and auxadc nodes to the Mediatek MT8173
    dtsi file.
    
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
    Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 06a1564..e2ddd03 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -277,6 +277,11 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		auxadc: auxadc@11001000 {
+			compatible = "mediatek,mt8173-auxadc";
+			reg = <0 0x11001000 0 0x1000>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt8173-uart",
 				     "mediatek,mt6577-uart";
@@ -487,6 +492,18 @@
 			clock-names = "source", "hclk";
 			status = "disabled";
 		};
+
+		thermal: thermal@1100b000 {
+			#thermal-sensor-cells = <0>;
+			compatible = "mediatek,mt8173-thermal";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+			clock-names = "therm", "auxadc";
+			resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
+			mediatek,auxadc = <&auxadc>;
+			mediatek,apmixedsys = <&apmixedsys>;
+		};
 	};
 };
 
