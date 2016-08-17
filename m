From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/7] power: act8945a_charger: Remove
 "battery_temperature"
Date: Wed, 17 Aug 2016 13:31:41 +0200
Message-ID: <20160817113141.cshwjvpuwcj2hk5k@earth>
References: <1471337998-6467-1-git-send-email-wenyou.yang@atmel.com>
 <1471337998-6467-2-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kg37bpgv7pjpbj4z"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1471337998-6467-2-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--kg37bpgv7pjpbj4z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 16, 2016 at 04:59:52PM +0800, Wenyou Yang wrote:
> [...]
>
> -static int act8945a_get_battery_health(struct act8945a_charger *charger,
> -				       struct regmap *regmap, int *val)
> +static int act8945a_get_battery_health(struct regmap *regmap, int *val)
>  {
>  	int ret;
>  	unsigned int status;
> @@ -148,7 +146,7 @@ static int act8945a_get_battery_health(struct act8945=
a_charger *charger,
>  	if (ret < 0)
>  		return ret;
> =20
> -	if (charger->battery_temperature && !(status & APCH_STATUS_TEMPDAT))
> +	if (status & APCH_STATUS_TEMPDAT)

This incorrectly inverts the logic.

>  		*val =3D POWER_SUPPLY_HEALTH_OVERHEAT;
>  	else if (!(status & APCH_STATUS_INDAT))
>  		*val =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> @@ -188,8 +186,7 @@ static int act8945a_charger_get_property(struct power=
_supply *psy,
>  		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
>  		break;
>  	case POWER_SUPPLY_PROP_HEALTH:
> -		ret =3D act8945a_get_battery_health(charger,
> -						  regmap, &val->intval);
> +		ret =3D act8945a_get_battery_health(regmap, &val->intval);
>  		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
>  		val->strval =3D act8945a_charger_model;
> @@ -235,9 +232,6 @@ static int act8945a_charger_config(struct device *dev,
>  		return -EINVAL;
>  	}
> =20
> -	charger->battery_temperature =3D of_property_read_bool(np,
> -				"active-semi,check-battery-temperature");
> -
>  	chglev_pin =3D of_get_named_gpio_flags(np,
>  				"active-semi,chglev-gpios", 0, &flags);

-- Sebastian

--kg37bpgv7pjpbj4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXtEsaAAoJENju1/PIO/qaTuoQAIrTmlAYMwMQMGBOeEtyZPog
LOEDIdYPkNOUEBMuSR82Q7AKmuFdSntV4vCEGhhkVZ972QnG/I/RM+tPyYBSNSX5
zlxJ9yXDBUEnEC4fn+Arg6biZ/5Vk/aDg+vugTwTeoxoqxL3zlwO5J0wOYoHdP+I
XA9UvkYQ/pml8QGIAC13P90JQUHiHOsfgVFgJX8ywVR7eO6DOyx2CRnvP34VRquc
RjXgYSiSY9fUNLciN1ZSyX9h0GLOn/QMhdA2O6eSPYfzcI/ga7vgm0Z7uX2Li9ox
KJ2jFhBJ0FX6MGZc0DEKbTn43kOhxe+Waf84t09SigtT0F5b3ma+QuXG1sd86iVQ
GCT+TK0jMGTwOdfFPp8wirn7YZL/ZE/q8IYwdTqhub7TQJEjPSP+wc78y/DgUD+w
V+wXoitK0wafvOgLGQCyBH9C0ayhWUJ7xcqGrAOzbCiD8hxsOY6HOL1/zv/oHgcd
pjsl/scNOt72UCoeshuix6QkvblYPgTgjjqdiiGMFiXVyJulvYDJZCOBsLSMqX7c
uhzhpP/55TQb/RzFIvCGCusm9AafBlB7OP0wBFmMpR33kQ2yLC1jJMPrJlje6Mrc
solvizDRwFzDuUeoWXQZgWBwX9JGFApfU7QmwOcc2U3pHDowkReWFAI1DthtkTXX
6nMmmlWl0fuujACuadlT
=JvoK
-----END PGP SIGNATURE-----

--kg37bpgv7pjpbj4z--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
