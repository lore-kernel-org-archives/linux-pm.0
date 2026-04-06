Received: from outbound.mr.icloud.com (p-west2-cluster1-host6-snip4-10.eps.apple.com [57.103.68.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3DF3264C7
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509125; cv=none; b=gKUDPgnQ1R2PMEHLGvARtXAbNFnQUxwSi7HAoysH0qUUIy/XNXf6fMShLzljR+fMumyRzqw69c2AsTMnKzmMLKkoKkktEFSElerXHwm0lxPktTJsOkPKayrTNm4y2g/011TG6L9ko8W1l3YtBccx/sYr9Z0JqsLHZaBbZJxiOBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509125; c=relaxed/simple;
	bh=c0Tm6gUVO8eXh0ngq8yEi44CnKTh4grDBpjqyrMuG3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZo3qwwClrDwjFTysMKKmbzH7m8DeQZcwYRcs1gWULqqKRR2m0HNLKjLAQxtcQndpoPhGhB5TxqachuWUb8XSNenHWdQLjeJMTt5t5Kdwl5DZCiIZfT3N2K6GWOhV5wTPgB6OEQV9VdMl/i9Gj9Yqf2GwavNquUjWpdDvSqcJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GpmagIRO; arc=none smtp.client-ip=57.103.68.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GpmagIRO"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id 4F77F1800276;
	Mon, 06 Apr 2026 20:58:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775509122; x=1778101122; bh=ngkPovcK5vHtdBVUS/5qRg0nyTmDHTx7VvRDaWX4Huo=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=GpmagIRO2PFIDkJCLPlaQZS0ZOBJm57iySkCfAReDOjEhb2wo70oAXI3wt2Qc9UaEwojNNqgt+kLJ3cpckBwKX2ZqAKJFtP7hLK9Wudb46Y/QP6PjgKuoskuJtO4BiLev7uf8Be5p73kvXXJsnnAVXcf97sDt/DugME2fvhW2utGknmT5dailaM5A5aPC+U22IHQoHZvjtLOYjYuTFhqd3KOZdckAe1xiT0sCx2RbiHj47YfQQmSbxgz/8P34H9JAxbRk7c8XaUQWigP+eRgTWyNiPC1pKeG7a0C/vBhvI9oPnNFUiQay+B2gHcELRxIhSQVSghowGGsOBaJH40lZQ==
Received: from bigre.tail98293.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id 24B4C1800277;
	Mon, 06 Apr 2026 20:58:40 +0000 (UTC)
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
Subject: [PATCH v1 8/9] power: supply: Read MAX17042 battery info before registration
Date: Mon,  6 Apr 2026 16:57:56 -0400
Message-ID: <20260406205759.493288-9-vincent.cloutier@icloud.com>
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
X-Proofpoint-GUID: 1JmlubVl1nVrWppVL01zX9CC8bIQ51OK
X-Proofpoint-ORIG-GUID: 1JmlubVl1nVrWppVL01zX9CC8bIQ51OK
X-Authority-Info-Out: v=2.4 cv=dcKNHHXe c=1 sm=1 tr=0 ts=69d41e81
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=OUvvsuZA6Cg3MKn36OAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIwNiBTYWx0ZWRfXzZRhShFw+N9R
 JL+mrrU8gmQebU3bWaD0gHU7u5QOqUp/grY7lFo1QOMDm9JQQad6+WrWcN+HFaLaPQztcBU3gzP
 8t3ihECyWJ7nOQHRE+YCZZOxQm1HMEYyBEeHJcsRdBO6WkHSLHpEvULY+Z5s66WWXm5Arh97iC0
 0w9inemMl8Evh6wbD7w9G9eGYT6MT9InY483g4IdSgdNg6/wyVPyzjqgIB3VxF3SEmkIT5HyD+3
 gc6V7Z2lU7KDOrBABg+nJLPUcjZLPTmLYKKARU+rABEtwdxhOB+AcBI0ynmZH/5NbX9978KEXIx
 gfL39C/3ju1HUeRzeeMenlBbs8o8zEjip3jHTlMUsGkbdXieajwuttLU+DCFHk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604060206

From: Vincent Cloutier <vincent@cloutier.co>

Rework the MAX17042 `monitored-battery` path so the driver can consume DT
battery information before registering its power-supply device.

To do that, factor the parser in `power_supply_core` behind a new
`devm_power_supply_get_battery_info()` helper and let battery drivers
pass the pre-parsed `battery_info` through `struct power_supply_config`.
MAX17042 can then apply the design-capacity and termination-current data
before registration without exposing the battery too early or reparsing
the same node later in the class core.

Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c  |  62 ++++++++
 drivers/power/supply/power_supply_core.c | 188 ++++++++++++++---------
 include/linux/power/max17042_battery.h   |   1 +
 include/linux/power_supply.h             |  10 ++
 4 files changed, 187 insertions(+), 74 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 793164bd55d9..5bf15c19fc5d 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1025,6 +1025,57 @@ static int max17042_init_defaults(struct max17042_chip *chip)
 	return 0;
 }
 
+static int max17042_apply_battery_properties(struct max17042_chip *chip,
+					     struct power_supply_battery_info *info)
+{
+	struct device *dev = chip->dev;
+	bool needs_config;
+	u64 data64;
+
+	if (!info)
+		return 0;
+
+	needs_config = (chip->enable_current_sense &&
+			(info->charge_full_design_uah != -EINVAL ||
+			 info->charge_term_current_ua != -EINVAL)) ||
+		       (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055 &&
+			info->voltage_max_design_uv > 4250000);
+	if (!needs_config)
+		return 0;
+
+	if (!chip->config_data) {
+		chip->config_data = devm_kzalloc(dev,
+						 sizeof(*chip->config_data),
+						 GFP_KERNEL);
+		if (!chip->config_data)
+			return -ENOMEM;
+	}
+
+	if (chip->enable_current_sense &&
+	    info->charge_full_design_uah != -EINVAL) {
+		data64 = (u64)info->charge_full_design_uah * chip->r_sns;
+		do_div(data64, MAX17042_CAPACITY_LSB);
+		chip->config_data->design_cap = (u16)data64;
+		chip->enable_por_init = true;
+	}
+
+	if (chip->enable_current_sense &&
+	    info->charge_term_current_ua != -EINVAL) {
+		data64 = (u64)info->charge_term_current_ua * chip->r_sns;
+		do_div(data64, MAX17042_CURRENT_LSB);
+		chip->config_data->ichgt_term = (u16)data64;
+		chip->enable_por_init = true;
+	}
+
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055 &&
+	    info->voltage_max_design_uv > 4250000) {
+		chip->config_data->model_cfg = MAX17055_MODELCFG_VCHG_BIT;
+		chip->enable_por_init = true;
+	}
+
+	return 0;
+}
+
 static const struct regmap_config max17042_regmap_config = {
 	.name = "max17042",
 	.reg_bits = 8,
@@ -1060,6 +1111,7 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 	const struct power_supply_desc *max17042_desc = &max17042_psy_desc;
 	struct power_supply_config psy_cfg = {};
 	struct max17042_chip *chip;
+	struct power_supply_battery_info *battery_info = NULL;
 	int ret;
 	u32 val;
 	bool use_default_config = false;
@@ -1106,12 +1158,22 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 	if (chip->r_sns == 0)
 		chip->r_sns = MAX17042_DEFAULT_SNS_RESISTOR;
 
+	ret = devm_power_supply_get_battery_info(dev, &battery_info);
+	if (ret && ret != -ENODEV && ret != -ENOENT)
+		return ret;
+
+	ret = max17042_apply_battery_properties(chip, battery_info);
+	if (ret)
+		return ret;
+
 	if (!chip->enable_current_sense) {
 		regmap_write(chip->regmap, MAX17042_CGAIN, 0x0000);
 		regmap_write(chip->regmap, MAX17042_MiscCFG, 0x0003);
 		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
 	}
 
+	psy_cfg.battery_info = battery_info;
+
 	chip->battery = devm_power_supply_register(dev, max17042_desc,
 						   &psy_cfg);
 	if (IS_ERR(chip->battery))
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index a446d3d086fc..7ca3ed34095e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -577,20 +577,76 @@ struct power_supply *devm_power_supply_get_by_reference(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_power_supply_get_by_reference);
 
-int power_supply_get_battery_info(struct power_supply *psy,
-				  struct power_supply_battery_info **info_out)
+static void __power_supply_put_battery_info(struct device *dev,
+					    struct power_supply_battery_info *info)
+{
+	int i;
+
+	for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
+		if (info->ocv_table[i])
+			devm_kfree(dev, info->ocv_table[i]);
+	}
+
+	if (info->resist_table)
+		devm_kfree(dev, info->resist_table);
+
+	devm_kfree(dev, info);
+}
+
+static void power_supply_init_battery_info(struct power_supply_battery_info *info)
+{
+	int index;
+
+	info->technology = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+	info->energy_full_design_uwh = -EINVAL;
+	info->charge_full_design_uah = -EINVAL;
+	info->voltage_min_design_uv = -EINVAL;
+	info->voltage_max_design_uv = -EINVAL;
+	info->precharge_current_ua = -EINVAL;
+	info->charge_term_current_ua = -EINVAL;
+	info->constant_charge_current_max_ua = -EINVAL;
+	info->constant_charge_voltage_max_uv = -EINVAL;
+	info->tricklecharge_current_ua = -EINVAL;
+	info->precharge_voltage_max_uv = -EINVAL;
+	info->charge_restart_voltage_uv = -EINVAL;
+	info->overvoltage_limit_uv = -EINVAL;
+	info->maintenance_charge = NULL;
+	info->alert_low_temp_charge_current_ua = -EINVAL;
+	info->alert_low_temp_charge_voltage_uv = -EINVAL;
+	info->alert_high_temp_charge_current_ua = -EINVAL;
+	info->alert_high_temp_charge_voltage_uv = -EINVAL;
+	info->temp_ambient_alert_min = INT_MIN;
+	info->temp_ambient_alert_max = INT_MAX;
+	info->temp_alert_min = INT_MIN;
+	info->temp_alert_max = INT_MAX;
+	info->temp_min = INT_MIN;
+	info->temp_max = INT_MAX;
+	info->factory_internal_resistance_uohm = -EINVAL;
+	info->resist_table = NULL;
+	info->bti_resistance_ohm = -EINVAL;
+	info->bti_resistance_tolerance = -EINVAL;
+
+	for (index = 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
+		info->ocv_table[index] = NULL;
+		info->ocv_temp[index] = -EINVAL;
+		info->ocv_table_size[index] = -EINVAL;
+	}
+}
+
+static int __power_supply_get_battery_info(struct device *dev,
+					   struct fwnode_handle *srcnode,
+					   struct power_supply_battery_info **info_out)
 {
 	struct power_supply_resistance_temp_table *resist_table;
 	struct power_supply_battery_info *info;
-	struct fwnode_handle *srcnode, *fwnode;
+	struct fwnode_handle *fwnode;
 	const char *value;
 	int err, len, index, proplen;
 	u32 *propdata __free(kfree) = NULL;
 	u32 min_max[2];
 
-	srcnode = dev_fwnode(&psy->dev);
-	if (!srcnode && psy->dev.parent)
-		srcnode = dev_fwnode(psy->dev.parent);
+	if (!srcnode)
+		return -ENODEV;
 
 	fwnode = fwnode_find_reference(srcnode, "monitored-battery", 0);
 	if (IS_ERR(fwnode))
@@ -602,7 +658,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 
 
 	/* Try static batteries first */
-	err = samsung_sdi_battery_get_info(&psy->dev, value, &info);
+	err = samsung_sdi_battery_get_info(dev, value, &info);
 	if (!err)
 		goto out_ret_pointer;
 	else if (err == -ENODEV)
@@ -617,46 +673,13 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		goto out_put_node;
 	}
 
-	info = devm_kzalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		err = -ENOMEM;
 		goto out_put_node;
 	}
 
-	info->technology                     = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
-	info->energy_full_design_uwh         = -EINVAL;
-	info->charge_full_design_uah         = -EINVAL;
-	info->voltage_min_design_uv          = -EINVAL;
-	info->voltage_max_design_uv          = -EINVAL;
-	info->precharge_current_ua           = -EINVAL;
-	info->charge_term_current_ua         = -EINVAL;
-	info->constant_charge_current_max_ua = -EINVAL;
-	info->constant_charge_voltage_max_uv = -EINVAL;
-	info->tricklecharge_current_ua       = -EINVAL;
-	info->precharge_voltage_max_uv       = -EINVAL;
-	info->charge_restart_voltage_uv      = -EINVAL;
-	info->overvoltage_limit_uv           = -EINVAL;
-	info->maintenance_charge             = NULL;
-	info->alert_low_temp_charge_current_ua = -EINVAL;
-	info->alert_low_temp_charge_voltage_uv = -EINVAL;
-	info->alert_high_temp_charge_current_ua = -EINVAL;
-	info->alert_high_temp_charge_voltage_uv = -EINVAL;
-	info->temp_ambient_alert_min         = INT_MIN;
-	info->temp_ambient_alert_max         = INT_MAX;
-	info->temp_alert_min                 = INT_MIN;
-	info->temp_alert_max                 = INT_MAX;
-	info->temp_min                       = INT_MIN;
-	info->temp_max                       = INT_MAX;
-	info->factory_internal_resistance_uohm  = -EINVAL;
-	info->resist_table                   = NULL;
-	info->bti_resistance_ohm             = -EINVAL;
-	info->bti_resistance_tolerance       = -EINVAL;
-
-	for (index = 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
-		info->ocv_table[index]       = NULL;
-		info->ocv_temp[index]        = -EINVAL;
-		info->ocv_table_size[index]  = -EINVAL;
-	}
+	power_supply_init_battery_info(info);
 
 	/* The property and field names below must correspond to elements
 	 * in enum power_supply_property. For reasoning, see
@@ -678,7 +701,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		else if (!strcmp("lithium-ion-manganese-oxide", value))
 			info->technology = POWER_SUPPLY_TECHNOLOGY_LiMn;
 		else
-			dev_warn(&psy->dev, "%s unknown battery type\n", value);
+			dev_warn(dev, "%s unknown battery type\n", value);
 	}
 
 	fwnode_property_read_u32(fwnode, "energy-full-design-microwatt-hours",
@@ -729,7 +752,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		err = len;
 		goto out_put_node;
 	} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
-		dev_err(&psy->dev, "Too many temperature values\n");
+		dev_err(dev, "Too many temperature values\n");
 		err = -EINVAL;
 		goto out_put_node;
 	} else if (len > 0) {
@@ -744,28 +767,28 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		char *propname __free(kfree) = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d",
 							 index);
 		if (!propname) {
-			power_supply_put_battery_info(psy, info);
+			__power_supply_put_battery_info(dev, info);
 			err = -ENOMEM;
 			goto out_put_node;
 		}
 		proplen = fwnode_property_count_u32(fwnode, propname);
 		if (proplen < 0 || proplen % 2 != 0) {
-			dev_err(&psy->dev, "failed to get %s\n", propname);
-			power_supply_put_battery_info(psy, info);
+			dev_err(dev, "failed to get %s\n", propname);
+			__power_supply_put_battery_info(dev, info);
 			err = -EINVAL;
 			goto out_put_node;
 		}
 
 		u32 *propdata __free(kfree) = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
 		if (!propdata) {
-			power_supply_put_battery_info(psy, info);
+			__power_supply_put_battery_info(dev, info);
 			err = -EINVAL;
 			goto out_put_node;
 		}
 		err = fwnode_property_read_u32_array(fwnode, propname, propdata, proplen);
 		if (err < 0) {
-			dev_err(&psy->dev, "failed to get %s\n", propname);
-			power_supply_put_battery_info(psy, info);
+			dev_err(dev, "failed to get %s\n", propname);
+			__power_supply_put_battery_info(dev, info);
 			goto out_put_node;
 		}
 
@@ -773,9 +796,9 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		info->ocv_table_size[index] = tab_len;
 
 		info->ocv_table[index] = table =
-			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
+			devm_kcalloc(dev, tab_len, sizeof(*table), GFP_KERNEL);
 		if (!info->ocv_table[index]) {
-			power_supply_put_battery_info(psy, info);
+			__power_supply_put_battery_info(dev, info);
 			err = -ENOMEM;
 			goto out_put_node;
 		}
@@ -791,14 +814,14 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		err = 0;
 		goto out_ret_pointer;
 	} else if (proplen < 0 || proplen % 2 != 0) {
-		power_supply_put_battery_info(psy, info);
+		__power_supply_put_battery_info(dev, info);
 		err = (proplen < 0) ? proplen : -EINVAL;
 		goto out_put_node;
 	}
 
 	propdata = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
 	if (!propdata) {
-		power_supply_put_battery_info(psy, info);
+		__power_supply_put_battery_info(dev, info);
 		err = -ENOMEM;
 		goto out_put_node;
 	}
@@ -806,17 +829,17 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	err = fwnode_property_read_u32_array(fwnode, "resistance-temp-table",
 					     propdata, proplen);
 	if (err < 0) {
-		power_supply_put_battery_info(psy, info);
+		__power_supply_put_battery_info(dev, info);
 		goto out_put_node;
 	}
 
 	info->resist_table_size = proplen / 2;
-	info->resist_table = resist_table = devm_kcalloc(&psy->dev,
-							 info->resist_table_size,
-							 sizeof(*resist_table),
-							 GFP_KERNEL);
+	info->resist_table = resist_table = devm_kcalloc(dev,
+						 info->resist_table_size,
+						 sizeof(*resist_table),
+						 GFP_KERNEL);
 	if (!info->resist_table) {
-		power_supply_put_battery_info(psy, info);
+		__power_supply_put_battery_info(dev, info);
 		err = -ENOMEM;
 		goto out_put_node;
 	}
@@ -834,22 +857,35 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	fwnode_handle_put(fwnode);
 	return err;
 }
-EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
 
-void power_supply_put_battery_info(struct power_supply *psy,
-				   struct power_supply_battery_info *info)
+int devm_power_supply_get_battery_info(struct device *dev,
+					      struct power_supply_battery_info **info_out)
 {
-	int i;
+	struct fwnode_handle *srcnode = dev_fwnode(dev);
 
-	for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
-		if (info->ocv_table[i])
-			devm_kfree(&psy->dev, info->ocv_table[i]);
-	}
+	if (!srcnode && dev->parent)
+		srcnode = dev_fwnode(dev->parent);
 
-	if (info->resist_table)
-		devm_kfree(&psy->dev, info->resist_table);
+	return __power_supply_get_battery_info(dev, srcnode, info_out);
+}
+EXPORT_SYMBOL_GPL(devm_power_supply_get_battery_info);
+
+int power_supply_get_battery_info(struct power_supply *psy,
+				  struct power_supply_battery_info **info_out)
+{
+	struct fwnode_handle *srcnode = dev_fwnode(&psy->dev);
+
+	if (!srcnode && psy->dev.parent)
+		srcnode = dev_fwnode(psy->dev.parent);
 
-	devm_kfree(&psy->dev, info);
+	return __power_supply_get_battery_info(&psy->dev, srcnode, info_out);
+}
+EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
+
+void power_supply_put_battery_info(struct power_supply *psy,
+				   struct power_supply_battery_info *info)
+{
+	__power_supply_put_battery_info(&psy->dev, info);
 }
 EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
 
@@ -1620,9 +1656,13 @@ __power_supply_register(struct device *parent,
 	 * expose battery data to userspace for battery devices.
 	 */
 	if (desc->type == POWER_SUPPLY_TYPE_BATTERY) {
-		rc = power_supply_get_battery_info(psy, &psy->battery_info);
-		if (rc && rc != -ENODEV && rc != -ENOENT)
-			goto check_supplies_failed;
+		if (cfg && cfg->battery_info) {
+			psy->battery_info = cfg->battery_info;
+		} else {
+			rc = power_supply_get_battery_info(psy, &psy->battery_info);
+			if (rc && rc != -ENODEV && rc != -ENOENT)
+				goto check_supplies_failed;
+		}
 	}
 
 	spin_lock_init(&psy->changed_lock);
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 6b6e01d3e499..e9f2118e57c8 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -24,6 +24,7 @@
 #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
 
 #define MAX17055_MODELCFG_REFRESH_BIT	BIT(15)
+#define MAX17055_MODELCFG_VCHG_BIT	BIT(10)
 
 enum max17042_register {
 	MAX17042_STATUS		= 0x00,
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 360ffdf272da..f9fca7bb6e24 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -231,6 +231,7 @@ union power_supply_propval {
 
 struct device_node;
 struct power_supply;
+struct power_supply_battery_info;
 
 /* Run-time specific power supply configuration */
 struct power_supply_config {
@@ -239,6 +240,12 @@ struct power_supply_config {
 	/* Driver private data */
 	void *drv_data;
 
+	/*
+	 * Optional pre-parsed battery info for battery supplies.
+	 * The pointed-to data must remain valid for the power supply lifetime.
+	 */
+	struct power_supply_battery_info *battery_info;
+
 	/* Device specific sysfs attributes */
 	const struct attribute_group **attr_grp;
 
@@ -814,6 +821,9 @@ extern struct power_supply *power_supply_get_by_reference(struct fwnode_handle *
 extern struct power_supply *devm_power_supply_get_by_reference(
 				    struct device *dev, const char *property);
 
+extern int devm_power_supply_get_battery_info(struct device *dev,
+					      struct power_supply_battery_info **info_out);
+
 extern const enum power_supply_property power_supply_battery_info_properties[];
 extern const size_t power_supply_battery_info_properties_size;
 extern int power_supply_get_battery_info(struct power_supply *psy,
-- 
2.53.0

