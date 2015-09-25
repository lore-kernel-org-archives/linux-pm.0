From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 5/7] PM / Domains: succeed & warn when attaching non-irqsafe devices to an irq-safe domain.
Date: Fri, 25 Sep 2015 15:04:07 +0200
Message-ID: <1443186249-14596-6-git-send-email-mtitinger+renesas@baylibre.com>
References: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35097 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235AbbIYNEh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2015 09:04:37 -0400
Received: by wicge5 with SMTP id ge5so19890159wic.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2015 06:04:36 -0700 (PDT)
In-Reply-To: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, lina.iyer@linaro.org, Marc Titinger <mtitinger@baylibre.com>

From: Marc Titinger <mtitinger@baylibre.com>

This patch checks for irq-safe compatibility in suspend/resume instead of
failing the attach operation early on. Non-cpu devices attaching to an
irq-safe power domain will have to call pm_runtime_irq_safe from their
probe function.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/base/power/domain.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8259654..b747e9e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -585,6 +585,14 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	if (dev->power.irq_safe && !genpd->irq_safe)
 		return 0;
 
+	/* The device probe may have missed calling pm_runtime_irq_safe.
+	 */
+	if (!dev->power.irq_safe && genpd->irq_safe) {
+		dev_err(dev, "trying to %s a non-irqsafe device in an irq-safe domain\n",
+		__func__);
+		return -EINVAL;
+	}
+
 	genpd_lock(genpd);
 
 	genpd->in_progress++;
@@ -624,6 +632,14 @@ static int pm_genpd_runtime_resume(struct device *dev)
 		goto out;
 	}
 
+	/* The device probe may have missed calling pm_runtime_irq_safe.
+	 */
+	if (!dev->power.irq_safe && genpd->irq_safe) {
+		dev_err(dev, "trying to %s a non-irqsafe device in an irq-safe domain\n",
+		__func__);
+		return -EINVAL;
+	}
+
 	genpd_lock(genpd);
 	ret = __pm_genpd_poweron(genpd);
 	genpd_unlock(genpd);
@@ -1365,11 +1381,11 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	if (genpd->irq_safe && !dev->power.irq_safe) {
-		dev_err(dev,
+	/* Only issue a warning, runtime_irqsafe may be called later on
+	 * from the driver probe. */
+	if (genpd->irq_safe && !dev->power.irq_safe)
+		dev_warn(dev,
 			"Devices in an IRQ safe domain have to be IRQ safe.\n");
-		return -EINVAL;
-	}
 
 	gpd_data = genpd_alloc_dev_data(dev, genpd, td);
 	if (IS_ERR(gpd_data))
-- 
1.9.1

