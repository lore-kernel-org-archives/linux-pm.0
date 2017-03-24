From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFD PATCH 4/5] sched/cpufreq_schedutil: always consider all CPUs when deciding next freq
Date: Fri, 24 Mar 2017 14:08:59 +0000
Message-ID: <20170324140900.7334-5-juri.lelli@arm.com>
References: <20170324140900.7334-1-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935011AbdCXOJd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 10:09:33 -0400
In-Reply-To: <20170324140900.7334-1-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

No assumption can be made upon the rate at which frequency updates get
triggered, as there are scheduling policies (like SCHED_DEADLINE) which
don't trigger them so frequently.

Remove such assumption from the code.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>
---
 kernel/sched/cpufreq_schedutil.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index da67a1cf91e7..40f30373b709 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -233,14 +233,13 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu)
 		 * If the CPU utilization was last updated before the previous
 		 * frequency update and the time elapsed between the last update
 		 * of the CPU utilization and the last frequency update is long
-		 * enough, don't take the CPU into account as it probably is
-		 * idle now (and clear iowait_boost for it).
+		 * enough, reset iowait_boost, as it probably is not boosted
+		 * anymore now.
 		 */
 		delta_ns = last_freq_update_time - j_sg_cpu->last_update;
-		if (delta_ns > TICK_NSEC) {
+		if (delta_ns > TICK_NSEC)
 			j_sg_cpu->iowait_boost = 0;
-			continue;
-		}
+
 		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
 			return policy->cpuinfo.max_freq;
 
-- 
2.10.0
