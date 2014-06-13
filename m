From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: cpufreq-cpu0: fix CPU_THERMAL dependency
Date: Fri, 13 Jun 2014 10:40:32 +0200
Message-ID: <9629532.nBvvttN1Sz@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58724 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbaFMIki (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jun 2014 04:40:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

5fbfbcd3e842d ("cpufreq: cpufreq-cpu0: remove dependency on THERMAL and
REGULATOR") was a little too quick in completely removing the dependency
on the THERMAL driver.

The problem is that while there are inline wrappers to turn the thermal
API calls into empty functions, those do not help if the cpu-thermal
driver is a loadable module and cpufreq-cpu0 is builtin.

Since CONFIG_CPU_THERMAL is a bool option that decides whether the cpu
code is built into the thermal module or not, we have to use a dependency
on the thermal driver itself. However, if CPU_THERMAL is disabled, we
don't need the dependency, hence the strange '!CPU_THERMAL || THERMAL'
construct.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index e473d65..ffe350f 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -186,6 +186,8 @@ config CPU_FREQ_GOV_CONSERVATIVE
 config GENERIC_CPUFREQ_CPU0
 	tristate "Generic CPU0 cpufreq driver"
 	depends on HAVE_CLK && OF
+	# if CPU_THERMAL is on and THERMAL=m, CPU0 cannot be =y:
+	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This adds a generic cpufreq driver for CPU0 frequency management.

