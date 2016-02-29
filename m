From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] cpufreq: qoriq: allow building as module with THERMAL=m
Date: Mon, 29 Feb 2016 17:04:20 +0100
Message-ID: <1456761867-1742824-1-git-send-email-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:60642 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbcB2QFA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 11:05:00 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

My previous patch to avoid link errors with the qoriq cpufreq
driver disallowed all of the broken cases, but also prevented
the driver from being built when CONFIG_THERMAL is a module.

This changes the dependency to allow the cpufreq driver to
also be a module in this case, just not built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cpufreq: qoriq depends on thermal
---

If possible, please fold this change directly into the previous
commit

 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index ca05037dd565..d5e11d24f72b 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -297,7 +297,7 @@ endif
 config QORIQ_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
 	depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
-	depends on !CPU_THERMAL || THERMAL=y
+	depends on !CPU_THERMAL || THERMAL
 	select CLK_QORIQ
 	help
 	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
-- 
2.7.0

