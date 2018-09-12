From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/11] OPP: Don't take OPP table's kref for static OPPs
Date: Wed, 12 Sep 2018 13:58:44 +0530
Message-ID: <08942a9ab06dd76034242cb70dd2446020a2efe0.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The reference count is only required to be incremented for every call
that may lead to adding the OPP table. For static OPPs the same should
be done from the parent routine which adds all static OPPs together and
so only one refcount for all static OPPs.

Update code to reflect that.

The refcount is incremented every time a dynamic OPP is created (as that
can lead to creating the OPP table) and the same is dropped when the OPP
is removed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 332748adc262..2a6976265580 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -919,7 +919,6 @@ static void _opp_kref_release(struct kref *kref)
 	kfree(opp);
 
 	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
 }
 
 void dev_pm_opp_get(struct dev_pm_opp *opp)
@@ -963,11 +962,15 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 
 	if (found) {
 		dev_pm_opp_put(opp);
+
+		/* Drop the reference taken by dev_pm_opp_add() */
+		dev_pm_opp_put_opp_table(opp_table);
 	} else {
 		dev_warn(dev, "%s: Couldn't find OPP with freq: %lu\n",
 			 __func__, freq);
 	}
 
+	/* Drop the reference taken by _find_opp_table() */
 	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
@@ -1085,9 +1088,6 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	new_opp->opp_table = opp_table;
 	kref_init(&new_opp->kref);
 
-	/* Get a reference to the OPP table */
-	_get_opp_table_kref(opp_table);
-
 	ret = opp_debug_create_one(new_opp, opp_table);
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
@@ -1566,8 +1566,9 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 		return -ENOMEM;
 
 	ret = _opp_add_v1(opp_table, dev, freq, u_volt, true);
+	if (ret)
+		dev_pm_opp_put_opp_table(opp_table);
 
-	dev_pm_opp_put_opp_table(opp_table);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
-- 
2.18.0.rc1.242.g61856ae69a2c
