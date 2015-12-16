From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] cpufreq: governor: Fix negative idle_time when configured with CONFIG_HZ_PERIODIC
Date: Wed, 16 Dec 2015 12:20:29 +0800
Message-ID: <007bcbf2c1bced84fe8944eaec191ab1e5919f8e.1450238320.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:32069 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932552AbbLPEPk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Dec 2015 23:15:40 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: lenb@kernel.org, srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

It is reported that, with CONFIG_HZ_PERIODIC=y cpu stays at the
lowest frequency even if the usage goes to 100%, neither ondemand
nor conservative governor works, however performance and
userspace work as expected. If set with CONFIG_NO_HZ_FULL=y,
everything goes well.

This problem is caused by improper calculation of the idle_time
when the load is extremely high(near 100%). Firstly, cpufreq_governor
uses get_cpu_idle_time to get the total idle time for specific cpu, then:

1.If the system is configured with CONFIG_NO_HZ_FULL, the idle time is
  returned by ktime_get, which is always increasing, it's OK.
2.However, if the system is configured with CONFIG_HZ_PERIODIC,
  get_cpu_idle_time might not guarantee to be always increasing,
  because it will leverage get_cpu_idle_time_jiffy to calculate the
  idle_time, consider the following scenario:

At T1:
idle_tick_1 = total_tick_1 - user_tick_1

sample period(80ms)...

At T2: ( T2 = T1 + 80ms):
idle_tick_2 = total_tick_2 - user_tick_2

Currently the algorithm is using (idle_tick_2 - idle_tick_1) to
get the delta idle_time during the past sample period, however
it CAN NOT guarantee that idle_tick_2 >= idle_tick_1, especially
when cpu load is high.
(Yes, total_tick_2 >= total_tick_1, and user_tick_2 >= user_tick_1,
but how about idle_tick_2 and idle_tick_1? No guarantee.)
So governor might get a negative value of idle_time during the past
sample period, which might mislead the system that the idle time is
very big(converted to unsigned int), and the busy time is nearly zero,
which causes the governor to always choose the lowest cpufreq,
then cause this problem.

In theory there are two solutions:

1.The logic should not rely on the idle tick during every sample period,
  but be based on the busy tick directly, as this is how 'top' is
  implemented.

2.Or the logic must make sure that the idle_time is strictly increasing
  during each sample period, then there would be no negative idle_time
  anymore. This solution requires minimum modification to current code
  and this patch uses method 2.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=69821
Reported-by: Jan Fikar <j.fikar@gmail.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index b260576..363445f 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -84,6 +84,9 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 			(cur_wall_time - j_cdbs->prev_cpu_wall);
 		j_cdbs->prev_cpu_wall = cur_wall_time;
 
+		if (cur_idle_time < j_cdbs->prev_cpu_idle)
+			cur_idle_time = j_cdbs->prev_cpu_idle;
+
 		idle_time = (unsigned int)
 			(cur_idle_time - j_cdbs->prev_cpu_idle);
 		j_cdbs->prev_cpu_idle = cur_idle_time;
-- 
1.8.4.2

