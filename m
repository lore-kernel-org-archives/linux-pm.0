From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/11] OPP: Pass index to _of_init_opp_table()
Date: Wed, 12 Sep 2018 13:58:42 +0530
Message-ID: <ea0a5ea29296d192efa4599e12a9aa432fdaa2d6.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is a preparatory patch required for the next commit which will
start using OPP table's node pointer in _of_init_opp_table(), which
requires the index in order to read the OPP table's phandle.

This commit adds the index argument in the call chains in order to get
it delivered to _of_init_opp_table().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 19 +++++++++++++++----
 drivers/opp/of.c       | 12 +++++++-----
 drivers/opp/opp.h      |  4 ++--
 include/linux/pm_opp.h |  6 ++++++
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9f8aa31265fe..332748adc262 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -785,7 +785,7 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	return opp_dev;
 }
 
-static struct opp_table *_allocate_opp_table(struct device *dev)
+static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
 	struct opp_device *opp_dev;
@@ -808,7 +808,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev)
 		return NULL;
 	}
 
-	_of_init_opp_table(opp_table, dev);
+	_of_init_opp_table(opp_table, dev, index);
 
 	/* Find clk for the device */
 	opp_table->clk = clk_get(dev, NULL);
@@ -833,7 +833,7 @@ void _get_opp_table_kref(struct opp_table *opp_table)
 	kref_get(&opp_table->kref);
 }
 
-struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
+static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
 
@@ -844,15 +844,26 @@ struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 	if (!IS_ERR(opp_table))
 		goto unlock;
 
-	opp_table = _allocate_opp_table(dev);
+	opp_table = _allocate_opp_table(dev, index);
 
 unlock:
 	mutex_unlock(&opp_table_lock);
 
 	return opp_table;
 }
+
+struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
+{
+	return _opp_get_opp_table(dev, 0);
+}
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_table);
 
+struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev,
+						   int index)
+{
+	return _opp_get_opp_table(dev, index);
+}
+
 static void _opp_table_kref_release(struct kref *kref)
 {
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 20988c426650..a91857d163b2 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -52,7 +52,8 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 	return managed_table;
 }
 
-void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
+void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
+			int index)
 {
 	struct device_node *np;
 
@@ -378,7 +379,8 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 }
 
 /* Initializes OPP tables based on new bindings */
-static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
+static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
+				int index)
 {
 	struct device_node *np;
 	struct opp_table *opp_table;
@@ -393,7 +395,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		goto put_opp_table;
 	}
 
-	opp_table = dev_pm_opp_get_opp_table(dev);
+	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
 	if (!opp_table)
 		return -ENOMEM;
 
@@ -526,7 +528,7 @@ int dev_pm_opp_of_add_table(struct device *dev)
 		return _of_add_opp_table_v1(dev);
 	}
 
-	ret = _of_add_opp_table_v2(dev, opp_np);
+	ret = _of_add_opp_table_v2(dev, opp_np, 0);
 	of_node_put(opp_np);
 
 	return ret;
@@ -574,7 +576,7 @@ int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 		return -ENODEV;
 	}
 
-	ret = _of_add_opp_table_v2(dev, opp_np);
+	ret = _of_add_opp_table_v2(dev, opp_np, index);
 	of_node_put(opp_np);
 
 	return ret;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e0866b1c1f1b..84aba19531b8 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -200,9 +200,9 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of);
 struct opp_table *_add_opp_table(struct device *dev);
 
 #ifdef CONFIG_OF
-void _of_init_opp_table(struct opp_table *opp_table, struct device *dev);
+void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
 #else
-static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev) {}
+static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
 #endif
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 099b31960dec..5d399eeef172 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -79,6 +79,7 @@ struct dev_pm_set_opp_data {
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
+struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev, int index);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
@@ -136,6 +137,11 @@ static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev, int index)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
 
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
-- 
2.18.0.rc1.242.g61856ae69a2c
