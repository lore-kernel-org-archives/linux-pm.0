From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power_supply: lp8788-charger: initialize boolean 'found'
Date: Sat, 27 Feb 2016 12:54:11 +0000
Message-ID: <1456577651-5644-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60346 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbcB0MyQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 07:54:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Milo Kim <milo.kim@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The boolean 'found' is not initialized and hence garbage. It should
be initialized as false.

Found with static analysis using CoverityScan

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/lp8788-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/lp8788-charger.c b/drivers/power/lp8788-charger.c
index f5a48fd..7321b72 100644
--- a/drivers/power/lp8788-charger.c
+++ b/drivers/power/lp8788-charger.c
@@ -455,7 +455,7 @@ static void lp8788_charger_event(struct work_struct *work)
 
 static bool lp8788_find_irq_id(struct lp8788_charger *pchg, int virq, int *id)
 {
-	bool found;
+	bool found = false;
 	int i;
 
 	for (i = 0; i < pchg->num_irqs; i++) {
-- 
2.7.0

