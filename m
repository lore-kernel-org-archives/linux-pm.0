From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 7/8] PM / domains: Fix missing default_power_down_ok comment
Date: Fri,  9 Jun 2017 18:08:52 +0200
Message-ID: <20170609160853.31789-8-krzk@kernel.org>
References: <20170609160853.31789-1-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751881AbdFIQJa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jun 2017 12:09:30 -0400
In-Reply-To: <20170609160853.31789-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Commit fc5cbf0c94b6 ("PM / Domains: Support for multiple states") split
out some code out of default_power_down_ok() function so the
documentation has to be moved to appropriate place.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/power/domain_governor.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 2e0fce711135..281f949c5ffe 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -92,12 +92,6 @@ static bool default_suspend_ok(struct device *dev)
 	return td->cached_suspend_ok;
 }
 
-/**
- * default_power_down_ok - Default generic PM domain power off governor routine.
- * @pd: PM domain to check.
- *
- * This routine must be executed under the PM domain's lock.
- */
 static bool __default_power_down_ok(struct dev_pm_domain *pd,
 				     unsigned int state)
 {
@@ -187,6 +181,12 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 	return true;
 }
 
+/**
+ * default_power_down_ok - Default generic PM domain power off governor routine.
+ * @pd: PM domain to check.
+ *
+ * This routine must be executed under the PM domain's lock.
+ */
 static bool default_power_down_ok(struct dev_pm_domain *pd)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
-- 
2.9.3
