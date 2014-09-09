From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND PATCH 1/2] power: max8925: Fix NULL ptr dereference on memory
 allocation failure
Date: Tue, 09 Sep 2014 11:47:14 +0200
Message-ID: <1410256035-24051-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:65252 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbaIIJr3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 05:47:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Check the return value of devm_kzalloc() to fix possible NULL pointer
dereference and properly exit the probe() on memory allocation failure.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/max8925_power.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/max8925_power.c b/drivers/power/max8925_power.c
index b4513f284bbc..0cf237808d47 100644
--- a/drivers/power/max8925_power.c
+++ b/drivers/power/max8925_power.c
@@ -452,13 +452,14 @@ max8925_power_dt_init(struct platform_device *pdev)
 	pdata = devm_kzalloc(&pdev->dev,
 			sizeof(struct max8925_power_pdata),
 			GFP_KERNEL);
+	if (!pdata)
+		goto ret;
 
 	of_property_read_u32(np, "topoff-threshold", &topoff_threshold);
 	of_property_read_u32(np, "batt-detect", &batt_detect);
 	of_property_read_u32(np, "fast-charge", &fast_charge);
 	of_property_read_u32(np, "no-insert-detect", &no_insert_detect);
 	of_property_read_u32(np, "no-temp-support", &no_temp_support);
-	of_node_put(np);
 
 	pdata->batt_detect = batt_detect;
 	pdata->fast_charge = fast_charge;
@@ -466,6 +467,8 @@ max8925_power_dt_init(struct platform_device *pdev)
 	pdata->no_insert_detect = no_insert_detect;
 	pdata->no_temp_support = no_temp_support;
 
+ret:
+	of_node_put(np);
 	return pdata;
 }
 #else
-- 
1.9.1

