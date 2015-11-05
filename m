From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/5] PM / OPP: Rename OPP nodes as opp@<opp-hz>
Date: Thu,  5 Nov 2015 07:11:55 +0530
Message-ID: <5d5f139d334d5e503932c06694b47f0c3477caed.1446687367.git.viresh.kumar@linaro.org>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36379 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031633AbbKEBma (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 20:42:30 -0500
Received: by pacdm15 with SMTP id dm15so45821919pac.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2015 17:42:29 -0800 (PST)
In-Reply-To: <cover.1446687367.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446687367.git.viresh.kumar@linaro.org>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

It would be better to name OPP nodes as opp@<opp-hz> as that will ensure
that multiple DT nodes don't contain the same frequency. Of course we
expect the writer to name the node with its opp-hz frequency and not any
other frequency.

And that will let the compile error out if multiple nodes are using the
same opp-hz frequency.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 30c4bb3718bc..10ef08dc1b4c 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -183,20 +183,20 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
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
@@ -262,20 +262,20 @@ independently.
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
@@ -338,20 +338,20 @@ DVFS state together.
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
@@ -364,20 +364,20 @@ DVFS state together.
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
@@ -404,7 +404,7 @@ Example 4: Handling multiple regulators
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp00 {
+		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000>, /* Supply 0 */
 					<960000>, /* Supply 1 */
@@ -417,7 +417,7 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
-		opp00 {
+		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
 					<960000 965000 975000>, /* Supply 1 */
@@ -430,7 +430,7 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
-		opp00 {
+		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
 					<960000 965000 975000>, /* Supply 1 */
@@ -462,7 +462,7 @@ Example 5: opp-supported-hw
 		status = "okay";
 		opp-shared;
 
-		opp00 {
+		opp@600000000 {
 			/*
 			 * Supports all substrate and process versions for 0xF
 			 * cuts, i.e. only first four cuts.
@@ -473,7 +473,7 @@ Example 5: opp-supported-hw
 			...
 		};
 
-		opp01 {
+		opp@800000000 {
 			/*
 			 * Supports:
 			 * - cuts: only one, 6th cut (represented by 6th bit).
@@ -506,7 +506,7 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>, turbo-mode-<name>,
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp00 {
+		opp@1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt-slow = <900000 915000 925000>;
 			opp-microvolt-fast = <970000 975000 985000>;
@@ -516,7 +516,7 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>, turbo-mode-<name>,
 			opp-suspend-slow; /* Will be used as suspend-opp only if 'slow' is chosen */
 		};
 
-		opp01 {
+		opp@1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt-slow = <900000 915000 925000>, /* Supply vcc0 */
 					      <910000 925000 935000>; /* Supply vcc1 */
-- 
2.6.2.198.g614a2ac

