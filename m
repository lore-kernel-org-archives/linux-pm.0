From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v7 6/9] power: bq27xxx_battery: Add BQ27425 chip id
Date: Wed, 22 Feb 2017 14:15:16 -0600
Message-ID: <603d3912-5722-70da-f05d-2113c90c5d4b@ti.com>
References: <20170221213008.30044-1-liam@networkimprov.net>
 <20170221213008.30044-7-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:50884 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755105AbdBVUPm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Feb 2017 15:15:42 -0500
In-Reply-To: <20170221213008.30044-7-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On 02/21/2017 03:30 PM, Liam Breck wrote:
> From: Matt Ranostay <matt@ranostay.consulting>
> 
> This patch does not alter the function of the driver.
> This chip ID is referenced in the devicetree code.
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Looks inline with the datasheet,

Acked-by: Andrew F. Davis <afd@ti.com>

> ---
>  drivers/power/supply/bq27xxx_battery.c     | 23 ++++++++++++++++++++++-
>  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +-
>  include/linux/power/bq27xxx_battery.h      |  3 ++-
>  3 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 7272d1e..7475a5f 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -259,6 +259,25 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_REG_DCAP] = 0x3c,
>  		[BQ27XXX_REG_AP] = 0x18,
>  	},
> +	[BQ27425] = {
> +		[BQ27XXX_REG_CTRL] = 0x00,
> +		[BQ27XXX_REG_TEMP] = 0x02,
> +		[BQ27XXX_REG_INT_TEMP] = 0x1e,
> +		[BQ27XXX_REG_VOLT] = 0x04,
> +		[BQ27XXX_REG_AI] = 0x10,
> +		[BQ27XXX_REG_FLAGS] = 0x06,
> +		[BQ27XXX_REG_TTE] = INVALID_REG_ADDR,
> +		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
> +		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
> +		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> +		[BQ27XXX_REG_NAC] = 0x08,
> +		[BQ27XXX_REG_FCC] = 0x0e,
> +		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
> +		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
> +		[BQ27XXX_REG_SOC] = 0x1c,
> +		[BQ27XXX_REG_DCAP] = 0x3c,
> +		[BQ27XXX_REG_AP] = 0x18,
> +	},
>  };
>  
>  static enum power_supply_property bq27000_battery_props[] = {
> @@ -427,6 +446,7 @@ static struct {
>  	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
>  	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
>  	BQ27XXX_PROP(BQ27421, bq27421_battery_props),
> +	BQ27XXX_PROP(BQ27425, bq27421_battery_props),
>  };
>  
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> @@ -682,6 +702,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
>  		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
>  	case BQ27530:
>  	case BQ27421:
> +	case BQ27425:
>  		return flags & BQ27XXX_FLAG_OT;
>  	default:
>  		return false;
> @@ -693,7 +714,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
>   */
>  static bool bq27xxx_battery_undertemp(struct bq27xxx_device_info *di, u16 flags)
>  {
> -	if (di->chip == BQ27530 || di->chip == BQ27421)
> +	if (di->chip == BQ27530 || di->chip == BQ27421 || di->chip == BQ27425)
>  		return flags & BQ27XXX_FLAG_UT;
>  
>  	return false;
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index 5c5c3a6..d7da535 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -159,7 +159,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>  	{ "bq27742", BQ27541 },
>  	{ "bq27545", BQ27545 },
>  	{ "bq27421", BQ27421 },
> -	{ "bq27425", BQ27421 },
> +	{ "bq27425", BQ27425 },
>  	{ "bq27441", BQ27421 },
>  	{ "bq27621", BQ27421 },
>  	{},
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index 92df553..4925478 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -9,7 +9,8 @@ enum bq27xxx_chip {
>  	BQ27530, /* bq27530, bq27531 */
>  	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>  	BQ27545, /* bq27545 */
> -	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
> +	BQ27421, /* bq27421, bq27441, bq27621 */
> +	BQ27425, /* bq27425 */
>  };
>  
>  /**
> 
