From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v4 2/7] power: bq24190_charger: Call set_mode_host() on pm_resume()
Date: Wed, 18 Jan 2017 09:26:49 -0800
Message-ID: <20170118172654.19416-3-liam@networkimprov.net>
References: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
 <20170118172654.19416-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32811 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbdARR2V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2017 12:28:21 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so1521616pfg.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2017 09:28:21 -0800 (PST)
In-Reply-To: <20170118172654.19416-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

pm_resume() does a register_reset() which clears charger host mode.

Fix by calling set_mode_host() after the reset.

Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Mark Greer <mgreer@animalcreek.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index f5746b9..b51eac1 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1494,6 +1494,7 @@ static int bq24190_pm_resume(struct device *dev)
 
 	pm_runtime_get_sync(bdi->dev);
 	bq24190_register_reset(bdi);
+	bq24190_set_mode_host(bdi);
 	pm_runtime_put_sync(bdi->dev);
 
 	/* Things may have changed while suspended so alert upper layer */
