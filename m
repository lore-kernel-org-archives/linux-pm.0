From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
Date: Mon,  5 Nov 2018 12:06:43 +0530
Message-ID: <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1541399301.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, niklas.cassel@linaro.org, rnayak@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Introduce a new helper dev_pm_opp_xlate_performance_state() which will
be used to translate from pstate of a device to another one.

Initially this will be used by genpd to find pstate of a master domain
using its sub-domain's pstate.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  7 ++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0eaa954b3f6c..010a4268e8dd 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1707,6 +1707,55 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
 		dev_err(virt_dev, "Failed to find required device entry\n");
 }
 
+/**
+ * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
+ * @src_table: OPP table which has dst_table as one of its required OPP table.
+ * @dst_table: Required OPP table of the src_table.
+ * @pstate: Current performance state of the src_table.
+ *
+ * This Returns pstate of the OPP (present in @dst_table) pointed out by the
+ * "required-opps" property of the OPP (present in @src_table) which has
+ * performance state set to @pstate.
+ *
+ * Return: Positive performance state on success, otherwise 0 on errors.
+ */
+unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
+						struct opp_table *dst_table,
+						unsigned int pstate)
+{
+	struct dev_pm_opp *opp;
+	unsigned int dest_pstate = 0;
+	int i;
+
+	for (i = 0; i < src_table->required_opp_count; i++) {
+		if (src_table->required_opp_tables[i] == dst_table)
+			break;
+	}
+
+	if (unlikely(i == src_table->required_opp_count)) {
+		pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
+		       __func__, src_table, dst_table);
+		return 0;
+	}
+
+	mutex_lock(&src_table->lock);
+
+	list_for_each_entry(opp, &src_table->opp_list, node) {
+		if (opp->pstate == pstate) {
+			dest_pstate = opp->required_opps[i]->pstate;
+			goto unlock;
+		}
+	}
+
+	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
+	       dst_table);
+
+unlock:
+	mutex_unlock(&src_table->lock);
+
+	return dest_pstate;
+}
+
 /**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
  * @dev:	device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 2b2c3fd985ab..5a64a81a1789 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -128,6 +128,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*s
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
 void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
+unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -280,6 +281,12 @@ static inline struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev
 }
 
 static inline void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev) {}
+
+static inline unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
+{
+	return 0;
+}
+
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	return -ENOTSUPP;
-- 
2.19.1.568.g152ad8e3369a
