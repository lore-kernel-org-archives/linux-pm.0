From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 1/5] power: bq24190_charger: Add ti,bq24192i to devicetree table
Date: Fri, 25 Aug 2017 22:14:09 -0700
Message-ID: <20170826051413.24569-2-liam@networkimprov.net>
References: <20170826051413.24569-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33955 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbdHZFOt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Aug 2017 01:14:49 -0400
Received: by mail-pg0-f68.google.com with SMTP id 63so2162509pgc.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2017 22:14:49 -0700 (PDT)
In-Reply-To: <20170826051413.24569-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

bq24192i was previously only in ID table, so add it to DT table.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq24190_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 14199561..40b4bba7 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1732,6 +1732,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
 #ifdef CONFIG_OF
 static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", },
+	{ .compatible = "ti,bq24192i", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq24190_of_match);
-- 
2.13.2
