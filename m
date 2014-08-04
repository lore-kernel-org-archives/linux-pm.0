From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 2/2] sbs-battery: add min design voltage to sbs-battery
Date: Mon,  4 Aug 2014 13:47:46 +0200
Message-ID: <1407152866-31790-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1407152866-31790-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:33561 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbaHDLsQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Aug 2014 07:48:16 -0400
In-Reply-To: <1407152866-31790-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Simon Que <sque@chromium.org>, cychiang <cychiang@chromium.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

From: Simon Que <sque@chromium.org>

sbs-battery has a max design voltage but not a min design voltage field.
The SBS spec only has one design voltage:
http://www.sbs-forum.org/specs/sbdat110.pdf

Currently this is being used for max design voltage.  This patch uses it
for min design voltage as well.

Signed-off-by: Simon Que <sque@chromium.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Todd Broch <tbroch@chromium.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/power/sbs-battery.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index 08feb38..c7b7b40 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -48,7 +48,8 @@ enum {
 	REG_FULL_CHARGE_CAPACITY_CHARGE,
 	REG_DESIGN_CAPACITY,
 	REG_DESIGN_CAPACITY_CHARGE,
-	REG_DESIGN_VOLTAGE,
+	REG_DESIGN_VOLTAGE_MIN,
+	REG_DESIGN_VOLTAGE_MAX,
 	REG_MANUFACTURER,
 	REG_MODEL_NAME,
 };
@@ -114,7 +115,9 @@ static const struct chip_data {
 		SBS_DATA(POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN, 0x18, 0, 65535),
 	[REG_DESIGN_CAPACITY_CHARGE] =
 		SBS_DATA(POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN, 0x18, 0, 65535),
-	[REG_DESIGN_VOLTAGE] =
+	[REG_DESIGN_VOLTAGE_MIN] =
+		SBS_DATA(POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN, 0x19, 0, 65535),
+	[REG_DESIGN_VOLTAGE_MAX] =
 		SBS_DATA(POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN, 0x19, 0, 65535),
 	[REG_SERIAL_NUMBER] =
 		SBS_DATA(POWER_SUPPLY_PROP_SERIAL_NUMBER, 0x1C, 0, 65535),
@@ -138,6 +141,7 @@ static enum power_supply_property sbs_properties[] = {
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_NOW,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
@@ -431,6 +435,7 @@ static void  sbs_unit_adjustment(struct i2c_client *client,
 		break;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
@@ -592,6 +597,7 @@ static int sbs_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TEMP:
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 		ret = sbs_get_property_index(client, psp);
 		if (ret < 0)
-- 
2.0.0.rc2

