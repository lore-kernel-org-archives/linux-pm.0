From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] power: bq27xxx_battery: Unique chip IDs
Date: Wed, 8 Mar 2017 11:23:24 -0600
Message-ID: <0088f5a9-995e-bc57-6fa1-3c8991287a13@ti.com>
References: <20170307230536.22886-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:19654 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbdCHRX3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2017 12:23:29 -0500
In-Reply-To: <20170307230536.22886-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, linux-pm@vger.kernel.org
Cc: Liam Breck <kernel@networkimprov.net>

On 03/07/2017 05:05 PM, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
> 
> Assign every chip a unique ID, to enable
> power_supply_battery_info config for all supported chips.
> There are no functional changes to the driver.
> 
> Depends-on: power: bq27xxx_battery: Add power_supply_battery_info support
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> 
> ---
> Andrew, let me know if you'd like me to include this in the other patchset.

Why do we need this at all? It may be just bit too early for me, but I'm
not seeing what this gets us, that couldn't be done before.

> 
>  drivers/power/supply/bq27xxx_battery.c     | 94 +++++++++++++++++-------------
>  drivers/power/supply/bq27xxx_battery_i2c.c | 14 ++---
>  include/linux/power/bq27xxx_battery.h      | 15 +++--
>  3 files changed, 71 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index ed976a1..30af0e4 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -117,8 +117,8 @@ enum bq27xxx_reg_index {
>  };
>  
>  /* Register mappings */
> -static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
> -	[BQ27000] = {
> +static u8
> +	bq27000_regs[BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_REG_CTRL] = 0x00,
>  		[BQ27XXX_REG_TEMP] = 0x06,
>  		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
> @@ -142,7 +142,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
>  		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
>  	},
> -	[BQ27010] = {
> +	bq27010_regs[BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_REG_CTRL] = 0x00,
>  		[BQ27XXX_REG_TEMP] = 0x06,
>  		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
> @@ -166,7 +166,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
>  		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
>  	},
> -	[BQ27500] = {
> +	bq27500_regs[BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_REG_CTRL] = 0x00,
>  		[BQ27XXX_REG_TEMP] = 0x06,
>  		[BQ27XXX_REG_INT_TEMP] = 0x28,
> @@ -190,7 +190,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_DM_DATA] = 0x40,
>  		[BQ27XXX_DM_CKSUM] = 0x60,
>  	},
> -	[BQ27510] = {
> +	bq27510_regs[BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_REG_CTRL] = 0x00,
>  		[BQ27XXX_REG_TEMP] = 0x06,
>  		[BQ27XXX_REG_INT_TEMP] = 0x28,
> @@ -214,7 +214,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_DM_DATA] = 0x40,
>  		[BQ27XXX_DM_CKSUM] = 0x60,
>  	},
> -	[BQ27530] = {
> +	bq27530_regs[BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_REG_CTRL] = 0x00,
>  		[BQ27XXX_REG_TEMP] = 0x06,
>  		[BQ27XXX_REG_INT_TEMP] = 0x32,
> @@ -238,7 +238,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_DM_DATA] = 0x40,
>  		[BQ27XXX_DM_CKSUM] = 0x60,
>  	},
> -	[BQ27541] = {
> +	bq27541_regs[BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_REG_CTRL] = 0x00,
>  		[BQ27XXX_REG_TEMP] = 0x06,
>  		[BQ27XXX_REG_INT_TEMP] = 0x28,
> @@ -262,7 +262,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_DM_DATA] = 0x40,
>  		[BQ27XXX_DM_CKSUM] = 0x60,
>  	},
> -	[BQ27545] = {
> +	bq27545_regs[BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_REG_CTRL] = 0x00,
>  		[BQ27XXX_REG_TEMP] = 0x06,
>  		[BQ27XXX_REG_INT_TEMP] = 0x28,
> @@ -286,7 +286,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_DM_DATA] = 0x40,
>  		[BQ27XXX_DM_CKSUM] = 0x60,
>  	},
> -	[BQ27421] = {
> +	bq27425_regs[BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_REG_CTRL] = 0x00,
>  		[BQ27XXX_REG_TEMP] = 0x02,
>  		[BQ27XXX_REG_INT_TEMP] = 0x1e,
> @@ -309,31 +309,25 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_DM_BLOCK] = 0x3f,
>  		[BQ27XXX_DM_DATA] = 0x40,
>  		[BQ27XXX_DM_CKSUM] = 0x60,
> -	},
> -	[BQ27425] = {
> -		[BQ27XXX_REG_CTRL] = 0x00,
> -		[BQ27XXX_REG_TEMP] = 0x02,
> -		[BQ27XXX_REG_INT_TEMP] = 0x1e,
> -		[BQ27XXX_REG_VOLT] = 0x04,
> -		[BQ27XXX_REG_AI] = 0x10,
> -		[BQ27XXX_REG_FLAGS] = 0x06,
> -		[BQ27XXX_REG_TTE] = INVALID_REG_ADDR,
> -		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
> -		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
> -		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> -		[BQ27XXX_REG_NAC] = 0x08,
> -		[BQ27XXX_REG_FCC] = 0x0e,
> -		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
> -		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
> -		[BQ27XXX_REG_SOC] = 0x1c,
> -		[BQ27XXX_REG_DCAP] = 0x3c,
> -		[BQ27XXX_REG_AP] = 0x18,
> -		[BQ27XXX_DM_CTRL] = 0x61,
> -		[BQ27XXX_DM_CLASS] = 0x3e,
> -		[BQ27XXX_DM_BLOCK] = 0x3f,
> -		[BQ27XXX_DM_DATA] = 0x40,
> -		[BQ27XXX_DM_CKSUM] = 0x60,
> -	},
> +	};
> +
> +static u8* bq27xxx_regs[] = {
> +	[BQ27000] = bq27000_regs, /* really bq27200 */
> +	[BQ27010] = bq27010_regs, /* really bq27210 */

Not strictly true, the bq270x0 and bq272x0 are different chips, one has
an HDQ bus and the other I2C, later chips have both ports on each chip.

Andrew

> +	[BQ27500] = bq27500_regs,
> +	[BQ27510] = bq27510_regs,
> +	[BQ27520] = bq27510_regs,
> +	[BQ27530] = bq27530_regs,
> +	[BQ27531] = bq27530_regs,
> +	[BQ27541] = bq27541_regs,
> +	[BQ27542] = bq27541_regs,
> +	[BQ27546] = bq27541_regs,
> +	[BQ27742] = bq27541_regs,
> +	[BQ27545] = bq27545_regs,
> +	[BQ27425] = bq27425_regs,
> +	[BQ27421] = bq27425_regs,
> +	[BQ27441] = bq27425_regs,
> +	[BQ27621] = bq27425_regs,
>  };
>  
>  static enum power_supply_property bq27000_battery_props[] = {
> @@ -469,7 +463,7 @@ static enum power_supply_property bq27545_battery_props[] = {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>  
> -static enum power_supply_property bq27421_battery_props[] = {
> +static enum power_supply_property bq27425_battery_props[] = {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> @@ -498,11 +492,18 @@ static struct {
>  	BQ27XXX_PROP(BQ27010, bq27010_battery_props),
>  	BQ27XXX_PROP(BQ27500, bq27500_battery_props),
>  	BQ27XXX_PROP(BQ27510, bq27510_battery_props),
> +	BQ27XXX_PROP(BQ27520, bq27510_battery_props),
>  	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
> +	BQ27XXX_PROP(BQ27531, bq27530_battery_props),
>  	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
> +	BQ27XXX_PROP(BQ27542, bq27541_battery_props),
> +	BQ27XXX_PROP(BQ27546, bq27541_battery_props),
> +	BQ27XXX_PROP(BQ27742, bq27541_battery_props),
>  	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
> -	BQ27XXX_PROP(BQ27421, bq27421_battery_props),
> -	BQ27XXX_PROP(BQ27425, bq27421_battery_props),
> +	BQ27XXX_PROP(BQ27425, bq27425_battery_props),
> +	BQ27XXX_PROP(BQ27421, bq27425_battery_props),
> +	BQ27XXX_PROP(BQ27441, bq27425_battery_props),
> +	BQ27XXX_PROP(BQ27621, bq27425_battery_props),
>  };
>  
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> @@ -796,7 +797,8 @@ static int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di,
>  static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
>  					  struct bq27xxx_dm_buf *buf)
>  {
> -	bool cfgup = di->chip == BQ27425 || di->chip == BQ27421; /* || BQ27441 || BQ27621 */
> +	bool cfgup = di->chip == BQ27425 || di->chip == BQ27421
> +		  || di->chip == BQ27441 || di->chip == BQ27621;
>  	int ret;
>  
>  	if (!buf->updt)
> @@ -1169,8 +1171,11 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
>  	case BQ27545:
>  		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
>  	case BQ27530:
> +	case BQ27531:
>  	case BQ27421:
>  	case BQ27425:
> +	case BQ27441:
> +	case BQ27621:
>  		return flags & BQ27XXX_FLAG_OT;
>  	default:
>  		return false;
> @@ -1182,10 +1187,17 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
>   */
>  static bool bq27xxx_battery_undertemp(struct bq27xxx_device_info *di, u16 flags)
>  {
> -	if (di->chip == BQ27530 || di->chip == BQ27421 || di->chip == BQ27425)
> +	switch (di->chip) {
> +	case BQ27530:
> +	case BQ27531:
> +	case BQ27421:
> +	case BQ27425:
> +	case BQ27441:
> +	case BQ27621:
>  		return flags & BQ27XXX_FLAG_UT;
> -
> -	return false;
> +	default:
> +		return false;
> +	}
>  }
>  
>  /*
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index 4039b9d..abdc266 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -230,18 +230,18 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>  	{ "bq27210", BQ27010 },
>  	{ "bq27500", BQ27500 },
>  	{ "bq27510", BQ27510 },
> -	{ "bq27520", BQ27510 },
> +	{ "bq27520", BQ27520 },
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
>  	{ "bq27425", BQ27425 },
> -	{ "bq27441", BQ27425 },
> -	{ "bq27621", BQ27425 },
> +	{ "bq27441", BQ27441 },
> +	{ "bq27621", BQ27621 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index 44f469a..870e6f5 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -2,15 +2,22 @@
>  #define __LINUX_BQ27X00_BATTERY_H__
>  
>  enum bq27xxx_chip {
> -	BQ27000 = 1, /* bq27000, bq27200 */
> -	BQ27010, /* bq27010, bq27210 */
> +	BQ27000 = 1, /* bq27200 */
> +	BQ27010, /* bq27210 */
>  	BQ27500, /* bq27500 */
>  	BQ27510, /* bq27510, bq27520 */
> +	BQ27520,
>  	BQ27530, /* bq27530, bq27531 */
> +	BQ27531,
>  	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
> +	BQ27542,
> +	BQ27546,
> +	BQ27742,
>  	BQ27545, /* bq27545 */
> -	BQ27421, /* bq27421 */
> -	BQ27425, /* bq27425, bq27441, bq27621 */
> +	BQ27425, /* bq27425, bq27421, bq27441, bq27621 */
> +	BQ27421,
> +	BQ27441,
> +	BQ27621,
>  };
>  
>  /**
> 
