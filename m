From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] power: supply: core: Delete two error messages for a failed
 memory allocation in power_supply_check_supplies()
Date: Sat, 26 Aug 2017 19:37:00 +0200
Message-ID: <5f2600b3-e498-af9f-32b3-b41ebd81159b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:60386 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbdHZRhF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 26 Aug 2017 13:37:05 -0400
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 26 Aug 2017 19:22:32 +0200

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/power_supply_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 540d3e0aa011..3d46863baa52 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -259,18 +259,14 @@ static int power_supply_check_supplies(struct power_supply *psy)
 	/* All supplies found, allocate char ** array for filling */
 	psy->supplied_from = devm_kzalloc(&psy->dev, sizeof(psy->supplied_from),
 					  GFP_KERNEL);
-	if (!psy->supplied_from) {
-		dev_err(&psy->dev, "Couldn't allocate memory for supply list\n");
+	if (!psy->supplied_from)
 		return -ENOMEM;
-	}
 
 	*psy->supplied_from = devm_kzalloc(&psy->dev,
 					   sizeof(char *) * (cnt - 1),
 					   GFP_KERNEL);
-	if (!*psy->supplied_from) {
-		dev_err(&psy->dev, "Couldn't allocate memory for supply list\n");
+	if (!*psy->supplied_from)
 		return -ENOMEM;
-	}
 
 	return power_supply_populate_supplied_from(psy);
 }
-- 
2.14.0
