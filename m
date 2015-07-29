From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 01/16] PM / OPP: Update bindings to make opp-hz a 64 bit value
Date: Wed, 29 Jul 2015 16:22:56 +0530
Message-ID: <f87ca786bca8abce6261dbd79a34218550355684.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36352 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbG2Kx3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 06:53:29 -0400
Received: by pachj5 with SMTP id hj5so3892057pac.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2015 03:53:28 -0700 (PDT)
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Rob Herring <robh+dt@kernel.org>

With a 32 bit value, the maximum frequency that the bindings can
support is ~ 4 GHz. And that might fall short of what newer systems may
have.

Allow opp-hz to be a 64 bit big-endian value.

Cc: Rob Herring <rob.herring@linaro.org>
Cc: devicetree@vger.kernel.org
Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 40 ++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 0d5e7c978121..0cb44dc21f97 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -88,7 +88,7 @@ This defines voltage-current-frequency combinations along with other related
 properties.
 
 Required properties:
-- opp-hz: Frequency in Hz
+- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer.
 
 Optional properties:
 - opp-microvolt: voltage in micro Volts.
@@ -158,20 +158,20 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 		opp-shared;
 
 		opp00 {
-			opp-hz = <1000000000>;
+			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
 		opp01 {
-			opp-hz = <1100000000>;
+			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <980000 1000000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
 		opp02 {
-			opp-hz = <1200000000>;
+			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			clock-latency-ns = <290000>;
 			turbo-mode;
@@ -237,20 +237,20 @@ independently.
 		 */
 
 		opp00 {
-			opp-hz = <1000000000>;
+			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
 		opp01 {
-			opp-hz = <1100000000>;
+			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <980000 1000000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
 		opp02 {
-			opp-hz = <1200000000>;
+			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			opp-microamp = <90000;
 			lock-latency-ns = <290000>;
@@ -313,20 +313,20 @@ DVFS state together.
 		opp-shared;
 
 		opp00 {
-			opp-hz = <1000000000>;
+			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
 		opp01 {
-			opp-hz = <1100000000>;
+			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <980000 1000000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
 		opp02 {
-			opp-hz = <1200000000>;
+			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			opp-microamp = <90000>;
 			clock-latency-ns = <290000>;
@@ -339,20 +339,20 @@ DVFS state together.
 		opp-shared;
 
 		opp10 {
-			opp-hz = <1300000000>;
+			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1045000 1050000 1055000>;
 			opp-microamp = <95000>;
 			clock-latency-ns = <400000>;
 			opp-suspend;
 		};
 		opp11 {
-			opp-hz = <1400000000>;
+			opp-hz = /bits/ 64 <1400000000>;
 			opp-microvolt = <1075000>;
 			opp-microamp = <100000>;
 			clock-latency-ns = <400000>;
 		};
 		opp12 {
-			opp-hz = <1500000000>;
+			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1010000 1100000 1110000>;
 			opp-microamp = <95000>;
 			clock-latency-ns = <400000>;
@@ -379,7 +379,7 @@ Example 4: Handling multiple regulators
 		opp-shared;
 
 		opp00 {
-			opp-hz = <1000000000>;
+			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000>, /* Supply 0 */
 					<960000>, /* Supply 1 */
 					<960000>; /* Supply 2 */
@@ -392,7 +392,7 @@ Example 4: Handling multiple regulators
 		/* OR */
 
 		opp00 {
-			opp-hz = <1000000000>;
+			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
 					<960000 965000 975000>, /* Supply 1 */
 					<960000 965000 975000>; /* Supply 2 */
@@ -405,7 +405,7 @@ Example 4: Handling multiple regulators
 		/* OR */
 
 		opp00 {
-			opp-hz = <1000000000>;
+			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
 					<960000 965000 975000>, /* Supply 1 */
 					<960000 965000 975000>; /* Supply 2 */
@@ -437,12 +437,12 @@ Example 5: Multiple OPP tables
 		opp-shared;
 
 		opp00 {
-			opp-hz = <600000000>;
+			opp-hz = /bits/ 64 <600000000>;
 			...
 		};
 
 		opp01 {
-			opp-hz = <800000000>;
+			opp-hz = /bits/ 64 <800000000>;
 			...
 		};
 	};
@@ -453,12 +453,12 @@ Example 5: Multiple OPP tables
 		opp-shared;
 
 		opp10 {
-			opp-hz = <1000000000>;
+			opp-hz = /bits/ 64 <1000000000>;
 			...
 		};
 
 		opp11 {
-			opp-hz = <1100000000>;
+			opp-hz = /bits/ 64 <1100000000>;
 			...
 		};
 	};
-- 
2.4.0

