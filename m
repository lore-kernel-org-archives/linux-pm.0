From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V10 3/7] PM / Domains: Catch missing genpd_set_performance_state() in masters
Date: Tue, 19 Sep 2017 15:32:19 -0700
Message-ID: <e21f911f06b7ef0a462e0255ba40291bc4973c84.1505859768.git.viresh.kumar@linaro.org>
References: <cover.1505859768.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1505859768.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1505859768.git.viresh.kumar@linaro.org>
References: <cover.1505859768.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch catches the cases where dev_get_performance_state() callback
is implemented for a genpd, but none of its masters or their masters
(and so on) have implemented genpd_set_performance_state() callback.

The internal performance state routines don't return 0 anymore for
success, rather they return count of the domains whose performance state
is updated and the top level routine checks for that.

A zero value there would indicate that the genpd_set_performance_state()
callbacks are missing in the master hierarchy of the device.

This adds very little burden on the API and can be pretty useful.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
Note that similar checks aren't present in other APIs in genpd, like
genpd_power_on/off(). Maybe we should add some there as well?
---
 drivers/base/power/domain.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6d05c91cf44f..7e00b817abc7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -264,13 +264,13 @@ EXPORT_SYMBOL_GPL(dev_pm_genpd_has_performance_state);
 static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 					   int state, int depth);
 
-/* Returns -ve errors or 0 on success */
+/* Returns -ve errors or number of domains whose performance is set */
 static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 					int state, int depth)
 {
 	struct generic_pm_domain *master;
 	struct gpd_link *link;
-	int prev = genpd->performance_state, ret;
+	int prev = genpd->performance_state, ret, count = 0;
 
 	/* Propagate to masters of genpd */
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
@@ -280,19 +280,23 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 
 		link->performance_state = state;
 		ret = _genpd_reeval_performance_state(master, state, depth + 1);
-		if (ret)
+		if (ret < 0)
 			link->performance_state = prev;
 
 		genpd_unlock(master);
 
-		if (ret)
+		if (ret < 0)
 			goto err;
+
+		count += ret;
 	}
 
 	if (genpd->genpd_set_performance_state) {
 		ret = genpd->genpd_set_performance_state(genpd, state);
 		if (ret)
 			goto err;
+
+		count++;
 	}
 
 	/*
@@ -300,7 +304,7 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 	 * with those.
 	 */
 	genpd->performance_state = state;
-	return 0;
+	return count;
 
 err:
 	/* Encountered an error, lets rollback */
@@ -310,7 +314,7 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 
 		genpd_lock_nested(master, depth + 1);
 		link->performance_state = prev;
-		if (_genpd_reeval_performance_state(master, prev, depth + 1)) {
+		if (_genpd_reeval_performance_state(master, prev, depth + 1) < 0) {
 			pr_err("%s: Failed to roll back to %d performance state\n",
 			       master->name, prev);
 		}
@@ -345,7 +349,7 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
  * - The locks are always taken in bottom->up order, i.e. subdomain first,
  *   followed by its masters.
  *
- * Returns -ve errors or 0 on success.
+ * Returns -ve errors or number of domains whose performance is set.
  */
 static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 					   int state, int depth)
@@ -354,9 +358,14 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
 
-	/* New requested state is same as Max requested state */
-	if (state == genpd->performance_state)
-		return 0;
+	if (state == genpd->performance_state) {
+		/*
+		 * New requested state is same as Max requested state, return 1
+		 * to distinguish from the case where none of the masters have
+		 * set their genpd_set_performance_state() callback.
+		 */
+		return 1;
+	}
 
 	/* New requested state is higher than Max requested state */
 	if (state > genpd->performance_state)
@@ -444,7 +453,7 @@ int dev_pm_genpd_update_performance_state(struct device *dev,
 	}
 
 	ret = _genpd_reeval_performance_state(genpd, state, 0);
-	if (!ret) {
+	if (ret > 0) {
 		/*
 		 * Since we are passing "state" to
 		 * _genpd_reeval_performance_state() as well, we don't need to
@@ -453,6 +462,13 @@ int dev_pm_genpd_update_performance_state(struct device *dev,
 		 * state of master domain is updated.
 		 */
 		__genpd_dev_update_performance_state(dev, state);
+		ret = 0;
+	} else if (ret < 0) {
+		dev_err(dev, "Couldn't update performance state (%d)\n", ret);
+	} else {
+		WARN(1, "%s: None of %s and its masters have provided genpd_set_performance_state()\n",
+		     __func__, genpd->name);
+		ret = -ENODEV;
 	}
 
 unlock:
@@ -471,7 +487,7 @@ static int _genpd_on_update_performance_state(struct generic_pm_domain *genpd,
 		return 0;
 
 	ret = _genpd_set_performance_state(genpd, prev, depth);
-	if (ret) {
+	if (ret < 0) {
 		pr_err("%s: Failed to restore performance state to %d (%d)\n",
 		       genpd->name, prev, ret);
 	} else {
@@ -490,7 +506,7 @@ static void _genpd_off_update_performance_state(struct generic_pm_domain *genpd,
 		return;
 
 	ret = _genpd_set_performance_state(genpd, 0, depth);
-	if (ret) {
+	if (ret < 0) {
 		pr_err("%s: Failed to set performance state to 0 (%d)\n",
 		       genpd->name, ret);
 	} else {
-- 
2.7.4
