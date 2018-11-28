From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V3 1/4] dt-bindings: thermal: add binding doc for i.MX system
 controller thermal driver
Date: Wed, 28 Nov 2018 09:58:51 +0000
Message-ID: <1543398783-3185-2-git-send-email-Anson.Huang__29982.3578833186$1543401459$gmane$org@nxp.com>
References: <1543398783-3185-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1543398783-3185-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, Aisheng DONG <aisheng.dong@nxp.com>, Andy Gross <andy.gross@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "arnd@arndb.de" <arnd@arndb.de>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>, "ezequiel@collabora.com" <ezequiel@collabora.com>, "olof@lixom.net" <olof@lixom.net>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "LW@KARO-electronics.de" <LW@KARO-elec>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and thermal sensors etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to get temperature from thermal sensors, this patch adds
binding doc for i.MX system controller thermal driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change since V2.
 .../devicetree/bindings/thermal/imx-sc-thermal.txt | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/imx-sc-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/imx-sc-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-sc-thermal.txt
new file mode 100644
index 0000000..2f5b0a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/imx-sc-thermal.txt
@@ -0,0 +1,33 @@
+* Temperature Monitor (TEMPMON) on NXP i.MX SoCs with System Controller
+
+Required properties:
+- compatible : Must be "nxp,imx8qxp-sc-thermal";
+- tsens-num : Total number of thermal sensors supported;
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
+
+Example:
+tsens: thermal-sensor {
+	compatible = "nxp,imx8qxp-sc-thermal";
+	tsens-num = <1>;
+	#thermal-sensor-cells = <1>;
+};
+
+thermal_zones: thermal-zones {
+	cpu-thermal0 {
+		polling-delay-passive = <250>;
+		polling-delay = <2000>;
+		thermal-sensors = <&tsens 355>;
+		trips {
+			cpu_alert0: trip0 {
+				temperature = <107000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+			cpu_crit0: trip1 {
+				temperature = <127000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
+	};
+};
-- 
2.7.4
