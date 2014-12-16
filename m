From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH 3/4] PM / OPP: take RCU lock in dev_pm_opp_get_opp_count
Date: Tue, 16 Dec 2014 15:09:38 -0800
Message-ID: <1418771379-24369-4-git-send-email-dtor@chromium.org>
References: <1418771379-24369-1-git-send-email-dtor@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418771379-24369-1-git-send-email-dtor@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Stefan Wahren <stefan.wahren@i2se.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

A lot of callers are missing the fact that dev_pm_opp_get_opp_count
needs to be called under RCU lock. Given that RCU locks can safely be
nested, instead of providing *_locked() API, let's take RCU lock inside
dev_pm_opp_get_opp_count() and leave callers as is.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/base/power/opp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 413c7fe..ee5eca2 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -216,9 +216,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
  * This function returns the number of available opps if there are any,
  * else returns 0 if none or the corresponding error value.
  *
- * Locking: This function must be called under rcu_read_lock(). This function
- * internally references two RCU protected structures: device_opp and opp which
- * are safe as long as we are under a common RCU locked section.
+ * Locking: This function takes rcu_read_lock().
  */
 int dev_pm_opp_get_opp_count(struct device *dev)
 {
@@ -226,13 +224,14 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 	struct dev_pm_opp *temp_opp;
 	int count = 0;
 
-	opp_rcu_lockdep_assert();
+	rcu_read_lock();
 
 	dev_opp = find_device_opp(dev);
 	if (IS_ERR(dev_opp)) {
-		int r = PTR_ERR(dev_opp);
-		dev_err(dev, "%s: device OPP not found (%d)\n", __func__, r);
-		return r;
+		count = PTR_ERR(dev_opp);
+		dev_err(dev, "%s: device OPP not found (%d)\n",
+			__func__, count);
+		goto out_unlock;
 	}
 
 	list_for_each_entry_rcu(temp_opp, &dev_opp->opp_list, node) {
@@ -240,6 +239,8 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 			count++;
 	}
 
+out_unlock:
+	rcu_read_unlock();
 	return count;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
-- 
2.2.0.rc0.207.ga3a616c
