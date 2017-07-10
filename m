From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH] PM / Domains: Fix compilation error for devices that don't enable PM_SLEEP
Date: Mon, 10 Jul 2017 16:14:48 -0500
Message-ID: <20170710211448.11046-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:54474 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbdGJVP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 17:15:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mperttunen@nvidia.com, ulf.hansson@linaro.org, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>

Set pm_genpd_poweroff_noirq to NULL if CONFIG_PM_SLEEP isn't enabled.
This is the same approach done for other PM_SLEEP related functions.

Without this patch building the kernel with the keystone_defconfig
results in a compilation error.

Fixes: 10da65423fdb ("PM / Domains: Call driver's noirq callbacks")

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/base/power/domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9649dce..c140a9d5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1182,6 +1182,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 #define pm_genpd_thaw_noirq		NULL
 #define pm_genpd_restore_noirq		NULL
 #define pm_genpd_complete		NULL
+#define pm_genpd_poweroff_noirq		NULL
 
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.10.0
