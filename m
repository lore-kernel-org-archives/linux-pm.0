From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 1/8] PM / Domains: Constify genpd pointer
Date: Wed, 28 Jun 2017 16:56:16 +0200
Message-ID: <20170628145623.20716-2-krzk@kernel.org>
References: <20170628145623.20716-1-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751893AbdF1O46 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Jun 2017 10:56:58 -0400
In-Reply-To: <20170628145623.20716-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Mark pointer to struct generic_pm_domain const (either passed in
argument or used localy in a function), whenever it is not modifed by
the function itself.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index df2b282f48e5..01e31d9f6c94 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -126,7 +126,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
 
 static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
-		struct generic_pm_domain *genpd)
+		const struct generic_pm_domain *genpd)
 {
 	bool ret;
 
@@ -181,12 +181,14 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
 	return pd_to_genpd(dev->pm_domain);
 }
 
-static int genpd_stop_dev(struct generic_pm_domain *genpd, struct device *dev)
+static int genpd_stop_dev(const struct generic_pm_domain *genpd,
+			  struct device *dev)
 {
 	return GENPD_DEV_CALLBACK(genpd, int, stop, dev);
 }
 
-static int genpd_start_dev(struct generic_pm_domain *genpd, struct device *dev)
+static int genpd_start_dev(const struct generic_pm_domain *genpd,
+			   struct device *dev)
 {
 	return GENPD_DEV_CALLBACK(genpd, int, start, dev);
 }
@@ -738,7 +740,7 @@ static bool pm_genpd_present(const struct generic_pm_domain *genpd)
 
 #ifdef CONFIG_PM_SLEEP
 
-static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
+static bool genpd_dev_active_wakeup(const struct generic_pm_domain *genpd,
 				    struct device *dev)
 {
 	return GENPD_DEV_CALLBACK(genpd, bool, active_wakeup, dev);
@@ -840,7 +842,8 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
  * signal remote wakeup from the system's working state as needed by runtime PM.
  * Return 'true' in either of the above cases.
  */
-static bool resume_needed(struct device *dev, struct generic_pm_domain *genpd)
+static bool resume_needed(struct device *dev,
+			  const struct generic_pm_domain *genpd)
 {
 	bool active_wakeup;
 
@@ -975,7 +978,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
  */
 static int pm_genpd_freeze_noirq(struct device *dev)
 {
-	struct generic_pm_domain *genpd;
+	const struct generic_pm_domain *genpd;
 	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
@@ -999,7 +1002,7 @@ static int pm_genpd_freeze_noirq(struct device *dev)
  */
 static int pm_genpd_thaw_noirq(struct device *dev)
 {
-	struct generic_pm_domain *genpd;
+	const struct generic_pm_domain *genpd;
 	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
-- 
2.11.0
