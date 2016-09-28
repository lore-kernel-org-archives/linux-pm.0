From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 1/2] power: power_supply: add new property POWER_SUPPLY_PROP_POLL_INTERVAL
Date: Wed, 28 Sep 2016 12:55:11 -0700
Message-ID: <1475092512-30555-2-git-send-email-matt@ranostay.consulting>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pm@vger.kernel.org

Add new POWER_SUPPLY_PROP_POLL_INTERVAL property to display/set the
update interval in seconds of the device.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 Documentation/power/power_supply_class.txt | 1 +
 drivers/power/supply/power_supply_sysfs.c  | 1 +
 include/linux/power_supply.h               | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
index 0c72588bd967..df9b315fe55c 100644
--- a/Documentation/power/power_supply_class.txt
+++ b/Documentation/power/power_supply_class.txt
@@ -158,6 +158,7 @@ while battery powers a load)
 TIME_TO_FULL - seconds left for battery to be considered full (i.e.
 while battery is charging)
 
+POLL_INTERVAL - seconds between queries to retrieve stats from hardware
 
 Battery <-> external power supply interaction
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bcde8d13476a..580fd4bfe5f5 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -198,6 +198,7 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(scope),
 	POWER_SUPPLY_ATTR(charge_term_current),
 	POWER_SUPPLY_ATTR(calibrate),
+	POWER_SUPPLY_ATTR(poll_interval),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(model_name),
 	POWER_SUPPLY_ATTR(manufacturer),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3965503315ef..8b4cfe950d3b 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -148,6 +148,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_CALIBRATE,
+	POWER_SUPPLY_PROP_POLL_INTERVAL, /* in seconds! */
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
-- 
2.7.4
