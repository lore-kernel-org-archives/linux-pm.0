From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2] thermal: Exynos: Deletion of unnecessary checks before
 two function calls
Date: Fri, 21 Nov 2014 17:17:26 +0100
Message-ID: <546F6596.6010103@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net> <546F1017.5080403@users.sourceforge.net> <alpine.DEB.2.10.1411211116580.2554@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:62578 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412AbaKUQSN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Nov 2014 11:18:13 -0500
In-Reply-To: <alpine.DEB.2.10.1411211116580.2554@hadrien>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 21 Nov 2014 17:11:49 +0100

The functions cpufreq_cooling_unregister() and thermal_zone_device_unregister()
test whether their argument is NULL and then return immediately.
Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/thermal/samsung/exynos_thermal_common.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index 3f5ad25..b6be572 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -417,13 +417,10 @@ void exynos_unregister_thermal(struct thermal_sensor_conf *sensor_conf)
 
 	th_zone = sensor_conf->pzone_data;
 
-	if (th_zone->therm_dev)
-		thermal_zone_device_unregister(th_zone->therm_dev);
+	thermal_zone_device_unregister(th_zone->therm_dev);
 
-	for (i = 0; i < th_zone->cool_dev_size; i++) {
-		if (th_zone->cool_dev[i])
-			cpufreq_cooling_unregister(th_zone->cool_dev[i]);
-	}
+	for (i = 0; i < th_zone->cool_dev_size; ++i)
+		cpufreq_cooling_unregister(th_zone->cool_dev[i]);
 
 	dev_info(sensor_conf->dev,
 		"Exynos: Kernel Thermal management unregistered\n");
-- 
2.1.3

