From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 02/16] PM / Domains: Remove dev->driver check for runtime PM
Date: Fri, 26 Jun 2015 21:02:22 -0600
Message-ID: <1435374156-19214-3-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33571 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbbF0DCr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:02:47 -0400
Received: by pdjn11 with SMTP id n11so84889737pdj.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:02:46 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Remove check for driver of a device, for runtime PM. Device may be
suspended without an explicit driver. This check seems to be vestigial
and incorrect in the current context.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 44af889..e9b7cfb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -391,8 +391,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		if (stat > PM_QOS_FLAGS_NONE)
 			return -EBUSY;
 
-		if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
-		    || pdd->dev->power.irq_safe))
+		if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
 			not_suspended++;
 	}
 
-- 
2.1.4

