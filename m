From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V5 1/7] PM / OPP: Use - instead of @ for DT entries
Date: Thu, 20 Apr 2017 16:25:05 +0530
Message-ID: <3c211d59b9d8752a1d874b6141b4c40cad786902.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1492685450.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1492685450.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1492685450.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 63725498bd20..e36d261b9ba6 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -186,20 +186,20 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			clock-latency-ns = <290000>;
@@ -265,20 +265,20 @@ independently.
 		 * independently.
 		 */
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			opp-microamp = <90000;
@@ -341,20 +341,20 @@ DVFS state together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			opp-microamp = <90000>;
@@ -367,20 +367,20 @@ DVFS state together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1300000000 {
+		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1050000 1045000 1055000>;
 			opp-microamp = <95000>;
 			clock-latency-ns = <400000>;
 			opp-suspend;
 		};
-		opp@1400000000 {
+		opp-1400000000 {
 			opp-hz = /bits/ 64 <1400000000>;
 			opp-microvolt = <1075000>;
 			opp-microamp = <100000>;
 			clock-latency-ns = <400000>;
 		};
-		opp@1500000000 {
+		opp-1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1100000 1010000 1110000>;
 			opp-microamp = <95000>;
@@ -409,7 +409,7 @@ Example 4: Handling multiple regulators
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000>, /* Supply 0 */
 					<960000>, /* Supply 1 */
@@ -422,7 +422,7 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>, /* Supply 0 */
 					<965000 960000 975000>, /* Supply 1 */
@@ -435,7 +435,7 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>, /* Supply 0 */
 					<965000 960000 975000>, /* Supply 1 */
@@ -467,7 +467,7 @@ Example 5: opp-supported-hw
 		status = "okay";
 		opp-shared;
 
-		opp@600000000 {
+		opp-600000000 {
 			/*
 			 * Supports all substrate and process versions for 0xF
 			 * cuts, i.e. only first four cuts.
@@ -478,7 +478,7 @@ Example 5: opp-supported-hw
 			...
 		};
 
-		opp@800000000 {
+		opp-800000000 {
 			/*
 			 * Supports:
 			 * - cuts: only one, 6th cut (represented by 6th bit).
@@ -510,7 +510,7 @@ Example 5: opp-supported-hw
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt-slow = <915000 900000 925000>;
 			opp-microvolt-fast = <975000 970000 985000>;
@@ -518,7 +518,7 @@ Example 5: opp-supported-hw
 			opp-microamp-fast =  <71000>;
 		};
 
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt-slow = <915000 900000 925000>, /* Supply vcc0 */
 					      <925000 910000 935000>; /* Supply vcc1 */
-- 
2.12.0.432.g71c3a4f4ba37

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
