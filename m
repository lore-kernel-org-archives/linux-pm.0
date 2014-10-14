From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v10 3/5] ARM: dts: add RK3288 Thermal data
Date: Wed, 15 Oct 2014 01:10:06 +0800
Message-ID: <1413306608-11498-4-git-send-email-caesar.wang@rock-chips.com>
References: <1413306608-11498-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.130]:35802 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779AbaJNRK1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Oct 2014 13:10:27 -0400
In-Reply-To: <1413306608-11498-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, arnd@arndb.de
Cc: zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dmitry.torokhov@gmail.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com, Caesar Wang <caesar.wang@rock-chips.com>

This patch changes a dtsi file to contain the thermal data
on RK3288 and later SoCs. This data will
enable a thermal shutdown over 125C.

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-thermal.dtsi | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-thermal.dtsi

diff --git a/arch/arm/boot/dts/rk3288-thermal.dtsi b/arch/arm/boot/dts/rk3288-thermal.dtsi
new file mode 100644
index 0000000..c68c090
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-thermal.dtsi
@@ -0,0 +1,57 @@
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
+	polling-delay-passive = <500>; /* milliseconds */
+	polling-delay = <1000>; /* milliseconds */
+
+			/* sensor	ID */
+	thermal-sensors = <&tsadc	0>;
+
+};
+
+cpu_thermal: cpu_thermal {
+	polling-delay-passive = <500>; /* milliseconds */
+	polling-delay = <1000>; /* milliseconds */
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
+			temperature = <125000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
+};
+
+gpu_thermal: gpu_thermal {
+	polling-delay-passive = <500>; /* milliseconds */
+	polling-delay = <1000>; /* milliseconds */
+
+			/* sensor	ID */
+	thermal-sensors = <&tsadc	2>;
+
+	trips {
+		gpu_crit: gpu_crit {
+			temperature = <125000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
+};
-- 
1.9.1


