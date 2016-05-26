From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH v2 3/3] cpufreq: schedutil: map raw required frequency to driver frequency
Date: Wed, 25 May 2016 19:53:01 -0700
Message-ID: <1464231181-30741-4-git-send-email-smuckle@linaro.org>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

The slow-path frequency transition path is relatively expensive as it
requires waking up a thread to do work. Should support be added for
remote CPU cpufreq updates that is also expensive since it requires an
IPI. These activities should be avoided if they are not necessary.

To that end, calculate the actual driver-supported frequency required by
the new utilization value in schedutil by using the recently added
cpufreq_driver_resolve_freq callback. If it is the same as the
previously requested driver frequency then there is no need to continue
with the update assuming the cpu frequency limits have not changed. This
will have additional benefits should the semantics of the rate limit be
changed to apply solely to frequency transitions rather than to
frequency calculations in schedutil.

The last raw required frequency is cached. This allows the driver
frequency lookup to be skipped in the event that the new raw required
frequency matches the last one, assuming a frequency update has not been
forced due to limits changing (indicated by a next_freq value of
UINT_MAX, see sugov_should_update_freq).

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 154ae3a51e86..ef73ca4d8d78 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -45,6 +45,8 @@ struct sugov_cpu {
 	struct update_util_data update_util;
 	struct sugov_policy *sg_policy;
 
+	unsigned int cached_raw_freq;
+
 	/* The fields below are only needed when sharing a policy. */
 	unsigned long util;
 	unsigned long max;
@@ -104,7 +106,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
- * @policy: cpufreq policy object to compute the new frequency for.
+ * @sg_cpu: schedutil cpu object to compute the new frequency for.
  * @util: Current CPU utilization.
  * @max: CPU capacity.
  *
@@ -119,14 +121,24 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
  * next_freq = C * curr_freq * util_raw / max
  *
  * Take C = 1.25 for the frequency tipping point at (util / max) = 0.8.
+ *
+ * The lowest driver-supported frequency which is equal or greater than the raw
+ * next_freq (as calculated above) is returned.
  */
-static unsigned int get_next_freq(struct cpufreq_policy *policy,
-				  unsigned long util, unsigned long max)
+static unsigned int get_next_freq(struct sugov_cpu *sg_cpu, unsigned long util,
+				  unsigned long max)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
 
-	return (freq + (freq >> 2)) * util / max;
+	freq = (freq + (freq >> 2)) * util / max;
+
+	if (freq == sg_cpu->cached_raw_freq && sg_policy->next_freq != UINT_MAX)
+		return sg_policy->next_freq;
+	sg_cpu->cached_raw_freq = freq;
+	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
 static void sugov_update_single(struct update_util_data *hook, u64 time,
@@ -141,13 +153,14 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 		return;
 
 	next_f = util == ULONG_MAX ? policy->cpuinfo.max_freq :
-			get_next_freq(policy, util, max);
+			get_next_freq(sg_cpu, util, max);
 	sugov_update_commit(sg_policy, time, next_f);
 }
 
-static unsigned int sugov_next_freq_shared(struct sugov_policy *sg_policy,
+static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 					   unsigned long util, unsigned long max)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int max_f = policy->cpuinfo.max_freq;
 	u64 last_freq_update_time = sg_policy->last_freq_update_time;
@@ -187,7 +200,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_policy *sg_policy,
 		}
 	}
 
-	return get_next_freq(policy, util, max);
+	return get_next_freq(sg_cpu, util, max);
 }
 
 static void sugov_update_shared(struct update_util_data *hook, u64 time,
@@ -204,7 +217,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_policy, util, max);
+		next_f = sugov_next_freq_shared(sg_cpu, util, max);
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
@@ -432,6 +445,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 			sg_cpu->util = ULONG_MAX;
 			sg_cpu->max = 0;
 			sg_cpu->last_update = 0;
+			sg_cpu->cached_raw_freq = 0;
 			cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
 						     sugov_update_shared);
 		} else {
-- 
2.4.10
