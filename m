From: kongxinwei <kong.kongxinwei@hisilicon.com>
Subject: [PATCH 3/3] dt-bindings: Document the hi6220 thermal sensor bindings
Date: Thu, 19 Mar 2015 15:57:29 +0800
Message-ID: <1426751849-10604-4-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhuang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, devicetree@vger.kernel.org, liguozhu@hisilicon.com, xuwei5@hisilicon.com
List-Id: linux-pm@vger.kernel.org

This adds documentation of device tree bindings for the
thermal sensor controller of hi6220 SoC.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
---
 .../bindings/thermal/hisilicon-thermal.txt         | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
new file mode 100644
index 0000000..b75c48e
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
@@ -0,0 +1,51 @@
+* Hisilicon Thermal
+
+This driver is for hi6220 SoC which contain 4 thermal sensor.
+
+	1. sensor 0: local sensor;
+	2. sensor 1: remote sensor for ACPU cluster 1;
+	3. sensor 2: remote sensor for ACPU cluster 2;
+	4. sensor 3: remote sensor for GPU.
+
+Every sensor use one child node to represent it, so thermal sensor include
+parent node and four child node. The parent node describe common feature and
+child node describe private feature for thermal sensor;
+
+** Required properties :
+
+- compatible : "hisilicon,tsensor";
+- reg : address range of the thermal sensor registers;
+- interrupt : Standard way to define interrupt numbr;
+- clock-names : Should be "thermal_clk".
+		  See: Documentation/devicetree/bindings/resource-names.txt;
+- clocks : Phandle of the clock used by the thermal sensor.
+	     See: Documentation/devicetree/bindings/clock/clock-bindingm.txt
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description;
+
+** Required properties for child nodes :
+
+- hisilicon,tsensor-id : the index of thermal senor;
+- hisilicon,tsensor-thres-temp : the interrupt threshold temperature of
+				thermal senor;
+- hisilicon,tsensor-reset-temp : the reset temperature of the hardware SoC;
+- hisilicon,tsensor-bind-irq : systerm interrupt binding thermal sensor;
+
+Example :
+
+	tsensor: tsensor@0,f7030700 {
+		compatible = "hisilicon,tsensor";
+		reg = <0x0 0xf7030700 0x0 0x1000>;
+		interrupts = <0 7 0x4>;
+		clocks = <&clock_sys HI6220_TSENSOR_CLK>;
+		clock-names = "thermal_clk";
+		#thermal-sensor-cells = <1>;
+
+		local_sensor {
+			hisilicon,tsensor-id = <0>;
+			hisilicon,tsensor-lag-value = <10>;
+			hisilicon,tsensor-thres-temp = <35000>;
+			hisilicon,tsensor-reset-temp = <100000>;
+			hisilicon,tsensor-bind-irq;
+		}
+		.......
+	}
-- 
1.9.1
