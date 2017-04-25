From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 2/2] power: supply: sbs-battery: Correct supply status with current draw
Date: Tue, 25 Apr 2017 17:09:05 +0200
Message-ID: <20170425150905.4185-2-contact@paulk.fr>
References: <20170425150905.4185-1-contact@paulk.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:59510 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1949276AbdDYPPv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 11:15:51 -0400
In-Reply-To: <20170425150905.4185-1-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>

The status reported directly by the battery controller is not always
reliable and should be corrected based on the current draw information.

This implements such a correction with a dedicated function, called
where the supply status is retrieved.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/power/supply/sbs-battery.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 3e7125c8e4d1..29c4e277abf1 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -295,6 +295,31 @@ static int sbs_write_word_data(struct i2c_client *client, u8 address,
 	return 0;
 }
 
+static int sbs_status_correct(struct i2c_client *client, int *intval)
+{
+	int ret;
+
+	ret = sbs_read_word_data(client, sbs_data[REG_CURRENT].addr);
+	if (ret < 0)
+		return ret;
+
+	ret = (s16)ret;
+
+	/* Not drawing current means full (cannot be not charging) */
+	if (ret == 0)
+		*intval = POWER_SUPPLY_STATUS_FULL;
+
+	if (*intval == POWER_SUPPLY_STATUS_FULL) {
+		/* Drawing or providing current when full */
+		if (ret > 0)
+			*intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (ret < 0)
+			*intval = POWER_SUPPLY_STATUS_DISCHARGING;
+	}
+
+	return 0;
+}
+
 static int sbs_get_battery_presence_and_health(
 	struct i2c_client *client, enum power_supply_property psp,
 	union power_supply_propval *val)
@@ -401,6 +426,8 @@ static int sbs_get_battery_property(struct i2c_client *client,
 		else
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 
+		sbs_status_correct(client, &val->intval);
+
 		if (chip->poll_time == 0)
 			chip->last_state = val->intval;
 		else if (chip->last_state != val->intval) {
@@ -721,6 +748,8 @@ static void sbs_delayed_work(struct work_struct *work)
 	else
 		ret = POWER_SUPPLY_STATUS_CHARGING;
 
+	sbs_status_correct(chip->client, &ret);
+
 	if (chip->last_state != ret) {
 		chip->poll_time = 0;
 		power_supply_changed(chip->power_supply);
-- 
2.12.2
