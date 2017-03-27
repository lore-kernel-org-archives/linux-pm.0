From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v12 8/9] power: bq27xxx_battery: Enable chip data memory
 update for certain chips
Date: Mon, 27 Mar 2017 10:05:52 -0500
Message-ID: <5f1a297f-d99e-7fcc-c98c-f0802625abe3@ti.com>
References: <20170327074159.16213-1-liam@networkimprov.net>
 <20170327074159.16213-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:15493 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbdC0PGl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 11:06:41 -0400
In-Reply-To: <20170327074159.16213-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, linux-pm@vger.kernel.org
Cc: Liam Breck <kernel@networkimprov.net>

On 03/27/2017 02:41 AM, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
> 
> Support data memory update of BQ27500, 545, 421, 425, 441, 621.
> 
> Pass actual chip ID into _setup() to allow support for previously unID'd chips.
> 
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq27xxx_battery.c     | 70 ++++++++++++++++++++++++++++--
>  drivers/power/supply/bq27xxx_battery_i2c.c | 19 ++++----
>  include/linux/power/bq27xxx_battery.h      | 13 +++++-
>  3 files changed, 88 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index d845ade..95f86ad 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -894,6 +894,36 @@ static const char* bq27xxx_dm_reg_name[] = {
>  	[BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
>  };
>  
> +static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 10, 2,    0, 65535 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     = { }, /* missing on chip */
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 48, 2, 1000, 32767 },
> +};
> +
> +static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 23, 2,    0, 32767 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     = { 48, 25, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 67, 2, 2800,  3700 },
> +};
> +
> +static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2500,  3700 },
> +};
> +
> +static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 12, 2,    0, 32767 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 14, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 18, 2, 2800,  3700 },
> +};
> +
> +static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
> +};
> +
>  
>  static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
>  {
> @@ -1856,7 +1886,12 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
>  	schedule_delayed_work(&di->work, 0);
>  }
>  
> -int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
> +#define BQ27XXX_INIT(c,d,k)   \
> +	di->chip       = (c); \
> +	di->dm_regs    = (d); \
> +	di->unseal_key = (k)

These are static values per device, use a mapping table from chip ->
dm_regs/unseal_key, no need to fill in a static table at run-time.

> +
> +int bq27xxx_battery_setup(struct bq27xxx_device_info *di, enum bq27xxx_chip real_chip)
>  {
>  	struct power_supply_desc *psy_desc;
>  	struct power_supply_config psy_cfg = {
> @@ -1864,6 +1899,36 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>  		.drv_data = di,
>  	};
>  
> +	switch(real_chip) {
> +	                /* categories */
> +	case BQ27000:   BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27010:   BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ2750X:   BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27500:   BQ27XXX_INIT(real_chip, bq27500_dm_regs, 0x04143672); break;
> +	case BQ2751X:   BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27510G1: BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27510G2: BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27510G3: BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27520G1: BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27520G2: BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27520G3: BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27520G4: BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27530:   BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27541:   BQ27XXX_INIT(real_chip, 0, 0); break;
> +	case BQ27545:   BQ27XXX_INIT(real_chip, bq27545_dm_regs, 0x04143672); break;
> +	case BQ27421:   BQ27XXX_INIT(real_chip, bq27421_dm_regs, 0x80008000); break;
> +
> +	                /* members of categories */
> +	case BQ2752X:   BQ27XXX_INIT(BQ27510G3, 0, 0); break;
> +	case BQ27531:   BQ27XXX_INIT(BQ27530,   0, 0); break;
> +	case BQ27542:   BQ27XXX_INIT(BQ27541,   0, 0); break;
> +	case BQ27546:   BQ27XXX_INIT(BQ27541,   0, 0); break;
> +	case BQ27742:   BQ27XXX_INIT(BQ27541,   0, 0); break;
> +	case BQ27425:   BQ27XXX_INIT(BQ27421,   bq27425_dm_regs, 0x04143672); break;
> +	case BQ27441:   BQ27XXX_INIT(BQ27421,   bq27421_dm_regs, 0x80008000); break;
> +	case BQ27621:   BQ27XXX_INIT(BQ27421,   bq27621_dm_regs, 0x80008000); break;
> +	}
> +
>  	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>  	mutex_init(&di->lock);
>  	di->regs = bq27xxx_regs[di->chip];
> @@ -1981,11 +2046,10 @@ static int bq27xxx_battery_platform_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, di);
>  
>  	di->dev = &pdev->dev;
> -	di->chip = pdata->chip;
>  	di->name = pdata->name ?: dev_name(&pdev->dev);
>  	di->bus.read = bq27xxx_battery_platform_read;
>  
> -	return bq27xxx_battery_setup(di);
> +	return bq27xxx_battery_setup(di, pdata->chip);
>  }
>  
>  static int bq27xxx_battery_platform_remove(struct platform_device *pdev)
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index a597221..aaeddc0 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -169,7 +169,6 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>  
>  	di->id = num;
>  	di->dev = &client->dev;
> -	di->chip = id->driver_data;
>  	di->name = name;
>  
>  	di->bus.read = bq27xxx_battery_i2c_read;
> @@ -177,7 +176,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>  	di->bus.read_bulk = bq27xxx_battery_i2c_bulk_read;
>  	di->bus.write_bulk = bq27xxx_battery_i2c_bulk_write;
>  
> -	ret = bq27xxx_battery_setup(di);
> +	ret = bq27xxx_battery_setup(di, id->driver_data);
>  	if (ret)
>  		goto err_failed;
>  
> @@ -230,7 +229,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>  	{ "bq27210", BQ27010 },
>  	{ "bq27500", BQ2750X },
>  	{ "bq27510", BQ2751X },
> -	{ "bq27520", BQ2751X },
> +	{ "bq27520", BQ2752X },
>  	{ "bq27500-1", BQ27500 },
>  	{ "bq27510g1", BQ27510G1 },
>  	{ "bq27510g2", BQ27510G2 },
> @@ -240,16 +239,16 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>  	{ "bq27520g3", BQ27520G3 },
>  	{ "bq27520g4", BQ27520G4 },
>  	{ "bq27530", BQ27530 },
> -	{ "bq27531", BQ27530 },
> +	{ "bq27531", BQ27531 },
>  	{ "bq27541", BQ27541 },
> -	{ "bq27542", BQ27541 },
> -	{ "bq27546", BQ27541 },
> -	{ "bq27742", BQ27541 },
> +	{ "bq27542", BQ27542 },
> +	{ "bq27546", BQ27546 },
> +	{ "bq27742", BQ27742 },
>  	{ "bq27545", BQ27545 },
>  	{ "bq27421", BQ27421 },
> -	{ "bq27425", BQ27421 },
> -	{ "bq27441", BQ27421 },
> -	{ "bq27621", BQ27421 },
> +	{ "bq27425", BQ27425 },
> +	{ "bq27441", BQ27441 },
> +	{ "bq27621", BQ27621 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index 227eb08..4577727 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -2,6 +2,7 @@
>  #define __LINUX_BQ27X00_BATTERY_H__
>  
>  enum bq27xxx_chip {
> +	/* categories; index for bq27xxx_regs[] */
>  	BQ27000 = 1, /* bq27000, bq27200 */
>  	BQ27010, /* bq27010, bq27210 */
>  	BQ2750X, /* bq27500 deprecated alias */
> @@ -18,6 +19,16 @@ enum bq27xxx_chip {
>  	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>  	BQ27545, /* bq27545 */
>  	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
> +
> +	/* members of categories; translate these to category in _setup() */
> +	BQ2752X, /* deprecated alias */
> +	BQ27531,
> +	BQ27542,
> +	BQ27546,
> +	BQ27742,
> +	BQ27425,
> +	BQ27441,
> +	BQ27621,
>  };
>  
>  /**
> @@ -78,7 +89,7 @@ struct bq27xxx_device_info {
>  };
>  
>  void bq27xxx_battery_update(struct bq27xxx_device_info *di);
> -int bq27xxx_battery_setup(struct bq27xxx_device_info *di);
> +int bq27xxx_battery_setup(struct bq27xxx_device_info *di, enum bq27xxx_chip real_chip);

struct bq27xxx_device_info contains all needed info, if you want more
info passed into battery_setup() then add that into bq27xxx_device_info.

>  void bq27xxx_battery_teardown(struct bq27xxx_device_info *di);
>  
>  #endif
> 
