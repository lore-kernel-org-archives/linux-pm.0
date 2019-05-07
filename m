From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v3 4/4] arm64: dts: imx8mq: Add cpu speed grading and all OPPs
Date: Tue, 7 May 2019 13:52:26 +0000
Message-ID: <7effdee3820aa0408ba0c8a5267b5b9b4cee2fe7.1557236799.git.leonard.crestez@nxp.com>
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

Add nvmem-cells reference to cpu and fill the OPP table with all known
OPPs.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 26 ++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 6d635ba0904c..729376919d08 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -93,10 +93,12 @@
 			clocks = <&clk IMX8MQ_CLK_ARM>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 
 		A53_1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
@@ -143,18 +145,36 @@
 		opp-shared;
 
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <900000>;
+			/* Industrial only */
+			opp-supported-hw = <0xf>, <0x4>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <900000>;
+			/* Consumer only */
+			opp-supported-hw = <0xe>, <0x3>;
 			clock-latency-ns = <150000>;
 		};
 
 		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1000000>;
+			opp-supported-hw = <0xc>, <0x7>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1000000>;
+			/* Consumer only but rely on speed grading */
+			opp-supported-hw = <0x8>, <0x7>;
 			clock-latency-ns = <150000>;
-			opp-suspend;
 		};
 	};
 
 	pmu {
 		compatible = "arm,cortex-a53-pmu";
@@ -413,10 +433,14 @@
 				compatible = "fsl,imx8mq-ocotp", "syscon";
 				reg = <0x30350000 0x10000>;
 				clocks = <&clk IMX8MQ_CLK_OCOTP_ROOT>;
 				#address-cells = <1>;
 				#size-cells = <1>;
+
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
 			};
 
 			anatop: syscon@30360000 {
 				compatible = "fsl,imx8mq-anatop", "syscon";
 				reg = <0x30360000 0x10000>;
-- 
2.17.1
