From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] pm2301-charger: Combine substrings for three messages
Date: Sat, 16 Dec 2017 21:15:34 +0100
Message-ID: <6ffb5b34-3e1c-8f9b-6eaa-ad68b9e4e75a@users.sourceforge.net>
References: <b11627bc-502d-b3af-ee96-ac2a693448a7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:52332 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756881AbdLPUPj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Dec 2017 15:15:39 -0500
In-Reply-To: <b11627bc-502d-b3af-ee96-ac2a693448a7@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 16 Dec 2017 20:51:10 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/pm2301_charger.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index 99a9892f0f68..fa37144d9638 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -742,8 +742,7 @@ static int pm2xxx_charger_ac_en(struct ux500_charger *charger,
 
 		if (volt_index < 0 || curr_index < 0) {
 			dev_err(pm2->dev,
-				"Charger voltage or current too high, "
-				"charging not started\n");
+				"Charger voltage or current too high, charging not started\n");
 			return -ENXIO;
 		}
 
@@ -791,8 +790,8 @@ static int pm2xxx_charger_ac_en(struct ux500_charger *charger,
 
 		ret = pm2xxx_charging_enable_mngt(pm2);
 		if (ret < 0) {
-			dev_err(pm2->dev, "Failed to enable"
-						"pm2xxx ac charger\n");
+			dev_err(pm2->dev,
+				"Failed to enable pm2xxx ac charger\n");
 			goto error_occured;
 		}
 
@@ -809,8 +808,8 @@ static int pm2xxx_charger_ac_en(struct ux500_charger *charger,
 
 		ret = pm2xxx_charging_disable_mngt(pm2);
 		if (ret < 0) {
-			dev_err(pm2->dev, "failed to disable"
-						"pm2xxx ac charger\n");
+			dev_err(pm2->dev,
+				"failed to disable pm2xxx ac charger\n");
 			goto error_occured;
 		}
 
-- 
2.15.1
