From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] phy: core: Drop unused runtime PM APIs
Date: Tue, 19 Dec 2017 22:22:30 +0100
Message-ID: <1513718551-28624-3-git-send-email-ulf.hansson@linaro.org>
References: <1513718551-28624-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513718551-28624-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

The phy core already deploys runtime PM management, so there seems to be no
reason for having a separate option of controlling runtime PM for phys via
the phy runtime PM APIs.

Moreover, since previous changes moved the runtime PM reference counting
onto the parent provider device, which also avoid to enabled runtime PM for
the phy child device, the APIs becomes NOOP. Therefore, let's remove them
altogether.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/phy/phy-core.c  | 66 -------------------------------------------------
 include/linux/phy/phy.h | 45 ---------------------------------
 2 files changed, 111 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 9fa3f13..60818e1 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -149,72 +149,6 @@ static struct phy_provider *of_phy_provider_lookup(struct device_node *node)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
-int phy_pm_runtime_get(struct phy *phy)
-{
-	int ret;
-
-	if (!pm_runtime_enabled(&phy->dev))
-		return -ENOTSUPP;
-
-	ret = pm_runtime_get(&phy->dev);
-	if (ret < 0 && ret != -EINPROGRESS)
-		pm_runtime_put_noidle(&phy->dev);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_get);
-
-int phy_pm_runtime_get_sync(struct phy *phy)
-{
-	int ret;
-
-	if (!pm_runtime_enabled(&phy->dev))
-		return -ENOTSUPP;
-
-	ret = pm_runtime_get_sync(&phy->dev);
-	if (ret < 0)
-		pm_runtime_put_sync(&phy->dev);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_get_sync);
-
-int phy_pm_runtime_put(struct phy *phy)
-{
-	if (!pm_runtime_enabled(&phy->dev))
-		return -ENOTSUPP;
-
-	return pm_runtime_put(&phy->dev);
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_put);
-
-int phy_pm_runtime_put_sync(struct phy *phy)
-{
-	if (!pm_runtime_enabled(&phy->dev))
-		return -ENOTSUPP;
-
-	return pm_runtime_put_sync(&phy->dev);
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_put_sync);
-
-void phy_pm_runtime_allow(struct phy *phy)
-{
-	if (!pm_runtime_enabled(&phy->dev))
-		return;
-
-	pm_runtime_allow(&phy->dev);
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_allow);
-
-void phy_pm_runtime_forbid(struct phy *phy)
-{
-	if (!pm_runtime_enabled(&phy->dev))
-		return;
-
-	pm_runtime_forbid(&phy->dev);
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_forbid);
-
 int phy_init(struct phy *phy)
 {
 	int ret;
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 4f8423a..29871aaa 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -17,7 +17,6 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/device.h>
-#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
 struct phy;
@@ -133,12 +132,6 @@ static inline void *phy_get_drvdata(struct phy *phy)
 }
 
 #if IS_ENABLED(CONFIG_GENERIC_PHY)
-int phy_pm_runtime_get(struct phy *phy);
-int phy_pm_runtime_get_sync(struct phy *phy);
-int phy_pm_runtime_put(struct phy *phy);
-int phy_pm_runtime_put_sync(struct phy *phy);
-void phy_pm_runtime_allow(struct phy *phy);
-void phy_pm_runtime_forbid(struct phy *phy);
 int phy_init(struct phy *phy);
 int phy_exit(struct phy *phy);
 int phy_power_on(struct phy *phy);
@@ -187,44 +180,6 @@ void devm_of_phy_provider_unregister(struct device *dev,
 int phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id);
 void phy_remove_lookup(struct phy *phy, const char *con_id, const char *dev_id);
 #else
-static inline int phy_pm_runtime_get(struct phy *phy)
-{
-	if (!phy)
-		return 0;
-	return -ENOSYS;
-}
-
-static inline int phy_pm_runtime_get_sync(struct phy *phy)
-{
-	if (!phy)
-		return 0;
-	return -ENOSYS;
-}
-
-static inline int phy_pm_runtime_put(struct phy *phy)
-{
-	if (!phy)
-		return 0;
-	return -ENOSYS;
-}
-
-static inline int phy_pm_runtime_put_sync(struct phy *phy)
-{
-	if (!phy)
-		return 0;
-	return -ENOSYS;
-}
-
-static inline void phy_pm_runtime_allow(struct phy *phy)
-{
-	return;
-}
-
-static inline void phy_pm_runtime_forbid(struct phy *phy)
-{
-	return;
-}
-
 static inline int phy_init(struct phy *phy)
 {
 	if (!phy)
-- 
2.7.4
