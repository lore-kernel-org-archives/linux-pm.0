From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] ARM: dts: uniphier: add CPU clocks and OPP table for Pro5
 SoC
Date: Thu, 27 Oct 2016 01:37:38 +0900
Message-ID: <1477499859-12415-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org

Add a CPU clock to every CPU node and a CPU OPP table to use the
generic cpufreq driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-pro5.dtsi | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 5357ea9..5bd6068 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -56,16 +56,90 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&sys_clk 32>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			operating-points-v2 = <&cpu_opp>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clocks = <&sys_clk 32>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			operating-points-v2 = <&cpu_opp>;
+		};
+	};
+
+	cpu_opp: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@116667000 {
+			opp-hz = /bits/ 64 <116667000>;
+			clock-latency-ns = <300>;
+		};
+		opp@150000000 {
+			opp-hz = /bits/ 64 <150000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@175000000 {
+			opp-hz = /bits/ 64 <175000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@233334000 {
+			opp-hz = /bits/ 64 <233334000>;
+			clock-latency-ns = <300>;
+		};
+		opp@300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@350000000 {
+			opp-hz = /bits/ 64 <350000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@466667000 {
+			opp-hz = /bits/ 64 <466667000>;
+			clock-latency-ns = <300>;
+		};
+		opp@600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@933334000 {
+			opp-hz = /bits/ 64 <933334000>;
+			clock-latency-ns = <300>;
+		};
+		opp@1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			clock-latency-ns = <300>;
 		};
 	};
 
-- 
1.9.1
