From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 3/7] OPP: Add dev_pm_opp_xlate_performance_state() helper
Date: Fri, 14 Dec 2018 15:45:29 +0530
Message-ID: <135e59ab6353cc086b15ef96e2882aaec08e3322.1544782279.git.viresh.kumar@linaro.org>
References: <cover.1544782279.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544782279.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, rnayak@codeaurora.org, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

dev_pm_genpd_set_performance_state() needs to handle performance state
propagation going forward. Currently this routine only gets the required
performance state of the device's genpd as an argument, but it doesn't
know how to translate that to master genpd(s) of the device's genpd.

Introduce a new helper dev_pm_opp_xlate_performance_state() which will
be used to translate from performance state of a device (or genpd
sub-domain) to another device (or master genpd).

Normally the src_table (of genpd sub-domain) will have the
"required_opps" property set to point to one of the OPPs in the
dst_table (of master genpd), but in some cases the genpd and its master
have one to one mapping of performance states and so none of them have
the "required-opps" property set. Return the performance state of the
src_table as it is in such cases.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 63 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  7 +++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 98e60f0ed8b0..e5507add8f04 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1713,6 +1713,69 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
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
+ * Return: Zero or positive performance state on success, otherwise negative
+ * value on errors.
+ */
+int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
+				       struct opp_table *dst_table,
+				       unsigned int pstate)
+{
+	struct dev_pm_opp *opp;
+	int dest_pstate = -EINVAL;
+	int i;
+
+	if (!pstate)
+		return 0;
+
+	/*
+	 * Normally the src_table will have the "required_opps" property set to
+	 * point to one of the OPPs in the dst_table, but in some cases the
+	 * genpd and its master have one to one mapping of performance states
+	 * and so none of them have the "required-opps" property set. Return the
+	 * pstate of the src_table as it is in such cases.
+	 */
+	if (!src_table->required_opp_count)
+		return pstate;
+
+	for (i = 0; i < src_table->required_opp_count; i++) {
+		if (src_table->required_opp_tables[i]->np == dst_table->np)
+			break;
+	}
+
+	if (unlikely(i == src_table->required_opp_count)) {
+		pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
+		       __func__, src_table, dst_table);
+		return -EINVAL;
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
index 2b2c3fd985ab..0b04c2093eb9 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -128,6 +128,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*s
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
 void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
+int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -280,6 +281,12 @@ static inline struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev
 }
 
 static inline void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev) {}
+
+static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
+{
+	return -ENOTSUPP;
+}
+
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	return -ENOTSUPP;
-- 
2.19.1.568.g152ad8e3369a
