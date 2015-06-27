From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 14/16] arm: dts: Add L2 power-controller device bindings for APQ8084
Date: Fri, 26 Jun 2015 21:02:34 -0600
Message-ID: <1435374156-19214-15-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35943 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbF0DDG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:03:06 -0400
Received: by pdcu2 with SMTP id u2so84848169pdc.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:03:05 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Add power controller (SAW) device nodes for L2 caches. L2 SAW enable L2
to enter idle states and be powered off. Also, on 8084 the L2 SAW may be
used to regulate the active voltage for the cpu and L2.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 7084010..900ef1f 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -59,7 +59,7 @@
 		};
 
 		L2: l2-cache {
-			compatible = "qcom,arch-cache";
+			compatible = "cache";
 			cache-level = <2>;
 			qcom,saw = <&saw_l2>;
 		};
@@ -183,7 +183,7 @@
 		};
 
 		saw_l2: power-controller@f9012000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,apq8084-saw2-v2.1-l2", "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
 			regulator;
 		};
-- 
2.1.4

