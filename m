From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] phy: core: Move runtime PM reference counting to the parent device
Date: Tue, 19 Dec 2017 22:22:29 +0100
Message-ID: <1513718551-28624-2-git-send-email-ulf.hansson@linaro.org>
References: <1513718551-28624-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513718551-28624-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

The runtime PM deployment in the phy core is a bit unnecessary complicated
and the main reason is because it operates on the phy device, which is
created by the phy core and assigned as a child device of the phy provider
device.

Let's simplify the code, by replacing the existing calls to
phy_pm_runtime_get_sync() and phy_pm_runtime_put(), with regular calls to
pm_runtime_get_sync() and pm_runtime_put(). While doing that, let's also
change to give the phy provider device as the parameter to the runtime PM
calls. This together with adding error paths, that allows the phy
provider device to be runtime PM disabled, enables further clean up the
code. More precisely, we can simply avoid to enable runtime PM for the phy
device altogether, so let's do that as well.

More importantly, this change also fixes an issue for system suspend.
Especially in those cases when the phy provider device gets put into a low
power state via calling the pm_runtime_force_suspend() helper, as is the
case for a Renesas SoC, which has the phy provider device attached to the
generic PM domain.

The problem in this case, is that pm_runtime_force_suspend() expects the
child device of the provider device to be runtime suspended, else this will
trigger a WARN splat (correctly) when runtime PM gets re-enabled at system
resume.

In the current case, even if phy_power_off() triggers a pm_runtime_put()
during system suspend the phy device (child) doesn't get runtime suspended,
because that is prevented in the system suspend phases. However, by
avoiding to enable runtime PM, this problem goes away.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/phy/phy-core.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b4964b0..9fa3f13 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -222,10 +222,10 @@ int phy_init(struct phy *phy)
 	if (!phy)
 		return 0;
 
-	ret = phy_pm_runtime_get_sync(phy);
-	if (ret < 0 && ret != -ENOTSUPP)
+	ret = pm_runtime_get_sync(phy->dev.parent);
+	if (ret < 0 && ret != -EACCES)
 		return ret;
-	ret = 0; /* Override possible ret == -ENOTSUPP */
+	ret = 0;
 
 	mutex_lock(&phy->mutex);
 	if (phy->init_count == 0 && phy->ops->init) {
@@ -239,7 +239,7 @@ int phy_init(struct phy *phy)
 
 out:
 	mutex_unlock(&phy->mutex);
-	phy_pm_runtime_put(phy);
+	pm_runtime_put(phy->dev.parent);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(phy_init);
@@ -251,10 +251,10 @@ int phy_exit(struct phy *phy)
 	if (!phy)
 		return 0;
 
-	ret = phy_pm_runtime_get_sync(phy);
-	if (ret < 0 && ret != -ENOTSUPP)
+	ret = pm_runtime_get_sync(phy->dev.parent);
+	if (ret < 0 && ret != -EACCES)
 		return ret;
-	ret = 0; /* Override possible ret == -ENOTSUPP */
+	ret = 0;
 
 	mutex_lock(&phy->mutex);
 	if (phy->init_count == 1 && phy->ops->exit) {
@@ -268,7 +268,7 @@ int phy_exit(struct phy *phy)
 
 out:
 	mutex_unlock(&phy->mutex);
-	phy_pm_runtime_put(phy);
+	pm_runtime_put(phy->dev.parent);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(phy_exit);
@@ -286,11 +286,10 @@ int phy_power_on(struct phy *phy)
 			goto out;
 	}
 
-	ret = phy_pm_runtime_get_sync(phy);
-	if (ret < 0 && ret != -ENOTSUPP)
+	ret = pm_runtime_get_sync(phy->dev.parent);
+	if (ret < 0 && ret != -EACCES)
 		goto err_pm_sync;
-
-	ret = 0; /* Override possible ret == -ENOTSUPP */
+	ret = 0;
 
 	mutex_lock(&phy->mutex);
 	if (phy->power_count == 0 && phy->ops->power_on) {
@@ -306,7 +305,7 @@ int phy_power_on(struct phy *phy)
 
 err_pwr_on:
 	mutex_unlock(&phy->mutex);
-	phy_pm_runtime_put_sync(phy);
+	pm_runtime_put(phy->dev.parent);
 err_pm_sync:
 	if (phy->pwr)
 		regulator_disable(phy->pwr);
@@ -333,7 +332,7 @@ int phy_power_off(struct phy *phy)
 	}
 	--phy->power_count;
 	mutex_unlock(&phy->mutex);
-	phy_pm_runtime_put(phy);
+	pm_runtime_put(phy->dev.parent);
 
 	if (phy->pwr)
 		regulator_disable(phy->pwr);
@@ -774,11 +773,6 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 	if (ret)
 		goto put_dev;
 
-	if (pm_runtime_enabled(dev)) {
-		pm_runtime_enable(&phy->dev);
-		pm_runtime_no_callbacks(&phy->dev);
-	}
-
 	return phy;
 
 put_dev:
@@ -831,7 +825,6 @@ EXPORT_SYMBOL_GPL(devm_phy_create);
  */
 void phy_destroy(struct phy *phy)
 {
-	pm_runtime_disable(&phy->dev);
 	device_unregister(&phy->dev);
 }
 EXPORT_SYMBOL_GPL(phy_destroy);
-- 
2.7.4
