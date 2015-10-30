From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] PM / OPP: Remove 'operating-points-names' binding
Date: Fri, 30 Oct 2015 06:55:07 +0530
Message-ID: <0290b40c1cb5062335b74ad7e845a1f1d3111f13.1446167359.git.viresh.kumar@linaro.org>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32901 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758170AbbJ3BZk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2015 21:25:40 -0400
Received: by padhy1 with SMTP id hy1so50886032pad.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2015 18:25:39 -0700 (PDT)
In-Reply-To: <cover.1446167359.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446167359.git.viresh.kumar@linaro.org>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

These aren't used until now by any DT files and wouldn't be used now as
we have a better scheme in place now, i.e. opp-property-<name>
properties.

Remove the (useless) binding without breaking ABI.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 62 +--------------------------
 1 file changed, 2 insertions(+), 60 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 6e0dd8db3b86..9d2e08f488b5 100644
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
@@ -446,54 +435,7 @@ Example 4: Handling multiple regulators
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
@@ -538,7 +480,7 @@ Example 6: opp-supported-hw
 	};
 };
 
-Example 7: opp-microvolt-<name>, opp-microamp-<name>, turbo-mode-<name>,
+Example 6: opp-microvolt-<name>, opp-microamp-<name>, turbo-mode-<name>,
 opp-suspend-<name>:
 (example: device with two possible microvolt ranges: slow and fast)
 
-- 
2.6.2.198.g614a2ac

