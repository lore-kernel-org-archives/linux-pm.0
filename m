From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/4] opp: add dev_pm_opp_is_turbo() helper
Date: Tue, 28 Jul 2015 16:50:00 +0530
Message-ID: <e7e8c272f85df846466e9b57d7c9eef74109c081.1438081962.git.viresh.kumar@linaro.org>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438081962.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438081962.git.viresh.kumar@linaro.org>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, nm@ti.com, sboyd@codeaurora.org, Tomasz Figa <tomasz.figa@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Abraham <thomas.ab@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Add dev_pm_opp_is_turbo() helper to verify if an opp is to be used only
for turbo mode or not.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 30 ++++++++++++++++++++++++++++++
 include/linux/pm_opp.h   |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index b38f2600d797..a0c54058c4dd 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -281,6 +281,36 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
 /**
+ * dev_pm_opp_is_turbo() - Returns true if opp was trubo OPP
+ * @opp: opp for which turbo mode is being verified
+ *
+ * Return: true if opp is turbo opp, else false.
+ *
+ * Locking: This function must be called under rcu_read_lock(). opp is a rcu
+ * protected pointer. This means that opp which could have been fetched by
+ * opp_find_freq_{exact,ceil,floor} functions is valid as long as we are
+ * under RCU lock. The pointer returned by the opp_find_freq family must be
+ * used in the same section as the usage of this function with the pointer
+ * prior to unlocking with rcu_read_unlock() to maintain the integrity of the
+ * pointer.
+ */
+bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
+{
+	struct dev_pm_opp *tmp_opp;
+
+	opp_rcu_lockdep_assert();
+
+	tmp_opp = rcu_dereference(opp);
+	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return false;
+	}
+
+	return tmp_opp->turbo;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_is_turbo);
+
+/**
  * dev_pm_opp_get_max_clock_latency() - Get max clock latency in nanoseconds
  * @dev:	device for which we do this operation
  *
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index bb52fae5b921..cab7ba55bedb 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -30,6 +30,8 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
+bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
+
 int dev_pm_opp_get_opp_count(struct device *dev);
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 
@@ -63,6 +65,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
+{
+	return false;
+}
+
 static inline int dev_pm_opp_get_opp_count(struct device *dev)
 {
 	return 0;
-- 
2.4.0
