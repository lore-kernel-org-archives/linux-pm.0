From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 4/5] PM / OPP: Rename OPP nodes as opp@<opp-hz>
Date: Wed, 11 Nov 2015 08:10:57 +0530
Message-ID: <3517ee11b7260bb47993d48774c204331d2da784.1447209519.git.viresh.kumar@linaro.org>
References: <cover.1447209519.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447209519.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1447209519.git.viresh.kumar@linaro.org>
References: <cover.1447209519.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

It would be better to name OPP nodes as opp@<opp-hz> as that will ensure
that multiple DT nodes don't contain the same frequency. Of course we
expect the writer to name the node with its opp-hz frequency and not any
other frequency.

And that will let the compile error out if multiple nodes are using the
same opp-hz frequency.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 24eac9a97749..601256fe8c0d 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -177,20 +177,20 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp00 {
+		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp01 {
+		opp@1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <980000 1000000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp02 {
+		opp@1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			clock-latency-ns = <290000>;
@@ -256,20 +256,20 @@ independently.
 		 * independently.
 		 */
 
-		opp00 {
+		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp01 {
+		opp@1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <980000 1000000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp02 {
+		opp@1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			opp-microamp = <90000;
@@ -332,20 +332,20 @@ DVFS state together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp00 {
+		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp01 {
+		opp@1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <980000 1000000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp02 {
+		opp@1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			opp-microamp = <90000>;
@@ -358,20 +358,20 @@ DVFS state together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp10 {
+		opp@1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1045000 1050000 1055000>;
 			opp-microamp = <95000>;
 			clock-latency-ns = <400000>;
 			opp-suspend;
 		};
-		opp11 {
+		opp@1400000000 {
 			opp-hz = /bits/ 64 <1400000000>;
 			opp-microvolt = <1075000>;
 			opp-microamp = <100000>;
 			clock-latency-ns = <400000>;
 		};
-		opp12 {
+		opp@1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1010000 1100000 1110000>;
 			opp-microamp = <95000>;
@@ -398,7 +398,7 @@ Example 4: Handling multiple regulators
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp00 {
+		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000>, /* Supply 0 */
 					<960000>, /* Supply 1 */
@@ -411,7 +411,7 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
-		opp00 {
+		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
 					<960000 965000 975000>, /* Supply 1 */
@@ -424,7 +424,7 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
-		opp00 {
+		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
 					<960000 965000 975000>, /* Supply 1 */
@@ -456,7 +456,7 @@ Example 5: opp-supported-hw
 		status = "okay";
 		opp-shared;
 
-		opp00 {
+		opp@600000000 {
 			/*
 			 * Supports all substrate and process versions for 0xF
 			 * cuts, i.e. only first four cuts.
@@ -467,7 +467,7 @@ Example 5: opp-supported-hw
 			...
 		};
 
-		opp01 {
+		opp@800000000 {
 			/*
 			 * Supports:
 			 * - cuts: only one, 6th cut (represented by 6th bit).
@@ -499,7 +499,7 @@ Example 5: opp-supported-hw
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp00 {
+		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt-slow = <900000 915000 925000>;
 			opp-microvolt-fast = <970000 975000 985000>;
@@ -507,7 +507,7 @@ Example 5: opp-supported-hw
 			opp-microamp-fast =  <71000>;
 		};
 
-		opp01 {
+		opp@1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt-slow = <900000 915000 925000>, /* Supply vcc0 */
 					      <910000 925000 935000>; /* Supply vcc1 */
-- 
2.6.2.198.g614a2ac
