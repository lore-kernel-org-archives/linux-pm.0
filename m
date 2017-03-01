From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] PM / OPP: Documentation: Fix opp-microvolt in examples
Date: Wed,  1 Mar 2017 16:39:55 +0530
Message-ID: <e527318dc8b5a1acf260499c65cf025732d9fc51.1488365712.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The triplet present in "opp-microvolt" property should be in the order
<target min max>, while all the examples have it in the order
<min target max>.

Fix it.

Luckily all of the users of "opp-microvolt" property have applied brain
instead of copying the examples from documentation and none of the
actual dts files have it wrong.

Reported-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 44 +++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 9f5ca4457b5f..7951961ef356 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -188,14 +188,14 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <970000 975000 985000>;
+			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
 		opp@1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
-			opp-microvolt = <980000 1000000 1010000>;
+			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
@@ -267,14 +267,14 @@ independently.
 
 		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <970000 975000 985000>;
+			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
 		opp@1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
-			opp-microvolt = <980000 1000000 1010000>;
+			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
@@ -343,14 +343,14 @@ DVFS state together.
 
 		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <970000 975000 985000>;
+			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
 		opp@1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
-			opp-microvolt = <980000 1000000 1010000>;
+			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
@@ -369,7 +369,7 @@ DVFS state together.
 
 		opp@1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
-			opp-microvolt = <1045000 1050000 1055000>;
+			opp-microvolt = <1050000 1045000 1055000>;
 			opp-microamp = <95000>;
 			clock-latency-ns = <400000>;
 			opp-suspend;
@@ -382,7 +382,7 @@ DVFS state together.
 		};
 		opp@1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
-			opp-microvolt = <1010000 1100000 1110000>;
+			opp-microvolt = <1100000 1010000 1110000>;
 			opp-microamp = <95000>;
 			clock-latency-ns = <400000>;
 			turbo-mode;
@@ -424,9 +424,9 @@ Example 4: Handling multiple regulators
 
 		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
-					<960000 965000 975000>, /* Supply 1 */
-					<960000 965000 975000>; /* Supply 2 */
+			opp-microvolt = <975000 970000 985000>, /* Supply 0 */
+					<965000 960000 975000>, /* Supply 1 */
+					<965000 960000 975000>; /* Supply 2 */
 			opp-microamp =  <70000>,		/* Supply 0 */
 					<70000>,		/* Supply 1 */
 					<70000>;		/* Supply 2 */
@@ -437,9 +437,9 @@ Example 4: Handling multiple regulators
 
 		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
-					<960000 965000 975000>, /* Supply 1 */
-					<960000 965000 975000>; /* Supply 2 */
+			opp-microvolt = <975000 970000 985000>, /* Supply 0 */
+					<965000 960000 975000>, /* Supply 1 */
+					<965000 960000 975000>; /* Supply 2 */
 			opp-microamp =  <70000>,		/* Supply 0 */
 					<0>,			/* Supply 1 doesn't need this */
 					<70000>;		/* Supply 2 */
@@ -474,7 +474,7 @@ Example 5: opp-supported-hw
 			 */
 			opp-supported-hw = <0xF 0xFFFFFFFF 0xFFFFFFFF>
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <900000 915000 925000>;
+			opp-microvolt = <915000 900000 925000>;
 			...
 		};
 
@@ -487,7 +487,7 @@ Example 5: opp-supported-hw
 			 */
 			opp-supported-hw = <0x20 0xff0000ff 0x0000f4f0>
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <900000 915000 925000>;
+			opp-microvolt = <915000 900000 925000>;
 			...
 		};
 	};
@@ -512,18 +512,18 @@ Example 5: opp-supported-hw
 
 		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt-slow = <900000 915000 925000>;
-			opp-microvolt-fast = <970000 975000 985000>;
+			opp-microvolt-slow = <915000 900000 925000>;
+			opp-microvolt-fast = <975000 970000 985000>;
 			opp-microamp-slow =  <70000>;
 			opp-microamp-fast =  <71000>;
 		};
 
 		opp@1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt-slow = <900000 915000 925000>, /* Supply vcc0 */
-					      <910000 925000 935000>; /* Supply vcc1 */
-			opp-microvolt-fast = <970000 975000 985000>, /* Supply vcc0 */
-					     <960000 965000 975000>; /* Supply vcc1 */
+			opp-microvolt-slow = <915000 900000 925000>, /* Supply vcc0 */
+					      <925000 910000 935000>; /* Supply vcc1 */
+			opp-microvolt-fast = <975000 970000 985000>, /* Supply vcc0 */
+					     <965000 960000 975000>; /* Supply vcc1 */
 			opp-microamp =  <70000>; /* Will be used for both slow/fast */
 		};
 	};
-- 
2.7.1.410.g6faf27b

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
