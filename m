From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v2] power: tps65217_charger: Add properties like voltage
 and current charge
Date: Mon, 1 May 2017 17:41:54 +0200
Message-ID: <20170501154154.yhuib6wslw5zw7i6@earth>
References: <20170421155032.22784-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7m7qqw5def3imkvk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170421155032.22784-1-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--7m7qqw5def3imkvk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Fri, Apr 21, 2017 at 05:50:32PM +0200, Enric Balletbo i Serra wrote:
> Allow the possibility to configure the charge and the current voltage of
> the charger and also the NTC type for battery temperature measurement.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
> Changes since v1:
>  - Requested by Rob Herring
>    - Rename ti,charge-* to charge-* to be standard properties.
>    - Use unit suffixes as per bindings/property-units.txt
> ---
>  .../bindings/power/supply/tps65217_charger.txt     |  15 ++
>  drivers/power/supply/tps65217_charger.c            | 187 +++++++++++++++=
++++--
>  include/linux/mfd/tps65217.h                       |   2 +
>  3 files changed, 192 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_char=
ger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.t=
xt
> index a11072c..4415618 100644
> --- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> @@ -6,6 +6,18 @@ Required Properties:
>               Should be <0> for the USB charger and <1> for the AC adapte=
r.
>  -interrupt-names: Should be "USB" and "AC"
> =20
> +Optional properties:
> +-charge-voltage-microvolt: set the charge voltage. The value can be: 410=
0000,
> +	4150000, 4200000, 4250000; default: 4100000
> +
> +-charge-current-microamp: set the charging current. The value can be: 30=
0000,
> +	400000, 500000, 700000; default: 500000

These two are battery specific. Please use newly introduced
"simple-battery" instead. See=20

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/=
commit/?h=3Dfor-next&id=3Decc931a585b3b2567da772233215f59b56fb42f9
https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/=
commit/?h=3Dfor-next&id=3Dfb38342a5ae6e4f438256e98e4c29a7916195125

> +-ti,ntc-type: set the NTC type for battery temperature measurement. The =
value
> +	must be 0 or 1, where:
> +	  0 =E2=80=93 100k (curve 1, B =3D 3960)
> +	  1 =E2=80=93 10k  (curve 2, B =3D 3480) (default)
> +

This looks fine. Might make sense to move this into its own patch.

>  This node is a subnode of the tps65217 PMIC.
> =20
>  Example:
> @@ -14,4 +26,7 @@ Example:
>  		compatible =3D "ti,tps65217-charger";
>  		interrupts =3D <0>, <1>;
>  		interrupt-names =3D "USB", "AC";
> +		charge-voltage-microvolt =3D <4100000>;
> +		charge-current-microamp =3D <500000>;
> +		ti,ntc-type =3D <1>;
>  	};
> diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supp=
ly/tps65217_charger.c
> index 1f52340..087f29c 100644
> --- a/drivers/power/supply/tps65217_charger.c
> +++ b/drivers/power/supply/tps65217_charger.c
> @@ -39,6 +39,12 @@
>  #define NUM_CHARGER_IRQS	2
>  #define POLL_INTERVAL		(HZ * 2)
> =20
> +struct tps65217_charger_platform_data {
> +	u32	charge_current_uamp;
> +	u32	charge_voltage_uvolt;
> +	int	ntc_type;
> +};
> +
>  struct tps65217_charger {
>  	struct tps65217 *tps;
>  	struct device *dev;
> @@ -48,16 +54,82 @@ struct tps65217_charger {
>  	int	prev_online;
> =20
>  	struct task_struct	*poll_task;
> +	struct tps65217_charger_platform_data *pdata;
>  };
> =20
>  static enum power_supply_property tps65217_charger_props[] =3D {
>  	POWER_SUPPLY_PROP_ONLINE,
>  };
> =20
> -static int tps65217_config_charger(struct tps65217_charger *charger)
> +static int tps65217_set_charge_current(struct tps65217_charger *charger,
> +				       unsigned int uamp)
> +{
> +	int ret, val;
> +
> +	dev_dbg(charger->dev, "setting charge current to %d uA\n", uamp);
> +
> +	if (uamp =3D=3D 300000)
> +		val =3D 0x00;
> +	else if (uamp =3D=3D 400000)
> +		val =3D 0x01;
> +	else if (uamp =3D=3D 500000)
> +		val =3D 0x02;
> +	else if (uamp =3D=3D 700000)
> +		val =3D 0x03;
> +	else
> +		return -EINVAL;
> +
> +	ret =3D tps65217_set_bits(charger->tps, TPS65217_REG_CHGCONFIG3,
> +				TPS65217_CHGCONFIG3_ICHRG_MASK,
> +				val << TPS65217_CHGCONFIG3_ICHRG_SHIFT,
> +				TPS65217_PROTECT_NONE);
> +	if (ret) {
> +		dev_err(charger->dev,
> +			"failed to set ICHRG setting to 0x%02x (err: %d)\n",
> +			val, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tps65217_set_charge_voltage(struct tps65217_charger *charger,
> +				       unsigned int uvolt)
> +{
> +	int ret, val;
> +
> +	dev_dbg(charger->dev, "setting charge voltage to %d uV\n", uvolt);
> +
> +	if (uvolt !=3D 4100000 && uvolt !=3D 4150000 &&
> +	    uvolt !=3D 4200000 && uvolt !=3D 4250000)
> +		return -EINVAL;
> +
> +	val =3D (uvolt - 4100000) / 50000;
> +
> +	ret =3D tps65217_set_bits(charger->tps, TPS65217_REG_CHGCONFIG2,
> +				TPS65217_CHGCONFIG2_VOREG_MASK,
> +				val << TPS65217_CHGCONFIG2_VOREG_SHIFT,
> +				TPS65217_PROTECT_NONE);
> +	if (ret) {
> +		dev_err(charger->dev,
> +			"failed to set VOCHG setting to 0x%02x (err: %d)\n",
> +			val, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tps65217_set_ntc_type(struct tps65217_charger *charger,
> +				 unsigned int ntc)
>  {
>  	int ret;
> =20
> +	dev_dbg(charger->dev, "setting NTC type to %d\n", ntc);
> +
> +	if (ntc !=3D 0 && ntc !=3D 1)
> +		return -EINVAL;
> +
>  	/*
>  	 * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
>  	 *
> @@ -74,14 +146,57 @@ static int tps65217_config_charger(struct tps65217_c=
harger *charger)
>  	 * NTC TYPE (for battery temperature measurement)
>  	 *   0 =E2=80=93 100k (curve 1, B =3D 3960)
>  	 *   1 =E2=80=93 10k  (curve 2, B =3D 3480) (default on reset)
> -	 *
>  	 */
> -	ret =3D tps65217_clear_bits(charger->tps, TPS65217_REG_CHGCONFIG1,
> -				  TPS65217_CHGCONFIG1_NTC_TYPE,
> -				  TPS65217_PROTECT_NONE);
> +	if (ntc) {
> +		ret =3D tps65217_set_bits(charger->tps, TPS65217_REG_CHGCONFIG1,
> +					TPS65217_CHGCONFIG1_NTC_TYPE,
> +					TPS65217_CHGCONFIG1_NTC_TYPE,
> +					TPS65217_PROTECT_NONE);
> +		if (ret) {
> +			dev_err(charger->dev,
> +				"failed to set NTC type to 10K: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		ret =3D tps65217_clear_bits(charger->tps, TPS65217_REG_CHGCONFIG1,
> +					  TPS65217_CHGCONFIG1_NTC_TYPE,
> +					  TPS65217_PROTECT_NONE);
> +		if (ret) {
> +			dev_err(charger->dev,
> +				"failed to set NTC type to 100K: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int tps65217_config_charger(struct tps65217_charger *charger)
> +{
> +	int ret;
> +	struct tps65217_charger_platform_data *pdata =3D charger->pdata;
> +
> +	if (!charger->pdata)
> +		return -EINVAL;
> +
> +	ret =3D tps65217_set_charge_voltage(charger, pdata->charge_voltage_uvol=
t);
>  	if (ret) {
>  		dev_err(charger->dev,
> -			"failed to set 100k NTC setting: %d\n", ret);
> +			"failed to set charge voltage setting: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D tps65217_set_charge_current(charger, pdata->charge_current_uamp=
);
> +	if (ret) {
> +		dev_err(charger->dev,
> +			"failed to set charge current setting: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D tps65217_set_ntc_type(charger, pdata->ntc_type);
> +	if (ret) {
> +		dev_err(charger->dev,
> +			"failed to set NTC type setting: %d\n", ret);
>  		return ret;
>  	}
> =20
> @@ -185,6 +300,48 @@ static int tps65217_charger_poll_task(void *data)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_OF
> +static struct tps65217_charger_platform_data *tps65217_charger_pdata_ini=
t(
> +		struct platform_device *pdev)
> +{
> +	struct tps65217_charger_platform_data *pdata;
> +	struct device_node *np =3D pdev->dev.of_node;
> +	int ret;
> +
> +	if (!np) {
> +		dev_err(&pdev->dev, "No charger OF node\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D of_property_read_u32(np, "charge-voltage-microvolt",
> +				   &pdata->charge_voltage_uvolt);
> +	if (ret)
> +		pdata->charge_voltage_uvolt =3D 4100000;
> +
> +	ret =3D of_property_read_u32(np, "charge-current-microamp",
> +				   &pdata->charge_current_uamp);
> +	if (ret)
> +		pdata->charge_current_uamp =3D 500000;

struct power_supply_battery_info info =3D {};
power_supply_get_battery_info(tps65217, &info);

The simple-battery framework does not yet provide charge
current/voltage, so you will need to add that first. Please
Cc Liam on that patch.

> +	ret =3D of_property_read_u32(np, "ti,ntc-type",
> +				   &pdata->ntc_type);
> +	if (ret)
> +		pdata->ntc_type =3D 1;	/* 10k  (curve 2, B =3D 3480) */

Please use device_property_read_u32(dev, ...) instead.

> +
> +	return pdata;
> +}
> +#else /* CONFIG_OF */
> +static struct tps65217_charger_platform_data *tps65217_charger_pdata_ini=
t(
> +		struct platform_device *pdev)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_OF */
> +
>  static const struct power_supply_desc tps65217_charger_desc =3D {
>  	.name			=3D "tps65217-charger",
>  	.type			=3D POWER_SUPPLY_TYPE_MAINS,
> @@ -214,6 +371,18 @@ static int tps65217_charger_probe(struct platform_de=
vice *pdev)
>  	cfg.of_node =3D pdev->dev.of_node;
>  	cfg.drv_data =3D charger;
> =20
> +	charger->pdata =3D tps65217_charger_pdata_init(pdev);
> +	if (IS_ERR(charger->pdata)) {
> +		dev_err(charger->dev, "failed: getting platform data\n");
> +		return PTR_ERR(charger->pdata);
> +	}
> +
> +	ret =3D tps65217_config_charger(charger);
> +	if (ret < 0) {
> +		dev_err(charger->dev, "charger config failed, err %d\n", ret);
> +		return ret;
> +	}
> +
>  	charger->psy =3D devm_power_supply_register(&pdev->dev,
>  						  &tps65217_charger_desc,
>  						  &cfg);
> @@ -225,12 +394,6 @@ static int tps65217_charger_probe(struct platform_de=
vice *pdev)
>  	irq[0] =3D platform_get_irq_byname(pdev, "USB");
>  	irq[1] =3D platform_get_irq_byname(pdev, "AC");
> =20
> -	ret =3D tps65217_config_charger(charger);
> -	if (ret < 0) {
> -		dev_err(charger->dev, "charger config failed, err %d\n", ret);
> -		return ret;
> -	}
> -
>  	/* Create a polling thread if an interrupt is invalid */
>  	if (irq[0] < 0 || irq[1] < 0) {
>  		poll_task =3D kthread_run(tps65217_charger_poll_task,
> diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
> index eac2857..d040062 100644
> --- a/include/linux/mfd/tps65217.h
> +++ b/include/linux/mfd/tps65217.h
> @@ -103,8 +103,10 @@
>  #define TPS65217_CHGCONFIG2_DYNTMR	BIT(7)
>  #define TPS65217_CHGCONFIG2_VPREGHG	BIT(6)
>  #define TPS65217_CHGCONFIG2_VOREG_MASK	0x30
> +#define TPS65217_CHGCONFIG2_VOREG_SHIFT	4
> =20
>  #define TPS65217_CHGCONFIG3_ICHRG_MASK	0xC0
> +#define TPS65217_CHGCONFIG3_ICHRG_SHIFT	6
>  #define TPS65217_CHGCONFIG3_DPPMTH_MASK	0x30
>  #define TPS65217_CHGCONFIG2_PCHRGT	BIT(3)
>  #define TPS65217_CHGCONFIG2_TERMIF	0x06

-- Sebastian

--7m7qqw5def3imkvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHV0AACgkQ2O7X88g7
+po7uw/+KmAWbe8TZabV+Xlcfxt08jTsjzgK5ZYqQYWP/frCkHCNai2+7H3CGR9Q
8crhVXkNimZKPruo+IyqkGhYSaA7tI8QGVZ44Vhu9wvB0AfDQ+3uFch9jMESCEiZ
5WSCR8J0O7QLjJ1RqRRJ75hShxIselpmhVmbL7qL9ByV5VRBxSQtveopPVcPiYJd
Tfd4Ypx2PeiGPIf02yQcTmZBg1y6qrQoPTwjvS7yrru7LFmmcA8ACS4CrnalSz5E
qEmMV5IynHhc6M+b33icwPBfR3HGO/+wqdBig969j7ixy4oJ1JeyA+GqDw2ouLZ3
xwPM+qlSbB5hxHbR4VXnQsY9YpJXB+rS91oKhHZYf2E7+FdV8Ki1eCck0+JZ0C8P
O6UvywHrSZmSpruLH6khF9g+8U0xdZD/3pttRS3jWVuIi+EBNuU9zv99I1TEM0iR
eGP1aaqeOt8jkow8Bza2LHPLLxgBdmslJcLB+7yN17cFtrFgyCKd+xvE9DvoTFPV
4VJMYcwu+OIeMEtrjrbg3Giaz0rONzwKaGFRwPb6ukvsq80j/WA3uhdptRx/5i+d
77kN2R+GFJo8hUp7oma7NT7DlbJd4fDJd2y955xXvVu33ocgkeEPWxdsAoCH76tv
5sM+Xfy/uVLhBRyh0iTTlCpgj8TpJkeHlNWHxYh0mL84ZurR5fg=
=qCWA
-----END PGP SIGNATURE-----

--7m7qqw5def3imkvk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
