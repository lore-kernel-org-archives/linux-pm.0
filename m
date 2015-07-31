From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 12/16] PM / OPP: add dev_pm_opp_is_turbo() helper
Date: Fri, 31 Jul 2015 11:47:07 +0530
Message-ID: <20150731061707.GQ17794@linux>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <1e1445bc7f79eb4adc5bf1a0f5eddf118dc60345.1438166099.git.viresh.kumar@linaro.org>
 <20150731061023.GL3159@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36181 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbbGaGRO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 02:17:14 -0400
Received: by pdjr16 with SMTP id r16so37933107pdj.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 23:17:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150731061023.GL3159@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Abraham <thomas.ab@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 30-07-15, 23:10, Stephen Boyd wrote:
> On 07/29, Viresh Kumar wrote:
> > +bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
> > +{
> > +	struct dev_pm_opp *tmp_opp;
> > +
> > +	opp_rcu_lockdep_assert();
> > +
> > +	tmp_opp = rcu_dereference(opp);
> > +	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available) {
> 
> IS_ERR_OR_NULL already has unlikely inside it on the error
> pointer path so it seems redundant here.
> 
> Otherwise
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

----------------------8<----------------------
Message-Id: <f925cccfbe4765bc6b15740a43e5688d2a283fb0.1438323394.git.viresh.kumar@linaro.org>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 9 Jul 2015 17:43:35 +0200
Subject: [PATCH] PM / OPP: add dev_pm_opp_is_turbo() helper

Add dev_pm_opp_is_turbo() helper to verify if an opp is to be used only
for turbo mode or not.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h   |  7 +++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 663aae1c9834..204c6c945168 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -281,6 +281,40 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
 /**
+ * dev_pm_opp_is_turbo() - Returns if opp is turbo OPP or not
+ * @opp: opp for which turbo mode is being verified
+ *
+ * Turbo OPPs are not for normal use, and can be enabled (under certain
+ * conditions) for short duration of times to finish high throughput work
+ * quickly. Running on them for longer times may overheat the chip.
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
+	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available) {
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
