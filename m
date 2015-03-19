From: kongxinwei <kong.kongxinwei@hisilicon.com>
Subject: [PATCH 2/3] dts: hi6220: enable thermal sensor for hisilicon SoC
Date: Thu, 19 Mar 2015 15:57:28 +0800
Message-ID: <1426751849-10604-3-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:58011 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbCSH6J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 03:58:09 -0400
In-Reply-To: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhuang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, devicetree@vger.kernel.org, liguozhu@hisilicon.com, xuwei5@hisilicon.com

There have two parts for thermal sensor:

1. The first part is related with thermal sensor, every sensor need to
pass the sensor id, the threshold and reset temperature; so the sensor
will be registered as sensor devices;

2. The second part is related with thermal zones, in this part it will
define the thermal zones and which sensor device should be bound to. it
also need specify the polling interval for every thermal zone.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 153 ++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
new file mode 100644
index 0000000..da49790
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -0,0 +1,153 @@
+
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+
+	tsensor: tsensor@0,f7030700 {
+		compatible = "hisilicon,tsensor";
+		reg = <0x0 0xf7030700 0x0 0x1000>;
+		interrupts = <0 7 0x4>;
+		clocks = <&clock_sys HI6220_TSENSOR_CLK>;
+		clock-names = "thermal_clk";
+		#thermal-sensor-cells = <1>;
+
+		local_sensor {
+			hisilicon,tsensor-id = <0>;
+			hisilicon,tsensor-thres-temp = <80000>;
+			hisilicon,tsensor-reset-temp = <100000>;
+			hisilicon,tsensor-bind-irq;
+		};
+
+		acpu1_sensor {
+			hisilicon,tsensor-id = <1>;
+			hisilicon,tsensor-thres-temp = <80000>;
+			hisilicon,tsensor-reset-temp = <100000>;
+		};
+
+		acpu0_sensor {
+			hisilicon,tsensor-id = <2>;
+			hisilicon,tsensor-thres-temp = <80000>;
+			hisilicon,tsensor-reset-temp = <100000>;
+		};
+
+		gpu_sensor {
+			hisilicon,tsensor-id = <3>;
+			hisilicon,tsensor-thres-temp = <80000>;
+			hisilicon,tsensor-reset-temp = <100000>;
+		};
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
+}
-- 
1.9.1


