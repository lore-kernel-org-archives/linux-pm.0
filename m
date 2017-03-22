From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 6/7] power: bq24190_charger: Add
 power_supply_battery_info and devicetree support
Date: Wed, 22 Mar 2017 13:15:10 +0100
Message-ID: <932c4af4-76a6-7211-c8c0-b5af3d96d8d6@redhat.com>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-7-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934253AbdCVMYs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 08:24:48 -0400
In-Reply-To: <20170321220921.5834-7-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 21-03-17 23:09, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>
> Obtain pre-charge and end-charge current values from power_supply_battery_info.
> Obtain minimum system voltage level from devicetree.
>
> Cc: Mark Greer <mgreer@animalcreek.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/bq24190_charger.c | 102 +++++++++++++++++++++++++++++----
>  1 file changed, 90 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 2fbc7f3..a52816b 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -43,6 +43,8 @@
>  #define BQ24190_REG_POC_SYS_MIN_SHIFT		1
>  #define BQ24190_REG_POC_BOOST_LIM_MASK		BIT(0)
>  #define BQ24190_REG_POC_BOOST_LIM_SHIFT		0
> +#define BQ24190_REG_POC_SYS_MIN_MIN		3000
> +#define BQ24190_REG_POC_SYS_MIN_MAX		3700
>  Hi,
>  #define BQ24190_REG_CCC		0x02 /* Charge Current Control */
>  #define BQ24190_REG_CCC_ICHG_MASK		(BIT(7) | BIT(6) | BIT(5) | \
> @@ -58,6 +60,10 @@
>  #define BQ24190_REG_PCTCC_ITERM_MASK		(BIT(3) | BIT(2) | BIT(1) | \
>  						 BIT(0))
>  #define BQ24190_REG_PCTCC_ITERM_SHIFT		0
> +#define BQ24190_REG_PCTCC_IPRECHG_MIN		128
> +#define BQ24190_REG_PCTCC_IPRECHG_MAX		2048
> +#define BQ24190_REG_PCTCC_ITERM_MIN		128
> +#define BQ24190_REG_PCTCC_ITERM_MAX		2048
>
>  #define BQ24190_REG_CVC		0x04 /* Charge Voltage Control */
>  #define BQ24190_REG_CVC_VREG_MASK		(BIT(7) | BIT(6) | BIT(5) | \
> @@ -157,6 +163,9 @@ struct bq24190_dev_info {
>  	unsigned int			irq;
>  	bool				initialized;
>  	bool				irq_event;
> +	u16				sys_min;
> +	u16				iprechg;
> +	u16				iterm;
>  	struct mutex			f_reg_lock;
>  	u8				f_reg;
>  	u8				ss_reg;
> @@ -496,19 +505,20 @@ static int bq24190_sysfs_create_group(struct bq24190_dev_info *bdi)
>  static inline void bq24190_sysfs_remove_group(struct bq24190_dev_info *bdi) {}
>  #endif
>
> -/*
> - * According to the "Host Mode and default Mode" section of the
> - * manual, a write to any register causes the bq24190 to switch
> - * from default mode to host mode.  It will switch back to default
> - * mode after a WDT timeout unless the WDT is turned off as well.
> - * So, by simply turning off the WDT, we accomplish both with the
> - * same write.
> - */
> -static int bq24190_set_mode_host(struct bq24190_dev_info *bdi)
> +static int bq24190_set_operating_params(struct bq24190_dev_info *bdi)
>  {
>  	int ret;
>  	u8 v;
>
> +	/*
> +	 * According to the "Host Mode and default Mode" section of the
> +	 * manual, a write to any register causes the bq24190 to switch
> +	 * from default mode to host mode.  It will switch back to default
> +	 * mode after a WDT timeout unless the WDT is turned off as well.
> +	 * So, by simply turning off the WDT, we accomplish both with the
> +	 * same write.
> +	 */
> +
>  	ret = bq24190_read(bdi, BQ24190_REG_CTTC, &v);
>  	if (ret < 0)
>  		return ret;
> @@ -517,7 +527,41 @@ static int bq24190_set_mode_host(struct bq24190_dev_info *bdi)
>  					BQ24190_REG_CTTC_WATCHDOG_SHIFT);
>  	v &= ~BQ24190_REG_CTTC_WATCHDOG_MASK;
>
> -	return bq24190_write(bdi, BQ24190_REG_CTTC, v);
> +	ret = bq24190_write(bdi, BQ24190_REG_CTTC, v);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (bdi->sys_min) {
> +		v = bdi->sys_min / 100 - 30; // manual section 9.5.1.2, table 9
> +		ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
> +					 BQ24190_REG_POC_SYS_MIN_MASK,
> +					 BQ24190_REG_POC_SYS_MIN_SHIFT,
> +					 v);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	if (bdi->iprechg) {
> +		v = bdi->iprechg / 128 - 1; // manual section 9.5.1.4, table 11
> +		ret = bq24190_write_mask(bdi, BQ24190_REG_PCTCC,
> +					 BQ24190_REG_PCTCC_IPRECHG_MASK,
> +					 BQ24190_REG_PCTCC_IPRECHG_SHIFT,
> +					 v);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	if (bdi->iterm) {
> +		v = bdi->iterm / 128 - 1; // manual section 9.5.1.4, table 11
> +		ret = bq24190_write_mask(bdi, BQ24190_REG_PCTCC,
> +					 BQ24190_REG_PCTCC_ITERM_MASK,
> +					 BQ24190_REG_PCTCC_ITERM_SHIFT,
> +					 v);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>
>  static int bq24190_register_reset(struct bq24190_dev_info *bdi)
> @@ -1304,7 +1348,7 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
>  	if (ret < 0)
>  		return ret;
>
> -	ret = bq24190_set_mode_host(bdi);
> +	ret = bq24190_set_operating_params(bdi);
>  	if (ret < 0)
>  		return ret;
>
> @@ -1314,6 +1358,39 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
>  #ifdef CONFIG_OF
>  static int bq24190_setup_dt(struct bq24190_dev_info *bdi)
>  {
> +	struct power_supply_battery_info info = {};
> +	const char const* s = "ti,system-minimum-microvolt";
> +	int v;
> +
> +	if (!of_property_read_u32(bdi->dev->of_node, s, &v)) {
> +		v /= 1000;
> +		if (v >= BQ24190_REG_POC_SYS_MIN_MIN
> +		 && v <= BQ24190_REG_POC_SYS_MIN_MAX)
> +			bdi->sys_min = v;
> +		else
> +			dev_err(bdi->dev, "invalid value for %s: %u\n", s, v);
> +	}
> +
> +	if (!power_supply_get_battery_info(bdi->battery, &info)) {
> +		v = info.precharge_current_ua / 1000;
> +		if (v >= BQ24190_REG_PCTCC_IPRECHG_MIN
> +		 && v <= BQ24190_REG_PCTCC_IPRECHG_MAX)
> +			bdi->iprechg = v;
> +		else
> +			dev_err(bdi->dev,
> +				"invalid value for battery:precharge-current-microamp: %d\n",
> +				v);
> +
> +		v = info.endcharge_current_ua / 1000;
> +		if (v >= BQ24190_REG_PCTCC_ITERM_MIN
> +		 && v <= BQ24190_REG_PCTCC_ITERM_MAX)
> +			bdi->iterm = v;
> +		else
> +			dev_err(bdi->dev,
> +				"invalid value for battery:endcharge-current-microamp: %d\n",
> +				v);
> +	}
> +
>  	bdi->irq = irq_of_parse_and_map(bdi->dev->of_node, 0);
>  	if (bdi->irq <= 0)
>  		return -1;
> @@ -1407,6 +1484,7 @@ static int bq24190_probe(struct i2c_client *client,
>  	}
>
>  	battery_cfg.drv_data = bdi;
> +	battery_cfg.of_node = dev->of_node;
>  	bdi->battery = power_supply_register(dev, &bq24190_battery_desc,
>  						&battery_cfg);
>  	if (IS_ERR(bdi->battery)) {
> @@ -1570,7 +1648,7 @@ static int bq24190_pm_resume(struct device *dev)
>  	}
>
>  	bq24190_register_reset(bdi);
> -	bq24190_set_mode_host(bdi);
> +	bq24190_set_operating_params(bdi);
>  	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
>
>  	if (error >= 0) {
>
