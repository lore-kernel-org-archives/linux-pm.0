From: <grygorii.strashko@linaro.org>
Subject: [PATCH] thermal: ti-soc-thermal: bandgap: Fix build warning if !CONFIG_PM_SLEEP
Date: Fri,  6 Feb 2015 16:55:46 +0200
Message-ID: <1423234546-10458-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:56845 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238AbbBFOzw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Feb 2015 09:55:52 -0500
Received: by mail-lb0-f172.google.com with SMTP id l4so18400976lbv.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Feb 2015 06:55:51 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com, Grygorii Strashko <Grygorii.Strashko@linaro.org>

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Fix following build warning if CONFIG_PM_SLEEP is not set:

drivers/thermal/ti-soc-thermal/ti-bandgap.c:1478:12: warning: 'ti_bandgap_suspend' defined but not used [-Wunused-function]
 static int ti_bandgap_suspend(struct device *dev)
            ^
drivers/thermal/ti-soc-thermal/ti-bandgap.c:1492:12: warning: 'ti_bandgap_resume' defined but not used [-Wunused-function]
 static int ti_bandgap_resume(struct device *dev)
            ^
Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 74c0e34..5d46660 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1402,7 +1402,7 @@ int ti_bandgap_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int ti_bandgap_save_ctxt(struct ti_bandgap *bgp)
 {
 	int i;
-- 
1.9.1

