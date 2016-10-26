From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: uniphier: add CPU clocks and OPP table for PXs2 SoC
Date: Thu, 27 Oct 2016 01:37:39 +0900
Message-ID: <1477499859-12415-2-git-send-email-yamada.masahiro@socionext.com>
References: <1477499859-12415-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1477499859-12415-1-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add a CPU clock to every CPU node and a CPU OPP table to use the
generic cpufreq driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
---

 arch/arm/boot/dts/uniphier-pxs2.dtsi | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 950f07b..83ba3e6 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -56,32 +56,78 @@
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
 		};
 
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
+			clocks = <&sys_clk 32>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			operating-points-v2 = <&cpu_opp>;
 		};
 
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
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
+		opp@150000000 {
+			opp-hz = /bits/ 64 <150000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			clock-latency-ns = <300>;
+		};
+		opp@1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			clock-latency-ns = <300>;
 		};
 	};
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
