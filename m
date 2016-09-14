From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/2] cpufreq: Move gov_attr_* macros to cpufreq.h
Date: Wed, 14 Sep 2016 14:19:40 +0530
Message-ID: <fb9af4b5d55912994d369579a51ed0b7bbe5621f.1473842301.git.viresh.kumar@linaro.org>
References: <cover.1473842301.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1473842301.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1473842301.git.viresh.kumar@linaro.org>
References: <cover.1473842301.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mike@android.com, toddpoynor@google.com, kandoiruchi@google.com, juri.lelli@arm.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, john.stultz@linaro.org, amit.pundir@linaro.org
List-Id: linux-pm@vger.kernel.org

These macros can be reused by governors which don't use the common
governor code present in cpufreq_governor.c and should be moved to the
relevant header.

Now that they are getting moved to the right header file, reuse them in
schedutil governor as well (that required rename of show/store
routines).

Also create gov_attr_wo() macro for write-only sysfs files, this will be
used by Interactive governor in a later patch.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.h |  8 --------
 include/linux/cpufreq.h            | 12 ++++++++++++
 kernel/sched/cpufreq_schedutil.c   |  8 ++++----
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index ef1037e9c92b..3196ed9c1c0a 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -70,14 +70,6 @@ static ssize_t show_##file_name						\
 	return sprintf(buf, "%u\n", dbs_data->file_name);		\
 }
 
-#define gov_attr_ro(_name)						\
-static struct governor_attr _name =					\
-__ATTR(_name, 0444, show_##_name, NULL)
-
-#define gov_attr_rw(_name)						\
-static struct governor_attr _name =					\
-__ATTR(_name, 0644, show_##_name, store_##_name)
-
 /* Common to all CPUs of a policy */
 struct policy_dbs_info {
 	struct cpufreq_policy *policy;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 631ba33bbe9f..b65b1d795007 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -539,6 +539,18 @@ struct gov_attr_set {
 	int usage_count;
 };
 
+#define gov_attr_ro(_name)						\
+static struct governor_attr _name =					\
+__ATTR(_name, 0444, show_##_name, NULL)
+
+#define gov_attr_wo(_name)						\
+static struct governor_attr _name =					\
+__ATTR(_name, 0200, NULL, store_##_name)
+
+#define gov_attr_rw(_name)						\
+static struct governor_attr _name =					\
+__ATTR(_name, 0644, show_##_name, store_##_name)
+
 /* sysfs ops for cpufreq governors */
 extern const struct sysfs_ops governor_sysfs_ops;
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 69e06898997d..c67c751944a9 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -321,15 +321,15 @@ static inline struct sugov_tunables *to_sugov_tunables(struct gov_attr_set *attr
 	return container_of(attr_set, struct sugov_tunables, attr_set);
 }
 
-static ssize_t rate_limit_us_show(struct gov_attr_set *attr_set, char *buf)
+static ssize_t show_rate_limit_us(struct gov_attr_set *attr_set, char *buf)
 {
 	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
 
 	return sprintf(buf, "%u\n", tunables->rate_limit_us);
 }
 
-static ssize_t rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf,
-				   size_t count)
+static ssize_t store_rate_limit_us(struct gov_attr_set *attr_set,
+				   const char *buf, size_t count)
 {
 	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
 	struct sugov_policy *sg_policy;
@@ -346,7 +346,7 @@ static ssize_t rate_limit_us_store(struct gov_attr_set *attr_set, const char *bu
 	return count;
 }
 
-static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
+gov_attr_rw(rate_limit_us);
 
 static struct attribute *sugov_attributes[] = {
 	&rate_limit_us.attr,
-- 
2.7.1.410.g6faf27b
