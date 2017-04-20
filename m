From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 4/7] ARM: pxa: Use - instead of @ for DT OPP entries
Date: Thu, 20 Apr 2017 16:25:08 +0530
Message-ID: <741bc9af28d6968e6a9409f94681066db5d1228b.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:33343 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966242AbdDTKzj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 06:55:39 -0400
Received: by mail-io0-f178.google.com with SMTP id k87so65354514ioi.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2017 03:55:34 -0700 (PDT)
In-Reply-To: <cover.1492685450.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: arm@kernel.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

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
---
 arch/arm/boot/dts/pxa25x.dtsi |  8 ++++----
 arch/arm/boot/dts/pxa27x.dtsi | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
index f9f4726396a0..95d59be97213 100644
--- a/arch/arm/boot/dts/pxa25x.dtsi
+++ b/arch/arm/boot/dts/pxa25x.dtsi
@@ -93,22 +93,22 @@
 	pxa250_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
 
-		opp@99532800 {
+		opp-99532800 {
 			opp-hz = /bits/ 64 <99532800>;
 			opp-microvolt = <1000000 950000 1650000>;
 			clock-latency-ns = <20>;
 		};
-		opp@199065600 {
+		opp-199065600 {
 			opp-hz = /bits/ 64 <199065600>;
 			opp-microvolt = <1000000 950000 1650000>;
 			clock-latency-ns = <20>;
 		};
-		opp@298598400 {
+		opp-298598400 {
 			opp-hz = /bits/ 64 <298598400>;
 			opp-microvolt = <1100000 1045000 1650000>;
 			clock-latency-ns = <20>;
 		};
-		opp@398131200 {
+		opp-398131200 {
 			opp-hz = /bits/ 64 <398131200>;
 			opp-microvolt = <1300000 1235000 1650000>;
 			clock-latency-ns = <20>;
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index e0fab48ba6fa..5f1d6da02a4c 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -141,37 +141,37 @@
 	pxa270_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
 
-		opp@104000000 {
+		opp-104000000 {
 			opp-hz = /bits/ 64 <104000000>;
 			opp-microvolt = <900000 900000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@156000000 {
+		opp-156000000 {
 			opp-hz = /bits/ 64 <156000000>;
 			opp-microvolt = <1000000 1000000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@208000000 {
+		opp-208000000 {
 			opp-hz = /bits/ 64 <208000000>;
 			opp-microvolt = <1180000 1180000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@312000000 {
+		opp-312000000 {
 			opp-hz = /bits/ 64 <312000000>;
 			opp-microvolt = <1250000 1250000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@416000000 {
+		opp-416000000 {
 			opp-hz = /bits/ 64 <416000000>;
 			opp-microvolt = <1350000 1350000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@520000000 {
+		opp-520000000 {
 			opp-hz = /bits/ 64 <520000000>;
 			opp-microvolt = <1450000 1450000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@624000000 {
+		opp-624000000 {
 			opp-hz = /bits/ 64 <624000000>;
 			opp-microvolt = <1550000 1550000 1705000>;
 			clock-latency-ns = <20>;
-- 
2.12.0.432.g71c3a4f4ba37
