From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
Date: Thu, 8 Jun 2017 19:26:58 +0300
Message-ID: <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-dm3nam03on0081.outbound.protection.outlook.com ([104.47.41.81]:61168
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751563AbdFHQ10 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Jun 2017 12:27:26 -0400
In-Reply-To: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Bai Ping <ping.bai@nxp.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This seems to work fine with the existing imx thermal driver on both 6ul
and 6ull. It was just missing in dts.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index b9d7d2d..cda5e9e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -597,6 +597,14 @@
 				fsl,anatop = <&anatop>;
 			};
 
+			tempmon: tempmon {
+				compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				fsl,tempmon = <&anatop>;
+				fsl,tempmon-data = <&ocotp>;
+				clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
+			};
+
 			snvs: snvs@020cc000 {
 				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
 				reg = <0x020cc000 0x4000>;
-- 
2.7.4
