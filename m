From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 2/9] PM / Domains: Remove dev->driver check for runtime PM
Date: Tue,  4 Aug 2015 17:35:32 -0600
Message-ID: <1438731339-58317-3-git-send-email-lina.iyer@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35688 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbbHDXgH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 19:36:07 -0400
Received: by pabxd6 with SMTP id xd6so2466215pab.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 16:36:07 -0700 (PDT)
In-Reply-To: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Remove check for driver of a device, for runtime PM. Device may be
suspended without an explicit driver. This check seems to be vestigial
and incorrect in the current context.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5fd1306..ef8d19f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -394,8 +394,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		if (stat > PM_QOS_FLAGS_NONE)
 			return -EBUSY;
 
-		if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
-		    || pdd->dev->power.irq_safe))
+		if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
 			not_suspended++;
 	}
 
-- 
2.1.4

