From: Takeshi Yoshimura <yos@sslab.ics.keio.ac.jp>
Subject: [PATCH 1/1] power_supply: 88pm860x_charger: Do not call free_irq() twice
Date: Fri, 29 May 2015 13:16:43 +0000
Message-ID: <1432905403-27416-1-git-send-email-yos@sslab.ics.keio.ac.jp>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35378 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238AbbE2NS0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2015 09:18:26 -0400
Received: by pacrp13 with SMTP id rp13so12635675pac.2
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2015 06:18:25 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Takeshi Yoshimura <yos@sslab.ics.keio.ac.jp>

My static checker detected double free_irq() in pm860x_charger_remove().
Unloading this module always causes a warning. This patch removes the
first redundant free_irq() call.

Signed-off-by: Takeshi Yoshimura <yos@sslab.ics.keio.ac.jp>
---
 drivers/power/88pm860x_charger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/88pm860x_charger.c
index 0e448c6..297e72d 100644
--- a/drivers/power/88pm860x_charger.c
+++ b/drivers/power/88pm860x_charger.c
@@ -742,7 +742,6 @@ static int pm860x_charger_remove(struct platform_device *pdev)
 	int i;
 
 	power_supply_unregister(info->usb);
-	free_irq(info->irq[0], info);
 	for (i = 0; i < info->irq_nums; i++)
 		free_irq(info->irq[i], info);
 	return 0;
-- 
2.1.0

