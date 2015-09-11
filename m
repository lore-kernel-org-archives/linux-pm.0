From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Fri, 11 Sep 2015 17:31:57 +0530
Message-ID: <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36833 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbIKMCZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 08:02:25 -0400
Received: by padhk3 with SMTP id hk3so73535047pad.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2015 05:02:24 -0700 (PDT)
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Rob Herring <robh+dt@kernel.org>

Regulators already have stable DT bindings, wherein the consumer (of
supplies) will have following for each regulator/supply.

<name>-supply: <phandle to the regulator node>;

Current OPP bindings extend above, by transforming it into a list of
phandles. But we missed the <name> string, which is used to identify the
regulator.

And looking from regulators perspective, having two different ways of
specifying regulators doesn't seem like a step forward, it also means we
have to update every single device binding. And things will become
complex.

Another way to support multiple regulators per device (in OPP V2
bindings) is to leave regulator consumer bindings as is, and create a
'supply-names' property in the opp-table node, which will contain a list
of strings. The names in this list shall match 'name' from the
'<name>-supply' strings present in the device node.

The strings in this list also specify the order in which values must be
present in 'opp-microvolt' and 'opp-microamp' properties.

Cc: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 0cb44dc21f97..8759bc4783ed 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -69,6 +69,13 @@ This describes the OPPs belonging to a device. This node can have following
 - compatible: Allow OPPs to express their compatibility. It should be:
   "operating-points-v2".
 
+- supply-names: This is a required property, only if multiple supplies are
+  available for the device. Otherwise it is optional.
+
+  This list is used to pass names of all the device supplies. The order of names
+  present here is important, as that should match the order in which values are
+  present in 'opp-microvolt' and 'opp-microamp' properties.
+
 - OPP nodes: One or more OPP nodes describing voltage-current-frequency
   combinations. Their name isn't significant but their phandle can be used to
   reference an OPP.
@@ -97,8 +104,8 @@ properties.
   Single entry is for target voltage and three entries are for <target min max>
   voltages.
 
-  Entries for multiple regulators must be present in the same order as
-  regulators are specified in device's DT node.
+  Entries for multiple regulators must be present in the same order as their
+  names are present in 'supply-names' property of the opp-table.
 
 - opp-microamp: The maximum current drawn by the device in microamperes
   considering system specific parameters (such as transients, process, aging,
@@ -107,10 +114,12 @@ properties.
 
   Should only be set if opp-microvolt is set for the OPP.
 
-  Entries for multiple regulators must be present in the same order as
-  regulators are specified in device's DT node. If this property isn't required
-  for few regulators, then this should be marked as zero for them. If it isn't
-  required for any regulator, then this property need not be present.
+  Entries for multiple regulators must be present in the same order as their
+  names are present in 'supply-names' property of the opp-table.
+
+  If this property isn't required for few regulators, then this should be marked
+  as zero for them. If it isn't required for any regulator, then this property
+  need not be present.
 
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
@@ -369,13 +378,16 @@ Example 4: Handling multiple regulators
 			compatible = "arm,cortex-a7";
 			...
 
-			cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
+			vcc0-supply = <&cpu_supply0>;
+			vcc1-supply = <&cpu_supply1>;
+			vcc2-supply = <&cpu_supply2>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
 	};
 
 	cpu0_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
+		supply-names = "vcc0", "vcc1", "vcc2";
 		opp-shared;
 
 		opp00 {
-- 
2.4.0

