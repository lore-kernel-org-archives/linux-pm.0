From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 6/9] power: ab8500: convert to use match_string() helper
Date: Thu, 28 Jan 2016 15:14:22 +0200
Message-ID: <1453986865-133572-7-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34771 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967353AbcA1NPE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Jan 2016 08:15:04 -0500
In-Reply-To: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The new helper returns index of the mathing string in an array. We would use it
here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/ab8500_btemp.c    | 15 +++++----------
 drivers/power/ab8500_charger.c  | 16 +++++-----------
 drivers/power/ab8500_fg.c       | 15 +++++----------
 drivers/power/abx500_chargalg.c | 14 +++++---------
 4 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index 8f8044e..bf2e5dd 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -906,26 +906,21 @@ static int ab8500_btemp_get_property(struct power_supply *psy,
 static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
 {
 	struct power_supply *psy;
-	struct power_supply *ext;
+	struct power_supply *ext = dev_get_drvdata(dev);
+	const char **supplicants = (const char **)ext->supplied_to;
 	struct ab8500_btemp *di;
 	union power_supply_propval ret;
-	int i, j;
-	bool psy_found = false;
+	int j;
 
 	psy = (struct power_supply *)data;
-	ext = dev_get_drvdata(dev);
 	di = power_supply_get_drvdata(psy);
 
 	/*
 	 * For all psy where the name of your driver
 	 * appears in any supplied_to
 	 */
-	for (i = 0; i < ext->num_supplicants; i++) {
-		if (!strcmp(ext->supplied_to[i], psy->desc->name))
-			psy_found = true;
-	}
-
-	if (!psy_found)
+	j = match_string(supplicants, ext->num_supplicants, psy->desc->name);
+	if (j < 0)
 		return 0;
 
 	/* Go through all properties for the psy */
diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index e388171..30de5d4 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -1929,11 +1929,11 @@ static int ab8540_charger_usb_pre_chg_enable(struct ux500_charger *charger,
 static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
 {
 	struct power_supply *psy;
-	struct power_supply *ext;
+	struct power_supply *ext = dev_get_drvdata(dev);
+	const char **supplicants = (const char **)ext->supplied_to;
 	struct ab8500_charger *di;
 	union power_supply_propval ret;
-	int i, j;
-	bool psy_found = false;
+	int j;
 	struct ux500_charger *usb_chg;
 
 	usb_chg = (struct ux500_charger *)data;
@@ -1941,15 +1941,9 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
 
 	di = to_ab8500_charger_usb_device_info(usb_chg);
 
-	ext = dev_get_drvdata(dev);
-
 	/* For all psy where the driver name appears in any supplied_to */
-	for (i = 0; i < ext->num_supplicants; i++) {
-		if (!strcmp(ext->supplied_to[i], psy->desc->name))
-			psy_found = true;
-	}
-
-	if (!psy_found)
+	j = match_string(supplicants, ext->num_supplicants, psy->desc->name);
+	if (j < 0)
 		return 0;
 
 	/* Go through all properties for the psy */
diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 3830dad..5a36cf8 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -2168,26 +2168,21 @@ static int ab8500_fg_get_property(struct power_supply *psy,
 static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 {
 	struct power_supply *psy;
-	struct power_supply *ext;
+	struct power_supply *ext = dev_get_drvdata(dev);
+	const char **supplicants = (const char **)ext->supplied_to;
 	struct ab8500_fg *di;
 	union power_supply_propval ret;
-	int i, j;
-	bool psy_found = false;
+	int j;
 
 	psy = (struct power_supply *)data;
-	ext = dev_get_drvdata(dev);
 	di = power_supply_get_drvdata(psy);
 
 	/*
 	 * For all psy where the name of your driver
 	 * appears in any supplied_to
 	 */
-	for (i = 0; i < ext->num_supplicants; i++) {
-		if (!strcmp(ext->supplied_to[i], psy->desc->name))
-			psy_found = true;
-	}
-
-	if (!psy_found)
+	j = match_string(supplicants, ext->num_supplicants, psy->desc->name);
+	if (j < 0)
 		return 0;
 
 	/* Go through all properties for the psy */
diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/abx500_chargalg.c
index 541f702..d9104b1 100644
--- a/drivers/power/abx500_chargalg.c
+++ b/drivers/power/abx500_chargalg.c
@@ -975,22 +975,18 @@ static void handle_maxim_chg_curr(struct abx500_chargalg *di)
 static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 {
 	struct power_supply *psy;
-	struct power_supply *ext;
+	struct power_supply *ext = dev_get_drvdata(dev);
+	const char **supplicants = (const char **)ext->supplied_to;
 	struct abx500_chargalg *di;
 	union power_supply_propval ret;
-	int i, j;
-	bool psy_found = false;
+	int j;
 	bool capacity_updated = false;
 
 	psy = (struct power_supply *)data;
-	ext = dev_get_drvdata(dev);
 	di = power_supply_get_drvdata(psy);
 	/* For all psy where the driver name appears in any supplied_to */
-	for (i = 0; i < ext->num_supplicants; i++) {
-		if (!strcmp(ext->supplied_to[i], psy->desc->name))
-			psy_found = true;
-	}
-	if (!psy_found)
+	j = match_string(supplicants, ext->num_supplicants, psy->desc->name);
+	if (j < 0)
 		return 0;
 
 	/*
-- 
2.7.0.rc3

