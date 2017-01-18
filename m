From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v4 4/7] power: bq24190_charger: Adjust formatting
Date: Wed, 18 Jan 2017 09:26:51 -0800
Message-ID: <20170118172654.19416-5-liam@networkimprov.net>
References: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
 <20170118172654.19416-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36843 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdARR2a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2017 12:28:30 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so1506965pfo.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2017 09:28:29 -0800 (PST)
In-Reply-To: <20170118172654.19416-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Add breathing room in probe() out* section.

Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Mark A. Greer <mgreer@animalcreek.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 54c8952..62194d8 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1440,15 +1440,17 @@ static int bq24190_probe(struct i2c_client *client,
 
 out4:
 	bq24190_sysfs_remove_group(bdi);
+
 out3:
 	power_supply_unregister(bdi->battery);
+
 out2:
 	power_supply_unregister(bdi->charger);
+
 out1:
 	pm_runtime_disable(dev);
 	if (bdi->gpio_int)
 		gpio_free(bdi->gpio_int);
-
 	return ret;
 }
 
