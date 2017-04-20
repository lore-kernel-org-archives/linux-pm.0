From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 7/7] ARM: ZTE: Use - instead of @ for DT OPP entries
Date: Thu, 20 Apr 2017 11:14:18 +0530
Message-ID: <cf877dded1a27e5ad0f2e2298769b0ae1d3b5e8d.1492666725.git.viresh.kumar@linaro.org>
References: <cover.1492666725.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34028 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965368AbdDTFpZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 01:45:25 -0400
Received: by mail-oi0-f42.google.com with SMTP id x184so35209178oia.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2017 22:45:24 -0700 (PDT)
In-Reply-To: <cover.1492666725.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492666725.git.viresh.kumar@linaro.org>
References: <cover.1492666725.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: arm@kernel.org
Cc: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

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
 arch/arm64/boot/dts/zte/zx296718.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index b850b2cd0adc..2c7dc69987df 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -118,27 +118,27 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			clock-latency-ns = <500000>;
 		};
 
-		opp@648000000 {
+		opp-648000000 {
 			opp-hz = /bits/ 64 <648000000>;
 			clock-latency-ns = <500000>;
 		};
 
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			clock-latency-ns = <500000>;
 		};
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			clock-latency-ns = <500000>;
 		};
 
-		opp@1188000000 {
+		opp-1188000000 {
 			opp-hz = /bits/ 64 <1188000000>;
 			clock-latency-ns = <500000>;
 		};
-- 
2.12.0.432.g71c3a4f4ba37
