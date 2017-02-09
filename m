From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 5/6] PM / domain: Save/restore performance state at runtime suspend/resume
Date: Thu,  9 Feb 2017 09:11:51 +0530
Message-ID: <21383233a44afe5e5144fadb82867a0a890db46f.1486611268.git.viresh.kumar@linaro.org>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:32850 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbdBIDsm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2017 22:48:42 -0500
Received: by mail-pf0-f180.google.com with SMTP id y143so46722754pfb.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Feb 2017 19:48:37 -0800 (PST)
In-Reply-To: <cover.1486611268.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1486611268.git.viresh.kumar@linaro.org>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

With runtime PM, the devices get suspended while the system is up and
running in order to save power. At such times, it is important to
re-evaluate the required performance state of the domain, in order to
choose a lower state if possible.

This patch updates the genpd suspend/resume callbacks to do that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 19 +++++++++++++++++--
 include/linux/pm_domain.h   |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 1158a07f92de..ce9ab18be243 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -603,7 +603,8 @@ static int genpd_runtime_suspend(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	bool (*suspend_ok)(struct device *__dev);
-	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	struct generic_pm_domain_data *pd_data = dev_gpd_data(dev);
+	struct gpd_timing_data *td = &pd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -660,7 +661,14 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
+
+	/* Re-evaluate performance state of the domain */
+	pd_data->cached_performance_state = pd_data->performance_state;
+	pd_data->performance_state = 0;
+	update_domain_performance_state(genpd, 0);
+
 	genpd_power_off(genpd, false);
+
 	genpd_unlock(genpd);
 
 	return 0;
@@ -677,7 +685,8 @@ static int genpd_runtime_suspend(struct device *dev)
 static int genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	struct generic_pm_domain_data *pd_data = dev_gpd_data(dev);
+	struct gpd_timing_data *td = &pd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -700,7 +709,13 @@ static int genpd_runtime_resume(struct device *dev)
 	}
 
 	genpd_lock(genpd);
+
 	ret = genpd_power_on(genpd, 0);
+
+	/* Re-evaluate performance state of the domain */
+	pd_data->performance_state = pd_data->cached_performance_state;
+	update_domain_performance_state(genpd, 0);
+
 	genpd_unlock(genpd);
 
 	if (ret)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index d994ad5ba1c0..69b453d44adb 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -122,6 +122,7 @@ struct generic_pm_domain_data {
 	struct notifier_block nb;
 	struct notifier_block perf_nb;
 	unsigned int performance_state;
+	unsigned int cached_performance_state;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
-- 
2.7.1.410.g6faf27b

