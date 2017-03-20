From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v11 05/10] power: bq27xxx_battery: Make error reporting
 consistent
Date: Mon, 20 Mar 2017 11:57:54 -0500
Message-ID: <6e387ba3-c5ce-ef88-d5ab-560b190e8352@ti.com>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-6-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:50279 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbdCTTPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 15:15:48 -0400
In-Reply-To: <20170320094335.19224-6-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On 03/20/2017 04:43 AM, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
> 
> Previously errors were reported in a mix of styles via both dev_err() & dev_dbg().
> Report all errors with dev_err() and include error code in message.
> Report register ID separately in dev_dbg() message.
> 
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 35 ++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 398801a..2e2a3a8 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -794,11 +794,17 @@ MODULE_PARM_DESC(poll_interval,
>  static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
>  			       bool single)
>  {
> -	/* Reports EINVAL for invalid/missing registers */
> +	int ret;
> +
>  	if (!di || di->regs[reg_index] == INVALID_REG_ADDR)
>  		return -EINVAL;
>  
> -	return di->bus.read(di, di->regs[reg_index], single);
> +	ret = di->bus.read(di, di->regs[reg_index], single);
> +	if (ret < 0)
> +		dev_dbg(di->dev, "failed to read register 0x%02x (index %d)\n",
> +			di->regs[reg_index], reg_index);
> +

If we print out the error code here we don't have to do that in each of
the below printouts.

Otherwise looks good:
Acked-by: Andrew F. Davis <afd@ti.com>

> +	return ret;
>  }
>  
>  /*
> @@ -815,7 +821,7 @@ static int bq27xxx_battery_read_soc(struct bq27xxx_device_info *di)
>  		soc = bq27xxx_read(di, BQ27XXX_REG_SOC, false);
>  
>  	if (soc < 0)
> -		dev_dbg(di->dev, "error reading State-of-Charge\n");
> +		dev_err(di->dev, "error %d reading state-of-charge\n", soc);
>  
>  	return soc;
>  }
> @@ -830,8 +836,7 @@ static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di, u8 reg)
>  
>  	charge = bq27xxx_read(di, reg, false);
>  	if (charge < 0) {
> -		dev_dbg(di->dev, "error reading charge register %02x: %d\n",
> -			reg, charge);
> +		dev_err(di->dev, "error %d reading charge\n", charge);
>  		return charge;
>  	}
>  
> @@ -883,7 +888,7 @@ static int bq27xxx_battery_read_dcap(struct bq27xxx_device_info *di)
>  		dcap = bq27xxx_read(di, BQ27XXX_REG_DCAP, false);
>  
>  	if (dcap < 0) {
> -		dev_dbg(di->dev, "error reading initial last measured discharge\n");
> +		dev_err(di->dev, "error %d reading design capacity\n", dcap);
>  		return dcap;
>  	}
>  
> @@ -905,7 +910,7 @@ static int bq27xxx_battery_read_energy(struct bq27xxx_device_info *di)
>  
>  	ae = bq27xxx_read(di, BQ27XXX_REG_AE, false);
>  	if (ae < 0) {
> -		dev_dbg(di->dev, "error reading available energy\n");
> +		dev_err(di->dev, "error %d reading available energy\n", ae);
>  		return ae;
>  	}
>  
> @@ -927,7 +932,7 @@ static int bq27xxx_battery_read_temperature(struct bq27xxx_device_info *di)
>  
>  	temp = bq27xxx_read(di, BQ27XXX_REG_TEMP, false);
>  	if (temp < 0) {
> -		dev_err(di->dev, "error reading temperature\n");
> +		dev_err(di->dev, "error %d reading temperature\n", temp);
>  		return temp;
>  	}
>  
> @@ -947,7 +952,7 @@ static int bq27xxx_battery_read_cyct(struct bq27xxx_device_info *di)
>  
>  	cyct = bq27xxx_read(di, BQ27XXX_REG_CYCT, false);
>  	if (cyct < 0)
> -		dev_err(di->dev, "error reading cycle count total\n");
> +		dev_err(di->dev, "error %d reading cycle count total\n", cyct);
>  
>  	return cyct;
>  }
> @@ -962,8 +967,7 @@ static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, u8 reg)
>  
>  	tval = bq27xxx_read(di, reg, false);
>  	if (tval < 0) {
> -		dev_dbg(di->dev, "error reading time register %02x: %d\n",
> -			reg, tval);
> +		dev_err(di->dev, "error %d reading time\n", tval);
>  		return tval;
>  	}
>  
> @@ -983,8 +987,7 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
>  
>  	tval = bq27xxx_read(di, BQ27XXX_REG_AP, false);
>  	if (tval < 0) {
> -		dev_err(di->dev, "error reading average power register  %02x: %d\n",
> -			BQ27XXX_REG_AP, tval);
> +		dev_err(di->dev, "error %d reading average power\n", tval);
>  		return tval;
>  	}
>  
> @@ -1054,7 +1057,7 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>  
>  	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
>  	if (flags < 0) {
> -		dev_err(di->dev, "error reading flag register:%d\n", flags);
> +		dev_err(di->dev, "error %d reading flags\n", flags);
>  		return flags;
>  	}
>  
> @@ -1147,7 +1150,7 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
>  
>  	curr = bq27xxx_read(di, BQ27XXX_REG_AI, false);
>  	if (curr < 0) {
> -		dev_err(di->dev, "error reading current\n");
> +		dev_err(di->dev, "error %d reading current\n", curr);
>  		return curr;
>  	}
>  
> @@ -1236,7 +1239,7 @@ static int bq27xxx_battery_voltage(struct bq27xxx_device_info *di,
>  
>  	volt = bq27xxx_read(di, BQ27XXX_REG_VOLT, false);
>  	if (volt < 0) {
> -		dev_err(di->dev, "error reading voltage\n");
> +		dev_err(di->dev, "error %d reading voltage\n", volt);
>  		return volt;
>  	}
>  
> 
