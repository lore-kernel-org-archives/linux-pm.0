From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 1/3] power: supply: bq24735-charger: simplify register update to stop charging
Date: Wed, 14 Dec 2016 00:56:43 +0100
Message-ID: <1481673405-4547-2-git-send-email-peda@axentia.se>
References: <1481673405-4547-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve1eur01on0130.outbound.protection.outlook.com ([104.47.1.130]:39280
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751256AbcLNDcu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Dec 2016 22:32:50 -0500
In-Reply-To: <1481673405-4547-1-git-send-email-peda@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Providing value bits outside of the mask is pointless.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/power/supply/bq24735-charger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index eb7783b42e0a..1d5c9206e0ed 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -111,8 +111,7 @@ static inline int bq24735_enable_charging(struct bq24735 *charger)
 		return 0;
 
 	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
-				   BQ24735_CHG_OPT_CHARGE_DISABLE,
-				   ~BQ24735_CHG_OPT_CHARGE_DISABLE);
+				   BQ24735_CHG_OPT_CHARGE_DISABLE, 0);
 }
 
 static inline int bq24735_disable_charging(struct bq24735 *charger)
-- 
2.1.4

