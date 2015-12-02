From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Validate cases of a non-bound driver in genpd governor
Date: Wed,  2 Dec 2015 14:08:27 +0100
Message-ID: <1449061707-16030-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33559 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757392AbbLBNIc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 08:08:32 -0500
Received: by lfaz4 with SMTP id z4so49692928lfa.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2015 05:08:31 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>

Recently genpd removed the requirement of a having a driver bound for its
attached devices to allow genpd to power off. That change should also have
removed a corresponding validation in the governor, let's correct that.

Fixes: 298cd0f08801 ("PM / Domains: Remove dev->driver check for runtime")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain_governor.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index e60dd12..1e937ac 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -160,9 +160,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		struct gpd_timing_data *td;
 		s64 constraint_ns;
 
-		if (!pdd->dev->driver)
-			continue;
-
 		/*
 		 * Check if the device is allowed to be off long enough for the
 		 * domain to turn off and on (that's how much time it will
-- 
1.9.1

