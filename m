From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH v3 3/3] arm64: dts: register Hi3660's thermal sensor
Date: Thu, 10 Aug 2017 16:32:15 +0800
Message-ID: <1502353935-92924-4-git-send-email-kevin.wangtao@hisilicon.com>
References: <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1502353935-92924-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502353935-92924-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, xuwei5@hisilicon.com, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, kevin.wangtao@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sunzhaosheng@hisilicon.com
List-Id: linux-pm@vger.kernel.org

From: Tao Wang <kevin.wangtao@linaro.org>

Bind thermal sensor driver for Hi3660.

Signed-off-by: Tao Wang <kevin.wangtao@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi    | 10 ++++++++++
 include/dt-bindings/thermal/hi3660-thermal.h | 30 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/dt-bindings/thermal/hi3660-thermal.h

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index c6a1961..7e2081d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/hi3660-clock.h>
+#include <dt-bindings/thermal/hi3660-thermal.h>
 
 / {
 	compatible = "hisilicon,hi3660";
@@ -848,5 +849,14 @@
 				     &sdio_cfg_func>;
 			status = "disabled";
 		};
+
+		tsensor: tsensor@FFF3000 {
+			compatible = "hisilicon,tsensor";
+			reg = <0x0 0xfff30000 0x0 0x1000>;
+			offset = <0x1c 0x5c 0x9c>;
+			coefficients = <165000 (-40000)>;
+			hisi,adc-range = <0x74 0x39A>;
+			#thermal-sensor-cells = <1>;
+		};
 	};
 };
diff --git a/include/dt-bindings/thermal/hi3660-thermal.h b/include/dt-bindings/thermal/hi3660-thermal.h
new file mode 100644
index 0000000..1efe625
--- /dev/null
+++ b/include/dt-bindings/thermal/hi3660-thermal.h
@@ -0,0 +1,30 @@
+/*
+ *  Copyright (c) 2017 Hisilicon Limited.
+ *  Copyright (c) 2017 Linaro Limited.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __DTS_HI3660_THERMAL_H
+#define __DTS_HI3660_THERMAL_H
+
+/* sensor id */
+#define LITTLE_CPU_TEMP		0
+#define BIG_CPU_TEMP		1
+#define GPU_TEMP		2
+#define MAX_TEMP		3
+#define AVG_TEMP		4
+
+#define THERMAL_NO_LIMIT		(~0)
+
+#endif
-- 
2.8.1
