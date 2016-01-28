From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 5/9] power: charger_manager: convert to use match_string() helper
Date: Thu, 28 Jan 2016 15:14:21 +0200
Message-ID: <1453986865-133572-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3144 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967553AbcA1NOg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Jan 2016 08:14:36 -0500
In-Reply-To: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The new helper returns index of the mathing string in an array. We would use it
here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/power/charger-manager.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 1ea5d1a..e664ca7 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -2020,27 +2020,6 @@ static void __exit charger_manager_cleanup(void)
 module_exit(charger_manager_cleanup);
 
 /**
- * find_power_supply - find the associated power_supply of charger
- * @cm: the Charger Manager representing the battery
- * @psy: pointer to instance of charger's power_supply
- */
-static bool find_power_supply(struct charger_manager *cm,
-			struct power_supply *psy)
-{
-	int i;
-	bool found = false;
-
-	for (i = 0; cm->desc->psy_charger_stat[i]; i++) {
-		if (!strcmp(psy->desc->name, cm->desc->psy_charger_stat[i])) {
-			found = true;
-			break;
-		}
-	}
-
-	return found;
-}
-
-/**
  * cm_notify_event - charger driver notify Charger Manager of charger event
  * @psy: pointer to instance of charger's power_supply
  * @type: type of charger event
@@ -2057,9 +2036,11 @@ void cm_notify_event(struct power_supply *psy, enum cm_event_types type,
 
 	mutex_lock(&cm_list_mtx);
 	list_for_each_entry(cm, &cm_list, entry) {
-		found_power_supply = find_power_supply(cm, psy);
-		if (found_power_supply)
+		if (match_string(cm->desc->psy_charger_stat, -1,
+				 psy->desc->name) >= 0) {
+			found_power_supply = true;
 			break;
+		}
 	}
 	mutex_unlock(&cm_list_mtx);
 
-- 
2.7.0.rc3

