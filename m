From: Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH v6 3/3] dts: hi6220: enable thermal sensor for hisilicon SoC
Date: Wed, 20 May 2015 19:16:38 +0800
Message-ID: <1432120598-18268-4-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1432120598-18268-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432120598-18268-1-git-send-email-kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, Javi.Merino-5wv7dgnIgG8@public.gmane.org, jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gongyu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, zhenwei.wang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: kongxinwei <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>

Dts includes two part: the first part is related with thermal sensor;
the second part is related with thermal zones, in this part it will
define the thermal zones and which sensor device should be bound to.
it also need specify the polling interval for every thermal zone.

Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: kongxinwei <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 124 ++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 8ade3d9..eb465a6 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/hi6220-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "hisilicon,hi6220";
@@ -173,4 +174,127 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 	};
+
+	tsensor: tsensor@0,f7030700 {
+		compatible = "hisilicon,tsensor";
+		reg = <0x0 0xf7030700 0x0 0x1000>;
+		interrupts = <0 7 0x4>;
+		clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
+		clock-names = "thermal_clk";
+		#thermal-sensor-cells = <1>;
+	};
+
+	thermal-zones {
+		local: local {
+			/* milliseconds */
+			polling-delay-passive = <1000>;
+			/* milliseconds */
+			polling-delay = <5000>;
+
+			/* sensor	ID */
+			thermal-sensors = <&tsensor  0>;
+
+			trips {
+				local_alert: local_alert {
+					/* millicelsius */
+					temperature = <70000>;
+					/* millicelsius */
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				local_crit: local_crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				/* There are currently no cooling maps
+				because there are no cooling devices */
+			};
+		};
+
+		cluster1: cluster1 {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+
+			/* sensor	ID */
+			thermal-sensors = <&tsensor  1>;
+
+			trips {
+				cluster1_alert: cluster1_alert {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cluster1_crit: cluster1_crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				/* There are currently no cooling maps
+				because there are no cooling devices */
+			};
+		};
+
+		cluster0: cluster0 {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+
+			/* sensor	ID */
+			thermal-sensors = <&tsensor  2>;
+
+			trips {
+				cluster0_alert: cluster0_alert {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cluster0_crit: cluster0_crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cluster0_alert>;
+					cooling-device =
+					    <&cpu0 THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu: gpu {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+
+			/* sensor	ID */
+			thermal-sensors = <&tsensor  3>;
+
+			trips {
+				gpu_alert: gpu_alert {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				gpu_crit: gpu_crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				/* There are currently no cooling maps
+				because there are no cooling devices */
+			};
+		};
+	};
 };
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
