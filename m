From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V2 1/2] ARM: dts: imx6ul: add 696MHz operating point
Date: Sat, 6 Jan 2018 18:42:39 +0800
Message-ID: <1515235360-1628-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, linux@armlinux.org.uk, viresh.kumar@linaro.org, rafael@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add 696MHz operating point according to datasheet
(Rev. 0, 12/2015).

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index d5181f8..963e169 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -68,12 +68,14 @@
 			clock-latency = <61036>; /* two CLK32 periods */
 			operating-points = <
 				/* kHz	uV */
+				696000	1275000
 				528000	1175000
 				396000	1025000
 				198000	950000
 			>;
 			fsl,soc-operating-points = <
 				/* KHz	uV */
+				696000	1275000
 				528000	1175000
 				396000	1175000
 				198000	1175000
-- 
1.9.1
