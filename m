From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V6 1/2] thermal: max77620: Add DT binding doc for thermal driver
Date: Tue, 23 Aug 2016 13:50:26 +0530
Message-ID: <1471940427-2063-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10753 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756944AbcHWIhB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 04:37:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>

Maxim Semiconductor MAX77620 supports alarm interrupts when
its die temperature crosses 120C and 140C. These threshold
temperatures are not configurable.

Add DT binding document to details out the DT property related
to MAX77620 thermal functionality.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>

---
Changes from V4:
- Rename the file to max77620_thermal.txt
- Collected ack from Rob.
---
 .../bindings/thermal/max77620_thermal.txt          | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/max77620_thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/max77620_thermal.txt b/Documentation/devicetree/bindings/thermal/max77620_thermal.txt
new file mode 100644
index 0000000..323a3b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/max77620_thermal.txt
@@ -0,0 +1,70 @@
+Thermal driver for MAX77620 Power management IC from Maxim Semiconductor.
+
+Maxim Semiconductor MAX77620 supports alarm interrupts when its
+die temperature crosses 120C and 140C. These threshold temperatures
+are not configurable. Device does not provide the real temperature
+of die other than just indicating whether temperature is above or
+below threshold level.
+
+Required properties:
+-------------------
+#thermal-sensor-cells:	Please refer <devicetree/bindings/thermal/thermal.txt>
+			for more details.
+			The value must be 0.
+
+For more details, please refer generic thermal DT binding document
+<devicetree/bindings/thermal/thermal.txt>.
+
+Please refer <devicetree/bindings/mfd/max77620.txt> for mfd DT binding
+document for the MAX77620.
+
+Example:
+--------
+#include <dt-bindings/mfd/max77620.h>
+#include <dt-bindings/thermal/thermal.h>
+...
+
+i2c@7000d000 {
+	spmic: max77620@3c {
+		compatible = "maxim,max77620";
+		:::::
+		#thermal-sensor-cells = <0>;
+		:::
+	};
+};
+
+cool_dev: cool-dev {
+	compatible = "cooling-dev";
+	#cooling-cells = <2>;
+};
+
+thermal-zones {
+	PMIC-Die {
+		polling-delay = <0>;
+		polling-delay-passive = <0>;
+		thermal-sensors = <&spmic>;
+
+		trips {
+			pmic_die_warn_temp_thresh: hot-die {
+				temperature = <120000>;
+				type = "hot";
+				hysteresis = <0>;
+			};
+
+			pmic_die_cirt_temp_thresh: cirtical-die {
+				temperature = <140000>;
+				type = "critical";
+				hysteresis = <0>;
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&pmic_die_warn_temp_thresh>;
+				cooling-device = <&cool_dev THERMAL_NO_LIMIT
+						  THERMAL_NO_LIMIT>;
+				contribution = <100>;
+			};
+		};
+	};
+};
-- 
2.1.4

