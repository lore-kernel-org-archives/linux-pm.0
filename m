From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 4/5] power: supply: gpio-charger: LTC3651 support
Date: Wed, 17 Jan 2018 21:32:36 +0100
Message-ID: <20180117203236.GE8774@lenoch>
References: <20180117202701.GA8774@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:33078 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753710AbeAQUci (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 15:32:38 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23994691AbeAQUchXipDE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jan 2018 21:32:37 +0100
Content-Disposition: inline
In-Reply-To: <20180117202701.GA8774@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>

Just a proof of concept...

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/power/supply/gpio-charger.c | 78 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 11ce5fab27d5..463e0abe975b 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -254,7 +254,45 @@ static int gpio_charger_cfg_init(struct device *dev,
 			struct gpio_charger *gpio_charger,
 			struct gpio_charger_config *cfg)
 {
-	return -EINVAL;
+	struct gpio_desc *gpiod;
+	struct power_supply_desc *charger_desc;
+	int ret, i = 0;
+
+	while (cfg->gpios[i].label) {
+		gpiod = (cfg->gpios[i].flags & FLAG_PIN_OPTIONAL) ?
+			devm_gpiod_get_optional(dev, cfg->gpios[i].label,
+						GPIOD_IN) :
+			devm_gpiod_get(dev, cfg->gpios[i].label, GPIOD_IN);
+
+		if (IS_ERR(gpiod)) {
+			ret = PTR_ERR(gpiod);
+			if (ret != EPROBE_DEFER)
+				dev_err(dev,
+					"Failed to acquire '%s' GPIO: %d\n",
+					cfg->gpios[i].label, ret);
+			return ret;
+		}
+		gpio_charger->pin[i].gpiod = gpiod;
+		i++;
+	}
+
+	gpio_charger->nmaps = cfg->nmaps;
+	gpio_charger->mapping = cfg->mapping;
+	gpio_charger->npins = i;
+
+	charger_desc = &gpio_charger->charger_desc;
+	charger_desc->type = POWER_SUPPLY_TYPE_MAINS;
+	charger_desc->num_properties = cfg->nmaps;
+	charger_desc->properties = devm_kzalloc(dev,
+                             cfg->nmaps * sizeof(enum power_supply_property),
+                             GFP_KERNEL);
+	if (!charger_desc->properties)
+		return -ENOMEM;
+
+	for (i = 0; i < cfg->nmaps; i++)
+		charger_desc->properties[i] = cfg->mapping[i].psp;
+
+	return 0;
 }
 
 static int gpio_charger_probe(struct platform_device *pdev)
@@ -381,8 +419,44 @@ static int gpio_charger_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(gpio_charger_pm_ops,
 		gpio_charger_suspend, gpio_charger_resume);
 
+struct gpio_charger_mapping chrg_fault_mapping[] = {
+	{
+		POWER_SUPPLY_PROP_ONLINE,
+		0,
+		MAP(0x01,
+		{ 0x01, 1 }),
+	}, {
+		POWER_SUPPLY_PROP_STATUS,
+		POWER_SUPPLY_STATUS_UNKNOWN,
+		MAP(0x02,
+		{ 0x02, POWER_SUPPLY_STATUS_CHARGING },
+		{ 0x00, POWER_SUPPLY_STATUS_NOT_CHARGING }),
+	}, {
+		POWER_SUPPLY_PROP_HEALTH,
+		POWER_SUPPLY_HEALTH_UNKNOWN,
+		MAP(0x06,
+		{ 0x00, POWER_SUPPLY_HEALTH_GOOD },
+		{ 0x02, POWER_SUPPLY_HEALTH_OVERHEAT },
+		{ 0x06, POWER_SUPPLY_HEALTH_DEAD }),
+	},
+};
+
+static const struct gpio_charger_config ltc3651_cfg = {
+	MAPPING(chrg_fault_mapping),
+	{
+		{ "lltc,acpr", 0 },
+		{ "lltc,chrg", FLAG_PIN_OPTIONAL },
+		{ "lltc,fault", FLAG_PIN_OPTIONAL },
+		{ NULL, 0 },
+	},
+};
+
 static const struct of_device_id gpio_charger_match[] = {
-	{ .compatible = "gpio-charger" },
+	{	.compatible = "gpio-charger" },
+	{
+		.compatible = "lltc,ltc3651-charger",
+		.data = (void *) &ltc3651_cfg,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gpio_charger_match);
-- 
2.15.1
