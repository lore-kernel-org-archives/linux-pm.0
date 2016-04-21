From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] Revert "cpufreq: governor: Fix negative idle_time when configured with CONFIG_HZ_PERIODIC"
Date: Thu, 21 Apr 2016 20:57:47 +0200
Message-ID: <8912976.5IbnMFmJ9d@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56389 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753331AbcDUSzJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 14:55:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>, Timo Valtoaho <timo.valtoaho@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Revert commit 0df35026c6a5 (cpufreq: governor: Fix negative idle_time
when configured with CONFIG_HZ_PERIODIC) that introduced a regression
by causing the ondemand cpufreq governor to misbehave for
CONFIG_TICK_CPU_ACCOUNTING unset (the frequency goes up to the max at
one point and stays there indefinitely).

The revert takes subsequent modifications of the code in question into
account.

Fixes: 0df35026c6a5 (cpufreq: governor: Fix negative idle_time when configured with CONFIG_HZ_PERIODIC)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=115261
Reported-and-tested-by: Timo Valtoaho <timo.valtoaho@gmail.com>
Cc: 4.5+ <stable@vger.kernel.org> # 4.5+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -146,12 +146,8 @@ unsigned int dbs_update(struct cpufreq_p
 		wall_time = cur_wall_time - j_cdbs->prev_cpu_wall;
 		j_cdbs->prev_cpu_wall = cur_wall_time;
 
-		if (cur_idle_time <= j_cdbs->prev_cpu_idle) {
-			idle_time = 0;
-		} else {
-			idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
-			j_cdbs->prev_cpu_idle = cur_idle_time;
-		}
+		idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
+		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
 			u64 cur_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];

