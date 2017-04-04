From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 4/4] ARM: dts: imx6qp-sabresd: Set reg_arm regulator supply
Date: Tue, 4 Apr 2017 20:04:14 +0300
Message-ID: <f032759a6df750e504d040dfc80d834046c4c540.1491324640.git.leonard.crestez@nxp.com>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-co1nam03on0073.outbound.protection.outlook.com ([104.47.40.73]:26212
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754278AbdDDREp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Apr 2017 13:04:45 -0400
In-Reply-To: <cover.1491324640.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On imx6qp-sabresd LDO_ARM is connected to a different PMIC output than
the other imx6qdl-sabresd boards.

Setting cpu0 arm-supply to sw2_reg is wrong, this must have mistakenly
slipped out of the vendor tree where this is are used for LDO bypass.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qp-sabresd.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
index b234580..a8a5004 100644
--- a/arch/arm/boot/dts/imx6qp-sabresd.dts
+++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
@@ -50,8 +50,8 @@
 	compatible = "fsl,imx6qp-sabresd", "fsl,imx6qp";
 };
 
-&cpu0 {
-	arm-supply = <&sw2_reg>;
+&reg_arm {
+	vin-supply = <&sw2_reg>;
 };
 
 &iomuxc {
-- 
2.7.4
