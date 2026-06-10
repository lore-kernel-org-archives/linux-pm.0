Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA841C2F8;
	Wed, 10 Jun 2026 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102257; cv=none; b=JJTCnVQ6n66H6HzF06uSbCadyRI4AMKTPQE5z8NtCCYMsjC/Zfho5ioCt94EGoiS2W175f0hcU6lHtqUpa+9MB+GV/vtwg+pnIdCKoS56U36R5/uSxdN1QIE0daSG6/bDpWLWrM+f20oZNmnAzi/jVyF7rQci3ctsvwJrpCKVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102257; c=relaxed/simple;
	bh=6VW/q9K1IFpdCC5RLWNKih7slPAOnAXK1AcWzwOUhYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUyVGxvuKt9aU1RU4G1aGe6qJQoJNvFbJI6AY781wsKQvC17uVbuF+XcnTkbUdsesyKHDdjmdcOTjVFE5JYPaCQnrMyiRgARuF07DLi7HEMlbTCGXP6HKZm7ZICVA588cX727SgtPrfZTBw77J1cQsaBR7lc1i8U2FLsnNhp8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-03 (Coremail) with SMTP id rQCowABnhdyadilqGxtHFA--.6567S2;
	Wed, 10 Jun 2026 22:37:15 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: john@example.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jonghwa Lee <jonghwa3.lee@samsung.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Jonathan Bakker <xc-racer2@live.ca>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] power: supply: charger-manager: Make decisions focussed on battery status
Date: Wed, 10 Jun 2026 22:37:12 +0800
Message-ID: <20260610143712.33322-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnhdyadilqGxtHFA--.6567S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF47ur4kurW3AF48tr1kXwb_yoWfCF4UpF
	s29FyDt3yUtFW5uF1DC3y3CFy5Can3t34qk395G340yw43Grn0gry5tF12vr1FkryfuF1S
	vayFyw17t3WjkwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5qXd5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcOA2opLJXi5gAAs4

From: Jonghwa Lee <jonghwa3.lee@samsung.com>

cm_monitor(), where charging management starts, checks various charging
condition sequentially to decide next charging operation. However, as it
follows sequential process, cascaded if statements, it does some
jobs which have already done in the previous stage. This results in a
delay in decision making. Moreover, starting point of charging is spread
all around which makes maintain code and debugging difficult.

Both of the problems mentioned above become clean if it manages battery
charging focusing on battery status not following sequential condition
checking.  Now, cm_monitor() moves battery state diagram and does the
optimal operation for current state. As a result, it reduces whole
monitoring time almost in half.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/charger-manager.c | 181 +++++++++----------------
 include/linux/power/charger-manager.h  |   3 +
 2 files changed, 64 insertions(+), 120 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index cc8feb68694d..d10bf89328a0 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -271,6 +271,19 @@ static bool is_full_charged(struct charger_manager *cm)
 	if (!fuel_gauge)
 		return false;
 
+	/* Full, if it's over the fullbatt voltage */
+	if (desc->fullbatt_uV > 0) {
+		ret = get_batt_uV(cm, &uV);
+		if (!ret) {
+			/* Battery is already full, checks voltage drop. */
+			if (cm->battery_status == POWER_SUPPLY_STATUS_FULL
+					&& desc->fullbatt_vchkdrop_uV)
+				uV += desc->fullbatt_vchkdrop_uV;
+			if (uV >= desc->fullbatt_uV)
+				return true;
+		}
+	}
+
 	if (desc->fullbatt_full_capacity > 0) {
 		val.intval = 0;
 
@@ -283,15 +296,6 @@ static bool is_full_charged(struct charger_manager *cm)
 		}
 	}
 
-	/* Full, if it's over the fullbatt voltage */
-	if (desc->fullbatt_uV > 0) {
-		ret = get_batt_uV(cm, &uV);
-		if (!ret && uV >= desc->fullbatt_uV) {
-			is_full = true;
-			goto out;
-		}
-	}
-
 	/* Full, if the capacity is more than fullbatt_soc */
 	if (desc->fullbatt_soc > 0) {
 		val.intval = 0;
@@ -406,66 +410,12 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		}
 	}
 
-	if (!err) {
+	if (!err)
 		cm->charger_enabled = enable;
-		power_supply_changed(cm->charger_psy);
-	}
 
 	return err;
 }
 
-/**
- * try_charger_restart - Restart charging.
- * @cm: the Charger Manager representing the battery.
- *
- * Restart charging by turning off and on the charger.
- */
-static int try_charger_restart(struct charger_manager *cm)
-{
-	int err;
-
-	if (cm->emergency_stop)
-		return -EAGAIN;
-
-	err = try_charger_enable(cm, false);
-	if (err)
-		return err;
-
-	return try_charger_enable(cm, true);
-}
-
-/**
- * fullbatt_vchk - Check voltage drop some times after "FULL" event.
- *
- * If a user has designated "fullbatt_vchkdrop_uV" values with
- * charger_desc, Charger Manager checks voltage drop after the battery
- * "FULL" event. It checks whether the voltage has dropped more than
- * fullbatt_vchkdrop_uV by calling this function after fullbatt_vchkrop_ms.
- */
-static void fullbatt_vchk(struct charger_manager *cm)
-{
-	struct charger_desc *desc = cm->desc;
-	int batt_uV, err, diff;
-
-	if (!desc->fullbatt_vchkdrop_uV)
-		return;
-
-	err = get_batt_uV(cm, &batt_uV);
-	if (err) {
-		dev_err(cm->dev, "%s: get_batt_uV error(%d)\n", __func__, err);
-		return;
-	}
-
-	diff = desc->fullbatt_uV - batt_uV;
-	if (diff < 0)
-		return;
-
-	dev_info(cm->dev, "VBATT dropped %duV after full-batt\n", diff);
-
-	if (diff > desc->fullbatt_vchkdrop_uV)
-		try_charger_restart(cm);
-}
-
 /**
  * check_charging_duration - Monitor charging/discharging duration
  * @cm: the Charger Manager representing the battery.
@@ -493,17 +443,14 @@ static int check_charging_duration(struct charger_manager *cm)
 		if (duration > desc->charging_max_duration_ms) {
 			dev_info(cm->dev, "Charging duration exceed %ums\n",
 				 desc->charging_max_duration_ms);
-			try_charger_enable(cm, false);
 			ret = true;
 		}
-	} else if (is_ext_pwr_online(cm) && !cm->charger_enabled) {
+	} else if (cm->battery_status == POWER_SUPPLY_STATUS_NOT_CHARGING) {
 		duration = curr - cm->charging_end_time;
 
-		if (duration > desc->discharging_max_duration_ms &&
-				is_ext_pwr_online(cm)) {
+		if (duration > desc->charging_max_duration_ms) {
 			dev_info(cm->dev, "Discharging duration exceed %ums\n",
 				 desc->discharging_max_duration_ms);
-			try_charger_enable(cm, true);
 			ret = true;
 		}
 	}
@@ -585,9 +532,46 @@ static int cm_check_thermal_status(struct charger_manager *cm)
 	else
 		ret = CM_BATT_OK;
 
+	cm->emergency_stop = ret;
+
 	return ret;
 }
 
+/**
+ * cm_get_target_status - Check current status and get next target status.
+ * @cm: the Charger Manager representing the battery.
+ */
+static int cm_get_target_status(struct charger_manager *cm)
+{
+	if (!is_ext_pwr_online(cm))
+		return POWER_SUPPLY_STATUS_DISCHARGING;
+
+	if (cm_check_thermal_status(cm)) {
+		/* Check if discharging duration exeeds limit. */
+		if (check_charging_duration(cm))
+			goto charging_ok;
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	}
+
+	switch (cm->battery_status) {
+	case POWER_SUPPLY_STATUS_CHARGING:
+		/* Check if charging duration exeeds limit. */
+		if (check_charging_duration(cm))
+			return POWER_SUPPLY_STATUS_FULL;
+		fallthrough;
+	case POWER_SUPPLY_STATUS_FULL:
+		if (is_full_charged(cm))
+			return POWER_SUPPLY_STATUS_FULL;
+		fallthrough;
+	default:
+		break;
+	}
+
+charging_ok:
+	/* Charging is allowed. */
+	return POWER_SUPPLY_STATUS_CHARGING;
+}
+
 /**
  * _cm_monitor - Monitor the temperature and return true for exceptions.
  * @cm: the Charger Manager representing the battery.
@@ -597,56 +581,18 @@ static int cm_check_thermal_status(struct charger_manager *cm)
  */
 static bool _cm_monitor(struct charger_manager *cm)
 {
-	int temp_alrt;
+	int target;
 
-	temp_alrt = cm_check_thermal_status(cm);
+	target = cm_get_target_status(cm);
 
-	/* It has been stopped already */
-	if (temp_alrt && cm->emergency_stop)
-		return false;
-
-	/*
-	 * Check temperature whether overheat or cold.
-	 * If temperature is out of range normal state, stop charging.
-	 */
-	if (temp_alrt) {
-		cm->emergency_stop = temp_alrt;
-		try_charger_enable(cm, false);
-
-	/*
-	 * Check whole charging duration and discharging duration
-	 * after full-batt.
-	 */
-	} else if (!cm->emergency_stop && check_charging_duration(cm)) {
-		dev_dbg(cm->dev,
-			"Charging/Discharging duration is out of range\n");
-	/*
-	 * Check dropped voltage of battery. If battery voltage is more
-	 * dropped than fullbatt_vchkdrop_uV after fully charged state,
-	 * charger-manager have to recharge battery.
-	 */
-	} else if (!cm->emergency_stop && is_ext_pwr_online(cm) &&
-			!cm->charger_enabled) {
-		fullbatt_vchk(cm);
+	try_charger_enable(cm, (target == POWER_SUPPLY_STATUS_CHARGING));
 
-	/*
-	 * Check whether fully charged state to protect overcharge
-	 * if charger-manager is charging for battery.
-	 */
-	} else if (!cm->emergency_stop && is_full_charged(cm) &&
-			cm->charger_enabled) {
-		dev_info(cm->dev, "EVENT_HANDLE: Battery Fully Charged\n");
-		try_charger_enable(cm, false);
-
-		fullbatt_vchk(cm);
-	} else {
-		cm->emergency_stop = 0;
-		if (is_ext_pwr_online(cm)) {
-			try_charger_enable(cm, true);
-		}
+	if (cm->battery_status != target) {
+		cm->battery_status = target;
+		power_supply_changed(cm->charger_psy);
 	}
 
-	return true;
+	return (cm->battery_status == POWER_SUPPLY_STATUS_NOT_CHARGING);
 }
 
 /**
@@ -751,12 +697,7 @@ static int charger_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		if (is_charging(cm))
-			val->intval = POWER_SUPPLY_STATUS_CHARGING;
-		else if (is_ext_pwr_online(cm))
-			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
-		else
-			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		val->intval = cm->battery_status;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
 		if (cm->emergency_stop > 0)
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index 3a98837684e3..c127dbe31e49 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -213,6 +213,7 @@ struct charger_desc {
  *	saved status of battery before entering suspend-to-RAM
  * @charging_start_time: saved start time of enabling charging
  * @charging_end_time: saved end time of disabling charging
+ * @battery_status: Current battery status
  */
 struct charger_manager {
 	struct list_head entry;
@@ -232,6 +233,8 @@ struct charger_manager {
 
 	u64 charging_start_time;
 	u64 charging_end_time;
+
+	int battery_status;
 };
 
 #endif /* _CHARGER_MANAGER_H */
-- 
2.50.1 (Apple Git-155)

