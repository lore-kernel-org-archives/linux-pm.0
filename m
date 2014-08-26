From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/2] power: charger-manager: Fix checking of wrong return type
Date: Tue, 26 Aug 2014 13:41:38 +0900
Message-ID: <1409028099-6081-2-git-send-email-cw00.choi@samsung.com>
References: <1409028099-6081-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61526 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbaHZEln (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Aug 2014 00:41:43 -0400
In-reply-to: <1409028099-6081-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: myungjoo.ham@samsung.com, jonghwa3.lee@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch fix minor issue about checking wrong return type.

The of_cm_parse_desc() return ERR_PTR(errnor number) when some error happen
in this function. But, charger_manager_probe() has only checked whether
desc is NULL or not. If of_cm_parse_desc() returns ERR_PTR(-ENOMEM), desc
isn't NULL but desc is (void *)(-ENOMEM). Althouhg some error happen for parsing
DT, charger_manager_probe() can't detect error of desc instance.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/power/charger-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 9e4dab4..a10fb57 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1677,7 +1677,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (!desc) {
+	if (IS_ERR(desc)) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
 		return -ENODEV;
 	}
-- 
1.8.0

