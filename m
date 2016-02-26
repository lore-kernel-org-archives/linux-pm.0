From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: qoriq depends on thermal
Date: Fri, 26 Feb 2016 13:22:35 +0100
Message-ID: <1456489361-469413-1-git-send-email-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:57386 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcBZMXT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 07:23:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, Jia Hongtao <hongtao.jia@freescale.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The thermal subsystem can be a loadable module, so the qoriq driver has to be
a module in that case as well in order to call of_cpufreq_cooling_register:

drivers/built-in.o: In function `qoriq_cpufreq_ready':
text+0x1f4548): undefined reference to `of_cpufreq_cooling_register'

This adds a dependency that clarifies how we can either build the driver
when the cpu_thermal support is completely disabled, or how it depends
on the thermal support to enforce the qoriq driver to be a module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 8ae1702a0df5 ("cpufreq: qoriq: Register cooling device based on device tree")
---
 drivers/cpufreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

My patch is from Dec 22, and I had marked it as submitted, but can't
find the email now, so maybe I forgot to send it out back then.

The problem still exists in linux-next, please apply the patch
for 4.6.

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index dcb972a38fbc..ca05037dd565 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -297,6 +297,7 @@ endif
 config QORIQ_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
 	depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
+	depends on !CPU_THERMAL || THERMAL=y
 	select CLK_QORIQ
 	help
 	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
-- 
2.7.0

