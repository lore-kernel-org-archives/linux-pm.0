From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 4/5] ARM: dts: imx6qdl-sabresd: Set LDO regulator supply
Date: Fri, 31 Mar 2017 22:25:39 +0300
Message-ID: <48ebd72d94b5be37318f57e47c8ba5c6ab606470.1490987945.git.leonard.crestez@nxp.com>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490987945.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Setting the supply is optional but beneficial, it will cause PMIC
voltages to be dynamically changed with cpu frequency.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 63bf95e..58055ce 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -548,6 +548,18 @@
 	status = "okay";
 };
 
+&reg_arm {
+       vin-supply = <&sw1a_reg>;
+};
+
+&reg_pu {
+       vin-supply = <&sw1c_reg>;
+};
+
+&reg_soc {
+       vin-supply = <&sw1c_reg>;
+};
+
 &snvs_poweroff {
 	status = "okay";
 };
-- 
2.7.4
