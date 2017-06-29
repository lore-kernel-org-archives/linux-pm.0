From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] PM / Domains: defer dev_pm_domain_set() until genpd->attach_dev succeeds if present
Date: Thu, 29 Jun 2017 19:00:51 +0100
Message-ID: <1498759251-11709-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

If the genpd->attach_dev or genpd->power_on fails, genpd_dev_pm_attach
may return -EPROBE_DEFER initially. However genpd_alloc_dev_data sets
the PM domain for the device unconditionally.

When subsequent attempts are made to call genpd_dev_pm_attach, it may
return -EEXISTS checking dev->pm_domain without re-attempting to call
attach_dev or power_on.

platform_drv_probe then attempts to call drv->probe as the return value
-EEXIST != -EPROBE_DEFER, which may end up in a situation where the
device is accessed without it's power domain switched on.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index da49a8383dc3..b195d34de888 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1168,8 +1168,6 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 
 	spin_unlock_irq(&dev->power.lock);
 
-	dev_pm_domain_set(dev, &genpd->domain);
-
 	return gpd_data;
 
  err_free:
@@ -1221,6 +1219,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (ret)
 		goto out;
 
+	dev_pm_domain_set(dev, &genpd->domain);
+
 	genpd->device_count++;
 	genpd->max_off_time_changed = true;
 
-- 
2.7.4
