From: Virendra Kakade <virendra.kakade@ni.com>
Subject: [RFC 3/6] power: supply: Ettus Research E31x charger driver
Date: Mon, 11 Feb 2019 19:01:40 -0600
Message-ID: <20190212010143.3729-4-virendra.kakade@ni.com>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212010143.3729-1-virendra.kakade@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, moritz.fischer@ettus.com, Virendra Kakade <virendra.kakade@ni.com>
List-Id: linux-pm@vger.kernel.org

Document bindings for the E31x devices charger.

Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
---
 Documentation/devicetree/bindings/mfd/e31x-pmu.txt |  8 ++++++++
 .../bindings/power/supply/e31x-charger.txt         | 14 ++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/e31x-charger.txt

diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
index ebb5625f6c74..3798886578ba 100644
--- a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
+++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
@@ -4,11 +4,19 @@ Required properties:
 - compatible : Must be "ni,e31x-pmu"
 - regmap     : Must be <&regmapnode>
 
+e31x-pmu has a sub-device called e31x-charger.
+
+For the e31x-charger properties please refer to:
+Documentation/device-tree/bindings/power/supply/e31x-charger.txt
+
 Example:
 
 pmu {
 	compatible = "ni,e31x-pmu";
 	regmap = <&devctrl>;
 	status = "okay";
+	charger: charger@0{
+		compatible = "ni,e31x-charger";
+	};
 };
 
diff --git a/Documentation/devicetree/bindings/power/supply/e31x-charger.txt b/Documentation/devicetree/bindings/power/supply/e31x-charger.txt
new file mode 100644
index 000000000000..ae9fedcbf1b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/e31x-charger.txt
@@ -0,0 +1,14 @@
+Ettus Research/National Instruments  E31x Devices Charger
+
+All E31x devices have to be connected to an external power supply
+charger to charge the in-built battery or supply power.
+Some capability is provided to monitor this charger.
+
+Required properties:
+- compatible: Must be "ni,e31x-charger"
+
+Example:
+
+charger: charger@0{
+	compatible = "ni,e31x-charger";
+};
-- 
2.17.1
