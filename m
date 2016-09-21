From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] PM / OPP: Multiple regulators aren't supported yet
Date: Wed, 21 Sep 2016 15:02:50 +0530
Message-ID: <fc02fca412ffdb749bd811c8f1dc40fa2ae3fc3f.1474450324.git.viresh.kumar@linaro.org>
References: <be2c4fb0bb58f5b29facbc6f5aaf3dca13cf209e.1474450324.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be2c4fb0bb58f5b29facbc6f5aaf3dca13cf209e.1474450324.git.viresh.kumar@linaro.org>
In-Reply-To: <be2c4fb0bb58f5b29facbc6f5aaf3dca13cf209e.1474450324.git.viresh.kumar@linaro.org>
References: <be2c4fb0bb58f5b29facbc6f5aaf3dca13cf209e.1474450324.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Multiple regulators per device aren't supported yet by the kernel code
and the bindings provided in documentation aren't sufficient to handle
that case (as there is no way for kernel code to link multiple
voltage/current values to a power supply).

Remove them. These can be added later if required with appropriate
changes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 68 ++-------------------------
 1 file changed, 4 insertions(+), 64 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 5eab6f0215d1..5d0595f0a10c 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -86,8 +86,7 @@ properties.
   Single entry is for target voltage and three entries are for <target min max>
   voltages.
 
-  Entries for multiple regulators must be present in the same order as
-  regulators are specified in device's DT node.
+  Entries for multiple regulators aren't supported.
 
 - opp-microvolt-<name>: Named opp-microvolt property. This is exactly similar to
   the above opp-microvolt property, but allows multiple voltage ranges to be
@@ -104,10 +103,7 @@ properties.
 
   Should only be set if opp-microvolt is set for the OPP.
 
-  Entries for multiple regulators must be present in the same order as
-  regulators are specified in device's DT node. If this property isn't required
-  for few regulators, then this should be marked as zero for them. If it isn't
-  required for any regulator, then this property need not be present.
+  Entries for multiple regulators aren't supported.
 
 - opp-microamp-<name>: Named opp-microamp property. Similar to
   opp-microvolt-<name> property, but for microamp instead.
@@ -381,63 +377,7 @@ DVFS state together.
 	};
 };
 
-Example 4: Handling multiple regulators
-
-/ {
-	cpus {
-		cpu@0 {
-			compatible = "arm,cortex-a7";
-			...
-
-			cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
-			operating-points-v2 = <&cpu0_opp_table>;
-		};
-	};
-
-	cpu0_opp_table: opp_table0 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp@1000000000 {
-			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <970000>, /* Supply 0 */
-					<960000>, /* Supply 1 */
-					<960000>; /* Supply 2 */
-			opp-microamp =  <70000>,  /* Supply 0 */
-					<70000>,  /* Supply 1 */
-					<70000>;  /* Supply 2 */
-			clock-latency-ns = <300000>;
-		};
-
-		/* OR */
-
-		opp@1000000000 {
-			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
-					<960000 965000 975000>, /* Supply 1 */
-					<960000 965000 975000>; /* Supply 2 */
-			opp-microamp =  <70000>,		/* Supply 0 */
-					<70000>,		/* Supply 1 */
-					<70000>;		/* Supply 2 */
-			clock-latency-ns = <300000>;
-		};
-
-		/* OR */
-
-		opp@1000000000 {
-			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
-					<960000 965000 975000>, /* Supply 1 */
-					<960000 965000 975000>; /* Supply 2 */
-			opp-microamp =  <70000>,		/* Supply 0 */
-					<0>,			/* Supply 1 doesn't need this */
-					<70000>;		/* Supply 2 */
-			clock-latency-ns = <300000>;
-		};
-	};
-};
-
-Example 5: opp-supported-hw
+Example 4: opp-supported-hw
 (example: three level hierarchy of versions: cuts, substrate and process)
 
 / {
@@ -482,7 +422,7 @@ Example 5: opp-supported-hw
 	};
 };
 
-Example 6: opp-microvolt-<name>, opp-microamp-<name>:
+Example 5: opp-microvolt-<name>, opp-microamp-<name>:
 (example: device with two possible microvolt ranges: slow and fast)
 
 / {
-- 
2.7.1.410.g6faf27b
