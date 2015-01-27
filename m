From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/8] PM / Domains: Free pm_subsys_data in error path in __pm_genpd_add_device()
Date: Tue, 27 Jan 2015 21:13:43 +0100
Message-ID: <1422389625-11730-7-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

The error path in __pm_genpd_add_device() didn't decrease the reference
to the struct pm_subsys_data.

Let's move the calls to dev_pm_get|put_subsys_data() into
genpd_alloc|free_dev_data() to fix this issue and thus prevent a
potential memory leakage.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 1f026c1..3bd342f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1380,18 +1380,30 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
+	int ret;
+
+	ret = dev_pm_get_subsys_data(dev);
+	if (ret)
+		return ERR_PTR(ret);
 
 	gpd_data = kzalloc(sizeof(*gpd_data), GFP_KERNEL);
-	if (!gpd_data)
-		return NULL;
+	if (!gpd_data) {
+		ret = -ENOMEM;
+		goto err_put;
+	}
 
 	return gpd_data;
+
+ err_put:
+	dev_pm_put_subsys_data(dev);
+	return ERR_PTR(ret);
 }
 
 static void genpd_free_dev_data(struct device *dev,
 				struct generic_pm_domain_data *gpd_data)
 {
 	kfree(gpd_data);
+	dev_pm_put_subsys_data(dev);
 }
 
 /**
@@ -1412,8 +1424,8 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 		return -EINVAL;
 
 	gpd_data = genpd_alloc_dev_data(dev);
-	if (!gpd_data)
-		return -ENOMEM;
+	if (IS_ERR(gpd_data))
+		return PTR_ERR(gpd_data);
 
 	genpd_acquire_lock(genpd);
 
@@ -1422,10 +1434,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 		goto out;
 	}
 
-	ret = dev_pm_get_subsys_data(dev);
-	if (ret)
-		goto out;
-
 	spin_lock_irq(&dev->power.lock);
 
 	if (dev->power.subsys_data->domain_data) {
@@ -1528,7 +1536,6 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	genpd_release_lock(genpd);
 
-	dev_pm_put_subsys_data(dev);
 	genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
-- 
1.9.1
