From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH v3 1/3] dt-bindings: Document the hi3660 thermal sensor bindings
Date: Thu, 10 Aug 2017 16:32:13 +0800
Message-ID: <1502353935-92924-2-git-send-email-kevin.wangtao@hisilicon.com>
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

This adds documentation of device tree bindings for the
thermal sensor controller of hi3660 SoC.

Signed-off-by: Tao Wang <kevin.wangtao@linaro.org>
---
 .../devicetree/bindings/thermal/hisi-tsensor.txt   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisi-tsensor.txt

diff --git a/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt b/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
new file mode 100644
index 0000000..2ab0eb9
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
@@ -0,0 +1,23 @@
+* Temperature Sensor on hisilicon SoC
+
+** Required properties :
+
+- compatible: "hisilicon,thermal-tsensor".
+- reg: physical base address of thermal sensor and length of memory mapped
+  region.
+- offset: reg offset of each sensor.
+- coefficients:	An array of integers (one signed cell) containing
+		coefficients to turn adc value to temperture.
+- hisi,adc-range: adc value range, minimum value is followed by maximum value.
+- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
+
+Example :
+
+tsensor: tsensor@FFF3000 {
+	compatible = "hisilicon,tsensor";
+	reg = <0x0 0xfff30000 0x0 0x1000>;
+	offset = <0x1c 0x5c 0x9c>;
+	coefficients = <165000 (-40000)>;
+	hisi,adc-range = <0x74 0x39A>;
+	#thermal-sensor-cells = <1>;
+};
-- 
2.8.1
