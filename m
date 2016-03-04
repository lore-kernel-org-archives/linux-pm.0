From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 4/10] cpufreq: governor: Move abstract gov_attr_set code to seperate file
Date: Fri, 04 Mar 2016 04:03:12 +0100
Message-ID: <8439076.su0yJP41kh@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48656 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755484AbcCDDfC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 22:35:02 -0500
In-Reply-To: <2409306.qzzMXcm4dm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move abstract code related to struct gov_attr_set to a separate (new)
file so it can be shared with (future) goverernors that won't share
more code with "ondemand" and "conservative".

No intentional functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from the previous version:
- Different name of the new file.
- Different name of the new Kconfig symbol.

---
 drivers/cpufreq/Kconfig                     |    4 +
 drivers/cpufreq/Makefile                    |    1 
 drivers/cpufreq/cpufreq_governor.c          |   82 ---------------------------
 drivers/cpufreq/cpufreq_governor.h          |    6 ++
 drivers/cpufreq/cpufreq_governor_attr_set.c |   84 ++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 82 deletions(-)

Index: linux-pm/drivers/cpufreq/Kconfig
===================================================================
--- linux-pm.orig/drivers/cpufreq/Kconfig
+++ linux-pm/drivers/cpufreq/Kconfig
@@ -18,7 +18,11 @@ config CPU_FREQ
 
 if CPU_FREQ
 
+config CPU_FREQ_GOV_ATTR_SET
+	bool
+
 config CPU_FREQ_GOV_COMMON
+	select CPU_FREQ_GOV_ATTR_SET
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
+obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
 
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
 
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -112,53 +112,6 @@ void gov_update_cpu_data(struct dbs_data
 }
 EXPORT_SYMBOL_GPL(gov_update_cpu_data);
 
-static inline struct gov_attr_set *to_gov_attr_set(struct kobject *kobj)
-{
-	return container_of(kobj, struct gov_attr_set, kobj);
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
-	return gattr->show(to_gov_attr_set(kobj), buf);
-}
-
-static ssize_t governor_store(struct kobject *kobj, struct attribute *attr,
-			      const char *buf, size_t count)
-{
-	struct gov_attr_set *attr_set = to_gov_attr_set(kobj);
-	struct governor_attr *gattr = to_gov_attr(attr);
-	int ret = -EBUSY;
-
-	mutex_lock(&attr_set->update_lock);
-
-	if (attr_set->usage_count)
-		ret = gattr->store(attr_set, buf, count);
-
-	mutex_unlock(&attr_set->update_lock);
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
 
-static void gov_attr_set_init(struct gov_attr_set *attr_set,
-			      struct list_head *list_node)
-{
-	INIT_LIST_HEAD(&attr_set->policy_list);
-	mutex_init(&attr_set->update_lock);
-	attr_set->usage_count = 1;
-	list_add(list_node, &attr_set->policy_list);
-}
-
-static void gov_attr_set_get(struct gov_attr_set *attr_set,
-			     struct list_head *list_node)
-{
-	mutex_lock(&attr_set->update_lock);
-	attr_set->usage_count++;
-	list_add(list_node, &attr_set->policy_list);
-	mutex_unlock(&attr_set->update_lock);
-}
-
-static unsigned int gov_attr_set_put(struct gov_attr_set *attr_set,
-				     struct list_head *list_node)
-{
-	unsigned int count;
-
-	mutex_lock(&attr_set->update_lock);
-	list_del(list_node);
-	count = --attr_set->usage_count;
-	mutex_unlock(&attr_set->update_lock);
-	if (count)
-		return count;
-
-	kobject_put(&attr_set->kobj);
-	mutex_destroy(&attr_set->update_lock);
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
@@ -48,6 +48,12 @@ struct gov_attr_set {
 	int usage_count;
 };
 
+extern const struct sysfs_ops governor_sysfs_ops;
+
+void gov_attr_set_init(struct gov_attr_set *attr_set, struct list_head *list_node);
+void gov_attr_set_get(struct gov_attr_set *attr_set, struct list_head *list_node);
+unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list_head *list_node);
+
 /*
  * Abbreviations:
  * dbs: used as a shortform for demand based switching It helps to keep variable
Index: linux-pm/drivers/cpufreq/cpufreq_governor_attr_set.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/cpufreq/cpufreq_governor_attr_set.c
@@ -0,0 +1,84 @@
+/*
+ * Abstract code for CPUFreq governor tunable sysfs attributes.
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
+static inline struct gov_attr_set *to_gov_attr_set(struct kobject *kobj)
+{
+	return container_of(kobj, struct gov_attr_set, kobj);
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
+	return gattr->show(to_gov_attr_set(kobj), buf);
+}
+
+static ssize_t governor_store(struct kobject *kobj, struct attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct gov_attr_set *attr_set = to_gov_attr_set(kobj);
+	struct governor_attr *gattr = to_gov_attr(attr);
+	int ret;
+
+	mutex_lock(&attr_set->update_lock);
+	ret = attr_set->usage_count ? gattr->store(attr_set, buf, count) : -EBUSY;
+	mutex_unlock(&attr_set->update_lock);
+	return ret;
+}
+
+const struct sysfs_ops governor_sysfs_ops = {
+	.show	= governor_show,
+	.store	= governor_store,
+};
+EXPORT_SYMBOL_GPL(governor_sysfs_ops);
+
+void gov_attr_set_init(struct gov_attr_set *attr_set, struct list_head *list_node)
+{
+	INIT_LIST_HEAD(&attr_set->policy_list);
+	mutex_init(&attr_set->update_lock);
+	attr_set->usage_count = 1;
+	list_add(list_node, &attr_set->policy_list);
+}
+EXPORT_SYMBOL_GPL(gov_attr_set_init);
+
+void gov_attr_set_get(struct gov_attr_set *attr_set, struct list_head *list_node)
+{
+	mutex_lock(&attr_set->update_lock);
+	attr_set->usage_count++;
+	list_add(list_node, &attr_set->policy_list);
+	mutex_unlock(&attr_set->update_lock);
+}
+EXPORT_SYMBOL_GPL(gov_attr_set_get);
+
+unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list_head *list_node)
+{
+	unsigned int count;
+
+	mutex_lock(&attr_set->update_lock);
+	list_del(list_node);
+	count = --attr_set->usage_count;
+	mutex_unlock(&attr_set->update_lock);
+	if (count)
+		return count;
+
+	kobject_put(&attr_set->kobj);
+	mutex_destroy(&attr_set->update_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gov_attr_set_put);

