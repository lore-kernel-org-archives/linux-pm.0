From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v4 1/5] power: bq24190_charger: Add ti,bq24192i to devicetree table
Date: Mon, 28 Aug 2017 14:23:45 -0700
Message-ID: <20170828212349.19037-2-liam@networkimprov.net>
References: <20170828212349.19037-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36648 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdH1VYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2017 17:24:20 -0400
Received: by mail-pg0-f65.google.com with SMTP id 83so1210888pgb.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2017 14:24:20 -0700 (PDT)
In-Reply-To: <20170828212349.19037-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

bq24192i was previously only in ID table, so add it to DT table.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Tony Lindgren <tony@atomide.com>
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
