From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 1/3] power: supply: bq24190_charger: Use new extcon_register_notifier_all()
Date: Wed, 12 Apr 2017 20:18:06 +0200
Message-ID: <20170412181808.31768-2-hdegoede@redhat.com>
References: <20170412181808.31768-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752282AbdDLSSN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Apr 2017 14:18:13 -0400
In-Reply-To: <20170412181808.31768-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

When I submitted the extcon handling I had a patch pending for the
extcon sub-system for extcon_register_notifier to take -1 as cable id
for listening for all type cable events on an extcon with a single
notifier.

In the end it was decided to instead add a new
extcon_register_notifier_all function for this, switch to using this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
-This is a new patch in v4 of this patch-set
---
 drivers/power/supply/bq24190_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 7c893c0..bd9e5c3 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1502,8 +1502,8 @@ static int bq24190_probe(struct i2c_client *client,
 	if (bdi->extcon) {
 		INIT_DELAYED_WORK(&bdi->extcon_work, bq24190_extcon_work);
 		bdi->extcon_nb.notifier_call = bq24190_extcon_event;
-		ret = devm_extcon_register_notifier(dev, bdi->extcon, -1,
-						    &bdi->extcon_nb);
+		ret = devm_extcon_register_notifier_all(dev, bdi->extcon,
+							&bdi->extcon_nb);
 		if (ret) {
 			dev_err(dev, "Can't register extcon\n");
 			goto out_sysfs;
-- 
2.9.3
