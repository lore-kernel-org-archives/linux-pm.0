From: Takeshi Yoshimura <yos@sslab.ics.keio.ac.jp>
Subject: [PATCH 1/1] wm831x_power: Fix off-by-one at free_irq()
Date: Sun, 14 Jun 2015 20:55:18 +0900
Message-ID: <1434282918-6980-1-git-send-email-yos@sslab.ics.keio.ac.jp>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33892 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbbFNL6f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jun 2015 07:58:35 -0400
Received: by pacgb13 with SMTP id gb13so17971309pac.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2015 04:58:35 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Takeshi Yoshimura <yos@sslab.ics.keio.ac.jp>

An error handling in wm831x_power_probe() mistakenly frees a failed-to-
request irq as well as other irqs. I added missing decrement of the loop
counter.

Signed-off-by: Takeshi Yoshimura <yos@sslab.ics.keio.ac.jp>
---
 drivers/power/wm831x_power.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/wm831x_power.c b/drivers/power/wm831x_power.c
index 0161bda..db11ae6 100644
--- a/drivers/power/wm831x_power.c
+++ b/drivers/power/wm831x_power.c
@@ -609,6 +609,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	return ret;
 
 err_bat_irq:
+	--i;
 	for (; i >= 0; i--) {
 		irq = platform_get_irq_byname(pdev, wm831x_bat_irqs[i]);
 		free_irq(irq, power);
-- 
1.9.1

