From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 1/3] phy: core: Move runtime PM reference counting to the parent device
Date: Wed, 20 Dec 2017 15:09:18 +0100
Message-ID: <1513778960-10073-2-git-send-email-ulf.hansson@linaro.org>
References: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

The runtime PM deployment in the phy core is deployed using the phy core
device, which is created by the phy core and assigned as a child device of
the phy provider device.

The behaviour around the runtime PM deployment cause some issues during
system suspend, in cases when the phy provider device is put into a low
power state via a call to the pm_runtime_force_suspend() helper, as is the
case for a Renesas SoC, which has its phy provider device attached to the
generic PM domain.

In more detail, the problem in this case is that pm_runtime_force_suspend()
expects the child device of the provider device, which is the phy core
device, to be runtime suspended, else a WARN splat will be printed
(correctly) when runtime PM gets re-enabled at system resume.

In the current scenario, even if a call to phy_power_off() triggers it to
invoke pm_runtime_put() during system suspend, the phy core device doesn't
get runtime suspended, because this is prevented in the system suspend
phases by the PM core.

To solve this problem, let's move the runtime PM deployment from the phy
core device to the phy provider device, as this provides the similar
behaviour. Changing this makes it redundant to enable runtime PM for the
phy core device, so let's avoid doing that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/phy/phy-core.c  | 33 +++++++++++++++------------------
 include/linux/phy/phy.h |  1 +
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b4964b0..09588ec 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -153,12 +153,12 @@ int phy_pm_runtime_get(struct phy *phy)
 {
 	int ret;
 
-	if (!pm_runtime_enabled(&phy->dev))
+	if (!phy->use_runtime_pm)
 		return -ENOTSUPP;
 
-	ret = pm_runtime_get(&phy->dev);
+	ret = pm_runtime_get(phy->dev.parent);
 	if (ret < 0 && ret != -EINPROGRESS)
-		pm_runtime_put_noidle(&phy->dev);
+		pm_runtime_put_noidle(phy->dev.parent);
 
 	return ret;
 }
@@ -168,12 +168,12 @@ int phy_pm_runtime_get_sync(struct phy *phy)
 {
 	int ret;
 
-	if (!pm_runtime_enabled(&phy->dev))
+	if (!phy->use_runtime_pm)
 		return -ENOTSUPP;
 
-	ret = pm_runtime_get_sync(&phy->dev);
+	ret = pm_runtime_get_sync(phy->dev.parent);
 	if (ret < 0)
-		pm_runtime_put_sync(&phy->dev);
+		pm_runtime_put_sync(phy->dev.parent);
 
 	return ret;
 }
@@ -181,37 +181,37 @@ EXPORT_SYMBOL_GPL(phy_pm_runtime_get_sync);
 
 int phy_pm_runtime_put(struct phy *phy)
 {
-	if (!pm_runtime_enabled(&phy->dev))
+	if (!phy->use_runtime_pm)
 		return -ENOTSUPP;
 
-	return pm_runtime_put(&phy->dev);
+	return pm_runtime_put(phy->dev.parent);
 }
 EXPORT_SYMBOL_GPL(phy_pm_runtime_put);
 
 int phy_pm_runtime_put_sync(struct phy *phy)
 {
-	if (!pm_runtime_enabled(&phy->dev))
+	if (!phy->use_runtime_pm)
 		return -ENOTSUPP;
 
-	return pm_runtime_put_sync(&phy->dev);
+	return pm_runtime_put_sync(phy->dev.parent);
 }
 EXPORT_SYMBOL_GPL(phy_pm_runtime_put_sync);
 
 void phy_pm_runtime_allow(struct phy *phy)
 {
-	if (!pm_runtime_enabled(&phy->dev))
+	if (!phy->use_runtime_pm)
 		return;
 
-	pm_runtime_allow(&phy->dev);
+	pm_runtime_allow(phy->dev.parent);
 }
 EXPORT_SYMBOL_GPL(phy_pm_runtime_allow);
 
 void phy_pm_runtime_forbid(struct phy *phy)
 {
-	if (!pm_runtime_enabled(&phy->dev))
+	if (!phy->use_runtime_pm)
 		return;
 
-	pm_runtime_forbid(&phy->dev);
+	pm_runtime_forbid(phy->dev.parent);
 }
 EXPORT_SYMBOL_GPL(phy_pm_runtime_forbid);
 
@@ -774,10 +774,7 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 	if (ret)
 		goto put_dev;
 
-	if (pm_runtime_enabled(dev)) {
-		pm_runtime_enable(&phy->dev);
-		pm_runtime_no_callbacks(&phy->dev);
-	}
+	phy->use_runtime_pm = pm_runtime_enabled(dev);
 
 	return phy;
 
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 4f8423a..b4298a1 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -83,6 +83,7 @@ struct phy {
 	int			power_count;
 	struct phy_attrs	attrs;
 	struct regulator	*pwr;
+	bool			use_runtime_pm;
 };
 
 /**
-- 
2.7.4
