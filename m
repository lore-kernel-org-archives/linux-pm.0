From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/4] ARM: dts: augment Ux500 to use DT cpufreq
Date: Thu, 10 Aug 2017 14:52:18 +0200
Message-ID: <20170810125221.25818-2-linus.walleij@linaro.org>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36547 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdHJMwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2017 08:52:34 -0400
Received: by mail-lf0-f49.google.com with SMTP id o85so3005476lff.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2017 05:52:33 -0700 (PDT)
In-Reply-To: <20170810125221.25818-1-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

This adds the operating points to the Ux500 device tree and
deletes the old special-purpose cpufreq node, as we can now
use the generic DT cpufreq driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Viresh et al: I will merge this into ARM SoC separately from
the rest of the patches once we agree on this approach.
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 6c5affe2d0f5..2310a4e97768 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -37,6 +37,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x300>;
+			/* cpufreq controls */
+			operating-points = <998400 0
+					    800000 0
+					    400000 0
+					    200000 0>;
+			clocks = <&prcmu_clk PRCMU_ARMSS>;
+			clock-names = "cpu";
+			clock-latency = <20000>;
 		};
 		CPU1: cpu@301 {
 			device_type = "cpu";
@@ -494,13 +502,6 @@
 				reg = <0x80157450 0xC>;
 			};
 
-			cpufreq {
-				compatible = "stericsson,cpufreq-ux500";
-				clocks = <&prcmu_clk PRCMU_ARMSS>;
-				clock-names = "armss";
-				status = "disabled";
-			};
-
 			thermal@801573c0 {
 				compatible = "stericsson,db8500-thermal";
 				reg = <0x801573c0 0x40>;
-- 
2.9.4
