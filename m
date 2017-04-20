From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V5 5/7] ARM: sun8i: Use - instead of @ for DT OPP entries
Date: Thu, 20 Apr 2017 16:25:09 +0530
Message-ID: <2eb4a6e227f7edfb51ebf3723d5df7e652c703b4.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1492685450.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1492685450.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1492685450.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Compiling the DT file with W=1, DTC warns like follows:

Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
unit name, but no reg property

Fix this by replacing '@' with '-' as the OPP nodes will never have a
"reg" property.

Reported-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Reported-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Suggested-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts |  4 ++--
 arch/arm/boot/dts/sun8i-a33.dtsi               | 30 +++++++++++++-------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 9b620cc1d5f1..8a0b42a2c2da 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -88,13 +88,13 @@
 };
 
 &cpu0_opp_table {
-	opp@1104000000 {
+	opp-1104000000 {
 		opp-hz = /bits/ 64 <1104000000>;
 		opp-microvolt = <1320000>;
 		clock-latency-ns = <244144>; /* 8 32k periods */
 	};
 
-	opp@1200000000 {
+	opp-1200000000 {
 		opp-hz = /bits/ 64 <1200000000>;
 		opp-microvolt = <1320000>;
 		clock-latency-ns = <244144>; /* 8 32k periods */
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 61de52b9940d..6a33f840d981 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -50,73 +50,73 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@120000000 {
+		opp-120000000 {
 			opp-hz = /bits/ 64 <120000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@240000000 {
+		opp-240000000 {
 			opp-hz = /bits/ 64 <240000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@312000000 {
+		opp-312000000 {
 			opp-hz = /bits/ 64 <312000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@408000000 {
+		opp-408000000 {
 			opp-hz = /bits/ 64 <408000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@480000000 {
+		opp-480000000 {
 			opp-hz = /bits/ 64 <480000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@504000000 {
+		opp-504000000 {
 			opp-hz = /bits/ 64 <504000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@648000000 {
+		opp-648000000 {
 			opp-hz = /bits/ 64 <648000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@720000000 {
+		opp-720000000 {
 			opp-hz = /bits/ 64 <720000000>;
 			opp-microvolt = <1100000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@816000000 {
+		opp-816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1100000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@912000000 {
+		opp-912000000 {
 			opp-hz = /bits/ 64 <912000000>;
 			opp-microvolt = <1200000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@1008000000 {
+		opp-1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1200000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
@@ -164,15 +164,15 @@
 	mali_opp_table: gpu-opp-table {
 		compatible = "operating-points-v2";
 
-		opp@144000000 {
+		opp-144000000 {
 			opp-hz = /bits/ 64 <144000000>;
 		};
 
-		opp@240000000 {
+		opp-240000000 {
 			opp-hz = /bits/ 64 <240000000>;
 		};
 
-		opp@384000000 {
+		opp-384000000 {
 			opp-hz = /bits/ 64 <384000000>;
 		};
 	};
-- 
2.12.0.432.g71c3a4f4ba37

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
