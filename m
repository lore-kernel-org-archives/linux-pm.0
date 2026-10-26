Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036921;
	b=Kmr7RXLZGzfH51MtZFoL67nf2ksZUboYNBhZ/XYtbWDzAHwCIMZO7dq4mZ5KWWCDEvZi
	 W9k/Z1SvkfRj59ISd/6Apy1kRd+cVu22A56pr8HrO0EAvNLf0jmWlS7ELyYj/X0F+ZCQX
	 ZuPGmDGvtGdxfIm63HPg+Aagy6FJLrKUM4C0b2DyiIpl8nzJ+5uTldeA7HEVpotEq6P7/
	 sf1oZNTRsZLIRkldhYUriU/KYj3P+03TzEIJBMVj6W6AaPAs3fwDLm+2bcIt+DNpuHhqp
	 Sl/Rbfw/iCQynZWVoFOoJU6yxHeSfqm5GRLG9VLOtdZMJIp1DHycA6TUBhzKZWcbGDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gi9rVZ5J+AU6Vbn9lYKs/qifiOeHPtbMwpCRLQsEzvg=;
	b=awyqz9xdZn6hEr+J5M/KBZ9hNtqkDYrUWgcKYSyqydllY77TWpLoxSVZSnGOjpkYH99f
	 7vJT7GvKAcP86hFKpd6MdP42CONTF1BIyVQ3FG72YK+pynFtcahEmcXWjvOG71sArr6zt
	 QOt4yBZJ+vbEmkINSPWbIAHhA4GXZ5E7YRWpdKFygYNswXEba9MiGmOWj+6l3yjkMSWup
	 L3gvL0dPg59n3BtxJi9YN0B73mJ6oVb5NxmMkOqdr3e7udlNZFh5iH4WdX/bV81cg+x3n
	 EnXRMf51HYAdudUp3nc7h957blCLsSMlklHEabHoca+TC0awrcvO4c/SpvhZHlkn/2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MgYBHugz;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB6606A329
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 17:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ACB6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MgYBHugz
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-843ea301d60so2452581a34.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793036919; x=1793641719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gi9rVZ5J+AU6Vbn9lYKs/qifiOeHPtbMwpCRLQsEzvg=;
        b=MgYBHugzHdg7AZdJpVQiaHt3iN10Ol7Lhzk8Z0JXbenF5u4iX0CscOiz8WSRx3lkmn
         1k9EFA0KguvpBcg+plUwpN4OKqdH4hk9Ss9kbd4OBhNdUrO7ysdDebErf2+LJQucyO9x
         9hRCPf04E62ILNWcJ3aXWrdLA8pBp2RasFK5ek8IB5m6nAjOXKVZFUKmVTiqFOleKsFu
         v2aBo2RYJUrHhPop/FttH38eOXhKkP+Ae6uEbomCapfpISn4ewFqgMz7qM+mZHIYRpFW
         0EKcrwRHO1p33oNOZJrUzyRAwfT9+3xUhHzGUKp4ipHKfK9j3NQ4Riyx+gzh9RwSNr6t
         GYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036919; x=1793641719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gi9rVZ5J+AU6Vbn9lYKs/qifiOeHPtbMwpCRLQsEzvg=;
        b=mHaOLaZGHCq23FkKCD14qh5MJETpz0aQbYKLjaeYq9jjx8NZOOdlwfvlKRsca2hy1n
         9QtH++yv/VevC9VDboAfgOAbn/rtcD4r/75iY4fgsS8mFh7aP9rUFFsnfklXGxDOL8Z2
         f3X/huOlrJqKHdXHQylyAITH0k4tPQdqyKMBavpXbmu4lWJj+feVtpKY2cCuAMN40L2e
         nMeGrgasWItnHXYPmsNjFyf7ztALLyvKLTbRLsaGzE485yYPMg2vgcGPn8do3Ij0RT3H
         uSr559HREQH0LASnjb7yArPnDfQFl2fDtVMnBPHO8N98grrTh/0ig2KG/NO3i7bobnf3
         8LrQ==
X-Gm-Message-State: AFq9FYLkA8Ol1EPjHqrLne33CZB9eEH0n7xfVe6Kj8IH0W7WQyoIFEQg
	oyN3NdmxmROvmVRzpzagDCsOVvt5xLFe5g7VAPrknhx45nydLkjbkQsespp5EZeH
X-Gm-Gg: AYBFou2cY+o9j+ikIRD7iTlKtrcCChNMHRvao3QlO6lpml2K7gOfjiD+GNLCajm/aL1
	xEmyf9v874w/AQrIBJAy1T3za7/ABDxO4pxclhmqlNzcz0fEE55d0ufwNIRGv9YQSzhp0G0078w
	1F13FfvlNsxaR+AFJhEEiKo4bo5/judxCaSV6n20wi/FRVc7ohR92MwUt65SPsRx0MskwT9vT5q
	+6H0syROGF7joeC6nq6J87vAGDTONu0aJL8ICqh/y/89TQZQx7J6PhtzdzzWPH1YmUAN4QSI6Ad
	2BcgQ9CVypvU1a40tcjicZQO+u5LyM1bMOCBPSFVKGGc3iJNjMLsppmti+gKvkiiil4pN3NKvHq
	7xwa0bnvY2dD/hEbdCImHTBRtlczXgsotYFoNPGOF8eBo5gMkesG7IBNLlG9mYCqDwaliX8IXNA
	8nbSKnNLc5EOhdNC0pxYTHHN+GimpWdAiTgYHVmUIZ/20p96GBzaeyu3C8ClLz0/kEJSqS0Vsii
	E5h94eboaVAwzeAV+0aGr2rDrfPlljRGXk8k3QVWffDkcxQe0GyscVi
X-Received: by 2002:a05:6820:80a:b0:70a:4053:52dd with SMTP id 006d021491bc7-70ba0b2310cmr4200119eaf.12.1793036919230;
        Mon, 26 Oct 2026 10:48:39 -0700 (PDT)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a842e89e33sm5034753fac.1.2026.10.26.10.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:48:38 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	maccraft123mc@gmail.com,
	zhangqing@rock-chips.com,
	zyw@rock-chips.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Jacob Cook <jacobmcook1984@gmail.com>
Subject: [PATCH 2/5] power: supply: rk817-charger: Resolve boot state of charge from the coulomb counter
Date: Mon, 26 Oct 2026 12:48:31 -0500
Message-ID: <20261026174834.1652309-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026174834.1652309-1-macroalpha82@gmail.com>
References: <20261026174834.1652309-1-macroalpha82@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

The boot state of charge comes from PWRON_VOL when OFF_CNT reads three
or more and from the coulomb counter otherwise, and both fail in the
field.

PWRON_VOL is sampled at the power-on instant. A power-on caused by
plugging in a charger samples under charge current: on an RG353M it
read above the pack's maximum design voltage while the pack was at
74%. An RG DS was seen holding 2.63V in the register while running.
Either becomes a wrong percentage on every boot that reaches it.

A negative counter was clamped to zero and reported as 0%.

The counter itself keeps counting while the system is off: the same
RG353M, saved at 74% and charged for 1.5 hours powered off, booted
with the counter at full. The BSP driver relies on this: it reads
OFF_CNT into a flag it never uses, consults PWRON_VOL only when
BAT_CON marks a new battery, and adopts the counter when it diverges
from the saved capacity ("system halt last time").

Do the same. Keep the PWRON_VOL lookup for the first boot. Otherwise
take the counter, capped at full, unless it reads zero or negative,
in which case keep the saved soc, which is at most one update
interval old. Then read the
relax voltage pair every update interval and, while the battery is
resting and the pair disagrees with the tracked soc by more than 5%,
re-init the counter from it. The pair is a true open circuit voltage,
so this corrects a counter that is wrong by any amount, and it is the
mechanism the BSP driver uses at resume.

Expose PWRON_VOL as POWER_SUPPLY_PROP_VOLTAGE_BOOT and the current
rested pair as POWER_SUPPLY_PROP_VOLTAGE_OCV, -ENODATA while the
battery is not resting.

Log the counter, saved soc and battery voltage at boot, as the BSP logs
its saved and present capacity, so a counter that diverged from the
saved soc is visible.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Suggested-by: Jacob Cook <jacobmcook1984@gmail.com>
Co-developed-by: Jacob Cook <jacobmcook1984@gmail.com>
Signed-off-by: Jacob Cook <jacobmcook1984@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Assisted-by: Claude:claude-5-fable
---
 drivers/power/supply/rk817_charger.c | 222 ++++++++++++++++++++-------
 include/linux/mfd/rk808.h            |   2 +
 2 files changed, 171 insertions(+), 53 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 86da0462fb59..50fbea298127 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -95,6 +95,15 @@ struct rk817_charger {
 	int bat_voltage_min_design_uv;
 	int bat_voltage_max_design_uv;
 
+	/* Battery voltage the PMIC sampled when the system powered on. */
+	int boot_voltage_uv;
+
+	/* Rested voltage the gauge latched, 0 if it took no usable pair. */
+	int relax_voltage_uv;
+
+	/* Retained for the ocv-capacity table the recalibration needs. */
+	struct power_supply_battery_info *bat_info;
+
 	/* Values updated periodically by driver for display. */
 	int charge_now_uah;
 	int volt_avg_uv;
@@ -332,6 +341,42 @@ static int rk817_bat_calib_cap(struct rk817_charger *charger)
 	return 0;
 }
 
+/* Calibrated microvolts from one of the gas gauge's 16 bit voltage registers. */
+static int rk817_bat_voltage_uv(struct rk817_charger *charger, unsigned int reg)
+{
+	u8 bulk_reg[2];
+
+	regmap_bulk_read(charger->rk808->regmap, reg, bulk_reg, 2);
+
+	return (charger->voltage_k * get_unaligned_be16(bulk_reg)) +
+		1000 * charger->voltage_b;
+}
+
+/*
+ * Voltage the gauge latched while the battery was resting. Relax mode only
+ * samples below RELAX_THRE_CUR, so this is a true open circuit voltage with
+ * no resistance term. Returns 0 unless the battery is resting now and the
+ * latched pair is inside the pack's design range.
+ */
+static int rk817_bat_relax_voltage_uv(struct rk817_charger *charger)
+{
+	unsigned int need = RK817_RELAX_STS | RK817_RELAX_VOL_UPD;
+	int ret, sts, vol;
+
+	ret = regmap_read(charger->rk808->regmap, RK817_GAS_GAUGE_GG_STS, &sts);
+	if (ret < 0 || (sts & need) != need)
+		return 0;
+
+	vol = max(rk817_bat_voltage_uv(charger, RK817_GAS_GAUGE_RELAX_VOL1_H),
+		  rk817_bat_voltage_uv(charger, RK817_GAS_GAUGE_RELAX_VOL2_H));
+
+	if (vol < charger->bat_voltage_min_design_uv ||
+	    vol > charger->bat_voltage_max_design_uv)
+		return 0;
+
+	return vol;
+}
+
 static void rk817_read_props(struct rk817_charger *charger)
 {
 	int tmp, reg;
@@ -367,11 +412,8 @@ static void rk817_read_props(struct rk817_charger *charger)
 	charger->soc = charger->charge_now_uah * 100 / charger->fcc_mah;
 
 	/* Update reported voltage. */
-	regmap_bulk_read(charger->rk808->regmap, RK817_GAS_GAUGE_BAT_VOL_H,
-			 bulk_reg, 2);
-	tmp = get_unaligned_be16(bulk_reg);
-	charger->volt_avg_uv = (charger->voltage_k * tmp) + 1000 *
-				charger->voltage_b;
+	charger->volt_avg_uv = rk817_bat_voltage_uv(charger,
+						    RK817_GAS_GAUGE_BAT_VOL_H);
 
 	/*
 	 * Update reported current. Note value from registers is a signed 16
@@ -430,6 +472,8 @@ static void rk817_read_props(struct rk817_charger *charger)
 		charger->charger_input_volt_avg_uv = 0;
 	}
 
+	charger->relax_voltage_uv = rk817_bat_relax_voltage_uv(charger);
+
 	/* Calibrate battery capacity and soc. */
 	rk817_bat_calib_cap(charger);
 }
@@ -516,6 +560,14 @@ static int rk817_bat_get_prop(struct power_supply *ps,
 	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
 		val->intval = charger->volt_avg_uv;
 		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_BOOT:
+		val->intval = charger->boot_voltage_uv;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		if (!charger->relax_voltage_uv)
+			return -ENODATA;
+		val->intval = charger->relax_voltage_uv;
+		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 		val->intval = charger->cur_avg_ua;
 		break;
@@ -654,6 +706,8 @@ static enum power_supply_property rk817_bat_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_BOOT,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
@@ -746,15 +800,50 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 	return 0;
 }
 
+/*
+ * The relax pair is a true rested voltage: where it disagrees with the
+ * tracked soc by more than 5% (chosen arbitrarily), re-init the counter
+ * from it.
+ */
+static void rk817_bat_ocv_recalibrate(struct rk817_charger *charger)
+{
+	struct rk808 *rk808 = charger->rk808;
+	int ocv_soc, charge_now_adc;
+	u8 bulk_reg[4];
+
+	if (!charger->battery_present)
+		return;
+
+	if (!charger->relax_voltage_uv)
+		return;
+
+	ocv_soc = power_supply_batinfo_ocv2cap(charger->bat_info,
+					       charger->relax_voltage_uv,
+					       20) * 1000;
+	if (ocv_soc < 0 || abs(ocv_soc - charger->soc) <= 5000)
+		return;
+
+	dev_dbg(charger->dev,
+		"OCV %duV disagrees with soc, recalibrating (%d -> %d)\n",
+		charger->relax_voltage_uv, charger->soc, ocv_soc);
+	charger->soc = ocv_soc;
+	charge_now_adc = CHARGE_TO_ADC(ocv_soc * charger->fcc_mah / 100000,
+				       charger->res_div);
+	put_unaligned_be32(charge_now_adc, bulk_reg);
+	regmap_bulk_write(rk808->regmap, RK817_GAS_GAUGE_Q_INIT_H3,
+			  bulk_reg, 4);
+	rk817_record_battery_nvram_values(charger);
+}
+
 static int
 rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 				struct power_supply_battery_info *bat_info)
 {
 	struct rk808 *rk808 = charger->rk808;
+	u32 boot_charge_mah;
+	int ret, reg, tmp, off_cnt, bat_uv, boot_soc, table_soc;
+	bool first_boot, keep_saved;
 	u8 bulk_reg[4];
-	u32 boot_voltage, boot_charge_mah;
-	int ret, reg, off_time, tmp;
-	bool first_boot;
 
 	/*
 	 * Check if the battery is uninitalized. If it is, the columb counter
@@ -764,25 +853,22 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 	if (ret < 0)
 		return ret;
 	first_boot = reg & RK817_BAT_CON;
-	/*
-	 * If the battery is uninitialized, use the poweron voltage and an ocv
-	 * lookup to guess our charge. The number won't be very accurate until
-	 * we hit either our minimum voltage (0%) or full charge (100%).
-	 */
+
+	/* PWRON_VOL only refreshes on a real power-on; bound it to the pack. */
+	charger->boot_voltage_uv =
+		clamp(rk817_bat_voltage_uv(charger, RK817_GAS_GAUGE_PWRON_VOL_H),
+		      bat_info->voltage_min_design_uv,
+		      bat_info->voltage_max_design_uv);
+
 	if (first_boot) {
-		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_PWRON_VOL_H,
-				 bulk_reg, 2);
-		tmp = get_unaligned_be16(bulk_reg);
-		boot_voltage = (charger->voltage_k * tmp) +
-				1000 * charger->voltage_b;
 		/*
-		 * Since only implementation has no working thermistor, assume
-		 * 20C for OCV lookup. If lookup fails, report error with OCV
-		 * table.
+		 * Nothing has been saved yet, so estimate from the boot
+		 * voltage with an ocv lookup. Since only implementation has
+		 * no working thermistor, assume 20C for that lookup.
 		 */
 		charger->soc = power_supply_batinfo_ocv2cap(bat_info,
-							    boot_voltage,
-							    20) * 1000;
+						charger->boot_voltage_uv,
+						20) * 1000;
 		if (charger->soc < 0)
 			charger->soc = 0;
 
@@ -803,39 +889,54 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 		if (ret < 0)
 			return ret;
 
+		/*
+		 * The coulomb counter keeps counting while the system is off,
+		 * so take it, capped at full, unless it reads invalid; the
+		 * saved soc is then at most one update interval old. A counter
+		 * that is merely wrong is corrected by the next rested relax
+		 * pair.
+		 */
 		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
 				 bulk_reg, 4);
 		tmp = get_unaligned_be32(bulk_reg);
-		if (tmp < 0)
-			tmp = 0;
-		boot_charge_mah = ADC_TO_CHARGE_UAH(tmp,
-						    charger->res_div) / 1000;
-		/*
-		 * Check if the columb counter has been off for more than 30
-		 * minutes as it tends to drift downward. If so, re-init soc
-		 * with the boot voltage instead. Note the unit values for the
-		 * OFF_CNT register appear to be in decaminutes and stops
-		 * counting at 2550 (0xFF) minutes. BSP kernel used OCV, but
-		 * for me occasionally that would show invalid values. Boot
-		 * voltage is only accurate for me on first poweron (not
-		 * reboots), but we shouldn't ever encounter an OFF_CNT more
-		 * than 0 on a reboot anyway.
-		 */
-		regmap_read(rk808->regmap, RK817_GAS_GAUGE_OFF_CNT, &off_time);
-		if (off_time >= 3) {
-			regmap_bulk_read(rk808->regmap,
-					 RK817_GAS_GAUGE_PWRON_VOL_H,
-					 bulk_reg, 2);
-			tmp = get_unaligned_be16(bulk_reg);
-			boot_voltage = (charger->voltage_k * tmp) +
-					1000 * charger->voltage_b;
-			charger->soc =
-				power_supply_batinfo_ocv2cap(bat_info,
-							     boot_voltage,
-							     20) * 1000;
+		regmap_read(rk808->regmap, RK817_GAS_GAUGE_OFF_CNT, &off_cnt);
+		bat_uv = rk817_bat_voltage_uv(charger, RK817_GAS_GAUGE_BAT_VOL_H);
+		dev_dbg(charger->dev,
+			"boot: counter %d uAh, saved soc %d, fcc %d mAh, battery %d uV, off_cnt %d\n",
+			tmp > 0 ? ADC_TO_CHARGE_UAH(tmp, charger->res_div) : 0,
+			charger->soc, charger->fcc_mah, bat_uv, off_cnt);
+		if (tmp > 0) {
+			boot_charge_mah = ADC_TO_CHARGE_UAH(tmp,
+							    charger->res_div) / 1000;
+			if (boot_charge_mah > charger->fcc_mah)
+				boot_charge_mah = charger->fcc_mah;
+			boot_soc = boot_charge_mah * 100000 / charger->fcc_mah;
+
+			/*
+			 * The gauge re-derives this count from its own ocv
+			 * model while the pack rests, so bound it with the ocv
+			 * table: under load the terminal voltage sits below the
+			 * open circuit voltage, making the table a floor, and
+			 * under charge above it, making it a ceiling on any
+			 * saved soc that would displace the counter.
+			 */
+			table_soc = power_supply_batinfo_ocv2cap(bat_info, bat_uv,
+								 20) * 1000;
+			if (charger->plugged_in)
+				keep_saved = boot_soc < charger->soc - 10000 &&
+					     charger->soc <= table_soc + 10000;
+			else
+				keep_saved = boot_soc < table_soc - 10000;
+
+			if (keep_saved)
+				dev_dbg(charger->dev,
+					"counter %d, voltage allows %d, keeping saved soc %d\n",
+					boot_soc, table_soc, charger->soc);
+			else
+				charger->soc = boot_soc;
 		} else {
-			charger->soc = (boot_charge_mah * 1000 * 100 /
-					charger->fcc_mah);
+			dev_dbg(charger->dev,
+				"coulomb counter invalid, keeping saved soc\n");
 		}
 	}
 
@@ -1044,6 +1145,7 @@ static void rk817_charging_monitor(struct work_struct *work)
 	charger = container_of(work, struct rk817_charger, work.work);
 
 	rk817_read_props(charger);
+	rk817_bat_ocv_recalibrate(charger);
 
 	/* Run every 8 seconds like the BSP driver did. */
 	queue_delayed_work(system_percpu_wq, &charger->work, msecs_to_jiffies(8000));
@@ -1056,6 +1158,13 @@ static void rk817_cleanup_node(void *data)
 	of_node_put(node);
 }
 
+static void rk817_put_battery_info(void *data)
+{
+	struct rk817_charger *charger = data;
+
+	power_supply_put_battery_info(charger->bat_ps, charger->bat_info);
+}
+
 static int rk817_charger_probe(struct platform_device *pdev)
 {
 	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
@@ -1172,7 +1281,14 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	power_supply_put_battery_info(charger->bat_ps, bat_info);
+	/*
+	 * Keep the battery info: the periodic recalibration needs its
+	 * ocv-capacity table for as long as the driver is bound.
+	 */
+	charger->bat_info = bat_info;
+	ret = devm_add_action_or_reset(dev, rk817_put_battery_info, charger);
+	if (ret)
+		return ret;
 
 	plugin_irq = platform_get_irq(pdev, 0);
 	if (plugin_irq < 0)
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 7ffc904c864c..72419d311626 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -1211,6 +1211,8 @@ enum rk809_reg_id {
 
 #define RK817_GAS_GAUGE_RELAX_THRE_H	0x58
 #define RK817_GAS_GAUGE_RELAX_THRE_L	0x59
+#define RK817_GAS_GAUGE_RELAX_VOL1_H	0x5a
+#define RK817_GAS_GAUGE_RELAX_VOL2_H	0x5c
 #define RK817_GAS_GAUGE_OCV_THRE_VOL	0x62
 #define RK817_GAS_GAUGE_OCV_VOL_H	0x63
 #define RK817_GAS_GAUGE_OCV_VOL_L	0x64
-- 
2.53.0

