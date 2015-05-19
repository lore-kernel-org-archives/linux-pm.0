From: <Frank.Li@freescale.com>
Subject: [PATCH v2 7/7] arm: dts: imx6sx: enable snvs power key
Date: Wed, 20 May 2015 01:04:42 +0800
Message-ID: <1432055082-28983-8-git-send-email-Frank.Li@freescale.com>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, a.zummo@towertech.it, p.zabel@pengutronix.de, alexandre.belloni@free-electrons.com
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Frank Li <Frank.Li@freescale.com>
List-Id: linux-pm@vger.kernel.org

From: Frank Li <Frank.Li@freescale.com>

enable snvs ONOFF power key support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 97de407..2977015 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -674,6 +674,13 @@
 					compatible = "fsl,sec-v4.0-poweroff";
 					status = "disabled";
 				};
+
+				snvs_pwrkey: snvs-powerkey {
+					compatible = "fsl,sec-v4.0-pwrkey";
+					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+					linux,keycode = <116>; /* KEY_POWER */
+					wakeup;
+				};
 			};
 
 			epit1: epit@020d0000 {
-- 
1.9.1

