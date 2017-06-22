From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 Resend] PM / OPP: Use - instead of @ for DT entries
Date: Thu, 22 Jun 2017 09:15:11 +0530
Message-ID: <31dd4526b3975260a669494aaaaa19323f6d201d.1498103050.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32921 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbdFVDp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 23:45:26 -0400
Received: by mail-pf0-f178.google.com with SMTP id e7so2844939pfk.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2017 20:45:25 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Compiling the DT file with W=1, DTC warns like follows:

Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
unit name, but no reg property

Fix this by replacing '@' with '-' as the OPP nodes will never have a
"reg" property.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
@Rafael: You haven't applied it yesterday and I couldn't find it in
patchwork anymore, so I am assuming that I need to send it again.

 Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 63725498bd20..e36d261b9ba6 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -186,20 +186,20 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			clock-latency-ns = <290000>;
@@ -265,20 +265,20 @@ independently.
 		 * independently.
 		 */
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			opp-microamp = <90000;
@@ -341,20 +341,20 @@ DVFS state together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			opp-microamp = <90000>;
@@ -367,20 +367,20 @@ DVFS state together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1300000000 {
+		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1050000 1045000 1055000>;
 			opp-microamp = <95000>;
 			clock-latency-ns = <400000>;
 			opp-suspend;
 		};
-		opp@1400000000 {
+		opp-1400000000 {
 			opp-hz = /bits/ 64 <1400000000>;
 			opp-microvolt = <1075000>;
 			opp-microamp = <100000>;
 			clock-latency-ns = <400000>;
 		};
-		opp@1500000000 {
+		opp-1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1100000 1010000 1110000>;
 			opp-microamp = <95000>;
@@ -409,7 +409,7 @@ Example 4: Handling multiple regulators
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000>, /* Supply 0 */
 					<960000>, /* Supply 1 */
@@ -422,7 +422,7 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>, /* Supply 0 */
 					<965000 960000 975000>, /* Supply 1 */
@@ -435,7 +435,7 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>, /* Supply 0 */
 					<965000 960000 975000>, /* Supply 1 */
@@ -467,7 +467,7 @@ Example 5: opp-supported-hw
 		status = "okay";
 		opp-shared;
 
-		opp@600000000 {
+		opp-600000000 {
 			/*
 			 * Supports all substrate and process versions for 0xF
 			 * cuts, i.e. only first four cuts.
@@ -478,7 +478,7 @@ Example 5: opp-supported-hw
 			...
 		};
 
-		opp@800000000 {
+		opp-800000000 {
 			/*
 			 * Supports:
 			 * - cuts: only one, 6th cut (represented by 6th bit).
@@ -510,7 +510,7 @@ Example 5: opp-supported-hw
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt-slow = <915000 900000 925000>;
 			opp-microvolt-fast = <975000 970000 985000>;
@@ -518,7 +518,7 @@ Example 5: opp-supported-hw
 			opp-microamp-fast =  <71000>;
 		};
 
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt-slow = <915000 900000 925000>, /* Supply vcc0 */
 					      <925000 910000 935000>; /* Supply vcc1 */
-- 
2.13.0.71.gd7076ec9c9cb
