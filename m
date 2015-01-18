From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] power/axp288_fuel_gauge: axp288 fuel gauge driver
Date: Sun, 18 Jan 2015 11:49:27 +0100
Message-ID: <20150118104923.GA11147@earth.universe>
References: <20150107212655.GD3440@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150107212655.GD3440-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Todd E Brandt <todd.e.brandt-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 07, 2015 at 01:26:55PM -0800, Todd E Brandt wrote:
> X-Power AXP288 PMIC Fuel Gauge Driver
>=20
>  new power_supply driver at driver/power
>  interfaces with the axp20x mfd driver as a cell
>  provides battery info and monitors for changes
>  generates alerts on temperature and capacity issues
>=20
> [...]
>
> +static int fuel_gauge_battery_health(struct axp288_fg_info *info)
> +{
> +	int temp, vocv;
> +	int ret, health =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +
> +	ret =3D fuel_gauge_get_btemp(info, &temp);
> +	if (ret < 0)
> +		goto health_read_fail;
> +
> +	ret =3D fuel_gauge_get_vocv(info, &vocv);
> +	if (ret < 0)
> +		goto health_read_fail;
> +
> +	if (vocv > info->pdata->max_volt)
> +		health =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +	else if (temp > info->pdata->max_temp ||
> +			temp < info->pdata->min_temp)
> +		health =3D POWER_SUPPLY_HEALTH_OVERHEAT;

if (temp < info->pdata->min_temp)
    health =3D POWER_SUPPLY_HEALTH_COLD;

> +	else if (vocv < info->pdata->min_volt)
> +		health =3D POWER_SUPPLY_HEALTH_DEAD;
> +	else
> +		health =3D POWER_SUPPLY_HEALTH_GOOD;
> +
> +health_read_fail:
> +	return health;
> +}
>
> [...]
>
> +static int axp288_fuel_gauge_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

You can drop this function if nothing needs to be cleaned, but
that's not the case, so where is the cleanup code?

> [...]

-- Sebastian

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUu4+wAAoJENju1/PIO/qaqiAP/Ai1gGGYOSSK9/MJsxQgkce5
eeZpk+3mCUsle1Ks1CfaGQ84WtrEp9j3gnT3pZRSlOa4EaHsuuZ4U/T4cx+u+C9G
hmgKs2ATX2H++5ehsv/sNdmUABpSAa/U7jbxQiWYT+QFEdsTnhSNjIwECPVQ+qFp
PT9cRWiszwXcLWn5/3Sn/hxYDYgvYiWYlT4jV4kMr5j/zJsMEatW7zHIoqhoMO4a
y6Wm2HVr1A2+psIDw95UA3vUg+hPZELLeyLc0cKi6aXJ3JNZX8JuzOFAjL8mLMcH
IXRCDtogt+fVO37mTQKxy/zmMNcwtEa0Qu33i1kK9uAQXfQBmCw0mlkT3FCchSXP
j4hvp2SY3Z6zpl1YD0Dllgx36FzglKP8d3R5TTkYDbFLoBePscWgbhATGTCHJCkC
fIxqJxZ1KT7C//du2JYx9HFgIqzzLBxGs47VinFOKc+8ekfzMLyjUaN4B7Iw1sKt
a8irTX9EpStBYwzW22IUdv+2I6SQ3Igox3X+XNtPmUKHiAvulWdtBh//rkGvYApl
0dLfVA5P2/fNLc19VwzvzfSe5U0ed25/lkXElx1+Tn/mlXiwzIuZsbO/vwWPK4f6
7cnzv9piYWuZQ2ckRvcdpJtDTC0EHiUnhVceQr9j6XUvok7ntYDzzQVnDJMHfFdO
Fx6HusY6m2rIjmRnkyS7
=umqx
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
