From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2] ARM: dts: imx6sx-sdb: Remove OPP override
Date: Fri, 5 May 2017 14:00:17 +0300
Message-ID: <7b929a65b4893e081c2c04bb0588801f37ac2cca.1493981825.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-co1nam03on0041.outbound.protection.outlook.com ([104.47.40.41]:58688
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750867AbdEELAe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 May 2017 07:00:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Anson Huang <Anson.Huang@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Peter Chen <peter.chen@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Henri Roosen <henri.roosen@ginzinger.com>, Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

The board file for imx6sx-sdb overrides cpufreq operating points to use
higher voltages. This is done because the board has a shared rail for
VDD_ARM_IN and VDD_SOC_IN and when using LDO bypass the shared voltage
needs to be a value suitable for both ARM and SOC.

This only applies to LDO bypass mode, a feature not present in upstream.
When LDOs are enabled the effect is to use higher voltages than necessary
for no good reason.

Setting these higher voltages can make some boards fail to boot with ugly
semi-random crashes reminiscent of memory corruption. These failures only
happen on board rev. C, rev. B is reported to still work.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
CC: stable@vger.kernel.org

---

It is not known exactly why setting these higher voltages causes crashes.
Maybe this means that it's not appropriate to CC stable?

Removing this override is a correct change anyway because these OPP
overrides do not serve a purpose without ldo bypass.

Changes since v1:
- Adjusted commit message
- Link: https://lkml.org/lkml/2017/4/25/636

 arch/arm/boot/dts/imx6sx-sdb.dts | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 5bb8fd5..d71da30 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -12,23 +12,6 @@
 	model = "Freescale i.MX6 SoloX SDB RevB Board";
 };
 
-&cpu0 {
-	operating-points = <
-		/* kHz    uV */
-		996000  1250000
-		792000  1175000
-		396000  1175000
-		198000  1175000
-		>;
-	fsl,soc-operating-points = <
-		/* ARM kHz      SOC uV */
-		996000	1250000
-		792000	1175000
-		396000	1175000
-		198000  1175000
-	>;
-};
-
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
2.7.4
