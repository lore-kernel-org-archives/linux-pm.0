From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v4 6/7] max8903: remove unnecessary 'out of memory' error message.
Date: Mon, 20 Jun 2016 08:27:21 +1000
Message-ID: <1466375242-38354-7-git-send-email-chris@cpdesign.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466375242-38354-1-git-send-email-chris@cpdesign.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34681 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbcFTHWM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 03:22:12 -0400
Received: by mail-pa0-f68.google.com with SMTP id us13so10370097pab.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 00:21:16 -0700 (PDT)
In-Reply-To: <1466375242-38354-1-git-send-email-chris@cpdesign.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

Remove the 'out of memory' error message as it is printed by the core.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/max8903_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 643a87a..9453bbf 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -304,10 +304,8 @@ static int max8903_probe(struct platform_device *pdev)
 	}
 
 	data = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
-	if (data == NULL) {
-		dev_err(dev, "Cannot allocate memory.\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	data->pdata = pdev->dev.platform_data;
 	data->dev = dev;
-- 
1.9.1

