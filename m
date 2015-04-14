From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH] power_supply: Add TI BQ24257 charger driver
Date: Tue, 14 Apr 2015 12:49:22 +0300
Message-ID: <20150414094922.GA3838@lpalcu-linux>
References: <1428671897-12232-1-git-send-email-laurentiu.palcu@intel.com>
 <552BC09D.9040502@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1953 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbbDNJt0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Apr 2015 05:49:26 -0400
Content-Disposition: inline
In-Reply-To: <552BC09D.9040502@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 13, 2015 at 10:11:57PM +0900, Krzysztof Kozlowski wrote:
> W dniu 10.04.2015 o 22:18, Laurentiu Palcu pisze:
> >Based on the datasheet found here:
> >http://www.ti.com/lit/ds/symlink/bq24257.pdf
> >
> >Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
> 
> (...)
> 
> >diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
> >new file mode 100644
> >index 0000000..58b9af1
> >--- /dev/null
> >+++ b/drivers/power/bq24257_charger.c
> >@@ -0,0 +1,868 @@
> >+/*
> >+ * TI BQ24257 charger driver
> >+ *
> >+ * Copyright (C) 2015 Intel Corporation
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify
> >+ * it under the terms of the GNU General Public License as published by
> >+ * the Free Software Foundation; either version 2 of the License, or
> >+ * (at your option) any later version.
> >+ *
> >+ * This program is distributed in the hope that it will be useful,
> >+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >+ * GNU General Public License for more details.
> >+ *
> >+ */
> >+
> >+#include <linux/module.h>
> >+#include <linux/i2c.h>
> >+#include <linux/power_supply.h>
> >+#include <linux/regmap.h>
> >+#include <linux/types.h>
> >+#include <linux/gpio/consumer.h>
> >+#include <linux/interrupt.h>
> >+#include <linux/delay.h>
> >+
> >+#include <linux/acpi.h>
> >+#include <linux/of.h>
> >+
> >+#define BQ24257_REG_1			0x00
> >+#define BQ24257_REG_2			0x01
> >+#define BQ24257_REG_3			0x02
> >+#define BQ24257_REG_4			0x03
> >+#define BQ24257_REG_5			0x04
> >+#define BQ24257_REG_6			0x05
> >+#define BQ24257_REG_7			0x06
> >+
> >+#define BQ24257_MANUFACTURER		"Texas Instruments"
> >+#define BQ24257_STAT_IRQ		"stat"
> >+#define BQ24257_PG_GPIO			"pg"
> >+
> >+#define BQ24257_ILIM_SET_DELAY		1000	/* msec */
> >+
> >+enum bq24257_fields {
> >+	F_WD_FAULT, F_WD_EN, F_STAT, F_FAULT,			    /* REG 1 */
> >+	F_RESET, F_IILIMIT, F_EN_STAT, F_EN_TERM, F_CE, F_HZ_MODE,  /* REG 2 */
> >+	F_VBAT, F_USB_DET,					    /* REG 3 */
> >+	F_ICHG, F_ITERM,					    /* REG 4 */
> >+	F_LOOP_STATUS, F_LOW_CHG, F_DPDM_EN, F_CE_STATUS, F_VINDPM, /* REG 5 */
> >+	F_X2_TMR_EN, F_TMR, F_SYSOFF, F_TS_STAT,		    /* REG 6 */
> >+	F_VOVP, F_CLR_VDP, F_FORCE_BATDET, F_FORCE_PTM,		    /* REG 7 */
> >+
> >+	F_MAX_FIELDS
> >+};
> >+
> >+/* initial field values, converted from uV/uA */
> >+struct bq24257_init_data {
> >+	u8 ichg;	/* charge current      */
> >+	u8 vbat;	/* regulation voltage  */
> >+	u8 iterm;	/* termination current */
> >+};
> >+
> >+struct bq24257_state {
> >+	u8 status;
> >+	u8 fault;
> >+	bool power_good;
> >+};
> >+
> >+struct bq24257_device {
> >+	struct i2c_client *client;
> >+	struct device *dev;
> >+	struct power_supply *charger;
> >+	struct power_supply_desc charger_desc;
> >+
> >+	struct regmap *rmap;
> >+	struct regmap_field *rmap_fields[F_MAX_FIELDS];
> >+
> >+	struct gpio_desc *pg;
> >+
> >+	struct delayed_work iilimit_setup_work;
> >+
> >+	struct bq24257_init_data init_data;
> >+	struct bq24257_state state;
> >+
> >+	struct mutex lock; /* protect state data */
> >+};
> >+
> >+static bool bq24257_is_writeable_reg(struct device *dev, unsigned int reg)
> >+{
> >+	return true;
> 
> What is the benefit of such function always returning true?
Apparently, none. :) regmap_writeable() returns true, by default, anyway.
Thanks for spotting it.

> 
> (...)
> 
> >+
> >+static enum power_supply_property bq24257_power_supply_props[] = {
> >+	POWER_SUPPLY_PROP_MANUFACTURER,
> >+	POWER_SUPPLY_PROP_STATUS,
> >+	POWER_SUPPLY_PROP_ONLINE,
> >+	POWER_SUPPLY_PROP_HEALTH,
> >+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> >+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> >+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> >+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> >+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> >+};
> >+
> >+static char *bq24257_charger_supplied_to[] = {
> >+	"main-battery",
> >+};
> >+
> >+static int bq24257_power_supply_init(struct bq24257_device *bq)
> >+{
> >+	struct power_supply_config psy_cfg = { .drv_data = bq, };
> >+	struct power_supply_desc *psy_desc = &bq->charger_desc;
> >+
> >+	psy_desc->name = "bq24257-charger";
> >+	psy_desc->type = POWER_SUPPLY_TYPE_USB;
> >+	psy_desc->properties = bq24257_power_supply_props;
> >+	psy_desc->num_properties = ARRAY_SIZE(bq24257_power_supply_props);
> >+	psy_desc->get_property = bq24257_power_supply_get_property;
> 
> You are not modifying the power_supply_desc so it can be made a
> static const variable (file scope).
Fair enough. Will change in v2. I'll just give it a couple more days for
others to review.

laurentiu
