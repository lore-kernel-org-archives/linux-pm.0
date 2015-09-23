From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v9] Add Mediatek thermal support
Date: Wed, 23 Sep 2015 15:37:40 +0200
Message-ID: <1443015463-23639-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44953 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023AbbIWNiM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2015 09:38:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org

This series adds support for the thermal sensors included in the
MT8173 SoC. Currently only basic temperature reading is supported
without any interrupt support.

The cpufreq driver for MT8173 is currently under review, so there's no
real cooling device available in mainline. Until this is available the
thermal driver can be tested with the following dts snippet. It creates
a fake gpio fan and a fake trip point which is so low that it can easily
be reached with a "cat /dev/zero > /dev/null" on the command line.

Please review and let me know what's missing to be included in mainline.

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
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABCAAGBQJWAqrzAAoJEPFlmONMx+ezud4QAK3BODYyBYKDPHRF3M6bwcRR
Hc5gO9RuA3asA9eyxS+BCIyo9kuJW1Usb1xAE/YL8ryrXlMHMAGBxJH6jnlkuDTS
hNZRXdjIfCSLypWOxOLotDuH8RlRQVW4faNHjGYFxflXSL3YNGQlNPjxS2LLAKdU
flLSvwg9aWvtdeIwOyIL/tWbpMgF3sluLIz1K2iElqGKDFSDzwBfYEMlf27d6CKw
B3PoqDI0rRR6iDiMBoZFJLYzjyyNSKz9Xqqe9y6osOfPnlC7SRmwbBQ19df/Sqxl
+Cd4VsuWedqDmP5WD1MCr5SzYqocUnM54t7aarz5TmVf1Ehd3Z+hBW8ItGJsFPDp
Itn75HHiIDxm2GrIIkVs82dr3dUpw3v1vThEke3JqfrOvOi2H0bZ2C5jXCqbFr6M
bLKVADmyNDHfP/av+v224zMffmJVqRIedfnBKMV6nDLbTzzjlKVf2n1KeBKjwntS
PfEY/E4Qg/PM95E/G1qZCuInAN7w53dNZCGMnm+KCNVAcdkMsEwpNWT1lf8+18ng
brXWYXcDCniwr1Ye31NuakGdkWLzSolbpmWS5ValUtA/K9flfZBcnqJ5obF8ooD1
cMnyq4FMpYozhgRYoPVD3pooIBl+yqKNmNtphBftyozZKgPfdOjhPkoCx0hlpBuH
270RN+jva0dOJWk+FXGR
=bcx6
-----END PGP SIGNATURE-----

commit de42d22304311e6d5d711b85e66a281fe1035ba2
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue May 12 09:22:29 2015 +0200

    ARM64: dts: mt8173: Add thermal/auxadc device nodes
    
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
    Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d18ee42..3b18f37 100644
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
+			#thermal-sensor-cells = <1>;
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
 
