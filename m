From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/7] PM / OPP: Implement of_dev_pm_opp_find_required_opp()
Date: Fri, 22 Dec 2017 12:56:26 +0530
Message-ID: <b9de2027d02bd092049e022c3749f230611c8970.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513926033.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

A device's DT node or its OPP nodes can contain a phandle to other
device's OPP node, in the "required-opp" property.

This patch implements a routine to find that required OPP from the node
that contains the "required-opp" property.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     |  4 +---
 drivers/opp/of.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h      |  1 +
 include/linux/pm_opp.h |  6 ++++++
 4 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 92fa94a6dcc1..bfcad8983fd1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -33,8 +33,6 @@ LIST_HEAD(opp_tables);
 /* Lock to allow exclusive modification to the device and opp lists */
 DEFINE_MUTEX(opp_table_lock);
 
-static void dev_pm_opp_get(struct dev_pm_opp *opp);
-
 static struct opp_device *_find_opp_dev(const struct device *dev,
 					struct opp_table *opp_table)
 {
@@ -892,7 +890,7 @@ static void _opp_kref_release(struct kref *kref)
 	dev_pm_opp_put_opp_table(opp_table);
 }
 
-static void dev_pm_opp_get(struct dev_pm_opp *opp)
+void dev_pm_opp_get(struct dev_pm_opp *opp)
 {
 	kref_get(&opp->kref);
 }
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 22c9bd191f62..2d1bb348ae73 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -665,3 +665,56 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
+
+/**
+ * of_dev_pm_opp_find_required_opp() - Search for required OPP.
+ * @dev: The device whose OPP node is referenced by the 'np' DT node.
+ * @np: Node that contains the "required-opp" property.
+ *
+ * Returns the OPP of the device 'dev', whose phandle is present in the "np"
+ * node.
+ *
+ * Return: Matching opp, else returns ERR_PTR in case of error and should be
+ * handled using IS_ERR.
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev,
+						   struct device_node *np)
+{
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
+	struct device_node *required_np;
+	struct opp_table *opp_table;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return ERR_CAST(opp_table);
+
+	required_np = of_parse_phandle(np, "required-opp", 0);
+	if (unlikely(!required_np)) {
+		dev_err(dev, "Unable to parse required-opp\n");
+		goto put_opp_table;
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available && temp_opp->np == required_np) {
+			opp = temp_opp;
+
+			/* Increment the reference count of OPP */
+			dev_pm_opp_get(opp);
+			break;
+		}
+	}
+
+	mutex_unlock(&opp_table->lock);
+
+	of_node_put(required_np);
+put_opp_table:
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(of_dev_pm_opp_find_required_opp);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 4d00061648a3..b181032e6938 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -187,6 +187,7 @@ struct opp_table {
 };
 
 /* Routines internal to opp core */
+void dev_pm_opp_get(struct dev_pm_opp *opp);
 void _get_opp_table_kref(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index f042fdeaaa3c..70686f434c13 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -309,6 +309,7 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
+struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -342,6 +343,11 @@ static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device
 {
 	return NULL;
 }
+
+static inline struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np)
+{
+	return NULL;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.15.0.194.g9af6a3dea062
