From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v8] Add Mediatek thermal support
Date: Mon, 31 Aug 2015 09:34:03 +0200
Message-ID: <1441006446-4558-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46690 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbbHaHef (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2015 03:34:35 -0400
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
