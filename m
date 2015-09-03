From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] cpufreq: Add ARM_MT8173_CPUFREQ dependencyon THERMAL
Date: Thu,  3 Sep 2015 08:20:58 -0700
Message-ID: <1441293658-18199-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41318 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756992AbbICPVG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 11:21:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>

If ARM_MT8173_CPUFREQ is configured, and THERMAL is configured as module,
the following build error is seen for arm:allmodconfig and
arm64:allmodconfig.

drivers/built-in.o: In function `mtk_cpufreq_ready':
:(.text+0x32a20c): undefined reference to `of_cpufreq_cooling_register'
drivers/built-in.o: In function `mtk_cpufreq_exit':
:(.text+0x32a420): undefined reference to `cpufreq_cooling_unregister'

The fix is similar to CPUFREQ_DT, but more restrictive since
ARM_MT8173_CPUFREQ can not be built as module.

Fixes: 1453863fb02a ("cpufreq: mediatek: Add MT8173 cpufreq driver")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
It might also make sense to declare ARM_MT8173_CPUFREQ as tristate
and relax the conditions, but I don't know if that is feasible.

 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 77aa34eae92c..c4c6200be435 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -133,6 +133,7 @@ config ARM_KIRKWOOD_CPUFREQ
 config ARM_MT8173_CPUFREQ
 	bool "Mediatek MT8173 CPUFreq support"
 	depends on ARCH_MEDIATEK && REGULATOR
+	depends on !CPU_THERMAL || THERMAL=y
 	select PM_OPP
 	help
 	  This adds the CPUFreq driver support for Mediatek MT8173 SoC.
-- 
2.1.4

