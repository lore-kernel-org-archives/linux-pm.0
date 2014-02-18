From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v3] cpufreq: Kconfig.arm: Fix unmet direct dependencies
Date: Tue, 18 Feb 2014 10:44:51 -0300
Message-ID: <1392731091-817-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:12544
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754609AbaBRNpK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2014 08:45:10 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, shawn.guo@linaro.org, linux-pm@vger.kernel.org, festevam@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>

Currently the following warning is generated when building multi_v7_defconfig:

$ make multi_v7_defconfig 
warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL)
# configuration written to .config

Instead of forcing the selection of GENERIC_CPUFREQ_CPU0 let's depend on it.

By depending on GENERIC_CPUFREQ_CPU0 we can remove the selection of PM_OPP
and REGULATOR because we have:

config GENERIC_CPUFREQ_CPU0
	tristate "Generic CPU0 cpufreq driver"
	depends on HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL
	select PM_OPP

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Only keep the 'depends on GENERIC_CPUFREQ_CPU0' and remove the other 
selections
Changes since v1:
- Use 'depends on'

 drivers/cpufreq/Kconfig.arm | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 3129749..c43e2c2 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -84,9 +84,7 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
 config ARM_HIGHBANK_CPUFREQ
 	tristate "Calxeda Highbank-based"
 	depends on ARCH_HIGHBANK
-	select GENERIC_CPUFREQ_CPU0
-	select PM_OPP
-	select REGULATOR
+	depends on GENERIC_CPUFREQ_CPU0
 
 	default m
 	help
-- 
1.8.1.2


