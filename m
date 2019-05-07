From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v3 3/4] arm64: dts: imx8mm: Add cpu speed grading and all OPPs
Date: Tue, 7 May 2019 13:52:25 +0000
Message-ID: <5f2172c5e676d570b51ba66ff1ea9dd42b3e09fd.1557236799.git.leonard.crestez@nxp.com>
References: <cover.1557236799.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1557236799.git.leonard.crestez@nxp.com>
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
To: Viresh Kumar <viresh.kumar@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

Add a nvmem cell on cpu node referencing speed grade and the 1.8 Ghz
cpufreq opp.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 0b2a585c5844..7eea47584f31 100644
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
@@ -98,18 +100,27 @@
 		opp-shared;
 
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <850000>;
+			opp-supported-hw = <0xe>, <0x7>;
 			clock-latency-ns = <150000>;
 		};
 
 		opp-1600000000 {
 			opp-hz = /bits/ 64 <1600000000>;
 			opp-microvolt = <900000>;
+			opp-supported-hw = <0xc>, <0x7>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1000000>;
+			/* Consumer only but rely on speed grading */
+			opp-supported-hw = <0x8>, <0x7>;
 			clock-latency-ns = <150000>;
-			opp-suspend;
 		};
 	};
 
 	memory@40000000 {
 		device_type = "memory";
@@ -317,10 +328,14 @@
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
