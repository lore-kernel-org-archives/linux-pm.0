From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v2 1/5] power: bq24190_charger: Add ti,bq24192i to devicetree table
Date: Mon,  7 Aug 2017 12:54:16 -0700
Message-ID: <20170807195420.20767-2-liam@networkimprov.net>
References: <20170807195420.20767-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35551 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdHGTyk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2017 15:54:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id j68so1293337pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Aug 2017 12:54:40 -0700 (PDT)
In-Reply-To: <20170807195420.20767-1-liam@networkimprov.net>
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
 drivers/power/supply/bq24190_charger.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 14199561..3340ffa2 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1732,13 +1732,12 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
 #ifdef CONFIG_OF
 static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", },
+	{ .compatible = "ti,bq24192i", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq24190_of_match);
 #else
-static const struct of_device_id bq24190_of_match[] = {
-	{ },
-};
+static const struct of_device_id bq24190_of_match[] = { {} };
 #endif
 
 static struct i2c_driver bq24190_driver = {
-- 
2.13.2
