From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] power_supply: tps65217-charger: fix missing platform_set_drvdata()
Date: Tue, 26 Jul 2016 14:49:04 +0000
Message-ID: <1469544544-31749-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33748 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549AbcGZOto (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2016 10:49:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id i6so115804pfe.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2016 07:49:44 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-pm@vger.kernel.org

Add missing platform_set_drvdata() in tps65217_charger_probe(), otherwise
calling platform_get_drvdata() in remove returns NULL.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/power/tps65217_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/tps65217_charger.c b/drivers/power/tps65217_charger.c
index 73dfae4..4c56e54 100644
--- a/drivers/power/tps65217_charger.c
+++ b/drivers/power/tps65217_charger.c
@@ -206,6 +206,7 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	if (!charger)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, charger);
 	charger->tps = tps;
 	charger->dev = &pdev->dev;

