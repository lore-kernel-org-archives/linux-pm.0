From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: ti: move to new dev_pm_opp_set_supported_hw() API
Date: Thu,  9 Feb 2017 16:02:29 +0100
Message-ID: <20170209150240.1094801-1-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:63475 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdBIP4u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2017 10:56:50 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

We have a conflict between the interface change in one patch, and the
newly added driver using the old interface:

drivers/cpufreq/ti-cpufreq.c: In function 'ti_cpufreq_init':
drivers/cpufreq/ti-cpufreq.c:250:6: error: assignment makes integer from pointer without a cast [-Werror=int-conversion]

This adapts the driver accordingly.

Fixes: fa30184d192e ("PM / OPP: Return opp_table from dev_pm_opp_set_*() routines")
Fixes: 36cae4bca3bc ("cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/ti-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index a2a4e84c6166..d1ae3e608f59 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -247,8 +247,8 @@ static int ti_cpufreq_init(void)
 
 	of_node_put(opp_data->opp_node);
 
-	ret = dev_pm_opp_set_supported_hw(opp_data->cpu_dev, version,
-					  VERSION_COUNT);
+	ret = PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
+						 version, VERSION_COUNT));
 	if (ret) {
 		dev_err(opp_data->cpu_dev,
 			"Failed to set supported hardware\n");
-- 
2.9.0

