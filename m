From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 3/3] OPP: Add binding for 'opp-suspend'
Date: Wed, 20 May 2015 09:11:40 +0530
Message-ID: <618b02107af650bcb3246e165095bbca207d511a.1432091956.git.viresh.kumar@linaro.org>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35458 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbbETDmU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 23:42:20 -0400
Received: by pdea3 with SMTP id a3so51986615pde.2
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2015 20:42:19 -0700 (PDT)
In-Reply-To: <cover.1432091956.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1432091956.git.viresh.kumar@linaro.org>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

On few platforms, for power efficiency, we want the device to be
configured for a specific OPP while we put the device in suspend state.

Add an optional property in operating-points-v2 bindings for that.

Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 7f30d9b07db7..880f5e14b6e2 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -72,6 +72,8 @@ This describes the OPPs belonging to a device. This node can have following
   Missing property means devices have independent clock/voltage/current lines,
   but they share OPP tables.
 
+- opp-suspend: Phandle of the OPP to set while device is suspended.
+
 
 * OPP Node
 
@@ -143,9 +145,10 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 	cpu0_opp: opp0 {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp>;
 		opp-shared;
 
-		entry00 {
+		suspend-opp: entry00 {
 			opp-hz = <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
@@ -217,13 +220,14 @@ independently.
 
 	cpu0_opp: opp0 {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp>;
 
 		/*
 		 * Missing opp-shared property means CPUs switch DVFS states
 		 * independently.
 		 */
 
-		entry00 {
+		suspend-opp: entry00 {
 			opp-hz = <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
@@ -296,9 +300,10 @@ DVFS state together.
 
 	cluster0_opp: opp0 {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp0>;
 		opp-shared;
 
-		entry00 {
+		suspend-opp0: entry00 {
 			opp-hz = <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
@@ -321,9 +326,10 @@ DVFS state together.
 
 	cluster1_opp: opp1 {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp1>;
 		opp-shared;
 
-		entry10 {
+		suspend-opp1: entry10 {
 			opp-hz = <1300000000>;
 			opp-microvolt = <1045000 1050000 1055000>;
 			opp-microamp = <95000>;
-- 
2.4.0

