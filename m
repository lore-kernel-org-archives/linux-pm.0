From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 06/10] PM / OPP: Rename and split _dev_pm_opp_remove_table()
Date: Mon,  2 Jan 2017 14:41:00 +0530
Message-ID: <126eb7856151107e1ee883bca8a158bf7219f7f6.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Later patches would want to remove OPP table (and its OPPs) using the
opp_table pointer instead of 'dev'.

In order to prepare for that, rename _dev_pm_opp_remove_table() as
_dev_pm_opp_find_and_remove_table() split out part of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 35 ++++++++++++++++++++++-------------
 drivers/base/power/opp/of.c   |  2 +-
 drivers/base/power/opp/opp.h  |  2 +-
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index ea5b90e0882c..b3a624a4af81 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1888,11 +1888,29 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
  * Free OPPs either created using static entries present in DT or even the
  * dynamically added entries based on remove_all param.
  */
-void _dev_pm_opp_remove_table(struct device *dev, bool remove_all)
+static void _dev_pm_opp_remove_table(struct opp_table *opp_table,
+				     struct device *dev, bool remove_all)
 {
-	struct opp_table *opp_table;
 	struct dev_pm_opp *opp, *tmp;
 
+	opp_rcu_lockdep_assert();
+
+	/* Find if opp_table manages a single device */
+	if (list_is_singular(&opp_table->dev_list)) {
+		/* Free static OPPs */
+		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
+			if (remove_all || !opp->dynamic)
+				_opp_remove(opp_table, opp);
+		}
+	} else {
+		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
+	}
+}
+
+void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
+{
+	struct opp_table *opp_table;
+
 	/* Hold our table modification lock here */
 	mutex_lock(&opp_table_lock);
 
@@ -1909,16 +1927,7 @@ void _dev_pm_opp_remove_table(struct device *dev, bool remove_all)
 		goto unlock;
 	}
 
-	/* Find if opp_table manages a single device */
-	if (list_is_singular(&opp_table->dev_list)) {
-		/* Free static OPPs */
-		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
-			if (remove_all || !opp->dynamic)
-				_opp_remove(opp_table, opp);
-		}
-	} else {
-		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
-	}
+	_dev_pm_opp_remove_table(opp_table, dev, remove_all);
 
 unlock:
 	mutex_unlock(&opp_table_lock);
@@ -1939,6 +1948,6 @@ void _dev_pm_opp_remove_table(struct device *dev, bool remove_all)
  */
 void dev_pm_opp_remove_table(struct device *dev)
 {
-	_dev_pm_opp_remove_table(dev, true);
+	_dev_pm_opp_find_and_remove_table(dev, true);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 67c9eeded4e1..442fa46c4f5c 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -238,7 +238,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
  */
 void dev_pm_opp_of_remove_table(struct device *dev)
 {
-	_dev_pm_opp_remove_table(dev, false);
+	_dev_pm_opp_find_and_remove_table(dev, false);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 334f7570df32..c4b539a8533a 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -192,7 +192,7 @@ struct opp_table {
 /* Routines internal to opp core */
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
-void _dev_pm_opp_remove_table(struct device *dev, bool remove_all);
+void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all);
 struct dev_pm_opp *_opp_allocate(struct device *dev, struct opp_table **opp_table);
 void _opp_free(struct dev_pm_opp *opp, struct opp_table *opp_table);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
-- 
2.7.1.410.g6faf27b
