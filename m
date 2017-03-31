From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 5/5] ARM: dts: imx6qp-sabresd: Set reg_arm regulator supply
Date: Fri, 31 Mar 2017 22:25:40 +0300
Message-ID: <6711393cb78e8f975014e26e4008481828459463.1490987945.git.leonard.crestez@nxp.com>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490987945.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On imx6qp-sabresd LDO_ARM is connected to a different PMIC output than
the other imx6qdl-sabresd boards.

Setting cpu0 arm-supply to sw2_reg is wrong, this must have mistakenly
slipped out of the vendor tree where this is are used for LDO bypass.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
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
