From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 5/10] cpufreq: Move governor attribute set headers to cpufreq.h
Date: Fri, 04 Mar 2016 04:05:03 +0100
Message-ID: <5093627.PgPWOgVgsM@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2409306.qzzMXcm4dm@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move definitions and function headers related to struct gov_attr_set
to include/linux/cpufreq.h so they can be used by (future) goverernors
located outside of drivers/cpufreq/.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch.  Needed to move cpufreq_schedutil.c to kernel/sched/.

---
 drivers/cpufreq/cpufreq_governor.h |   21 ---------------------
 include/linux/cpufreq.h            |   23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -41,19 +41,6 @@
 /* Ondemand Sampling types */
 enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
 
-struct gov_attr_set {
-	struct kobject kobj;
-	struct list_head policy_list;
-	struct mutex update_lock;
-	int usage_count;
-};
-
-extern const struct sysfs_ops governor_sysfs_ops;
-
-void gov_attr_set_init(struct gov_attr_set *attr_set, struct list_head *list_node);
-void gov_attr_set_get(struct gov_attr_set *attr_set, struct list_head *list_node);
-unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list_head *list_node);
-
 /*
  * Abbreviations:
  * dbs: used as a shortform for demand based switching It helps to keep variable
@@ -80,14 +67,6 @@ static inline struct dbs_data *to_dbs_da
 	return container_of(attr_set, struct dbs_data, attr_set);
 }
 
-/* Governor's specific attributes */
-struct governor_attr {
-	struct attribute attr;
-	ssize_t (*show)(struct gov_attr_set *attr_set, char *buf);
-	ssize_t (*store)(struct gov_attr_set *attr_set, const char *buf,
-			 size_t count);
-};
-
 #define gov_show_one(_gov, file_name)					\
 static ssize_t show_##file_name						\
 (struct gov_attr_set *attr_set, char *buf)				\
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -462,6 +462,29 @@ void cpufreq_unregister_governor(struct
 struct cpufreq_governor *cpufreq_default_governor(void);
 struct cpufreq_governor *cpufreq_fallback_governor(void);
 
+/* Governor attribute set */
+struct gov_attr_set {
+	struct kobject kobj;
+	struct list_head policy_list;
+	struct mutex update_lock;
+	int usage_count;
+};
+
+/* sysfs ops for cpufreq governors */
+extern const struct sysfs_ops governor_sysfs_ops;
+
+void gov_attr_set_init(struct gov_attr_set *attr_set, struct list_head *list_node);
+void gov_attr_set_get(struct gov_attr_set *attr_set, struct list_head *list_node);
+unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list_head *list_node);
+
+/* Governor sysfs attribute */
+struct governor_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gov_attr_set *attr_set, char *buf);
+	ssize_t (*store)(struct gov_attr_set *attr_set, const char *buf,
+			 size_t count);
+};
+
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
  *********************************************************************/
