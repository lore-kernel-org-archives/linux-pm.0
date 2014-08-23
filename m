From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH 1/2] dt-bindings: document Rockchip thermal
Date: Sat, 23 Aug 2014 08:15:33 +0800
Message-ID: <1408752934-18318-2-git-send-email-caesar.wang@rock-chips.com>
References: <1408752934-18318-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408752934-18318-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com, rdunlap@infradead.org, heiko@sntech.de
Cc: cf@rock-chips.com, grant.linkely@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, zyw@rock-chips.com, huangtao@rock-chips.com, xjq@rock-chips.com, addy.ke@rock-chips.com, dianders@chromium.org, Caesar Wang <caesar.wang@rock-chips.com>, zhaoyifeng <zyf@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This add the necessary binding documentation for the thermal
found on Rockchip SoCs

Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 .../bindings/thermal/rockchip-thermal.txt          |   33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
new file mode 100644
index 0000000..b556eae
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -0,0 +1,33 @@
+* Temperature Sensor ADC (TSADC) on rockchip SoCs
+
+Required properties:
+- compatible : "rockchip,rk3288-tsadc"
+- reg : physical base address of the controller and length of memory mapped
+  region.
+- interrupts : The interrupt number to the cpu. The interrupt specifier format
+  depends on the interrupt controller.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Shall be "tsadc_clk" for the transfer-clock, and "tsadc_pclk" for
+    the peripheral clock.
+Optional properties:
+- clock-frequency : Thermal sensor's clock frequency.
+- pinctrl-names : Should contain only one value - "default".
+- pinctrl-0 : Should contain only one value - &tsadc_int.
+- passive-temp : Temperature of trip 0.
+- critical-temp : Temperature of trip 1.
+- force-shut-temp : Temperature of force shut down.
+Example:
+
+tsadc: tsadc@ff280000 {
+	compatible = "rockchip,rk3288-tsadc";
+	reg = <0xff280000 0x100>;
+	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+	clock-frequency = <10000>;
+	clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+	clock-names = "tsadc_clk", "tsadc_pclk";
+	pinctrl-names = "default";
+	pinctrl-1 = <&tsadc_int>;
+	passive-temp = <80>;
+	critical-temp = <100>;
+	force-shut-temp = <120>;
+};
-- 
1.7.9.5
