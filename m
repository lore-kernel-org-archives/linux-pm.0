From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH 7/9] dt-bindings: Document the hi3660 thermal sensor binding
Date: Fri, 22 Sep 2017 17:42:10 +0800
Message-ID: <1506073332-92438-8-git-send-email-kevin.wangtao@hisilicon.com>
References: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, lonela.Voinescu@arm.com, Valentin.Schneider@arm.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Wangtao <kevin.wangtao@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

This adds documentation of device tree bindings for the
thermal sensor controller of hi3660 SoC.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
---
 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
index d48fc52..cef716a 100644
--- a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
@@ -13,6 +13,7 @@
 
 Example :
 
+for Hi6220:
 	tsensor: tsensor@0,f7030700 {
 		compatible = "hisilicon,tsensor";
 		reg = <0x0 0xf7030700 0x0 0x1000>;
@@ -21,3 +22,11 @@ Example :
 		clock-names = "thermal_clk";
 		#thermal-sensor-cells = <1>;
 	}
+
+for Hi3660:
+	tsensor: tsensor@fff30000 {
+		compatible = "hisilicon,hi3660-tsensor";
+		reg = <0x0 0xfff30000 0x0 0x1000>;
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.8.1
