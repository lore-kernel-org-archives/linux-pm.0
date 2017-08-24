From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 11/12] PM / devfreq: Remove exported opp_notifier function
Date: Thu, 24 Aug 2017 10:42:58 +0900
Message-ID: <1503538979-22693-12-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014300epcas2p27dfdc54aae8ea29e5e60425a87cf4aab@epcas2p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:20012 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdHXBnC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 21:43:02 -0400
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The devfreq provides the helper function to register the OPP notifier
which is used to catch the change of OPP entry such as OPP_EVENT_ADD,
OPP_EVENT_REMOVE, OPP_EVENT_DISABLE and OPP_EVENT_ENABLE. The OPP
notifier is optional.

But, the devfreq uses the OPP interface as a mandatory method
to handle the frequency and voltage. If so, the OPP notifier is
mandatory. So, the OPP notifier have to be handled in the devfreq core
instead of each device driver.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c    | 77 --------------------------------------------
 drivers/devfreq/exynos-bus.c |  7 ----
 drivers/devfreq/rk3399_dmc.c |  1 -
 include/linux/devfreq.h      | 31 ------------------
 4 files changed, 116 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 77eb3edf6bf3..7efa867e4aea 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1344,83 +1344,6 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 EXPORT_SYMBOL(devfreq_recommended_opp);
 
 /**
- * devfreq_register_opp_notifier() - Helper function to get devfreq notified
- *				   for any changes in the OPP availability
- *				   changes
- * @dev:	The devfreq user device. (parent of devfreq)
- * @devfreq:	The devfreq object.
- */
-int devfreq_register_opp_notifier(struct device *dev, struct devfreq *devfreq)
-{
-	return dev_pm_opp_register_notifier(dev, &devfreq->nb);
-}
-EXPORT_SYMBOL(devfreq_register_opp_notifier);
-
-/**
- * devfreq_unregister_opp_notifier() - Helper function to stop getting devfreq
- *				     notified for any changes in the OPP
- *				     availability changes anymore.
- * @dev:	The devfreq user device. (parent of devfreq)
- * @devfreq:	The devfreq object.
- *
- * At exit() callback of devfreq_dev_profile, this must be included if
- * devfreq_recommended_opp is used.
- */
-int devfreq_unregister_opp_notifier(struct device *dev, struct devfreq *devfreq)
-{
-	return dev_pm_opp_unregister_notifier(dev, &devfreq->nb);
-}
-EXPORT_SYMBOL(devfreq_unregister_opp_notifier);
-
-static void devm_devfreq_opp_release(struct device *dev, void *res)
-{
-	devfreq_unregister_opp_notifier(dev, *(struct devfreq **)res);
-}
-
-/**
- * devm_ devfreq_register_opp_notifier()
- *		- Resource-managed devfreq_register_opp_notifier()
- * @dev:	The devfreq user device. (parent of devfreq)
- * @devfreq:	The devfreq object.
- */
-int devm_devfreq_register_opp_notifier(struct device *dev,
-				       struct devfreq *devfreq)
-{
-	struct devfreq **ptr;
-	int ret;
-
-	ptr = devres_alloc(devm_devfreq_opp_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
-	ret = devfreq_register_opp_notifier(dev, devfreq);
-	if (ret) {
-		devres_free(ptr);
-		return ret;
-	}
-
-	*ptr = devfreq;
-	devres_add(dev, ptr);
-
-	return 0;
-}
-EXPORT_SYMBOL(devm_devfreq_register_opp_notifier);
-
-/**
- * devm_devfreq_unregister_opp_notifier()
- *		- Resource-managed devfreq_unregister_opp_notifier()
- * @dev:	The devfreq user device. (parent of devfreq)
- * @devfreq:	The devfreq object.
- */
-void devm_devfreq_unregister_opp_notifier(struct device *dev,
-					 struct devfreq *devfreq)
-{
-	WARN_ON(devres_release(dev, devm_devfreq_opp_release,
-			       devm_devfreq_dev_match, devfreq));
-}
-EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
-
-/**
  * devfreq_register_notifier() - Register a driver with devfreq
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to register.
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 49f68929e024..a144d7ae066e 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -444,13 +444,6 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	/* Register opp_notifier to catch the change of OPP  */
-	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
-	if (ret < 0) {
-		dev_err(dev, "failed to register opp notifier\n");
-		goto err;
-	}
-
 	/*
 	 * Enable devfreq-event to get raw data which is used to determine
 	 * current bus load.
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 1b89ebbad02c..4fb1041b628e 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -435,7 +435,6 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 					   &data->ondemand_data);
 	if (IS_ERR(data->devfreq))
 		return PTR_ERR(data->devfreq);
-	devm_devfreq_register_opp_notifier(dev, data->devfreq);
 
 	data->dev = dev;
 	platform_set_drvdata(pdev, data);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 597294e0cc40..d6f054545799 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -189,14 +189,6 @@ extern void devm_devfreq_remove_device(struct device *dev,
 /* Helper functions for devfreq user device driver with OPP. */
 extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags);
-extern int devfreq_register_opp_notifier(struct device *dev,
-					 struct devfreq *devfreq);
-extern int devfreq_unregister_opp_notifier(struct device *dev,
-					   struct devfreq *devfreq);
-extern int devm_devfreq_register_opp_notifier(struct device *dev,
-					      struct devfreq *devfreq);
-extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
-						struct devfreq *devfreq);
 extern int devfreq_register_notifier(struct devfreq *devfreq,
 					struct notifier_block *nb,
 					unsigned int list);
@@ -310,29 +302,6 @@ static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 	return ERR_PTR(-EINVAL);
 }
 
-static inline int devfreq_register_opp_notifier(struct device *dev,
-					 struct devfreq *devfreq)
-{
-	return -EINVAL;
-}
-
-static inline int devfreq_unregister_opp_notifier(struct device *dev,
-					   struct devfreq *devfreq)
-{
-	return -EINVAL;
-}
-
-static inline int devm_devfreq_register_opp_notifier(struct device *dev,
-						     struct devfreq *devfreq)
-{
-	return -EINVAL;
-}
-
-static inline void devm_devfreq_unregister_opp_notifier(struct device *dev,
-							struct devfreq *devfreq)
-{
-}
-
 static inline int devfreq_register_notifier(struct devfreq *devfreq,
 					struct notifier_block *nb,
 					unsigned int list)
-- 
1.9.1
