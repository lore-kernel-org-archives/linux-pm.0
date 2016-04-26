From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/2] PM / Domains: Drop unnecessary wakeup code from pm_genpd_prepare()
Date: Tue, 26 Apr 2016 08:47:18 +0200
Message-ID: <1461653238-3891-3-git-send-email-ulf.hansson@linaro.org>
References: <1461653238-3891-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:32818 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbcDZGrd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 02:47:33 -0400
Received: by mail-lf0-f41.google.com with SMTP id y84so5447509lfc.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2016 23:47:32 -0700 (PDT)
In-Reply-To: <1461653238-3891-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

As the PM core already have wakeup management during the system PM phase,
it seems reasonable that genpd and its users should be able to rely on
that. Therefore let's remove this from pm_genpd_prepare().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	None.

---
 drivers/base/power/domain.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 60a3573..de23b64 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -730,12 +730,6 @@ static int pm_genpd_prepare(struct device *dev)
 	 * at this point and a system wakeup event should be reported if it's
 	 * set up to wake up the system from sleep states.
 	 */
-	if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
-		pm_wakeup_event(dev, 0);
-
-	if (pm_wakeup_pending())
-		return -EBUSY;
-
 	if (resume_needed(dev, genpd))
 		pm_runtime_resume(dev);
 
-- 
1.9.1

