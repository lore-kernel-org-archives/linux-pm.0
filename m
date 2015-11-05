From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/5] PM / OPP: Remove 'operating-points-names' binding
Date: Thu,  5 Nov 2015 07:11:54 +0530
Message-ID: <c4070eeceb0fdf6a6ab56fcaef1769d01dd01c7e.1446687367.git.viresh.kumar@linaro.org>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446687367.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446687367.git.viresh.kumar@linaro.org>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

These aren't used until now by any DT files and wouldn't be used now as
we have a better scheme in place now, i.e. opp-property-<name>
properties.

Remove the (useless) binding without breaking ABI.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 62 +--------------------------
 1 file changed, 2 insertions(+), 60 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 61c6f25cf8e2..30c4bb3718bc 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -45,21 +45,10 @@ Devices supporting OPPs must set their "operating-points-v2" property with
 phandle to a OPP table in their DT node. The OPP core will use this phandle to
 find the operating points for the device.
 
-Devices may want to choose OPP tables at runtime and so can provide a list of
-phandles here. But only *one* of them should be chosen at runtime. This must be
-accompanied by a corresponding "operating-points-names" property, to uniquely
-identify the OPP tables.
-
 If required, this can be extended for SoC vendor specfic bindings. Such bindings
 should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
 and should have a compatible description like: "operating-points-v2-<vendor>".
 
-Optional properties:
-- operating-points-names: Names of OPP tables (required if multiple OPP
-  tables are present), to uniquely identify them. The same list must be present
-  for all the CPUs which are sharing clock/voltage rails and hence the OPP
-  tables.
-
 * OPP Table Node
 
 This describes the OPPs belonging to a device. This node can have following
@@ -454,54 +443,7 @@ Example 4: Handling multiple regulators
 	};
 };
 
-Example 5: Multiple OPP tables
-
-/ {
-	cpus {
-		cpu@0 {
-			compatible = "arm,cortex-a7";
-			...
-
-			cpu-supply = <&cpu_supply>
-			operating-points-v2 = <&cpu0_opp_table_slow>, <&cpu0_opp_table_fast>;
-			operating-points-names = "slow", "fast";
-		};
-	};
-
-	cpu0_opp_table_slow: opp_table_slow {
-		compatible = "operating-points-v2";
-		status = "okay";
-		opp-shared;
-
-		opp00 {
-			opp-hz = /bits/ 64 <600000000>;
-			...
-		};
-
-		opp01 {
-			opp-hz = /bits/ 64 <800000000>;
-			...
-		};
-	};
-
-	cpu0_opp_table_fast: opp_table_fast {
-		compatible = "operating-points-v2";
-		status = "okay";
-		opp-shared;
-
-		opp10 {
-			opp-hz = /bits/ 64 <1000000000>;
-			...
-		};
-
-		opp11 {
-			opp-hz = /bits/ 64 <1100000000>;
-			...
-		};
-	};
-};
-
-Example 6: opp-supported-hw
+Example 5: opp-supported-hw
 (example: three level hierarchy of versions: cuts, substrate and process)
 
 / {
@@ -546,7 +488,7 @@ Example 6: opp-supported-hw
 	};
 };
 
-Example 7: opp-microvolt-<name>, opp-microamp-<name>, turbo-mode-<name>,
+Example 6: opp-microvolt-<name>, opp-microamp-<name>, turbo-mode-<name>,
 opp-suspend-<name>:
 (example: device with two possible microvolt ranges: slow and fast)
 
-- 
2.6.2.198.g614a2ac
