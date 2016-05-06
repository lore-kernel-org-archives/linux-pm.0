From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: schedutil: Make it depend on CONFIG_SMP
Date: Fri, 06 May 2016 15:00:38 +0200
Message-ID: <3697740.fObsh7mydn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55478 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757934AbcEFM5Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 08:57:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: schedutil: Make it depend on CONFIG_SMP

Make the schedutil cpufreq governor depend on CONFIG_SMP, because
the scheduler-provided utilization numbers used by it are only
available for CONFIG_SMP set.

Fixes: 9bdcb44e391d (cpufreq: schedutil: New governor based on scheduler utilization data)
Reported-by: Steve Muckle <steve.muckle@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

linux-next material.

Please let me know if there are any objections.

---
 drivers/cpufreq/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/Kconfig
===================================================================
--- linux-pm.orig/drivers/cpufreq/Kconfig
+++ linux-pm/drivers/cpufreq/Kconfig
@@ -200,7 +200,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
 
 config CPU_FREQ_GOV_SCHEDUTIL
 	tristate "'schedutil' cpufreq policy governor"
-	depends on CPU_FREQ
+	depends on CPU_FREQ && SMP
 	select CPU_FREQ_GOV_ATTR_SET
 	select IRQ_WORK
 	help

