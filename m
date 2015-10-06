From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC v2 4/6] PM / Domains: succeed & warn when attaching non-irqsafe devices to an irq-safe domain.
Date: Tue,  6 Oct 2015 16:27:43 +0200
Message-ID: <1444141665-18534-5-git-send-email-mtitinger+renesas@baylibre.com>
References: <20151006022702.GA78570@linaro.org>
 <1444141665-18534-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35144 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbbJFO15 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 10:27:57 -0400
Received: by wicge5 with SMTP id ge5so169643676wic.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2015 07:27:56 -0700 (PDT)
In-Reply-To: <1444141665-18534-1-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@kernel.org, rjw@rjwysocki.net
Cc: lina.iyer@linaro.org, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>

From: Marc Titinger <mtitinger@baylibre.com>

This patch checks for irq-safe compatibility in suspend/resume instead of
failing the attach operation early on. Non-cpu devices attaching to an
irq-safe power domain will have to call pm_runtime_irq_safe from their
probe function.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/base/power/domain.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 1ca28a2..ebf1299 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -635,6 +635,14 @@ static int pm_genpd_runtime_resume(struct device *dev)
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
@@ -1376,12 +1384,11 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	if (genpd->irq_safe && !dev->power.irq_safe) {
-		dev_err(dev,
-			"PM Domain %s is IRQ safe; device has to IRQ safe.\n",
-			genpd->name);
-		return -EINVAL;
-	}
+	/* Only issue a warning, runtime_irqsafe may be called later on
+	 * from the driver probe. */
+	if (genpd->irq_safe && !dev->power.irq_safe)
+		dev_warn(dev,
+		"Devices in an IRQ safe domain have to be IRQ safe.\n");
 
 	gpd_data = genpd_alloc_dev_data(dev, genpd, td);
 	if (IS_ERR(gpd_data))
-- 
1.9.1

