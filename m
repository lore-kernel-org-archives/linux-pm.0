From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/3] phy: core: Drop unused runtime PM APIs
Date: Wed, 20 Dec 2017 15:09:19 +0100
Message-ID: <1513778960-10073-3-git-send-email-ulf.hansson@linaro.org>
References: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41505 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755425AbdLTOJc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 09:09:32 -0500
Received: by mail-lf0-f68.google.com with SMTP id f18so24164612lfg.8
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2017 06:09:31 -0800 (PST)
In-Reply-To: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

The phy core already deploys runtime PM support, so there seems to be no
obvious reason for having dedicated APIs to control runtime PM for phys.

Therefore, let's remove the APIs altogether and instead convert internal
needed functions to be static.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/phy/phy-core.c  | 50 +++----------------------------------------------
 include/linux/phy/phy.h | 45 --------------------------------------------
 2 files changed, 3 insertions(+), 92 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 09588ec..1621625 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -149,22 +149,7 @@ static struct phy_provider *of_phy_provider_lookup(struct device_node *node)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
-int phy_pm_runtime_get(struct phy *phy)
-{
-	int ret;
-
-	if (!phy->use_runtime_pm)
-		return -ENOTSUPP;
-
-	ret = pm_runtime_get(phy->dev.parent);
-	if (ret < 0 && ret != -EINPROGRESS)
-		pm_runtime_put_noidle(phy->dev.parent);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_get);
-
-int phy_pm_runtime_get_sync(struct phy *phy)
+static int phy_pm_runtime_get_sync(struct phy *phy)
 {
 	int ret;
 
@@ -177,43 +162,14 @@ int phy_pm_runtime_get_sync(struct phy *phy)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(phy_pm_runtime_get_sync);
 
-int phy_pm_runtime_put(struct phy *phy)
+static int phy_pm_runtime_put(struct phy *phy)
 {
 	if (!phy->use_runtime_pm)
 		return -ENOTSUPP;
 
 	return pm_runtime_put(phy->dev.parent);
 }
-EXPORT_SYMBOL_GPL(phy_pm_runtime_put);
-
-int phy_pm_runtime_put_sync(struct phy *phy)
-{
-	if (!phy->use_runtime_pm)
-		return -ENOTSUPP;
-
-	return pm_runtime_put_sync(phy->dev.parent);
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_put_sync);
-
-void phy_pm_runtime_allow(struct phy *phy)
-{
-	if (!phy->use_runtime_pm)
-		return;
-
-	pm_runtime_allow(phy->dev.parent);
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_allow);
-
-void phy_pm_runtime_forbid(struct phy *phy)
-{
-	if (!phy->use_runtime_pm)
-		return;
-
-	pm_runtime_forbid(phy->dev.parent);
-}
-EXPORT_SYMBOL_GPL(phy_pm_runtime_forbid);
 
 int phy_init(struct phy *phy)
 {
@@ -306,7 +262,7 @@ int phy_power_on(struct phy *phy)
 
 err_pwr_on:
 	mutex_unlock(&phy->mutex);
-	phy_pm_runtime_put_sync(phy);
+	phy_pm_runtime_put(phy);
 err_pm_sync:
 	if (phy->pwr)
 		regulator_disable(phy->pwr);
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index b4298a1..050b620 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -17,7 +17,6 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/device.h>
-#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
 struct phy;
@@ -134,12 +133,6 @@ static inline void *phy_get_drvdata(struct phy *phy)
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
@@ -188,44 +181,6 @@ void devm_of_phy_provider_unregister(struct device *dev,
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
