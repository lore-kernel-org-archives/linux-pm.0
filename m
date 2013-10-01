From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/7] arm: dts: add dra7 IVA thermal data
Date: Tue, 1 Oct 2013 14:32:19 -0400
Message-ID: <1380652344-18819-3-git-send-email-eduardo.valentin@ti.com>
References: <1380652344-18819-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380652344-18819-1-git-send-email-eduardo.valentin-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch changes a dtsi file to contain the thermal data
for IVA domain on DRA7 and later SoCs. This data will
enable a thermal shutdown at 125C.

This thermal data can be reused across TI SoC devices.

Signed-off-by: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7-iva-thermal.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi

diff --git a/arch/arm/boot/dts/dra7-iva-thermal.dtsi b/arch/arm/boot/dts/dra7-iva-thermal.dtsi
new file mode 100644
index 0000000..fea0cea
--- /dev/null
+++ b/arch/arm/boot/dts/dra7-iva-thermal.dtsi
@@ -0,0 +1,28 @@
+/*
+ * Device Tree Source for DRA7 SoC IVA thermal
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Contact: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+iva_thermal: iva_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <1000>; /* milliseconds */
+
+		/* sensor       ID */
+	thermal-sensors = <&bandgap     4>;
+
+	trips {
+		iva_crit: iva_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = THERMAL_TRIP_CRITICAL;
+		};
+	};
+};
-- 
1.8.2.1.342.gfa7285d

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
