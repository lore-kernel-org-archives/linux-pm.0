From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/9] cpufreq: governor: Fix nice contribution computation in dbs_check_cpu()
Date: Mon, 15 Feb 2016 02:15:50 +0100
Message-ID: <4591302.DXuxEtjCGY@vostro.rjw.lan>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47940 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751769AbcBOBVN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Feb 2016 20:21:13 -0500
In-Reply-To: <3329748.lhJgppdTt9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The contribution of the CPU nice time to the idle time in dbs_check_cpu()
is computed in a bogus way, as the code may subtract current and previous
nice values for different CPUs.

That doesn't matter for cases when cpufreq policies are not shared,
but may lead to problems otherwise.

Fix the computation and simplify it to avoid taking unnecessary steps.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -198,22 +198,10 @@ void dbs_check_cpu(struct cpufreq_policy
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
-			struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
-			u64 cur_nice;
-			unsigned long cur_nice_jiffies;
+			u64 cur_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 
-			cur_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE] -
-					 cdbs->prev_cpu_nice;
-			/*
-			 * Assumption: nice time between sampling periods will
-			 * be less than 2^32 jiffies for 32 bit sys
-			 */
-			cur_nice_jiffies = (unsigned long)
-					cputime64_to_jiffies64(cur_nice);
-
-			cdbs->prev_cpu_nice =
-				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
-			idle_time += jiffies_to_usecs(cur_nice_jiffies);
+			idle_time += cputime_to_usecs(cur_nice - j_cdbs->prev_cpu_nice);
+			j_cdbs->prev_cpu_nice = cur_nice;
 		}
 
 		if (unlikely(!wall_time || wall_time < idle_time))

