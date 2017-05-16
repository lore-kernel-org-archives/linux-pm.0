From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / Domains: pdd->dev can't be NULL in genpd_dev_pm_qos_notifier()
Date: Tue, 16 May 2017 10:52:43 +0530
Message-ID: <201976beb620010271d6f842abbc40a93f55bd73.1494912124.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:32947 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdEPFXC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2017 01:23:02 -0400
Received: by mail-pg0-f52.google.com with SMTP id u187so70590924pgb.0
        for <linux-pm@vger.kernel.org>; Mon, 15 May 2017 22:22:57 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

The pm_domain_data (pdd) pointer is set from genpd_alloc_dev_data() and
pdd->dev is guaranteed to be valid. There is no need to check pdd and
pdd->dev in rest of the code as pdd->dev will always be valid for a non
NULL pdd pointer.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index da49a8383dc3..71c95ad808d5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -443,7 +443,7 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 
 		pdd = dev->power.subsys_data ?
 				dev->power.subsys_data->domain_data : NULL;
-		if (pdd && pdd->dev) {
+		if (pdd) {
 			to_gpd_data(pdd)->td.constraint_changed = true;
 			genpd = dev_to_genpd(dev);
 		} else {
-- 
2.13.0.303.g4ebf3021692d
