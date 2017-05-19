From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH v2 2/2] sched: Make iowait_boost optional in schedutil
Date: Thu, 18 May 2017 23:23:44 -0700
Message-ID: <20170519062344.27692-3-joelaf@google.com>
References: <20170519062344.27692-1-joelaf@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519062344.27692-1-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

We should apply the iowait boost only if cpufreq policy has iowait boost
enabled. Also make it a schedutil configuration from sysfs so it can be turned
on/off if needed (by default initialize it to the policy value).

For systems that don't need/want it enabled, such as those on arm64 based
mobile devices that are battery operated, it saves energy when the cpufreq
driver policy doesn't have it enabled (details below):

Here are some results for energy measurements collected running a YouTube video
for 30 seconds:
Before: 8.042533 mWh
After: 7.948377 mWh
Energy savings is ~1.2%

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/sched/cpufreq_schedutil.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 76877a62b5fa..0e392b58b9b3 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -24,6 +24,7 @@
 struct sugov_tunables {
 	struct gov_attr_set attr_set;
 	unsigned int rate_limit_us;
+	bool iowait_boost_enable;
 };
 
 struct sugov_policy {
@@ -171,6 +172,11 @@ static void sugov_get_util(unsigned long *util, unsigned long *max)
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 				   unsigned int flags)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+
+	if (!sg_policy->tunables->iowait_boost_enable)
+		return;
+
 	if (flags & SCHED_CPUFREQ_IOWAIT) {
 		sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
 	} else if (sg_cpu->iowait_boost) {
@@ -386,10 +392,34 @@ static ssize_t rate_limit_us_store(struct gov_attr_set *attr_set, const char *bu
 	return count;
 }
 
+static ssize_t iowait_boost_enable_show(struct gov_attr_set *attr_set,
+					char *buf)
+{
+	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
+
+	return sprintf(buf, "%u\n", tunables->iowait_boost_enable);
+}
+
+static ssize_t iowait_boost_enable_store(struct gov_attr_set *attr_set,
+					 const char *buf, size_t count)
+{
+	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
+	bool enable;
+
+	if (kstrtobool(buf, &enable))
+		return -EINVAL;
+
+	tunables->iowait_boost_enable = enable;
+
+	return count;
+}
+
 static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
+static struct governor_attr iowait_boost_enable = __ATTR_RW(iowait_boost_enable);
 
 static struct attribute *sugov_attributes[] = {
 	&rate_limit_us.attr,
+	&iowait_boost_enable.attr,
 	NULL
 };
 
@@ -543,6 +573,8 @@ static int sugov_init(struct cpufreq_policy *policy)
 			tunables->rate_limit_us *= lat;
 	}
 
+	tunables->iowait_boost_enable = policy->iowait_boost_enable;
+
 	policy->governor_data = sg_policy;
 	sg_policy->tunables = tunables;
 
-- 
2.13.0.303.g4ebf302169-goog
