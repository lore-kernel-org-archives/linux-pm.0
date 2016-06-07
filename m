From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V4 1/2] thermal: max77620: Add DT binding doc for thermal driver
Date: Tue, 7 Jun 2016 16:22:33 +0530
Message-ID: <1465296754-13186-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, robh+dt@kernel.org, Keerthy <a0393675@ti.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Maxim Semiconductor MAX77620 supports alarm interrupts when
its die temperature crosses 120C and 140C. These threshold
temperatures are not configurable.

Add DT binding document to details out the DT property related
to MAX77620 thermal functionality.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
Changes from V3:
Added example node for the critical trips also as critical.
Also change the warning as "hot" type.

 .../bindings/thermal/thermal-max77620.txt          | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-max77620.txt

diff --git a/Documentation/devicetree/bindings/thermal/thermal-max77620.txt b/Documentation/devicetree/bindings/thermal/thermal-max77620.txt
new file mode 100644
index 0000000..323a3b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-max77620.txt
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
