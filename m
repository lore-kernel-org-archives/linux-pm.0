From: Virendra Kakade <virendra.kakade@ni.com>
Subject: [RFC 5/6] power: supply: Ettus Research E31x battery driver
Date: Mon, 11 Feb 2019 19:01:42 -0600
Message-ID: <20190212010143.3729-6-virendra.kakade@ni.com>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212010143.3729-1-virendra.kakade@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, moritz.fischer@ettus.com, Virendra Kakade <virendra.kakade@ni.com>
List-Id: linux-pm@vger.kernel.org

Document bindings for the E31x devices battery.

Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
---
 Documentation/devicetree/bindings/mfd/e31x-pmu.txt |  8 +++++++-
 .../bindings/power/supply/e31x-battery.txt         | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/e31x-battery.txt

diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
index 3798886578ba..223ab9e0d680 100644
--- a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
+++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
@@ -4,11 +4,14 @@ Required properties:
 - compatible : Must be "ni,e31x-pmu"
 - regmap     : Must be <&regmapnode>
 
-e31x-pmu has a sub-device called e31x-charger.
+e31x-pmu consists of two sub-devices, e31x-charger and e31x-battery.
 
 For the e31x-charger properties please refer to:
 Documentation/device-tree/bindings/power/supply/e31x-charger.txt
 
+For the e31x-battery properties please refer to:
+Documentation/device-tree/bindings/power/supply/e31x-battery.txt
+
 Example:
 
 pmu {
@@ -18,5 +21,8 @@ pmu {
 	charger: charger@0{
 		compatible = "ni,e31x-charger";
 	};
+	battery: battery@1{
+		compatible = "ni,e31x-battery";
+	};
 };
 
diff --git a/Documentation/devicetree/bindings/power/supply/e31x-battery.txt b/Documentation/devicetree/bindings/power/supply/e31x-battery.txt
new file mode 100644
index 000000000000..e09cd92ef82e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/e31x-battery.txt
@@ -0,0 +1,14 @@
+Ettus Research/National Instruments E31x Devices Battery
+
+Some variants of the E31x devices have an in-built Li-ion
+battery. This driver provides capability to monitor
+the battery.
+
+Required properties:
+- compatible: Must be "ni,e31x-battery"
+
+Example:
+
+battery: battery@0{
+	compatible = "ni,e31x-battery";
+};
-- 
2.17.1
