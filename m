From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery device .type=unknown
Date: Tue, 21 Mar 2017 15:09:21 -0700
Message-ID: <20170321220921.5834-8-liam@networkimprov.net>
References: <20170321220921.5834-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35110 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933021AbdCUWRo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 18:17:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id n11so12564418pfg.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2017 15:17:38 -0700 (PDT)
In-Reply-To: <20170321220921.5834-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

From: Liam Breck <kernel@networkimprov.net>

Not for upstream. Temporary workaround to prevent bq24190-battery device
from interfering with a fuel gauge that has .type=power_supply_type_battery

I'll move properties from -battery device to -charger in a subsequent version.

Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index a52816b..12f3780 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1228,7 +1228,7 @@ static enum power_supply_property bq24190_battery_properties[] = {
 
 static const struct power_supply_desc bq24190_battery_desc = {
 	.name			= "bq24190-battery",
-	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.type			= POWER_SUPPLY_TYPE_UNKNOWN,
 	.properties		= bq24190_battery_properties,
 	.num_properties		= ARRAY_SIZE(bq24190_battery_properties),
 	.get_property		= bq24190_battery_get_property,
-- 
2.9.3
