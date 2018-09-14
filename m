From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 1/2] ARM: dts: imx6ul: use nvmem-cells for cpu speed grading
Date: Fri, 14 Sep 2018 10:59:21 +0800
Message-ID: <1536893962-11200-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-pm@vger.kernel.org

On i.MX6UL, accessing OCOTP directly is wrong because the ocotp clock
needs to be enabled first, so use the nvmem-cells binding instead.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 6dc0b56..c670d8e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -89,6 +89,8 @@
 				      "pll1_sys";
 			arm-supply = <&reg_arm>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 	};
 
@@ -932,6 +934,10 @@
 				tempmon_temp_grade: temp-grade@20 {
 					reg = <0x20 4>;
 				};
+
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
 			};
 
 			lcdif: lcdif@21c8000 {
-- 
2.7.4
