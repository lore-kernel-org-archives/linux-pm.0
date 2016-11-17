From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: schedutil: add up/down frequency transition rate limits
Date: Thu, 17 Nov 2016 10:48:45 +0530
Message-ID: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34203 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbcKQFVl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 00:21:41 -0500
Received: by mail-pf0-f179.google.com with SMTP id c4so35235740pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2016 21:21:41 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Viresh Kumar <viresh.kumar@linaro.org>

From: Steve Muckle <smuckle.linux@gmail.com>

The rate-limit tunable in the schedutil governor applies to transitions
to both lower and higher frequencies. On several platforms it is not the
ideal tunable though, as it is difficult to get best power/performance
figures using the same limit in both directions.

It is common on mobile platforms with demanding user interfaces to want
to increase frequency rapidly for example but decrease slowly.

One of the example can be a case where we have short busy periods
followed by similar or longer idle periods. If we keep the rate-limit
high enough, we will not go to higher frequencies soon enough. On the
other hand, if we keep it too low, we will have too many frequency
transitions, as we will always reduce the frequency after the busy
period.

It would be very useful if we can set low rate-limit while increasing
the frequency (so that we can respond to the short busy periods quickly)
and high rate-limit while decreasing frequency (so that we don't reduce
the frequency immediately after the short busy period and that may avoid
frequency transitions before the next busy period).

Implement separate up/down transition rate limits. Note that the
governor avoids frequency recalculations for a period equal to minimum
of up and down rate-limit. A global mutex is also defined to protect
updates to min_rate_limit_us via two separate sysfs files.

Note that this wouldn't change behavior of the schedutil governor for
the platforms which wish to keep same values for both up and down rate
limits.

This is tested with the rt-app [1] on ARM Exynos, dual A15 processor
platform.

Testcase: Run a SCHED_OTHER thread on CPU0 which will emulate work-load
for X ms of busy period out of the total period of Y ms, i.e. Y - X ms
of idle period. The values of X/Y taken were: 20/40, 20/50, 20/70, i.e
idle periods of 20, 30 and 50 ms respectively. These were tested against
values of up/down rate limits as: 10/10 ms and 10/40 ms.

For every test we noticed a performance increase of 5-10% with the
schedutil governor, which was very much expected.

[Viresh]: Simplified user interface and introduced min_rate_limit_us +
	      mutex, rewrote commit log and included test results.

[1] https://github.com/scheduler-tools/rt-app/

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 106 +++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 42a220e78f00..7fae0dbfe4bd 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -22,7 +22,8 @@
 
 struct sugov_tunables {
 	struct gov_attr_set attr_set;
-	unsigned int rate_limit_us;
+	unsigned int up_rate_limit_us;
+	unsigned int down_rate_limit_us;
 };
 
 struct sugov_policy {
@@ -33,7 +34,9 @@ struct sugov_policy {
 
 	raw_spinlock_t update_lock;  /* For shared policies */
 	u64 last_freq_update_time;
-	s64 freq_update_delay_ns;
+	s64 min_rate_limit_ns;
+	s64 up_rate_delay_ns;
+	s64 down_rate_delay_ns;
 	unsigned int next_freq;
 
 	/* The next fields are only needed if fast switch cannot be used. */
@@ -84,7 +87,27 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	}
 
 	delta_ns = time - sg_policy->last_freq_update_time;
-	return delta_ns >= sg_policy->freq_update_delay_ns;
+
+	/* No need to recalculate next freq for min_rate_limit_us at least */
+	return delta_ns >= sg_policy->min_rate_limit_ns;
+}
+
+static bool sugov_up_down_rate_limit(struct sugov_policy *sg_policy, u64 time,
+				     unsigned int next_freq)
+{
+	s64 delta_ns;
+
+	delta_ns = time - sg_policy->last_freq_update_time;
+
+	if (next_freq > sg_policy->next_freq &&
+	    delta_ns < sg_policy->up_rate_delay_ns)
+			return true;
+
+	if (next_freq < sg_policy->next_freq &&
+	    delta_ns < sg_policy->down_rate_delay_ns)
+			return true;
+
+	return false;
 }
 
 static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
@@ -92,6 +115,9 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
 
+	if (sugov_up_down_rate_limit(sg_policy, time, next_freq))
+		return;
+
 	sg_policy->last_freq_update_time = time;
 
 	if (policy->fast_switch_enabled) {
@@ -340,15 +366,32 @@ static inline struct sugov_tunables *to_sugov_tunables(struct gov_attr_set *attr
 	return container_of(attr_set, struct sugov_tunables, attr_set);
 }
 
-static ssize_t rate_limit_us_show(struct gov_attr_set *attr_set, char *buf)
+static DEFINE_MUTEX(min_rate_lock);
+
+static void update_min_rate_limit_us(struct sugov_policy *sg_policy)
+{
+	mutex_lock(&min_rate_lock);
+	sg_policy->min_rate_limit_ns = min(sg_policy->up_rate_delay_ns,
+					   sg_policy->down_rate_delay_ns);
+	mutex_unlock(&min_rate_lock);
+}
+
+static ssize_t up_rate_limit_us_show(struct gov_attr_set *attr_set, char *buf)
+{
+	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
+
+	return sprintf(buf, "%u\n", tunables->up_rate_limit_us);
+}
+
+static ssize_t down_rate_limit_us_show(struct gov_attr_set *attr_set, char *buf)
 {
 	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
 
-	return sprintf(buf, "%u\n", tunables->rate_limit_us);
+	return sprintf(buf, "%u\n", tunables->down_rate_limit_us);
 }
 
-static ssize_t rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf,
-				   size_t count)
+static ssize_t up_rate_limit_us_store(struct gov_attr_set *attr_set,
+				      const char *buf, size_t count)
 {
 	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
 	struct sugov_policy *sg_policy;
@@ -357,18 +400,42 @@ static ssize_t rate_limit_us_store(struct gov_attr_set *attr_set, const char *bu
 	if (kstrtouint(buf, 10, &rate_limit_us))
 		return -EINVAL;
 
-	tunables->rate_limit_us = rate_limit_us;
+	tunables->up_rate_limit_us = rate_limit_us;
 
-	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
-		sg_policy->freq_update_delay_ns = rate_limit_us * NSEC_PER_USEC;
+	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook) {
+		sg_policy->up_rate_delay_ns = rate_limit_us * NSEC_PER_USEC;
+		update_min_rate_limit_us(sg_policy);
+	}
 
 	return count;
 }
 
-static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
+static ssize_t down_rate_limit_us_store(struct gov_attr_set *attr_set,
+					const char *buf, size_t count)
+{
+	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
+	struct sugov_policy *sg_policy;
+	unsigned int rate_limit_us;
+
+	if (kstrtouint(buf, 10, &rate_limit_us))
+		return -EINVAL;
+
+	tunables->down_rate_limit_us = rate_limit_us;
+
+	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook) {
+		sg_policy->down_rate_delay_ns = rate_limit_us * NSEC_PER_USEC;
+		update_min_rate_limit_us(sg_policy);
+	}
+
+	return count;
+}
+
+static struct governor_attr up_rate_limit_us = __ATTR_RW(up_rate_limit_us);
+static struct governor_attr down_rate_limit_us = __ATTR_RW(down_rate_limit_us);
 
 static struct attribute *sugov_attributes[] = {
-	&rate_limit_us.attr,
+	&up_rate_limit_us.attr,
+	&down_rate_limit_us.attr,
 	NULL
 };
 
@@ -512,10 +579,13 @@ static int sugov_init(struct cpufreq_policy *policy)
 		goto stop_kthread;
 	}
 
-	tunables->rate_limit_us = LATENCY_MULTIPLIER;
+	tunables->up_rate_limit_us = LATENCY_MULTIPLIER;
+	tunables->down_rate_limit_us = LATENCY_MULTIPLIER;
 	lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
-	if (lat)
-		tunables->rate_limit_us *= lat;
+	if (lat) {
+		tunables->up_rate_limit_us *= lat;
+		tunables->down_rate_limit_us *= lat;
+	}
 
 	policy->governor_data = sg_policy;
 	sg_policy->tunables = tunables;
@@ -574,7 +644,11 @@ static int sugov_start(struct cpufreq_policy *policy)
 	struct sugov_policy *sg_policy = policy->governor_data;
 	unsigned int cpu;
 
-	sg_policy->freq_update_delay_ns = sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
+	sg_policy->up_rate_delay_ns =
+		sg_policy->tunables->up_rate_limit_us * NSEC_PER_USEC;
+	sg_policy->down_rate_delay_ns =
+		sg_policy->tunables->down_rate_limit_us * NSEC_PER_USEC;
+	update_min_rate_limit_us(sg_policy);
 	sg_policy->last_freq_update_time = 0;
 	sg_policy->next_freq = UINT_MAX;
 	sg_policy->work_in_progress = false;
-- 
2.7.1.410.g6faf27b

