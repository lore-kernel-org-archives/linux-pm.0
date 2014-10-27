From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v14 2/5] dt-bindings: document Rockchip thermal
Date: Mon, 27 Oct 2014 10:39:45 +0800
Message-ID: <1414377588-2237-3-git-send-email-caesar.wang@rock-chips.com>
References: <1414377588-2237-1-git-send-email-caesar.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1414377588-2237-1-git-send-email-caesar.wang@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com
Cc: huangtao@rock-chips.com, devicetree@vger.kernel.org, dbasehore@chromium.org, dmitry.torokhov@gmail.com, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Caesar Wang <caesar.wang@rock-chips.com>, cf@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com, linux-arm-kernel@lists.infradead.org, zyf@rock-chips.com
List-Id: linux-pm@vger.kernel.org

This add the necessary binding documentation for the thermal
found on Rockchip SoCs

Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 .../bindings/thermal/rockchip-thermal.txt          | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
new file mode 100644
index 0000000..d5b1401
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -0,0 +1,53 @@
+* Temperature Sensor ADC (TSADC) on rockchip SoCs
+
+Required properties:
+- compatible : "rockchip,rk3288-tsadc"
+- reg : physical base address of the controller and length of memory mapped
+	region.
+- interrupts : The interrupt number to the cpu. The interrupt specifier format
+	       depends on the interrupt controller.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Shall be "tsadc" for the converter-clock, and "apb_pclk" for
+		the peripheral clock.
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
+
+Exiample:
+tsadc: tsadc@ff280000 {
+	compatible = "rockchip,rk3288-tsadc";
+	reg = <0xff280000 0x100>;
+	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+	clock-names = "tsadc", "apb_pclk";
+};
+
+Example: referring to thermal sensors:
+thermal-zones {
+	cpu_thermal: cpu_thermal {
+		polling-delay-passive = <1000>; /* milliseconds */
+		polling-delay = <5000>; /* milliseconds */
+
+		/* sensor	ID */
+		thermal-sensors = <&tsadc	1>;
+
+		trips {
+			cpu_alert0: cpu_alert {
+				temperature = <80000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "passive";
+			};
+			cpu_crit: cpu_crit {
+				temperature = <120000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "critical";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&cpu_alert0>;
+				cooling-device =
+					<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
-- 
1.9.1
