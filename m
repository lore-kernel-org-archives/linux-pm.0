Received: from outbound.mr.icloud.com (p-west2-cluster1-host1-snip4-1.eps.apple.com [57.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930C1E531
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509122; cv=none; b=i86gAmeIV6opl5lGIJO4++Fxij404EzOKYzGtCchmKJQ8VMiJlWxzyye+rKPbp9x86eEd/W+g2Yq8gnEF2dWotqIOROD3M1sty7MQ7kj8rPYalINXdXjxN2LnvlTmUvBnFjrCoSE3myqUrHIMmX+nfsX7HmbPlQ2NWdMw75/h9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509122; c=relaxed/simple;
	bh=0+Na2HcqS18Gkb0TJBYZ56EuQ4dlZjOFYc+9ha8e/+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfhxdFhYI0YcRtsl8tqQ1Qhph/ZHX+4gHewfJDC0RfK0O+N1s8PfX607bHrQHuU619zN2FSI9lTAC1en8mVZIoop6cFKVhtQAqrdIQrckVgL1KmH+ZEjpgjeWxQVIIGm3VaVnO9twt+EQ49hHV0KA3zhadHr6xFLH51I1/U3+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Ow94vmHk; arc=none smtp.client-ip=57.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Ow94vmHk"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id 2D97B1800270;
	Mon, 06 Apr 2026 20:58:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775509120; x=1778101120; bh=a2Xl3gavdTtDCKylwYZDrfviP43GxntVPY8Z9z4YIws=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Ow94vmHkfygupTxw2oB+eRQhv2lyFVrllSdmSwJnPnsDHjSQTQk3FWd3w0SEGLTK3cTSwrFOuLmATpXn1ijrvtr359CLMXgHXAkDCpsmZEAHFKTzGq2vWIfcPrC3BawHYUmWhx1nR+pzzLxfxPLzbZol7hUyEgfGndWnOg4mqJYaJmX460Db1YkGSMepKmDPcqhX+/JVX8LqVdexeOTBS6O4v3MEXrmKYpk/+QbWqeu7AMMTyaQZzzDJSXGm3VxLfFhevkquvl3Rl0hgfOiBkfE8LRLNH+C12P33QZa/wt336GryeOorkcANwnHKUDh4aJdmD70D+j3TWgBUjh6Idg==
Received: from bigre.tail98293.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id DA7D21800132;
	Mon, 06 Apr 2026 20:58:37 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v1 6/9] power: supply: max17042_battery: Remove unused platform-data plumbing
Date: Mon,  6 Apr 2026 16:57:54 -0400
Message-ID: <20260406205759.493288-7-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406205759.493288-1-vincent.cloutier@icloud.com>
References: <20260406205759.493288-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIwNiBTYWx0ZWRfXwdzYh7YGcp4Y
 T/gkYYqmA5XDZG7SDTwwKZTHOkEWPi88P6V8GvhCD8gGhlEbEGZrVQhO31IZwdpYvEDQZezXONM
 dkNnyghXMPL0XcIHUTOmUUufUaweP5WUS0fgtsvWf1GsGvI53rSw6HhaTbMN/M/NJYSnJ7Pl7zz
 3QRtRJBjvBXvW+1sAsDmCCV9c0tMvwvpaDMT0rBVTpVC/xg2WEZIsJ9cIIDXq16rKEmSOtYoUii
 XVGfoxC8TCDIsPcUnsQjKg8nBYIdamT8+JTwhFEVHuTM7glLggRqYrb6XDFx1U47LNKJKhUNa6j
 W0a9YluUA3YmdE/dU+4rL2ZRnpZlQV1L3YYUccyVolyotsduDFC+ym6cX6h+k0=
X-Proofpoint-ORIG-GUID: Qvt34T5BiADgQ8ibSlq2q5MekIhcfg7P
X-Proofpoint-GUID: Qvt34T5BiADgQ8ibSlq2q5MekIhcfg7P
X-Authority-Info-Out: v=2.4 cv=Z5nh3XRA c=1 sm=1 tr=0 ts=69d41e7f
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=BWTXLzbCmJ5VM3Q8rPcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604060206

From: Vincent Cloutier <vincent@cloutier.co>

No in-tree user still provides `max17042_platform_data` or
`max17042_reg_data`. Move the simple runtime fields into
`struct max17042_chip`, populate them directly from DT or the default
hardware state, and drop the unused public platform-data interface.

While here, write the MAX17047/MAX17050 default `FullSOCThr` value
directly in probe instead of carrying it through an `init_data` table.

Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 204 +++++++++++-------------
 include/linux/power/max17042_battery.h  |  29 ----
 2 files changed, 89 insertions(+), 144 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index b93fedf183b1..a96427bf07d0 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -68,10 +68,17 @@ struct max17042_chip {
 	struct regmap *regmap;
 	struct power_supply *battery;
 	enum max170xx_chip_type chip_type;
-	struct max17042_platform_data *pdata;
+	struct max17042_config_data *config_data;
 	struct work_struct work;
 	int    init_complete;
 	int    irq;
+	bool   enable_current_sense;
+	bool   enable_por_init;
+	unsigned int r_sns;
+	int    vmin;	/* in millivolts */
+	int    vmax;	/* in millivolts */
+	int    temp_min;	/* in tenths of degree Celsius */
+	int    temp_max;	/* in tenths of degree Celsius */
 };
 
 static enum power_supply_property max17042_battery_props[] = {
@@ -163,7 +170,7 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
 	 * Even though we are supplied, we may still be discharging if the
 	 * supply is e.g. only delivering 5V 0.5A. Check current if available.
 	 */
-	if (!chip->pdata->enable_current_sense) {
+	if (!chip->enable_current_sense) {
 		*status = POWER_SUPPLY_STATUS_CHARGING;
 		return 0;
 	}
@@ -205,12 +212,12 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 	/* Convert to millivolts */
 	vbatt /= 1000;
 
-	if (vavg < chip->pdata->vmin) {
+	if (vavg < chip->vmin) {
 		*health = POWER_SUPPLY_HEALTH_DEAD;
 		goto out;
 	}
 
-	if (vbatt > chip->pdata->vmax + MAX17042_VMAX_TOLERANCE) {
+	if (vbatt > chip->vmax + MAX17042_VMAX_TOLERANCE) {
 		*health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		goto out;
 	}
@@ -219,12 +226,12 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 	if (ret < 0)
 		goto health_error;
 
-	if (temp < chip->pdata->temp_min) {
+	if (temp < chip->temp_min) {
 		*health = POWER_SUPPLY_HEALTH_COLD;
 		goto out;
 	}
 
-	if (temp > chip->pdata->temp_max) {
+	if (temp > chip->temp_max) {
 		*health = POWER_SUPPLY_HEALTH_OVERHEAT;
 		goto out;
 	}
@@ -325,7 +332,7 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data * MAX17042_VOLTAGE_LSB;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		if (chip->pdata->enable_current_sense)
+		if (chip->enable_current_sense)
 			ret = regmap_read(map, MAX17042_RepSOC, &data);
 		else
 			ret = regmap_read(map, MAX17042_VFSOC, &data);
@@ -340,7 +347,7 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = data * MAX17042_CAPACITY_LSB;
-		do_div(data64, chip->pdata->r_sns);
+		do_div(data64, chip->r_sns);
 		val->intval = data64;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
@@ -349,7 +356,7 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = data * MAX17042_CAPACITY_LSB;
-		do_div(data64, chip->pdata->r_sns);
+		do_div(data64, chip->r_sns);
 		val->intval = data64;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
@@ -358,7 +365,7 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = data * MAX17042_CAPACITY_LSB;
-		do_div(data64, chip->pdata->r_sns);
+		do_div(data64, chip->r_sns);
 		val->intval = data64;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
@@ -367,7 +374,7 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = sign_extend64(data, 15) * MAX17042_CAPACITY_LSB;
-		val->intval = div_s64(data64, chip->pdata->r_sns);
+		val->intval = div_s64(data64, chip->r_sns);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		ret = max17042_get_temperature(chip, &val->intval);
@@ -389,10 +396,10 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = sign_extend32(data >> 8, 7) * 10;
 		break;
 	case POWER_SUPPLY_PROP_TEMP_MIN:
-		val->intval = chip->pdata->temp_min;
+		val->intval = chip->temp_min;
 		break;
 	case POWER_SUPPLY_PROP_TEMP_MAX:
-		val->intval = chip->pdata->temp_max;
+		val->intval = chip->temp_max;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
 		ret = max17042_get_battery_health(chip, &val->intval);
@@ -403,25 +410,25 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		if (chip->pdata->enable_current_sense) {
+		if (chip->enable_current_sense) {
 			ret = regmap_read(map, MAX17042_Current, &data);
 			if (ret < 0)
 				return ret;
 
 			data64 = sign_extend64(data, 15) * MAX17042_CURRENT_LSB;
-			val->intval = div_s64(data64, chip->pdata->r_sns);
+			val->intval = div_s64(data64, chip->r_sns);
 		} else {
 			return -EINVAL;
 		}
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
-		if (chip->pdata->enable_current_sense) {
+		if (chip->enable_current_sense) {
 			ret = regmap_read(map, MAX17042_AvgCurrent, &data);
 			if (ret < 0)
 				return ret;
 
 			data64 = sign_extend64(data, 15) * MAX17042_CURRENT_LSB;
-			val->intval = div_s64(data64, chip->pdata->r_sns);
+			val->intval = div_s64(data64, chip->r_sns);
 		} else {
 			return -EINVAL;
 		}
@@ -432,7 +439,7 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = data * MAX17042_CURRENT_LSB;
-		val->intval = div_s64(data64, chip->pdata->r_sns);
+		val->intval = div_s64(data64, chip->r_sns);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
 		ret = regmap_read(map, MAX17042_TTE, &data);
@@ -562,7 +569,7 @@ static inline void max17042_write_model_data(struct max17042_chip *chip,
 
 	for (i = 0; i < size; i++)
 		regmap_write(map, addr + i,
-			chip->pdata->config_data->cell_char_tbl[i]);
+			chip->config_data->cell_char_tbl[i]);
 }
 
 static inline void max17042_read_model_data(struct max17042_chip *chip,
@@ -597,7 +604,7 @@ static inline int max17042_model_data_compare(struct max17042_chip *chip,
 static int max17042_init_model(struct max17042_chip *chip)
 {
 	int ret;
-	int table_size = ARRAY_SIZE(chip->pdata->config_data->cell_char_tbl);
+	int table_size = ARRAY_SIZE(chip->config_data->cell_char_tbl);
 	u16 *temp_data;
 
 	temp_data = kcalloc(table_size, sizeof(*temp_data), GFP_KERNEL);
@@ -612,7 +619,7 @@ static int max17042_init_model(struct max17042_chip *chip)
 
 	ret = max17042_model_data_compare(
 		chip,
-		chip->pdata->config_data->cell_char_tbl,
+		chip->config_data->cell_char_tbl,
 		temp_data,
 		table_size);
 
@@ -625,7 +632,7 @@ static int max17042_init_model(struct max17042_chip *chip)
 static int max17042_verify_model_lock(struct max17042_chip *chip)
 {
 	int i;
-	int table_size = ARRAY_SIZE(chip->pdata->config_data->cell_char_tbl);
+	int table_size = ARRAY_SIZE(chip->config_data->cell_char_tbl);
 	u16 *temp_data;
 	int ret = 0;
 
@@ -645,7 +652,7 @@ static int max17042_verify_model_lock(struct max17042_chip *chip)
 
 static void max17042_write_config_regs(struct max17042_chip *chip)
 {
-	struct max17042_config_data *config = chip->pdata->config_data;
+	struct max17042_config_data *config = chip->config_data;
 	struct regmap *map = chip->regmap;
 
 	regmap_write(map, MAX17042_CONFIG, config->config);
@@ -662,7 +669,7 @@ static void max17042_write_config_regs(struct max17042_chip *chip)
 
 static void  max17042_write_custom_regs(struct max17042_chip *chip)
 {
-	struct max17042_config_data *config = chip->pdata->config_data;
+	struct max17042_config_data *config = chip->config_data;
 	struct regmap *map = chip->regmap;
 
 	max17042_write_verify_reg(map, MAX17042_RCOMP0, config->rcomp0);
@@ -686,7 +693,7 @@ static void  max17042_write_custom_regs(struct max17042_chip *chip)
 
 static void max17042_update_capacity_regs(struct max17042_chip *chip)
 {
-	struct max17042_config_data *config = chip->pdata->config_data;
+	struct max17042_config_data *config = chip->config_data;
 	struct regmap *map = chip->regmap;
 
 	max17042_write_verify_reg(map, MAX17042_FullCAP,
@@ -712,7 +719,7 @@ static void max17042_load_new_capacity_params(struct max17042_chip *chip)
 	u32 full_cap0, rep_cap, dq_acc, vfSoc;
 	u32 rem_cap;
 
-	struct max17042_config_data *config = chip->pdata->config_data;
+	struct max17042_config_data *config = chip->config_data;
 	struct regmap *map = chip->regmap;
 
 	regmap_read(map, MAX17042_FullCAP0, &full_cap0);
@@ -744,14 +751,14 @@ static void max17042_load_new_capacity_params(struct max17042_chip *chip)
 }
 
 /*
- * Block write all the override values coming from platform data.
+ * Block write all the override values coming from config_data.
  * This function MUST be called before the POR initialization procedure
  * specified by maxim.
  */
 static inline void max17042_override_por_values(struct max17042_chip *chip)
 {
 	struct regmap *map = chip->regmap;
-	struct max17042_config_data *config = chip->pdata->config_data;
+	struct max17042_config_data *config = chip->config_data;
 
 	max17042_override_por(map, MAX17042_TGAIN, config->tgain);
 	max17042_override_por(map, MAX17042_TOFF, config->toff);
@@ -864,7 +871,7 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
 	/* program interrupt thresholds such that we should
 	 * get interrupt for every 'off' perc change in the soc
 	 */
-	if (chip->pdata->enable_current_sense)
+	if (chip->enable_current_sense)
 		regmap_read(map, MAX17042_RepSOC, &soc);
 	else
 		regmap_read(map, MAX17042_VFSOC, &soc);
@@ -880,7 +887,7 @@ static void max17042_set_critical_soc_threshold(struct max17042_chip *chip)
 	struct regmap *map = chip->regmap;
 	u32 soc;
 
-	if (chip->pdata->enable_current_sense)
+	if (chip->enable_current_sense)
 		regmap_read(map, MAX17042_RepSOC, &soc);
 	else
 		regmap_read(map, MAX17042_VFSOC, &soc);
@@ -943,8 +950,8 @@ static void max17042_init_worker(struct work_struct *work)
 				struct max17042_chip, work);
 	int ret;
 
-	/* Initialize registers according to values from the platform data */
-	if (chip->pdata->enable_por_init && chip->pdata->config_data) {
+	/* Initialize registers according to values from config_data */
+	if (chip->enable_por_init && chip->config_data) {
 		ret = max17042_init_chip(chip);
 		if (ret)
 			return;
@@ -954,102 +961,56 @@ static void max17042_init_worker(struct work_struct *work)
 }
 
 #ifdef CONFIG_OF
-static struct max17042_platform_data *
-max17042_get_of_pdata(struct max17042_chip *chip)
+static int max17042_parse_dt(struct max17042_chip *chip)
 {
-	struct device *dev = chip->dev;
-	struct device_node *np = dev->of_node;
+	struct device_node *np = chip->dev->of_node;
 	u32 prop;
-	struct max17042_platform_data *pdata;
-
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return NULL;
 
 	/*
 	 * Require current sense resistor value to be specified for
 	 * current-sense functionality to be enabled at all.
 	 */
 	if (of_property_read_u32(np, "maxim,rsns-microohm", &prop) == 0) {
-		pdata->r_sns = prop;
-		pdata->enable_current_sense = true;
+		chip->r_sns = prop;
+		chip->enable_current_sense = true;
 	}
 
-	if (of_property_read_s32(np, "maxim,cold-temp", &pdata->temp_min))
-		pdata->temp_min = INT_MIN;
-	if (of_property_read_s32(np, "maxim,over-heat-temp", &pdata->temp_max))
-		pdata->temp_max = INT_MAX;
-	if (of_property_read_s32(np, "maxim,dead-volt", &pdata->vmin))
-		pdata->vmin = INT_MIN;
-	if (of_property_read_s32(np, "maxim,over-volt", &pdata->vmax))
-		pdata->vmax = INT_MAX;
+	if (of_property_read_s32(np, "maxim,cold-temp", &chip->temp_min))
+		chip->temp_min = INT_MIN;
+	if (of_property_read_s32(np, "maxim,over-heat-temp", &chip->temp_max))
+		chip->temp_max = INT_MAX;
+	if (of_property_read_s32(np, "maxim,dead-volt", &chip->vmin))
+		chip->vmin = INT_MIN;
+	if (of_property_read_s32(np, "maxim,over-volt", &chip->vmax))
+		chip->vmax = INT_MAX;
 
-	return pdata;
+	return 0;
 }
 #endif
 
-static struct max17042_reg_data max17047_default_pdata_init_regs[] = {
-	/*
-	 * Some firmwares do not set FullSOCThr, Enable End-of-Charge Detection
-	 * when the voltage FG reports 95%, as recommended in the datasheet.
-	 */
-	{ MAX17047_FullSOCThr, MAX17042_BATTERY_FULL << 8 },
-};
-
-static struct max17042_platform_data *
-max17042_get_default_pdata(struct max17042_chip *chip)
+static int max17042_init_defaults(struct max17042_chip *chip)
 {
-	struct device *dev = chip->dev;
-	struct max17042_platform_data *pdata;
 	int ret, misc_cfg;
 
 	/*
-	 * The MAX17047 gets used on x86 where we might not have pdata, assume
+	 * The MAX17047 gets used on x86 where we might not have DT, assume
 	 * the firmware will already have initialized the fuel-gauge and provide
 	 * default values for the non init bits to make things work.
 	 */
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return pdata;
-
-	if ((chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047) ||
-	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050)) {
-		pdata->init_data = max17047_default_pdata_init_regs;
-		pdata->num_init_data =
-			ARRAY_SIZE(max17047_default_pdata_init_regs);
-	}
 
 	ret = regmap_read(chip->regmap, MAX17042_MiscCFG, &misc_cfg);
 	if (ret < 0)
-		return NULL;
+		return ret;
 
 	/* If bits 0-1 are set to 3 then only Voltage readings are used */
-	if ((misc_cfg & 0x3) == 0x3)
-		pdata->enable_current_sense = false;
-	else
-		pdata->enable_current_sense = true;
+	chip->enable_current_sense = (misc_cfg & 0x3) != 0x3;
 
-	pdata->vmin = MAX17042_DEFAULT_VMIN;
-	pdata->vmax = MAX17042_DEFAULT_VMAX;
-	pdata->temp_min = MAX17042_DEFAULT_TEMP_MIN;
-	pdata->temp_max = MAX17042_DEFAULT_TEMP_MAX;
+	chip->vmin = MAX17042_DEFAULT_VMIN;
+	chip->vmax = MAX17042_DEFAULT_VMAX;
+	chip->temp_min = MAX17042_DEFAULT_TEMP_MIN;
+	chip->temp_max = MAX17042_DEFAULT_TEMP_MAX;
 
-	return pdata;
-}
-
-static struct max17042_platform_data *
-max17042_get_pdata(struct max17042_chip *chip)
-{
-	struct device *dev = chip->dev;
-
-#ifdef CONFIG_OF
-	if (dev->of_node)
-		return max17042_get_of_pdata(chip);
-#endif
-	if (dev->platform_data)
-		return dev->platform_data;
-
-	return max17042_get_default_pdata(chip);
+	return 0;
 }
 
 static const struct regmap_config max17042_regmap_config = {
@@ -1088,8 +1049,8 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 	struct power_supply_config psy_cfg = {};
 	struct max17042_chip *chip;
 	int ret;
-	int i;
 	u32 val;
+	bool use_default_config = false;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EIO;
@@ -1106,10 +1067,19 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 		return -EINVAL;
 	}
 
-	chip->pdata = max17042_get_pdata(chip);
-	if (!chip->pdata) {
-		dev_err(dev, "no platform data provided\n");
-		return -EINVAL;
+
+#ifdef CONFIG_OF
+	if (dev->of_node) {
+		ret = max17042_parse_dt(chip);
+		if (ret)
+			return ret;
+	} else
+#endif
+	{
+		ret = max17042_init_defaults(chip);
+		if (ret)
+			return ret;
+		use_default_config = true;
 	}
 
 	dev_set_drvdata(dev, chip);
@@ -1118,19 +1088,13 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 
 	/* When current is not measured,
 	 * CURRENT_NOW and CURRENT_AVG properties should be invisible. */
-	if (!chip->pdata->enable_current_sense)
+	if (!chip->enable_current_sense)
 		max17042_desc = &max17042_no_current_sense_psy_desc;
 
-	if (chip->pdata->r_sns == 0)
-		chip->pdata->r_sns = MAX17042_DEFAULT_SNS_RESISTOR;
+	if (chip->r_sns == 0)
+		chip->r_sns = MAX17042_DEFAULT_SNS_RESISTOR;
 
-	if (chip->pdata->init_data)
-		for (i = 0; i < chip->pdata->num_init_data; i++)
-			regmap_write(chip->regmap,
-					chip->pdata->init_data[i].addr,
-					chip->pdata->init_data[i].data);
-
-	if (!chip->pdata->enable_current_sense) {
+	if (!chip->enable_current_sense) {
 		regmap_write(chip->regmap, MAX17042_CGAIN, 0x0000);
 		regmap_write(chip->regmap, MAX17042_MiscCFG, 0x0003);
 		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
@@ -1142,6 +1106,16 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 		return dev_err_probe(dev, PTR_ERR(chip->battery),
 				     "failed: power supply register\n");
 
+	/*
+	 * Some firmwares do not set FullSOCThr, Enable End-of-Charge Detection
+	 * when the voltage FG reports 95%, as recommended in the datasheet.
+	 */
+	if (use_default_config &&
+	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047 ||
+	     chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050))
+		regmap_write(chip->regmap, MAX17047_FullSOCThr,
+			     MAX17042_BATTERY_FULL << 8);
+
 	if (irq) {
 		unsigned int flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_PROBE_SHARED;
 
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index c417abd2ab70..36817da50548 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -177,16 +177,6 @@ enum max170xx_chip_type {
 	MAXIM_DEVICE_TYPE_NUM
 };
 
-/*
- * used for setting a register to a desired value
- * addr : address for a register
- * data : setting value for the register
- */
-struct max17042_reg_data {
-	u8 addr;
-	u16 data;
-};
-
 struct max17042_config_data {
 	/* External current sense resistor value in milli-ohms */
 	u32	cur_sense_val;
@@ -244,23 +234,4 @@ struct max17042_config_data {
 	u16	cell_char_tbl[MAX17042_CHARACTERIZATION_DATA_SIZE];
 } __packed;
 
-struct max17042_platform_data {
-	struct max17042_reg_data *init_data;
-	struct max17042_config_data *config_data;
-	int num_init_data; /* Number of enties in init_data array */
-	bool enable_current_sense;
-	bool enable_por_init; /* Use POR init from Maxim appnote */
-
-	/*
-	 * R_sns in micro-ohms.
-	 * default 10000 (if r_sns = 0) as it is the recommended value by
-	 * the datasheet although it can be changed by board designers.
-	 */
-	unsigned int r_sns;
-	int         vmin;	/* in millivolts */
-	int         vmax;	/* in millivolts */
-	int         temp_min;	/* in tenths of degree Celsius */
-	int         temp_max;	/* in tenths of degree Celsius */
-};
-
 #endif /* __MAX17042_BATTERY_H_ */
-- 
2.53.0

