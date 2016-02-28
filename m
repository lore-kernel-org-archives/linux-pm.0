From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power_supply: 88pm860x_charger: do not pass NULL to power_supply_put
Date: Sun, 28 Feb 2016 19:57:58 +0000
Message-ID: <1456689478-7318-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48073 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbcB1T6E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 28 Feb 2016 14:58:04 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where power_supply_get_by_name returns NULL the current
error return path calls power_supply_put with a NULL psy which will
cause a null pointer dereference.  Avoid this with an immediate
return.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/88pm860x_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/88pm860x_charger.c
index 297e72d..2b82e44 100644
--- a/drivers/power/88pm860x_charger.c
+++ b/drivers/power/88pm860x_charger.c
@@ -435,7 +435,7 @@ static irqreturn_t pm860x_temp_handler(int irq, void *data)
 
 	psy = power_supply_get_by_name(pm860x_supplied_to[0]);
 	if (!psy)
-		goto out;
+		return IRQ_HANDLED;
 	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_TEMP, &temp);
 	if (ret)
 		goto out;
-- 
2.7.0

