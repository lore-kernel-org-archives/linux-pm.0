From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 13/14] ARM64: dts: hisilicon: Add dual clusters thermal zones for hi3660
Date: Tue, 25 Sep 2018 11:03:11 +0200
Message-ID: <1537866192-12320-14-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "moderated list:ARM/HISILICON SOC
        SUPPORT" <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Add a thermal zone for the little cluster, so we can handle two
sensors managing each a cluster on the SoC.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 97 ++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index dd398cb..6df7d9f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1090,42 +1090,71 @@
 		};
 
                 thermal-zones {
+			tz_a53: tz_a53 {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				sustainable-power = <4500>;
+
+				/* sensor ID */
+				thermal-sensors = <&tsensor 0>;
+
+				trips {
+					a53_temp_threshold: trip-point@0 {
+						temperature = <65000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+
+					a53_temp_target: trip-point@1 {
+						temperature = <75000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+				};
 
-                        cls0: cls0 {
-                                polling-delay = <1000>;
-                                polling-delay-passive = <100>;
-                                sustainable-power = <4500>;
-
-                                /* sensor ID */
-                                thermal-sensors = <&tsensor 1>;
-
-                                trips {
-                                        threshold: trip-point@0 {
-                                                temperature = <65000>;
-                                                hysteresis = <1000>;
-                                                type = "passive";
-                                        };
-
-                                        target: trip-point@1 {
-                                                temperature = <75000>;
-                                                hysteresis = <1000>;
-                                                type = "passive";
-                                        };
-                                };
-
-                                cooling-maps {
+				cooling-maps {
 					map0 {
-                                                trip = <&target>;
-                                                contribution = <1024>;
-                                                cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-                                        };
-					map1 {
-                                                trip = <&target>;
-                                                contribution = <512>;
-                                                cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-                                        };
-                                };
-                        };
+						trip = <&a53_temp_target>;
+						contribution = <512>;
+						cooling-device = <&cpu0
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+
+			tz_a73: tz_a73 {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				sustainable-power = <4500>;
+
+				/* sensor ID */
+				thermal-sensors = <&tsensor 1>;
+
+				trips {
+					a73_temp_threshold: trip-point@0 {
+						temperature = <65000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+
+					a73_temp_target: trip-point@1 {
+						temperature = <75000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&a73_temp_target>;
+						contribution = <1024>;
+						cooling-device = <&cpu4
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+					};
+				};
+			};
                 };
 	};
 };
-- 
2.7.4
