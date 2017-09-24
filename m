From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] power: supply: axp20x-battery: support AXP803
Date: Sun, 24 Sep 2017 15:34:36 +0100
Message-ID: <20170924153436.570b60ea@archlinux>
References: <20170920151814.22461-1-icenowy@aosc.io>
        <20170920151814.22461-5-icenowy@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920151814.22461-5-icenowy-h8G6r0blFSE@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 20 Sep 2017 23:18:11 +0800
Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:

> The AXP803 PMIC has battery support like other AXP PMICs, but with
> different definition of max target charging voltage and constant
> charging current.
> 
> Add support for AXP803 battery in axp20x-battery driver.
> 
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>

This looks fine to me, but I haven't dived into the precise values
etc.

Jonathan

> ---
>  drivers/power/supply/axp20x_battery.c | 88 +++++++++++++++++++++++++++++++----
>  1 file changed, 78 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index 7494f0f0eadb..c9a9fb320c92 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -49,6 +49,8 @@
>  #define AXP22X_CHRG_CTRL1_TGT_4_22V	(1 << 5)
>  #define AXP22X_CHRG_CTRL1_TGT_4_24V	(3 << 5)
>  
> +#define AXP803_CHRG_CTRL1_TGT_4_35V	(3 << 5)
> +
>  #define AXP20X_CHRG_CTRL1_TGT_CURR	GENMASK(3, 0)
>  
>  #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
> @@ -123,20 +125,71 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>  	return 0;
>  }
>  
> +static int axp803_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> +					  int *val)
> +{
> +	int ret, reg;
> +
> +	ret = regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
> +	if (ret)
> +		return ret;
> +
> +	switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
> +	case AXP20X_CHRG_CTRL1_TGT_4_1V:
> +		*val = 4100000;
> +		break;
> +	case AXP20X_CHRG_CTRL1_TGT_4_15V:
> +		*val = 4150000;
> +		break;
> +	case AXP20X_CHRG_CTRL1_TGT_4_2V:
> +		*val = 4200000;
> +		break;
> +	case AXP803_CHRG_CTRL1_TGT_4_35V:
> +		*val = 4350000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static void raw_to_constant_charge_current(struct axp20x_batt_ps *axp, int *val)
>  {
> -	if (axp->axp_id == AXP209_ID)
> +	switch (axp->axp_id) {
> +	case AXP209_ID:
>  		*val = *val * 100000 + 300000;
> -	else
> +		break;
> +	case AXP221_ID:
>  		*val = *val * 150000 + 300000;
> +		break;
> +	case AXP803_ID:
> +		*val = *val * 200000 + 200000;
> +		break;
> +	}
>  }
>  
>  static void constant_charge_current_to_raw(struct axp20x_batt_ps *axp, int *val)
>  {
> -	if (axp->axp_id == AXP209_ID)
> +	switch (axp->axp_id) {
> +	case AXP209_ID:
>  		*val = (*val - 300000) / 100000;
> -	else
> +		break;
> +	case AXP221_ID:
>  		*val = (*val - 300000) / 150000;
> +		break;
> +	case AXP803_ID:
> +		*val = (*val - 200000) / 200000;
> +		/*
> +		 * The maximum charge current on AXP803 is 2.8A, and the
> +		 * datasheet says "1110-1111 reserved" in this part.
> +		 * So we return an invalid value -1 in this situation,
> +		 * which will be dealed by the caller of this function,
> +		 */
> +		if (*val > 13)
> +			*val = -1;
> +		break;
> +	}
>  }
>  
>  static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
> @@ -269,9 +322,13 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
>  		if (ret)
>  			return ret;
>  
> -		if (axp20x_batt->axp_id == AXP221_ID &&
> -		    !(reg & AXP22X_FG_VALID))
> -			return -EINVAL;
> +		switch (axp20x_batt->axp_id) {
> +		case AXP221_ID:
> +		case AXP803_ID:
> +			if (!(reg & AXP22X_FG_VALID))
> +				return -EINVAL;
> +			break;
> +		};
>  
>  		/*
>  		 * Fuel Gauge data takes 7 bits but the stored value seems to be
> @@ -281,11 +338,19 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
>  		break;
>  
>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> -		if (axp20x_batt->axp_id == AXP209_ID)
> +		switch (axp20x_batt->axp_id) {
> +		case AXP209_ID:
>  			return axp20x_battery_get_max_voltage(axp20x_batt,
>  							      &val->intval);
> -		return axp22x_battery_get_max_voltage(axp20x_batt,
> -						      &val->intval);
> +		case AXP221_ID:
> +			return axp22x_battery_get_max_voltage(axp20x_batt,
> +							      &val->intval);
> +		case AXP803_ID:
> +			return axp803_battery_get_max_voltage(axp20x_batt,
> +							      &val->intval);
> +		default:
> +			return -EINVAL;
> +		}
>  
>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>  		ret = regmap_read(axp20x_batt->regmap, AXP20X_V_OFF, &reg);
> @@ -467,6 +532,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
>  	}, {
>  		.compatible = "x-powers,axp221-battery-power-supply",
>  		.data = (void *)AXP221_ID,
> +	}, {
> +		.compatible = "x-powers,axp803-battery-power-supply",
> +		.data = (void *)AXP803_ID,
>  	}, { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
