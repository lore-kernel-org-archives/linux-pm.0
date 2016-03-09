From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 6/6] thermal: Add DT binding doc for thermal of PMIC max77620
Date: Wed, 9 Mar 2016 18:40:10 +0530
Message-ID: <1457529010-6538-7-git-send-email-ldewangan@nvidia.com>
References: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11651 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693AbcCINXq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 08:23:46 -0500
In-Reply-To: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, rklein@nvidia.com, Laxman Dewangan <ldewangan@nvidia.com>

Maxim Semiconductor MAX77620 supports alarm interrupts when
its die temperature crosses 120C and 140C. These threshold
temperatures are not configurable.

Add DT binding document to details out the DT property related
to MAX77620 thermal functionality.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
Changes from V1:
- New in series to add DT binding doc per V1 review.

 .../bindings/thermal/thermal-max77620.txt          | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-max77620.txt

diff --git a/Documentation/devicetree/bindings/thermal/thermal-max77620.txt b/Documentation/devicetree/bindings/thermal/thermal-max77620.txt
new file mode 100644
index 0000000..d76412f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-max77620.txt
@@ -0,0 +1,43 @@
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
+...
+spmic: max77620@3c {
+	compatible = "maxim,max77620";
+
+	#thermal-sensor-cells = <0>;
+};
+
+thermal-zones {
+	PMIC-Die {
+		thermal-sensors = <&spmic>;
+		trips {
+			die_temp_thresh: hot-die {
+				temperature = <120000>;
+				type = "active";
+				hysteresis = <0>;
+			};
+		};
+	};
+};
+
-- 
2.1.4

