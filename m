From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] PM / Domains: provide pm_genpd_poweroff_noirq stub
Date: Fri, 30 Jun 2017 18:06:57 +0200
Message-ID: <20170630160816.4153006-1-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59278 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdF3QIe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2017 12:08:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

When CONFIG_PM_SLEEP is disabled, we don't have a pm_genpd_poweroff_noirq
function definition:

drivers/base/power/domain.c: In function 'pm_genpd_init':
drivers/base/power/domain.c:1549:37: error: 'pm_genpd_poweroff_noirq' undeclared (first use in this function); did you mean 'genpd_power_off_unused'?

This adds another NULL definition for it, just like we already have
for the other _noirq handlers.

Fixes: 10da65423fdb ("PM / Domains: Call driver's noirq callbacks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/base/power/domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ac1ff052653f..a380d9d61335 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1158,6 +1158,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 #define pm_genpd_resume_noirq		NULL
 #define pm_genpd_freeze_noirq		NULL
 #define pm_genpd_thaw_noirq		NULL
+#define pm_genpd_poweroff_noirq		NULL
 #define pm_genpd_restore_noirq		NULL
 #define pm_genpd_complete		NULL
 
-- 
2.9.0
