From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v7 3/5] ARM: dts: add RK3xxx CPU Thermal data
Date: Sun, 28 Sep 2014 18:38:11 +0800
Message-ID: <1411900693-30484-4-git-send-email-caesar.wang@rock-chips.com>
References: <1411900693-30484-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411900693-30484-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com
Cc: dmitry.torokhov@gmail.com, arnd@arndb.de, zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dbasehore@chromium.org, huangtao@rock-chips.com, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This patch changes a dtsi file to contain the thermal data
on RK3288 and later SoCs. This data will
enable a thermal shutdown over 125C.

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi

diff --git a/arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi b/arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi
new file mode 100644
index 0000000..8888f7e
--- /dev/null
+++ b/arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi
@@ -0,0 +1,32 @@
+/*
+ * Device Tree Source for RK3XXX SoC CPU thermal
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
+cpu_thermal: cpu_thermal {
+	polling-delay-passive = <500>; /* milliseconds */
+	polling-delay = <1000>; /* milliseconds */
+
+			/* sensor       ID */
+        thermal-sensors = <&tsadc     0>;
+
+        trips {
+                cpu_alert0: cpu_alert {
+                        temperature = <800000>; /* millicelsius */
+                        hysteresis = <2000>; /* millicelsius */
+                        type = "passive";
+                };
+                cpu_crit: cpu_crit {
+                        temperature = <125000>; /* millicelsius */
+                        hysteresis = <2000>; /* millicelsius */
+                        type = "critical";
+                };
+        };
+};
-- 
1.9.1
