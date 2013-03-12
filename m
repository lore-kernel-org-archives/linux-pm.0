From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] thermal: db8500: Fix checking return value of
 thermal_zone_device_register
Date: Tue, 12 Mar 2013 23:42:20 +0800
Message-ID: <1363102940.3160.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:59449 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932870Ab3CLPm2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Mar 2013 11:42:28 -0400
Received: by mail-ia0-f175.google.com with SMTP id y26so845674iab.20
        for <linux-pm@vger.kernel.org>; Tue, 12 Mar 2013 08:42:27 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Hongbo Zhang <hongbo.zhang@stericsson.com>, Viresh Kumar <viresh.kumar@linaro.org>, Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org

thermal_zone_device_register() returns ERR_PTR on error, thus use
IS_ERR rather than IS_ERR_OR_NULL to check return value.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/thermal/db8500_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 61ce60a..6bdcec4 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -447,7 +447,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	pzone->therm_dev = thermal_zone_device_register("db8500_thermal_zone",
 		ptrips->num_trips, 0, pzone, &thdev_ops, NULL, 0, 0);
 
-	if (IS_ERR_OR_NULL(pzone->therm_dev)) {
+	if (IS_ERR(pzone->therm_dev)) {
 		dev_err(&pdev->dev, "Register thermal zone device failed.\n");
 		return PTR_ERR(pzone->therm_dev);
 	}
-- 
1.7.9.5



