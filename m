From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH 1/1] power: check return value of devm_kzalloc
Date: Sun, 23 Apr 2017 17:03:56 +0800
Message-ID: <1492938236-9928-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m50-134.163.com ([123.125.50.134]:58927 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756237AbdDWJEN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Apr 2017 05:04:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>

Function devm_kzalloc() will return a NULL pointer if there is no enough
memory. However, in function isp1704_charger_probe(), the return value
of devm_kzalloc() is used without validation. This may result in a bad
memory access bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/power/supply/isp1704_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/supply/isp1704_charger.c
index 4cd6899..4dd2482 100644
--- a/drivers/power/supply/isp1704_charger.c
+++ b/drivers/power/supply/isp1704_charger.c
@@ -418,6 +418,8 @@ static int isp1704_charger_probe(struct platform_device *pdev)
 
 		pdata = devm_kzalloc(&pdev->dev,
 			sizeof(struct isp1704_charger_data), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
 		pdata->enable_gpio = gpio;
 
 		dev_info(&pdev->dev, "init gpio %d\n", pdata->enable_gpio);
-- 
1.9.1
