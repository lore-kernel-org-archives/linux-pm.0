From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V4 1/4] dt-bindings: fsl: scu: add thermal binding
Date: Thu, 29 Nov 2018 02:37:24 +0000
Message-ID: <1543458696-4741-2-git-send-email-Anson.Huang__37487.8893992447$1543462179$gmane$org@nxp.com>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
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
ChangeLog:
V3->V4:
  *move binding doc to SCU since it is belonging to SCU;
  *change compatile string to start with "fsl" instead of "nxp" to align with other nodes in dtb.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 3f3d697..b77ec29 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -112,6 +112,16 @@ RTC bindings based on SCU Message Protocol
 Required properties:
 - compatible: should be "fsl,imx8qxp-sc-rtc";
 
+Thermal bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible : Must be "fsl,imx8qxp-sc-thermal";
+- tsens-num : Total number of thermal sensors supported;
+- #thermal-sensor-cells : Should be 1. See
+			  Documentation/devicetree/bindings/thermal/thermal.txt
+			  for a description.
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -158,6 +168,12 @@ firmware {
 		rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible = "fsl,imx8qxp-sc-thermal";
+			tsens-num = <1>;
+			#thermal-sensor-cells = <1>;
+		};
 	};
 };
 
-- 
2.7.4
