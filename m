From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] cpufreq: Kconfig.arm: Do not select GENERIC_CPUFREQ_CPU0
Date: Mon, 17 Feb 2014 15:35:27 -0300
Message-ID: <1392662127-31005-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [207.46.163.24] ([207.46.163.24]:18712 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754035AbaBQSiN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2014 13:38:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, festevam@gmail.com, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Currently the following warnings are generated when building multi_v7_defconfig:

$ make multi_v7_defconfig 
warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL)
# configuration written to .config

ARM_HIGHBANK_CPUFREQ can be built with GENERIC_CPUFREQ_CPU0=n, so remove this
selection.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/cpufreq/Kconfig.arm | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 3129749..bdd3ff9 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -84,7 +84,6 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
 config ARM_HIGHBANK_CPUFREQ
 	tristate "Calxeda Highbank-based"
 	depends on ARCH_HIGHBANK
-	select GENERIC_CPUFREQ_CPU0
 	select PM_OPP
 	select REGULATOR
 
-- 
1.8.1.2


