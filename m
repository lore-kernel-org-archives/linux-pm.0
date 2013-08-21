From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] PM / devfreq: exynos: remove unnecessary platform_set_drvdata()
Date: Wed, 21 Aug 2013 18:33:56 +0900
Message-ID: <002701ce9e51$8f008a80$ad019f80$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38200 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab3HUJd7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2013 05:33:59 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRV00DHEJWM5MY0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 21 Aug 2013 18:33:58 +0900 (KST)
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'MyungJoo Ham' <myungjoo.ham@samsung.com>
Cc: 'Kyungmin Park' <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/devfreq/exynos/exynos5_bus.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
index 574b16b..65b3fa9 100644
--- a/drivers/devfreq/exynos/exynos5_bus.c
+++ b/drivers/devfreq/exynos/exynos5_bus.c
@@ -419,7 +419,6 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 
 err_devfreq_add:
 	devfreq_remove_device(data->devfreq);
-	platform_set_drvdata(pdev, NULL);
 err_opp_add:
 	clk_put(data->int_clk);
 err_clock:
@@ -437,7 +436,6 @@ static int exynos5_busfreq_int_remove(struct platform_device *pdev)
 	devfreq_remove_device(data->devfreq);
 	regulator_put(data->vdd_int);
 	clk_put(data->int_clk);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.10.4


