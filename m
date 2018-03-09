From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 5/6] power: supply: axp20x_battery: add
 support for AXP813
Date: Fri, 9 Mar 2018 17:09:42 +0100
Message-ID: <20180309160942.fp6vrjnvis3kiarb@earth.universe>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
 <3969fa859a80afba1fe3c9b71cf3147111582520.1519813976.git-series.quentin.schulz@bootlin.com>
Reply-To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ftaiz767pliwrnwg"
Return-path: <linux-sunxi+bncBDXMLNOH5ANRBSXDRLKQKGQE6PSQWNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <3969fa859a80afba1fe3c9b71cf3147111582520.1519813976.git-series.quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--ftaiz767pliwrnwg
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

Hi,

On Wed, Feb 28, 2018 at 11:36:00AM +0100, Quentin Schulz wrote:
> The X-Powers AXP813 PMIC has got some slight differences from
> AXP20X/AXP22X PMICs:
>  - the maximum voltage supplied by the PMIC is 4.35 instead of 4.36/4.24
>  for AXP20X/AXP22X,
>  - the constant charge current formula is different,
> 
> It also has a bit to tell whether the battery percentage returned by the
> PMIC is valid.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/axp20x_battery.c | 42 ++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index 04a0d91..4f69c0e 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -49,6 +49,8 @@
>  #define AXP22X_CHRG_CTRL1_TGT_4_22V	(1 << 5)
>  #define AXP22X_CHRG_CTRL1_TGT_4_24V	(3 << 5)
>  
> +#define AXP813_CHRG_CTRL1_TGT_4_35V	(3 << 5)
> +
>  #define AXP20X_CHRG_CTRL1_TGT_CURR	GENMASK(3, 0)
>  
>  #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
> @@ -133,6 +135,35 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>  	return 0;
>  }
>  
> +static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
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
> +	case AXP813_CHRG_CTRL1_TGT_4_35V:
> +		*val = 4350000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
>  					      int *val)
>  {
> @@ -491,6 +522,14 @@ static const struct axp_data axp221_data = {
>  	.set_max_voltage = axp22x_battery_set_max_voltage,
>  };
>  
> +static const struct axp_data axp813_data = {
> +	.ccc_scale = 200000,
> +	.ccc_offset = 200000,
> +	.has_fg_valid = true,
> +	.get_max_voltage = axp813_battery_get_max_voltage,
> +	.set_max_voltage = axp20x_battery_set_max_voltage,
> +};
> +
>  static const struct of_device_id axp20x_battery_ps_id[] = {
>  	{
>  		.compatible = "x-powers,axp209-battery-power-supply",
> @@ -498,6 +537,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
>  	}, {
>  		.compatible = "x-powers,axp221-battery-power-supply",
>  		.data = (void *)&axp221_data,
> +	}, {
> +		.compatible = "x-powers,axp813-battery-power-supply",
> +		.data = (void *)&axp813_data,
>  	}, { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
> -- 
> git-series 0.9.1
--ftaiz767pliwrnwg--
