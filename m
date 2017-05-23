From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH RFC 5/8] sched/cpufreq_schedutil: always consider all CPUs when deciding next freq
Date: Tue, 23 May 2017 09:53:48 +0100
Message-ID: <20170523085351.18586-6-juri.lelli@arm.com>
References: <20170523085351.18586-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523085351.18586-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

No assumption can be made upon the rate at which frequency updates get
triggered, as there are scheduling policies (like SCHED_DEADLINE) which
don't trigger them so frequently.

Remove such assumption from the code, by always considering
SCHED_DEADLINE utilization signal as not stale.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>
---
Changes from RFD
 - discard CFS contribution only as stale (as suggested by Rafael)
---
 kernel/sched/cpufreq_schedutil.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index f930cec4c3d4..688bd11c2641 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -259,17 +259,22 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		s64 delta_ns;
 
 		/*
-		 * If the CPU utilization was last updated before the previous
-		 * frequency update and the time elapsed between the last update
-		 * of the CPU utilization and the last frequency update is long
-		 * enough, don't take the CPU into account as it probably is
-		 * idle now (and clear iowait_boost for it).
+		 * If the CFS CPU utilization was last updated before the
+		 * previous frequency update and the time elapsed between the
+		 * last update of the CPU utilization and the last frequency
+		 * update is long enough, reset iowait_boost and util_cfs, as
+		 * they are now probably stale. However, still consider the
+		 * CPU contribution if it has some DEADLINE utilization
+		 * (util_dl).
 		 */
 		delta_ns = time - j_sg_cpu->last_update;
 		if (delta_ns > TICK_NSEC) {
 			j_sg_cpu->iowait_boost = 0;
-			continue;
+			j_sg_cpu->util_cfs = 0;
+			if (j_sg_cpu->util_dl == 0)
+				continue;
 		}
+
 		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
 			return policy->cpuinfo.max_freq;
 
-- 
2.11.0
