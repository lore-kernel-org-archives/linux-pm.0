From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] PM / OPP: Move error message to debug level
Date: Fri, 29 Sep 2017 14:39:49 -0300
Message-ID: <1506706789-7717-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:53472
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752006AbdI2Rkp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Sep 2017 13:40:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vireshk@kernel.org
Cc: nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, festevam@gmail.com, shawnguo@kernel.org, anson.huang@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>

On some i.MX6 platforms which do not have speed grading
check, opp table will not be created in platform code,
so cpufreq driver prints the following error message:

cpu cpu0: dev_pm_opp_get_opp_count: OPP table not found (-19)

However, this is not really an error in this case because the
imx6q-cpufreq driver first calls dev_pm_opp_get_opp_count()
and if it fails, it means that platform code does not provide
OPP and then dev_pm_opp_of_add_table() will be called.

In order to avoid such confusing error message, move it to
debug level.

It is up to the caller of dev_pm_opp_get_opp_count() to check its
return value and decide if it will print an error or not.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Previous discussion on this topic:
https://patchwork.kernel.org/patch/9295059/

 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index a6de325..0459b12 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -296,7 +296,7 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		count = PTR_ERR(opp_table);
-		dev_err(dev, "%s: OPP table not found (%d)\n",
+		dev_dbg(dev, "%s: OPP table not found (%d)\n",
 			__func__, count);
 		return count;
 	}
-- 
2.7.4
