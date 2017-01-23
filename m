From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 06/12] PM / OPP: Add 'struct kref' to struct dev_pm_opp
Date: Mon, 23 Jan 2017 10:11:46 +0530
Message-ID: <e5dac5538fda0b9e14ff81a4a1f9969066647b0f.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Add kref to struct dev_pm_opp for easier accounting of the OPPs.

Note that the OPPs are freed under the opp_table->lock mutex only.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 27 ++++++++++++---------------
 drivers/base/power/opp/opp.h  |  3 +++
 include/linux/pm_opp.h        |  3 +++
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index ab9499e3ba02..9870ee54d708 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -949,20 +949,10 @@ static void _kfree_opp_rcu(struct rcu_head *head)
 	kfree_rcu(opp, rcu_head);
 }
 
-/**
- * _opp_remove()  - Remove an OPP from a table definition
- * @opp_table:	points back to the opp_table struct this opp belongs to
- * @opp:	pointer to the OPP to remove
- *
- * This function removes an opp definition from the opp table.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * It is assumed that the caller holds required mutex for an RCU updater
- * strategy.
- */
-static void _opp_remove(struct opp_table *opp_table, struct dev_pm_opp *opp)
+static void _opp_kref_release(struct kref *kref)
 {
-	mutex_lock(&opp_table->lock);
+	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
+	struct opp_table *opp_table = opp->opp_table;
 
 	/*
 	 * Notify the changes in the availability of the operable
@@ -977,6 +967,12 @@ static void _opp_remove(struct opp_table *opp_table, struct dev_pm_opp *opp)
 	dev_pm_opp_put_opp_table(opp_table);
 }
 
+void dev_pm_opp_put(struct dev_pm_opp *opp)
+{
+	kref_put_mutex(&opp->kref, _opp_kref_release, &opp->opp_table->lock);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put);
+
 /**
  * dev_pm_opp_remove()  - Remove an OPP from OPP table
  * @dev:	device for which we do this operation
@@ -1020,7 +1016,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 		goto unlock;
 	}
 
-	_opp_remove(opp_table, opp);
+	dev_pm_opp_put(opp);
 unlock:
 	mutex_unlock(&opp_table_lock);
 }
@@ -1124,6 +1120,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	mutex_unlock(&opp_table->lock);
 
 	new_opp->opp_table = opp_table;
+	kref_init(&new_opp->kref);
 
 	/* Get a reference to the OPP table */
 	_get_opp_table_kref(opp_table);
@@ -1819,7 +1816,7 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
 		/* Free static OPPs */
 		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
 			if (remove_all || !opp->dynamic)
-				_opp_remove(opp_table, opp);
+				dev_pm_opp_put(opp);
 		}
 	} else {
 		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index a01724363347..586f36f94e28 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -16,6 +16,7 @@
 
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/limits.h>
 #include <linux/pm_opp.h>
@@ -56,6 +57,7 @@ extern struct list_head opp_tables;
  *		are protected by the opp_table_lock for integrity.
  *		IMPORTANT: the opp nodes should be maintained in increasing
  *		order.
+ * @kref:	for reference count of the OPP.
  * @available:	true/false - marks if this OPP as available or not
  * @dynamic:	not-created from static DT entries.
  * @turbo:	true if turbo (boost) OPP
@@ -73,6 +75,7 @@ extern struct list_head opp_tables;
  */
 struct dev_pm_opp {
 	struct list_head node;
+	struct kref kref;
 
 	bool available;
 	bool dynamic;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 99787cbcaab2..731d548657aa 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -102,6 +102,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
+void dev_pm_opp_put(struct dev_pm_opp *opp);
 
 int dev_pm_opp_add(struct device *dev, unsigned long freq,
 		   unsigned long u_volt);
@@ -193,6 +194,8 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline void dev_pm_opp_put(struct dev_pm_opp *opp) {}
+
 static inline int dev_pm_opp_add(struct device *dev, unsigned long freq,
 					unsigned long u_volt)
 {
-- 
2.7.1.410.g6faf27b
