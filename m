From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 3/8] power: bq27x00_battery: Fix function parameter alignment
Date: Wed, 22 Jul 2015 16:51:55 -0500
Message-ID: <1437601920-13045-4-git-send-email-afd@ti.com>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60272 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbGVWAq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 18:00:46 -0400
In-Reply-To: <1437601920-13045-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>

Fix the alignment of function parameters on new lines.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27x00_battery.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index 203cf61..9cdad19 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -210,7 +210,7 @@ MODULE_PARM_DESC(poll_interval, "battery poll interval in seconds - " \
  */
 
 static inline int bq27x00_read(struct bq27x00_device_info *di, u8 reg,
-		bool single)
+			       bool single)
 {
 	if (di->chip == BQ27425)
 		return di->bus.read(di, reg - BQ27425_REG_OFFSET, single);
@@ -565,7 +565,7 @@ static void bq27x00_battery_poll(struct work_struct *work)
  * Or 0 if something fails.
  */
 static int bq27x00_battery_current(struct bq27x00_device_info *di,
-	union power_supply_propval *val)
+				   union power_supply_propval *val)
 {
 	int curr;
 	int flags;
@@ -593,7 +593,7 @@ static int bq27x00_battery_current(struct bq27x00_device_info *di,
 }
 
 static int bq27x00_battery_status(struct bq27x00_device_info *di,
-	union power_supply_propval *val)
+				  union power_supply_propval *val)
 {
 	int status;
 
@@ -621,7 +621,7 @@ static int bq27x00_battery_status(struct bq27x00_device_info *di,
 }
 
 static int bq27x00_battery_capacity_level(struct bq27x00_device_info *di,
-	union power_supply_propval *val)
+					  union power_supply_propval *val)
 {
 	int level;
 
@@ -655,7 +655,7 @@ static int bq27x00_battery_capacity_level(struct bq27x00_device_info *di,
  * Or < 0 if something fails.
  */
 static int bq27x00_battery_voltage(struct bq27x00_device_info *di,
-	union power_supply_propval *val)
+				   union power_supply_propval *val)
 {
 	int volt;
 
@@ -671,7 +671,7 @@ static int bq27x00_battery_voltage(struct bq27x00_device_info *di,
 }
 
 static int bq27x00_simple_value(int value,
-	union power_supply_propval *val)
+				union power_supply_propval *val)
 {
 	if (value < 0)
 		return value;
@@ -987,7 +987,7 @@ static inline void bq27x00_battery_i2c_exit(void) {};
 #ifdef CONFIG_BATTERY_BQ27X00_PLATFORM
 
 static int bq27000_read_platform(struct bq27x00_device_info *di, u8 reg,
-			bool single)
+				 bool single)
 {
 	struct device *dev = di->dev;
 	struct bq27000_platform_data *pdata = dev->platform_data;
-- 
1.9.1

