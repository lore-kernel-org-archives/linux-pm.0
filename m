From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V7 2/3] OPP: Allow multiple OPP tables to be passed via DT
Date: Thu,  4 Jun 2015 21:50:32 +0530
Message-ID: <263c128844f5a3c9280c8be71f6c9eb1869a5188.1433434659.git.viresh.kumar@linaro.org>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32808 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbbFDQUx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 12:20:53 -0400
Received: by padj3 with SMTP id j3so32601887pad.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2015 09:20:52 -0700 (PDT)
In-Reply-To: <cover.1433434659.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1433434659.git.viresh.kumar@linaro.org>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

On some platforms (Like Qualcomm's SoCs), it is not decided until
runtime on what OPPs to use. The OPP tables can be fixed at compile
time, but which table to use is found out only after reading some efuses
(sort of an prom) and knowing characteristics of the SoC.

To support such platform we need to pass multiple OPP tables per device
and hardware should be able to choose one and only one table out of
those.

Update OPP-v2 bindings to support that.

Acked-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 52 +++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 259bf00edf7d..2938c52dbf84 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -45,6 +45,9 @@ Devices supporting OPPs must set their "operating-points-v2" property with
 phandle to a OPP table in their DT node. The OPP core will use this phandle to
 find the operating points for the device.
 
+Devices may want to choose OPP tables at runtime and so can provide a list of
+phandles here. But only *one* of them should be chosen at runtime.
+
 If required, this can be extended for SoC vendor specfic bindings. Such bindings
 should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
 and should have a compatible description like: "operating-points-v2-<vendor>".
@@ -63,6 +66,9 @@ This describes the OPPs belonging to a device. This node can have following
   reference an OPP.
 
 Optional properties:
+- opp-name: Name of the OPP table, to uniquely identify it if more than one OPP
+  table is supplied in "operating-points-v2" property of device.
+
 - opp-shared: Indicates that device nodes using this OPP Table Node's phandle
   switch their DVFS state together, i.e. they share clock/voltage/current lines.
   Missing property means devices have independent clock/voltage/current lines,
@@ -396,3 +402,49 @@ Example 4: Handling multiple regulators
 		};
 	};
 };
+
+Example 5: Multiple OPP tables
+
+/ {
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a7";
+			...
+
+			cpu-supply = <&cpu_supply>
+			operating-points-v2 = <&cpu0_opp_table_slow>, <&cpu0_opp_table_fast>;
+		};
+	};
+
+	cpu0_opp_table_slow: opp_table_slow {
+		compatible = "operating-points-v2";
+		opp-name = "slow";
+		opp-shared;
+
+		opp00 {
+			opp-hz = <600000000>;
+			...
+		};
+
+		opp01 {
+			opp-hz = <800000000>;
+			...
+		};
+	};
+
+	cpu0_opp_table_fast: opp_table_fast {
+		compatible = "operating-points-v2";
+		opp-name = "fast";
+		opp-shared;
+
+		opp10 {
+			opp-hz = <1000000000>;
+			...
+		};
+
+		opp11 {
+			opp-hz = <1100000000>;
+			...
+		};
+	};
+};
-- 
2.4.0

