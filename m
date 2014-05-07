From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/3] thermal: exynos: remove unnecessary OOM messages
Date: Wed, 07 May 2014 15:04:48 +0900
Message-ID: <01ac01cf69ba$40962910$c1c27b30$%han@samsung.com>
References: <01a401cf69ba$0f1b88d0$2d529a70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:24367 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbaEGGEu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 May 2014 02:04:50 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5600K39WW1A1C0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 07 May 2014 15:04:49 +0900 (KST)
In-reply-to: <01a401cf69ba$0f1b88d0$2d529a70$%han@samsung.com>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Zhang Rui' <rui.zhang@intel.com>
Cc: 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Amit Daniel Kachhap' <amit.daniel@samsung.com>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 0d96a51..9d17086 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -607,10 +607,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct exynos_tmu_data),
 					GFP_KERNEL);
-	if (!data) {
-		dev_err(&pdev->dev, "Failed to allocate driver structure\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(pdev, data);
 	mutex_init(&data->lock);
@@ -656,7 +654,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	sensor_conf = devm_kzalloc(&pdev->dev,
 				sizeof(struct thermal_sensor_conf), GFP_KERNEL);
 	if (!sensor_conf) {
-		dev_err(&pdev->dev, "Failed to allocate registration struct\n");
 		ret = -ENOMEM;
 		goto err_clk;
 	}
-- 
1.7.10.4


