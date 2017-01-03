From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/6] PM / domain: Save/restore performance state at runtime suspend/resume
Date: Tue,  3 Jan 2017 16:36:11 +0530
Message-ID: <dd5ae96e358f9c1e2e92d9ce523f7784dc05baf4.1483439894.git.viresh.kumar@linaro.org>
References: <cover.1483439894.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35198 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934803AbdACLGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2017 06:06:50 -0500
Received: by mail-pg0-f46.google.com with SMTP id i5so149100341pgh.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2017 03:06:50 -0800 (PST)
In-Reply-To: <cover.1483439894.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1483439894.git.viresh.kumar@linaro.org>
References: <cover.1483439894.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

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
index f460be4ca5f7..ef4062927713 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -576,7 +576,8 @@ static int genpd_runtime_suspend(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	bool (*suspend_ok)(struct device *__dev);
-	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	struct generic_pm_domain_data *pd_data = dev_gpd_data(dev);
+	struct gpd_timing_data *td = &pd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -633,7 +634,14 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
+
+	/* Re-evaluate performance state of the domain */
+	pd_data->cached_performance_state = pd_data->performance_state;
+	pd_data->performance_state = 0;
+	update_domain_performance_state(genpd);
+
 	genpd_poweroff(genpd, false);
+
 	genpd_unlock(genpd);
 
 	return 0;
@@ -650,7 +658,8 @@ static int genpd_runtime_suspend(struct device *dev)
 static int genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	struct generic_pm_domain_data *pd_data = dev_gpd_data(dev);
+	struct gpd_timing_data *td = &pd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -673,7 +682,13 @@ static int genpd_runtime_resume(struct device *dev)
 	}
 
 	genpd_lock(genpd);
+
 	ret = genpd_poweron(genpd, 0);
+
+	/* Re-evaluate performance state of the domain */
+	pd_data->performance_state = pd_data->cached_performance_state;
+	update_domain_performance_state(genpd);
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

