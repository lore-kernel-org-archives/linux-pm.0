From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v4 2/5] PM / OPP: add a function to get the voltage for disabled OPPs
Date: Fri, 14 Aug 2015 18:56:57 +0100
Message-ID: <1439575020-3447-3-git-send-email-javi.merino@arm.com>
References: <1439575020-3447-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439575020-3447-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com, rufus.hamade@imgtec.com, Javi Merino <javi.merino@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The OPP library is now used for power models to calculate the power
that a device would consume at a specific OPP.  To do that, we use a
simple power model which takes frequency and voltage as inputs.  We get
the voltage and frequency from the OPP library.

The devfreq cooling device for the thermal framework controls temperature
by disabling OPPs.  The power model needs to calculate the power that
would be consumed if we reenabled the OPP.  dev_pm_opp_get_voltage()
doesn't work for disabled OPPs.

Add a dev_pm_opp_get_voltage_always() that works both for enabled and
disabled OPPs to be used by the power model.  The documentation for this
function clearly states that you should use dev_pm_opp_get_voltage()
instead unless you know what you're doing.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/base/power/opp.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h   |  7 +++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 677fb2843553..b1a4216c7ec3 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -182,6 +182,43 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
 
 /**
+ * dev_pm_opp_get_voltage_always() - Gets the voltage corresponding to an opp
+ * @opp:	opp for which voltage has to be returned for
+ *
+ * This function is similar to dev_pm_opp_get_voltage() except that it
+ * works for disabled opps as well.  In most cases, you want to
+ * operate only on available opps so you should use
+ * dev_pm_opp_get_voltage() instead.
+ *
+ * Return: voltage in micro volt corresponding to the opp, else
+ * return 0
+ *
+ * Locking: This function must be called under rcu_read_lock(). opp is a rcu
+ * protected pointer. This means that opp which could have been fetched by
+ * opp_find_freq_{exact,ceil,floor} functions is valid as long as we are
+ * under RCU lock. The pointer returned by the opp_find_freq family must be
+ * used in the same section as the usage of this function with the pointer
+ * prior to unlocking with rcu_read_unlock() to maintain the integrity of the
+ * pointer.
+ */
+unsigned long dev_pm_opp_get_voltage_always(struct dev_pm_opp *opp)
+{
+	struct dev_pm_opp *tmp_opp;
+	unsigned long v = 0;
+
+	opp_rcu_lockdep_assert();
+
+	tmp_opp = rcu_dereference(opp);
+	if (unlikely(IS_ERR_OR_NULL(tmp_opp)))
+		pr_err("%s: Invalid parameters\n", __func__);
+	else
+		v = tmp_opp->u_volt;
+
+	return v;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage_always);
+
+/**
  * dev_pm_opp_get_freq() - Gets the frequency corresponding to an available opp
  * @opp:	opp for which frequency has to be returned for
  *
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cec2d4540914..fba83eb616d5 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -28,6 +28,8 @@ enum dev_pm_opp_event {
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
+unsigned long dev_pm_opp_get_voltage_always(struct dev_pm_opp *opp);
+
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
 int dev_pm_opp_get_opp_count(struct device *dev);
@@ -57,6 +59,11 @@ static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_voltage_always(struct dev_pm_opp *opp)
+{
+	return 0;
+}
+
 static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
1.9.1
