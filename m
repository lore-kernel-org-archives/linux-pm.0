From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: schedutil: Make default depend on CONFIG_SMP
Date: Wed, 11 May 2016 14:52:01 +0200
Message-ID: <1462971135-613196-1-git-send-email-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:59121 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbcEKMwW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2016 08:52:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

CPU_FREQ_GOV_SCHEDUTIL gained a dependency on SMP, so now we
get a warning if it gets selected by CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
without SMP:

warning: (CPU_FREQ_DEFAULT_GOV_SCHEDUTIL) selects CPU_FREQ_GOV_SCHEDUTIL which has unmet direct dependencies (CPU_FREQ && SMP)

This adds another dependency to avoid the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: bf7cdff19429 ("cpufreq: schedutil: Make it depend on CONFIG_SMP")
---
 drivers/cpufreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 0bfc3427fc86..b7445b6ae5a4 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -110,6 +110,7 @@ config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
 
 config CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
 	bool "schedutil"
+	depends on SMP
 	select CPU_FREQ_GOV_SCHEDUTIL
 	select CPU_FREQ_GOV_PERFORMANCE
 	help
-- 
2.7.0

