From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: Move gov_attr_* macros to cpufreq.h
Date: Fri, 20 May 2016 12:09:36 +0530
Message-ID: <ebf41116d27a807e9344dbb0ab8836828fa0dc20.1463723328.git.viresh.kumar@linaro.org>
References: <cover.1463723328.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36515 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbcETGkP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 02:40:15 -0400
Received: by mail-pa0-f42.google.com with SMTP id bt5so36572483pac.3
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 23:40:15 -0700 (PDT)
In-Reply-To: <cover.1463723328.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1463723328.git.viresh.kumar@linaro.org>
References: <cover.1463723328.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rostedt@goodmis.org, mike@android.com, toddpoynor@google.com, linux-kernel@vger.kernel.org, kandoiruchi@google.com, juri.lelli@arm.com, steve.muckle@linaro.org, vincent.guittot@linaro.org

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
index fbd696edf5bd..533490cd046d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -504,6 +504,18 @@ struct gov_attr_set {
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
index 758efd7f3abe..cc77ce18e52c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -243,15 +243,15 @@ static inline struct sugov_tunables *to_sugov_tunables(struct gov_attr_set *attr
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
@@ -268,7 +268,7 @@ static ssize_t rate_limit_us_store(struct gov_attr_set *attr_set, const char *bu
 	return count;
 }
 
-static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
+gov_attr_rw(rate_limit_us);
 
 static struct attribute *sugov_attributes[] = {
 	&rate_limit_us.attr,
-- 
2.7.1.410.g6faf27b

