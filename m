From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: dbx500: add a Kconfig symbol
Date: Thu, 11 May 2017 14:12:29 +0200
Message-ID: <20170511121258.3521041-1-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:60616 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755137AbdEKMNC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2017 08:13:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Moving the cooling code into the cpufreq driver caused a possible build failure
when the cpu_thermal helper code is a loadable module or disabled:

drivers/cpufreq/dbx500-cpufreq.o: In function `dbx500_cpufreq_ready':
dbx500-cpufreq.c:(.text.dbx500_cpufreq_ready+0x4): undefined reference to `cpufreq_cooling_register'

This adds the same dependency that we have in other cpufreq drivers,
forcing the driver to be disabled when we can't possibly link it.

Fixes: 19678ffb9fd6 ("cpufreq: dbx500: Manage cooling device from cpufreq driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm | 9 +++++++++
 drivers/cpufreq/Makefile    | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 74ed7e9a7f27..2011fec2d6ad 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -71,6 +71,15 @@ config ARM_HIGHBANK_CPUFREQ
 
 	  If in doubt, say N.
 
+config ARM_DB8500_CPUFREQ
+	tristate "ST-Ericsson DB8500 cpufreq" if COMPILE_TEST && !ARCH_U8500
+	default ARCH_U8500
+	depends on HAS_IOMEM
+	depends on !CPU_THERMAL || THERMAL
+	help
+	  This adds the CPUFreq driver for ST-Ericsson Ux500 (DB8500) SoC
+	  series.
+
 config ARM_IMX6Q_CPUFREQ
 	tristate "Freescale i.MX6 cpufreq support"
 	depends on ARCH_MXC
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index b7e78f063c4f..ab3a42cd29ef 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -53,7 +53,7 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
-obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
+obj-$(CONFIG_ARM_DB8500_CPUFREQ)	+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
-- 
2.9.0
