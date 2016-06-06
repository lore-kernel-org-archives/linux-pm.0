From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 1/2] thermal: max77620: Add DT binding doc for thermal driver
Date: Mon, 6 Jun 2016 17:14:26 +0530
Message-ID: <1465213467-23518-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Maxim Semiconductor MAX77620 supports alarm interrupts when
its die temperature crosses 120C and 140C. These threshold
temperatures are not configurable.

Add DT binding document to details out the DT property related
to MAX77620 thermal functionality.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/thermal/thermal-max77620.txt          | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-max77620.txt

diff --git a/Documentation/devicetree/bindings/thermal/thermal-max77620.txt b/Documentation/devicetree/bindings/thermal/thermal-max77620.txt
new file mode 100644
index 0000000..5a500d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-max77620.txt
@@ -0,0 +1,64 @@
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
+			die_temp_thresh: hot-die {
+				temperature = <120000>;
+				type = "active";
+				hysteresis = <0>;
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&die_temp_thresh>;
+				cooling-device = <&cool_dev THERMAL_NO_LIMIT
+						  THERMAL_NO_LIMIT>;
+				contribution = <100>;
+			};
+		};
+	};
+};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
