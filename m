From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH 1/1] power: Fix unchecked return value of devm_kzalloc
Date: Mon, 24 Apr 2017 16:22:08 +0800
Message-ID: <1493022128-3918-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m12-11.163.com ([220.181.12.11]:36914 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758242AbdDXIWQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Apr 2017 04:22:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>

Function devm_kzalloc() will return a NULL pointer. However, in function
isp1704_charger_probe(), the return value of devm_kzalloc() is directly
used without validation. This may result in a bad memory access bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/power/supply/isp1704_charger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/supply/isp1704_charger.c
index 4cd6899..95af5f3 100644
--- a/drivers/power/supply/isp1704_charger.c
+++ b/drivers/power/supply/isp1704_charger.c
@@ -418,6 +418,10 @@ static int isp1704_charger_probe(struct platform_device *pdev)
 
 		pdata = devm_kzalloc(&pdev->dev,
 			sizeof(struct isp1704_charger_data), GFP_KERNEL);
+		if (!pdata) {
+			ret = -ENOMEM;
+			goto fail0;
+		}
 		pdata->enable_gpio = gpio;
 
 		dev_info(&pdev->dev, "init gpio %d\n", pdata->enable_gpio);
-- 
1.9.1
