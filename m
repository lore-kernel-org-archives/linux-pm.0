From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Rename dev_pm_opp_register_put_opp_helper()
Date: Thu,  5 Oct 2017 17:26:21 +0530
Message-ID: <0d69b3a1e8b565815c1f5a77f5622b524f6f7d35.1507204552.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The routine is named incorrectly since the first attempt as there is
nothing like a put_opp() helper. We wanted to unregister the set_opp()
helper here and so it should rather be named as
dev_pm_opp_unregister_set_opp_helper().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 6 +++---
 include/linux/pm_opp.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a6de32530693..7b6e83f0268a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1476,13 +1476,13 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_register_set_opp_helper);
 
 /**
- * dev_pm_opp_register_put_opp_helper() - Releases resources blocked for
+ * dev_pm_opp_unregister_set_opp_helper() - Releases resources blocked for
  *					   set_opp helper
  * @opp_table: OPP table returned from dev_pm_opp_register_set_opp_helper().
  *
  * Release resources blocked for platform specific set_opp helper.
  */
-void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table)
+void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
 {
 	if (!opp_table->set_opp) {
 		pr_err("%s: Doesn't have custom set_opp helper set\n",
@@ -1497,7 +1497,7 @@ void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table)
 
 	dev_pm_opp_put_opp_table(opp_table);
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_register_put_opp_helper);
+EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
 
 /**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 51ec727b4824..849d21dc4ca7 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -124,7 +124,7 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
-void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table);
+void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -243,7 +243,7 @@ static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device
 	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table) {}
+static inline void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table) {}
 
 static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
-- 
2.14.1.202.g24db08a6e8fe
