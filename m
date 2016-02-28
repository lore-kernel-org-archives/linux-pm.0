From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Select IRQ_WORK if CPU_FREQ_GOV_COMMON is set
Date: Sun, 28 Feb 2016 02:33:29 +0100
Message-ID: <38362761.gZ1JT20KQT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60776 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S2992634AbcB1BcC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 20:32:02 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 8fb47ff100af (cpufreq: governor: Replace timers with utilization
update callbacks) made CPU_FREQ select IRQ_WORK, but that's not
necessary, as it is sufficient for IRQ_WORK to be selected by
CPU_FREQ_GOV_COMMON, so modify the cpufreq Kconfig to that effect.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of linux-next.

Thanks,
Rafael

---
 drivers/cpufreq/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/Kconfig
===================================================================
--- linux-pm.orig/drivers/cpufreq/Kconfig
+++ linux-pm/drivers/cpufreq/Kconfig
@@ -3,7 +3,6 @@ menu "CPU Frequency scaling"
 config CPU_FREQ
 	bool "CPU Frequency scaling"
 	select SRCU
-	select IRQ_WORK
 	help
 	  CPU Frequency scaling allows you to change the clock speed of 
 	  CPUs on the fly. This is a nice method to save power, because 
@@ -20,6 +19,7 @@ config CPU_FREQ
 if CPU_FREQ
 
 config CPU_FREQ_GOV_COMMON
+	select IRQ_WORK
 	bool
 
 config CPU_FREQ_BOOST_SW

