From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH v7 2/2] cpufreq: schedutil: Use unsigned int for iowait boost
Date: Sun, 23 Jul 2017 08:54:26 -0700
Message-ID: <20170723155426.9170-2-joelaf@google.com>
References: <20170723155426.9170-1-joelaf@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170723155426.9170-1-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Andres Oportus <andresoportus@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org, Joel Fernandes <joelaf@google.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

Make iowait_boost and iowait_boost_max as unsigned int since its unit is kHz
and this is consistent with struct cpufreq_policy. Also change the local
variables in sugov_iowait_boost to match this.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/sched/cpufreq_schedutil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 570ab6e779e6..7650784eb857 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -54,8 +54,8 @@ struct sugov_cpu {
 	struct sugov_policy *sg_policy;
 
 	bool iowait_boost_pending;
-	unsigned long iowait_boost;
-	unsigned long iowait_boost_max;
+	unsigned int iowait_boost;
+	unsigned int iowait_boost_max;
 	u64 last_update;
 
 	/* The fields below are only needed when sharing a policy. */
@@ -199,7 +199,7 @@ static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
 			       unsigned long *max)
 {
-	unsigned long boost_util, boost_max;
+	unsigned int boost_util, boost_max;
 
 	if (!sg_cpu->iowait_boost)
 		return;
-- 
2.14.0.rc0.284.gd933b75aa4-goog
