From: nicolassaenzj@gmail.com
Subject: [PATCH] power: generic-adc-battery: Fix power_supply_property returned value
Date: Sun,  8 Mar 2015 19:21:20 +0000
Message-ID: <1425842480-8746-1-git-send-email-nicolassaenzj@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:38732 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbCHTVa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 8 Mar 2015 15:21:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Saenz Julienne <nicolassaenzj@gmail.com>

From: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>

The POWER_SUPPLY_PROP_STATUS case in gab_get_property() wasn't providing any
value.

Signed-off-by: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
---
 drivers/power/generic-adc-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/generic-adc-battery.c b/drivers/power/generic-adc-battery.c
index d72733e..0a566ac 100644
--- a/drivers/power/generic-adc-battery.c
+++ b/drivers/power/generic-adc-battery.c
@@ -159,7 +159,7 @@ static int gab_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		gab_get_status(adc_bat);
+		val->intval = gab_get_status(adc_bat);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN:
 		val->intval = 0;
-- 
2.3.2

