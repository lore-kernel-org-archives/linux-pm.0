From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 2/3] arm64: dts: imx8mm: Add cpu speed grading and all OPPs
Date: Thu, 2 May 2019 22:44:15 +0000
Message-ID: <cb0329b83347e551911f3d474cf512f3fe10cde4.1556836868.git.leonard.crestez@nxp.com>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1556836868.git.leonard.crestez@nxp.com>
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
To: Viresh Kumar <viresh.kumar@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

Add a nvmem cell on cpu node referencing speed grade and the 1.8 Ghz
cpufreq opp.

The imx-cpufreq-dt driver will read speed grade and disable higher opps
if unsupported.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 0b2a585c5844..9154f48e81f4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -51,10 +51,12 @@
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MM_CLK_ARM>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 
 		A53_1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
@@ -95,21 +97,36 @@
 
 	a53_opp_table: opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <850000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <150000>;
+		};
+
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <850000>;
+			opp-supported-hw = <0xe>;
 			clock-latency-ns = <150000>;
 		};
 
 		opp-1600000000 {
 			opp-hz = /bits/ 64 <1600000000>;
 			opp-microvolt = <900000>;
+			opp-supported-hw = <0xc>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1000000>;
+			opp-supported-hw = <0x8>;
 			clock-latency-ns = <150000>;
-			opp-suspend;
 		};
 	};
 
 	memory@40000000 {
 		device_type = "memory";
@@ -317,10 +334,14 @@
 				reg = <0x30350000 0x10000>;
 				clocks = <&clk IMX8MM_CLK_OCOTP_ROOT>;
 				/* For nvmem subnodes */
 				#address-cells = <1>;
 				#size-cells = <1>;
+
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
 			};
 
 			anatop: anatop@30360000 {
 				compatible = "fsl,imx8mm-anatop", "syscon", "simple-bus";
 				reg = <0x30360000 0x10000>;
-- 
2.17.1
