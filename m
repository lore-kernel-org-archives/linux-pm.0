From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v4 1/7] power: bq24190_charger: Fix irq trigger to IRQF_TRIGGER_FALLING
Date: Wed, 18 Jan 2017 09:26:48 -0800
Message-ID: <20170118172654.19416-2-liam@networkimprov.net>
References: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
 <20170118172654.19416-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35693 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdARR2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2017 12:28:16 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so1514126pfa.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2017 09:28:16 -0800 (PST)
In-Reply-To: <20170118172654.19416-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

The interrupt signal is TRIGGER_FALLING. This is is specified in the
data sheet PIN FUNCTIONS: "The INT pin sends active low, 256us
pulse to host to report charger device status and fault."

Also the direction can be seen in the data sheet Figure 37 "BQ24190
with D+/D- Detection and USB On-The-Go (OTG)" which shows a 10k
pull-up resistor installed for the sample configurations.

Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Mark Greer <mgreer@animalcreek.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 694c088..f5746b9 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1394,7 +1394,7 @@ static int bq24190_probe(struct i2c_client *client,
 
 	ret = devm_request_threaded_irq(dev, bdi->irq, NULL,
 			bq24190_irq_handler_thread,
-			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			"bq24190-charger", bdi);
 	if (ret < 0) {
 		dev_err(dev, "Can't set up irq handler\n");
