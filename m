From: Talel Shenhar <talel@amazon.com>
Subject: [PATCH v3 1/2] dt-bindings: thermal: al-thermal: Add binding documentation
Date: Thu, 11 Apr 2019 13:22:47 +0300
Message-ID: <1554978168-17369-2-git-send-email-talel@amazon.com>
References: <1554978168-17369-1-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554978168-17369-1-git-send-email-talel@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: talel@amazon.com, robh@kernel.org, edubezval@gmail.com, dwmw@amazon.co.uk, jonnyc@amazon.com, rui.zhang@intel.com, hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add thermal binding documentation for Amazon's Annapurna Labs Thermal
Sensor.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/amazon,al-thermal.txt         | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
new file mode 100644
index 0000000..703979d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
@@ -0,0 +1,33 @@
+Amazon's Annapurna Labs Thermal Sensor
+
+Simple thermal device that allows temperature reading by a single MMIO
+transaction.
+
+Required properties:
+- compatible: "amazon,al-thermal".
+- reg: The physical base address and length of the sensor's registers.
+- #thermal-sensor-cells: Must be 1. See ./thermal.txt for a description.
+
+Example:
+	thermal: thermal {
+		compatible = "amazon,al-thermal";
+		reg = <0x0 0x05002860 0x0 0x1>;
+		#thermal-sensor-cells = <0x1>;
+	};
+
+	thermal-zones {
+		thermal-z0 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&thermal 0>;
+			trips {
+				critical {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+		};
+	};
+
-- 
2.7.4
