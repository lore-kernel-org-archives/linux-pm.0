From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v6 5/7] power: act8945a_charger: Add capacity level
 property
Date: Fri, 19 Aug 2016 17:59:16 +0200
Message-ID: <20160819155916.mzrgdgainol4c6nw@earth>
References: <1471569215-6046-1-git-send-email-wenyou.yang@atmel.com>
 <1471569215-6046-6-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yjmus2fbawmbzcxr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754226AbcHSP7W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Aug 2016 11:59:22 -0400
Content-Disposition: inline
In-Reply-To: <1471569215-6046-6-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org


--yjmus2fbawmbzcxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 19, 2016 at 09:13:33AM +0800, Wenyou Yang wrote:
> Add the power supply capacity level property, it corresponds to
> POWER_SUPPLY_CAPACITY_LEVEL_*.
>=20
> It also utilizes the precision voltage detector function module
> to catch the low battery voltage.
>=20
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>=20
> Changes in v6:
>  - For 'lbo-gpios', use gpiod API instead of old gpio API to handle.
>=20
> Changes in v5: None
> Changes in v4:
>  - Change devname of devm_request_irq() from "lbo-detect" to
>    "act8945a, lbo-detect".
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  drivers/power/supply/act8945a_charger.c | 75 +++++++++++++++++++++++++++=
++++++
>  1 file changed, 75 insertions(+)
>=20
> diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supp=
ly/act8945a_charger.c
> index 2ff2f8d..de7ad48 100644
> --- a/drivers/power/supply/act8945a_charger.c
> +++ b/drivers/power/supply/act8945a_charger.c
> @@ -18,6 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/regmap.h>
> +#include <linux/gpio/consumer.h>
> =20
>  static const char *act8945a_charger_model =3D "ACT8945A";
>  static const char *act8945a_charger_manufacturer =3D "Active-semi";
> @@ -83,6 +84,7 @@ struct act8945a_charger {
>  	struct work_struct work;
> =20
>  	bool init_done;
> +	struct gpio_desc *lbo_gpio;
>  };
> =20
>  static int act8945a_get_charger_state(struct regmap *regmap, int *val)
> @@ -208,11 +210,67 @@ static int act8945a_get_battery_health(struct regma=
p *regmap, int *val)
>  	return 0;
>  }
> =20
> +static int act8945a_get_capacity_level(struct act8945a_charger *charger,
> +				       struct regmap *regmap, int *val)
> +{
> +	int ret;
> +	unsigned int status, state, config;
> +	int lbo_level =3D gpiod_get_value(charger->lbo_gpio);
> +
> +	ret =3D regmap_read(regmap, ACT8945A_APCH_STATUS, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_read(regmap, ACT8945A_APCH_CFG, &config);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_read(regmap, ACT8945A_APCH_STATE, &state);
> +	if (ret < 0)
> +		return ret;
> +
> +	state &=3D APCH_STATE_CSTATE;
> +	state >>=3D APCH_STATE_CSTATE_SHIFT;
> +
> +	switch (state) {
> +	case APCH_STATE_CSTATE_PRE:
> +		*val =3D POWER_SUPPLY_CAPACITY_LEVEL_LOW;
> +		break;
> +	case APCH_STATE_CSTATE_FAST:
> +		if (lbo_level)
> +			*val =3D POWER_SUPPLY_CAPACITY_LEVEL_HIGH;
> +		else
> +			*val =3D POWER_SUPPLY_CAPACITY_LEVEL_LOW;
> +		break;
> +	case APCH_STATE_CSTATE_EOC:
> +		if (status & APCH_STATUS_CHGDAT)
> +			*val =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> +		else
> +			*val =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
> +		break;
> +	case APCH_STATE_CSTATE_DISABLED:
> +	default:
> +		if (config & APCH_CFG_SUSCHG) {
> +			*val =3D POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
> +		} else {
> +			*val =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
> +			if (!(status & APCH_STATUS_INDAT)) {
> +				if (!lbo_level)
> +					*val =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> +			}
> +		}
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static enum power_supply_property act8945a_charger_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_CHARGE_TYPE,
>  	POWER_SUPPLY_PROP_TECHNOLOGY,
>  	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER
>  };
> @@ -238,6 +296,10 @@ static int act8945a_charger_get_property(struct powe=
r_supply *psy,
>  	case POWER_SUPPLY_PROP_HEALTH:
>  		ret =3D act8945a_get_battery_health(regmap, &val->intval);
>  		break;
> +	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
> +		ret =3D act8945a_get_capacity_level(charger,
> +						  regmap, &val->intval);
> +		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
>  		val->strval =3D act8945a_charger_model;
>  		break;
> @@ -352,6 +414,19 @@ static int act8945a_charger_config(struct device *de=
v,
>  	if (tmp & APCH_CFG_SUSCHG)
>  		value |=3D APCH_CFG_SUSCHG;
> =20
> +	charger->lbo_gpio =3D devm_gpiod_get(dev, "active-semi,lbo", GPIOD_IN);
> +	if (IS_ERR(charger->lbo_gpio)) {
> +		dev_err(dev, "unable to claim gpio \"lbo\"\n");
> +		charger->lbo_gpio =3D NULL;
> +	};

You need special handling for -EPROBE_DEFER.

> +	ret =3D devm_request_irq(dev, gpiod_to_irq(charger->lbo_gpio),
> +			       act8945a_status_changed,
> +			       (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
> +			       "act8945a_lbo_detect", charger);
> +	if (ret)
> +		dev_dbg(dev, "failed to request \"lbo\" pin IRQ\n");

Also everything in act8945a_charger_config is done with parent
device as *dev. Thus all devm_*(dev, ...) calls are wrong.

-- Sebastian

--yjmus2fbawmbzcxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXtyzUAAoJENju1/PIO/qabxcP/1ECTxNy83MTPip4wODOZP+B
p35V6F/b+dT7WcqS54ZDPqCBd/p5mDXkWB1ZiB6YVwing7HySuXWNe6bqVEmUrvN
fHadIrsXmctRRsGfFaPfoOXueD6M1XOSfbMposeWJ7o/goiApZ7a70jpSMVYwbiV
bGHK5eagQ4IDqbjXPgMpHCdP/UMmSdGCP4hzlDJkF5kub0RJydpqI6iQLxWHIeJJ
wAd7fDQ8oNLmH55adN881h/lRimA8e5WRi5fEJ2Z5R3lxZRm8UGWIG8btxw2ULnY
ojXmhAKv4PELA1GTDmm16tPZAFmUctMSJtfFpyeBd4LviDZtzKnkQrnYhMn8nh8/
i/0rvsqls7jH5AVB9L8E4F2GaqG09Qwsz0E7IDgmXu+CeRjAxL4gzWwhXKO7pyAI
CGfHUwxRwgmcR94NQK3LwB5YED37xJM2/pIwIC2i+39KyuuxD2ivVMZWWmat6Z31
6fa3a4Wdckeg/LoyUJJ4oc+v3/BlYlxsd53oShbZWdyByDcTrnkrwdjJuczN8aCp
7ecaq+2NxEZo85XCBulew0uhnIzAxCxb5dqHcBkn7vLuEDEVE0hP0N9d5hTTyR1P
OhLRn3XMvVMza0k61P0HWg7GqRzq4rxtGEK4QdfwdLjrypFLAqFnSNcUYwLLf8bY
7Q6i+cLIfChz3echOTFr
=2iM0
-----END PGP SIGNATURE-----

--yjmus2fbawmbzcxr--
