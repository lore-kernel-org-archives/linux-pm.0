From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 3/3] OPP: Add binding for 'opp-suspend'
Date: Sat, 13 Jun 2015 14:10:23 +0530
Message-ID: <20150613084023.GA4203@linux>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <dedf8c02fdd9dbf169f43de74ead4c1434d89b45.1433434659.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36087 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbbFMIk3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 13 Jun 2015 04:40:29 -0400
Received: by pabqy3 with SMTP id qy3so35064006pab.3
        for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2015 01:40:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <dedf8c02fdd9dbf169f43de74ead4c1434d89b45.1433434659.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 04-06-15, 21:50, Viresh Kumar wrote:
> +		opp-suspend = <&suspend_opp>;

> -		opp00 {
> +		suspend-opp: opp00 {

Minor nit, s/suspend-opp/suspend_opp

and here is updated patch

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 20 May 2015 08:27:49 +0530
Subject: [PATCH V8] OPP: Add binding for 'opp-suspend'

On few platforms, for power efficiency, we want the device to be
configured for a specific OPP while we put the device in suspend state.

Add an optional property in operating-points-v2 bindings for that.

Acked-by: Nishanth Menon <nm@ti.com>
Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 2938c52dbf84..29f115d26f7d 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -74,6 +74,8 @@ This describes the OPPs belonging to a device. This node can have following
   Missing property means devices have independent clock/voltage/current lines,
   but they share OPP tables.
 
+- opp-suspend: Phandle of the OPP to set while device is suspended.
+
 
 * OPP Node
 
@@ -145,9 +147,10 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 	cpu0_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp>;
 		opp-shared;
 
-		opp00 {
+		suspend_opp: opp00 {
 			opp-hz = <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
@@ -219,13 +222,14 @@ independently.
 
 	cpu_opp_table: opp_table {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp>;
 
 		/*
 		 * Missing opp-shared property means CPUs switch DVFS states
 		 * independently.
 		 */
 
-		opp00 {
+		suspend_opp: opp00 {
 			opp-hz = <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
@@ -298,9 +302,10 @@ DVFS state together.
 
 	cluster0_opp: opp_table0 {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp0>;
 		opp-shared;
 
-		opp00 {
+		suspend_opp: opp00 {
 			opp-hz = <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
@@ -323,9 +328,10 @@ DVFS state together.
 
 	cluster1_opp: opp_table1 {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp1>;
 		opp-shared;
 
-		opp10 {
+		suspend_opp: opp10 {
 			opp-hz = <1300000000>;
 			opp-microvolt = <1045000 1050000 1055000>;
 			opp-microamp = <95000>;
