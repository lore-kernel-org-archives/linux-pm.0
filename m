From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH] PM / Domains: Remove dev->driver check for runtime PM
Date: Wed, 28 Oct 2015 15:18:59 -0600
Message-ID: <1446067139-42360-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36688 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427AbbJ1VTX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 17:19:23 -0400
Received: by pacfv9 with SMTP id fv9so18421764pac.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2015 14:19:22 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: ulf.hansson@linaro.org, Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>

Remove check for driver of a device, for runtime PM. Device may be
suspended without an explicit driver. This check seems to be vestigial
and incorrect in the current context.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9b0f5a0..6483a92 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -346,8 +346,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		if (stat > PM_QOS_FLAGS_NONE)
 			return -EBUSY;
 
-		if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
-		    || pdd->dev->power.irq_safe))
+		if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
 			not_suspended++;
 	}
 
-- 
2.1.4

