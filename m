From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/6] cpufreq: governor: Move abstract gov_tunables code to a seperate file
Date: Wed, 02 Mar 2016 03:10:10 +0100
Message-ID: <5134851.EfvU9zA4LR@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2495375.dFbdlAZmA6@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move abstract code related to struct gov_tunables to a separate (new)
file so it can be shared with (future) goverernors that won't share
more code with "ondemand" and "conservative".

No intentional functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/Kconfig                     |    4 +
 drivers/cpufreq/Makefile                    |    1 
 drivers/cpufreq/cpufreq_governor.c          |   82 ---------------------------
 drivers/cpufreq/cpufreq_governor.h          |    6 ++
 drivers/cpufreq/cpufreq_governor_tunables.c |   84 ++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 82 deletions(-)

Index: linux-pm/drivers/cpufreq/Kconfig
===================================================================
--- linux-pm.orig/drivers/cpufreq/Kconfig
+++ linux-pm/drivers/cpufreq/Kconfig
@@ -18,7 +18,11 @@ config CPU_FREQ
 
 if CPU_FREQ
 
+config CPU_FREQ_GOV_TUNABLES
+	bool
+
 config CPU_FREQ_GOV_COMMON
+	select CPU_FREQ_GOV_TUNABLES
 	select IRQ_WORK
 	bool
 
Index: linux-pm/drivers/cpufreq/Makefile
===================================================================
--- linux-pm.orig/drivers/cpufreq/Makefile
+++ linux-pm/drivers/cpufreq/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+=
 obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+= cpufreq_ondemand.o
 obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
 obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+= cpufreq_governor.o
+obj-$(CONFIG_CPU_FREQ_GOV_TUNABLES)	+= cpufreq_governor_tunables.o
 
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
 
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -111,53 +111,6 @@ void gov_update_cpu_data(struct dbs_data
 }
 EXPORT_SYMBOL_GPL(gov_update_cpu_data);
 
-static inline struct gov_tunables *to_gov_tunables(struct kobject *kobj)
-{
-	return container_of(kobj, struct gov_tunables, kobj);
-}
-
-static inline struct governor_attr *to_gov_attr(struct attribute *attr)
-{
-	return container_of(attr, struct governor_attr, attr);
-}
-
-static ssize_t governor_show(struct kobject *kobj, struct attribute *attr,
-			     char *buf)
-{
-	struct governor_attr *gattr = to_gov_attr(attr);
-
-	return gattr->show(to_gov_tunables(kobj), buf);
-}
-
-static ssize_t governor_store(struct kobject *kobj, struct attribute *attr,
-			      const char *buf, size_t count)
-{
-	struct gov_tunables *gt = to_gov_tunables(kobj);
-	struct governor_attr *gattr = to_gov_attr(attr);
-	int ret = -EBUSY;
-
-	mutex_lock(&gt->update_lock);
-
-	if (gt->usage_count)
-		ret = gattr->store(gt, buf, count);
-
-	mutex_unlock(&gt->update_lock);
-
-	return ret;
-}
-
-/*
- * Sysfs Ops for accessing governor attributes.
- *
- * All show/store invocations for governor specific sysfs attributes, will first
- * call the below show/store callbacks and the attribute specific callback will
- * be called from within it.
- */
-static const struct sysfs_ops governor_sysfs_ops = {
-	.show	= governor_show,
-	.store	= governor_store,
-};
-
 unsigned int dbs_update(struct cpufreq_policy *policy)
 {
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
@@ -424,41 +377,6 @@ static void free_policy_dbs_info(struct
 	gov->free(policy_dbs);
 }
 
-static void gov_tunables_init(struct gov_tunables *gt,
-			      struct list_head *list_node)
-{
-	INIT_LIST_HEAD(&gt->policy_list);
-	mutex_init(&gt->update_lock);
-	gt->usage_count = 1;
-	list_add(list_node, &gt->policy_list);
-}
-
-static void gov_tunables_get(struct gov_tunables *gt,
-			     struct list_head *list_node)
-{
-	mutex_lock(&gt->update_lock);
-	gt->usage_count++;
-	list_add(list_node, &gt->policy_list);
-	mutex_unlock(&gt->update_lock);
-}
-
-static unsigned int gov_tunables_put(struct gov_tunables *gt,
-				     struct list_head *list_node)
-{
-	unsigned int count;
-
-	mutex_lock(&gt->update_lock);
-	list_del(list_node);
-	count = --gt->usage_count;
-	mutex_unlock(&gt->update_lock);
-	if (count)
-		return count;
-
-	kobject_put(&gt->kobj);
-	mutex_destroy(&gt->update_lock);
-	return 0;
-}
-
 static int cpufreq_governor_init(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -48,6 +48,12 @@ struct gov_tunables {
 	int usage_count;
 };
 
+extern const struct sysfs_ops governor_sysfs_ops;
+
+void gov_tunables_init(struct gov_tunables *gt, struct list_head *list_node);
+void gov_tunables_get(struct gov_tunables *gt, struct list_head *list_node);
+unsigned int gov_tunables_put(struct gov_tunables *gt, struct list_head *list_node);
+
 /*
  * Abbreviations:
  * dbs: used as a shortform for demand based switching It helps to keep variable
Index: linux-pm/drivers/cpufreq/cpufreq_governor_tunables.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/cpufreq/cpufreq_governor_tunables.c
@@ -0,0 +1,84 @@
+/*
+ * Abstract code for CPUFreq governor tunables handling.
+ *
+ * Copyright (C) 2016, Intel Corporation
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "cpufreq_governor.h"
+
+static inline struct gov_tunables *to_gov_tunables(struct kobject *kobj)
+{
+	return container_of(kobj, struct gov_tunables, kobj);
+}
+
+static inline struct governor_attr *to_gov_attr(struct attribute *attr)
+{
+	return container_of(attr, struct governor_attr, attr);
+}
+
+static ssize_t governor_show(struct kobject *kobj, struct attribute *attr,
+			     char *buf)
+{
+	struct governor_attr *gattr = to_gov_attr(attr);
+
+	return gattr->show(to_gov_tunables(kobj), buf);
+}
+
+static ssize_t governor_store(struct kobject *kobj, struct attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct gov_tunables *gt = to_gov_tunables(kobj);
+	struct governor_attr *gattr = to_gov_attr(attr);
+	int ret;
+
+	mutex_lock(&gt->update_lock);
+	ret = gt->usage_count ? gattr->store(gt, buf, count) : -EBUSY;
+	mutex_unlock(&gt->update_lock);
+	return ret;
+}
+
+const struct sysfs_ops governor_sysfs_ops = {
+	.show	= governor_show,
+	.store	= governor_store,
+};
+EXPORT_SYMBOL_GPL(governor_sysfs_ops);
+
+void gov_tunables_init(struct gov_tunables *gt, struct list_head *list_node)
+{
+	INIT_LIST_HEAD(&gt->policy_list);
+	mutex_init(&gt->update_lock);
+	gt->usage_count = 1;
+	list_add(list_node, &gt->policy_list);
+}
+EXPORT_SYMBOL_GPL(gov_tunables_init);
+
+void gov_tunables_get(struct gov_tunables *gt, struct list_head *list_node)
+{
+	mutex_lock(&gt->update_lock);
+	gt->usage_count++;
+	list_add(list_node, &gt->policy_list);
+	mutex_unlock(&gt->update_lock);
+}
+EXPORT_SYMBOL_GPL(gov_tunables_get);
+
+unsigned int gov_tunables_put(struct gov_tunables *gt, struct list_head *list_node)
+{
+	unsigned int count;
+
+	mutex_lock(&gt->update_lock);
+	list_del(list_node);
+	count = --gt->usage_count;
+	mutex_unlock(&gt->update_lock);
+	if (count)
+		return count;
+
+	kobject_put(&gt->kobj);
+	mutex_destroy(&gt->update_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gov_tunables_put);
