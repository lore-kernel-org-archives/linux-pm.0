From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v14 3/5] ARM: dts: add RK3288 Thermal data
Date: Mon, 27 Oct 2014 10:39:46 +0800
Message-ID: <1414377588-2237-4-git-send-email-caesar.wang@rock-chips.com>
References: <1414377588-2237-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414377588-2237-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com
Cc: zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dmitry.torokhov@gmail.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This patch changes a dtsi file to contain the thermal data
on RK3288 and later SoCs. This data will
enable a thermal shutdown over 120C.

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-thermal.dtsi | 65 +++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-thermal.dtsi

diff --git a/arch/arm/boot/dts/rk3288-thermal.dtsi b/arch/arm/boot/dts/rk3288-thermal.dtsi
new file mode 100644
index 0000000..0555224
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-thermal.dtsi
@@ -0,0 +1,65 @@
+/*
+ * Device Tree Source for RK3288 SoC thermal
+ *
+ * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+reserve_thermal: reserve_thermal {
+	polling-delay-passive = <1000>; /* milliseconds */
+	polling-delay = <5000>; /* milliseconds */
+
+			/* sensor	ID */
+	thermal-sensors = <&tsadc	0>;
+
+};
+
+cpu_thermal: cpu_thermal {
+	polling-delay-passive = <1000>; /* milliseconds */
+	polling-delay = <5000>; /* milliseconds */
+
+			/* sensor	ID */
+	thermal-sensors = <&tsadc	1>;
+
+	trips {
+		cpu_alert0: cpu_alert0 {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu_crit: cpu_crit {
+			temperature = <120000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+		trip = <&cpu_alert0>;
+			cooling-device =
+				<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+gpu_thermal: gpu_thermal {
+	polling-delay-passive = <1000>; /* milliseconds */
+	polling-delay = <5000>; /* milliseconds */
+
+			/* sensor	ID */
+	thermal-sensors = <&tsadc	2>;
+
+	trips {
+		gpu_crit: gpu_crit {
+			temperature = <120000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
+};
-- 
1.9.1
