From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 6/6] power: supply: charger-manager: Add new method to start/stop charging
Date: Fri, 16 Nov 2018 19:01:13 +0800
Message-ID: <c920cab7a1e4caedcab0636eccdebec88fbaab9f.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

For some chargers (such as Spreadtrum SC2731 charger), they don't use
regulators to control charging, instead charging control was implemented
in their drivers, so we can add some supports to start or stop charging
by POWER_SUPPLY_PROP_STATUS property.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/charger-manager.c |   35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 4f28c03..d0d0b82 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -348,6 +348,32 @@ static bool is_polling_required(struct charger_manager *cm)
 	return false;
 }
 
+static int try_charger_enable_by_psy(struct charger_manager *cm, bool enable)
+{
+	struct charger_desc *desc = cm->desc;
+	union power_supply_propval val;
+	struct power_supply *psy;
+	int i, err;
+
+	for (i = 0; desc->psy_charger_stat[i]; i++) {
+		psy = power_supply_get_by_name(desc->psy_charger_stat[i]);
+		if (!psy) {
+			dev_err(cm->dev, "Cannot find power supply \"%s\"\n",
+				desc->psy_charger_stat[i]);
+			continue;
+		}
+
+		val.intval = enable;
+		err = power_supply_set_property(psy, POWER_SUPPLY_PROP_STATUS,
+						&val);
+		power_supply_put(psy);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * try_charger_enable - Enable/Disable chargers altogether
  * @cm: the Charger Manager representing the battery.
@@ -378,6 +404,10 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		cm->charging_start_time = ktime_to_ms(ktime_get());
 		cm->charging_end_time = 0;
 
+		err = try_charger_enable_by_psy(cm, enable);
+		if (!err)
+			goto out;
+
 		for (i = 0 ; i < desc->num_charger_regulators ; i++) {
 			if (desc->charger_regulators[i].externally_control)
 				continue;
@@ -396,6 +426,10 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		cm->charging_start_time = 0;
 		cm->charging_end_time = ktime_to_ms(ktime_get());
 
+		err = try_charger_enable_by_psy(cm, enable);
+		if (!err)
+			goto out;
+
 		for (i = 0 ; i < desc->num_charger_regulators ; i++) {
 			if (desc->charger_regulators[i].externally_control)
 				continue;
@@ -422,6 +456,7 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		}
 	}
 
+out:
 	if (!err)
 		cm->charger_enabled = enable;
 
-- 
1.7.9.5
