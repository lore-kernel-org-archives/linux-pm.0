From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH v4 1/3] dt-bindings: Document the hi3660 thermal sensor bindings
Date: Tue, 29 Aug 2017 16:17:44 +0800
Message-ID: <1503994666-13954-2-git-send-email-kevin.wangtao@hisilicon.com>
References: <e313015d-11d5-91b8-aa64-37e9410cb882@hisilicon.com>
 <1503994666-13954-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503994666-13954-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, kevin.wangtao@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com
List-Id: linux-pm@vger.kernel.org

From: Tao Wang <kevin.wangtao@linaro.org>

This adds documentation of device tree bindings for the
thermal sensor controller of hi3660 SoC.

Signed-off-by: Tao Wang <kevin.wangtao@linaro.org>
---
 .../devicetree/bindings/thermal/hisi-tsensor.txt   | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisi-tsensor.txt

diff --git a/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt b/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
new file mode 100644
index 0000000..4643dbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
@@ -0,0 +1,37 @@
+* Temperature Sensor on hisilicon SoC
+
+Hisilicon SoC supplies temperature sensor feature, each CPU cluster and G3D
+area contains a temperture sensor. The temperture sensor produces an output
+value which has a linear relationship with the temperture of the area.
+
+for Hi3660,
+sensor0 monitors the temperture of A53;
+sensor1 monitors the temperture of A72;
+sensor2 monitors the temperture of GPU;
+sensor3 is a virtual sensor, which produces the maximum value of all sensors;
+sensor4 is a virtual sensor, which produces the average value of all sensors.
+
+** Required properties :
+- compatible: "hisilicon,thermal-tsensor".
+- reg: physical reg address of thermal sensor and length of memory mapped
+  region.
+- hisi,tsensors: number of hardware tsensors
+- hisi,coef:	An array of integers (one signed cell) containing
+		coefficients to turn adc value to temperture.
+- hisi,adc-range: adc value range, minimum value is followed by maximum value.
+- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
+
+Example :
+Hi3660:
+tsensor: tsensor@fff30000 {
+	compatible = "hisilicon,hi3660-tsensor";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	reg = <0x0 0xfff3001c 0x0 0x4>,
+		<0x0 0xfff3005c 0x0 0x4>,
+		<0x0 0xfff3009c 0x0 0x4>;
+	hisi,tsensors = <HISI_MAX_TSENSORS>;
+	hisi,coef = <165000 (-40000)>;
+	hisi,adc-range = <0x74 0x39A>;
+	#thermal-sensor-cells = <1>;
+};
-- 
2.8.1
