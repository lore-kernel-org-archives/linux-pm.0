From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/6] cpufreq: Reuse gov_attr_* macros in schedutil governor
Date: Wed, 18 May 2016 17:55:30 +0530
Message-ID: <8db591e521218af3c4b21ccc0d50606bfbde106b.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33383 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbcERMZy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 08:25:54 -0400
Received: by mail-pa0-f42.google.com with SMTP id xk12so17579432pac.0
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2016 05:25:54 -0700 (PDT)
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

These macros can be used by governors which don't use the common
governor code present in cpufreq_governor.c and should be moved to the
relevant header.

Now that they are getting moved to the right header file, reuse them in
schedutil governor as well (that required rename of show/store
routines).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.h | 8 --------
 include/linux/cpufreq.h            | 8 ++++++++
 kernel/sched/cpufreq_schedutil.c   | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 34eb214b6d57..e2bc5281d3b7 100644
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
index 4e81e08db752..fe4c48b0fa40 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -501,6 +501,14 @@ struct gov_attr_set {
 	int usage_count;
 };
 
+#define gov_attr_ro(_name)						\
+static struct governor_attr _name =					\
+__ATTR(_name, 0444, show_##_name, NULL)
+
+#define gov_attr_rw(_name)						\
+static struct governor_attr _name =					\
+__ATTR(_name, 0644, show_##_name, store_##_name)
+
 /* sysfs ops for cpufreq governors */
 extern const struct sysfs_ops governor_sysfs_ops;
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 14c4aa25cc45..4035765deafc 100644
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

