From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/4] power: supply: sc2731_charger: Add one work to
 charge/discharge
Date: Thu, 6 Dec 2018 00:08:47 +0100
Message-ID: <20181205230847.lczprnbn3c4lsqvb@earth.universe>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e633v6t3dufbfteu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org


--e633v6t3dufbfteu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 12, 2018 at 06:52:35PM +0800, Baolin Wang wrote:
> Since the USB notifier context is atomic, we can not start or stop chargi=
ng
> in atomic context. Thus this patch adds one work to help to charge or
> discharge.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Thanks, patchset queued.

-- Sebastian

>  drivers/power/supply/sc2731_charger.c |   30 ++++++++++++++++++++++-----=
---
>  1 file changed, 22 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply=
/sc2731_charger.c
> index 525a820..393ba98 100644
> --- a/drivers/power/supply/sc2731_charger.c
> +++ b/drivers/power/supply/sc2731_charger.c
> @@ -57,9 +57,11 @@ struct sc2731_charger_info {
>  	struct usb_phy *usb_phy;
>  	struct notifier_block usb_notify;
>  	struct power_supply *psy_usb;
> +	struct work_struct work;
>  	struct mutex lock;
>  	bool charging;
>  	u32 base;
> +	u32 limit;
>  };
> =20
>  static void sc2731_charger_stop_charge(struct sc2731_charger_info *info)
> @@ -318,22 +320,21 @@ static int sc2731_charger_property_is_writeable(str=
uct power_supply *psy,
>  	.property_is_writeable	=3D sc2731_charger_property_is_writeable,
>  };
> =20
> -static int sc2731_charger_usb_change(struct notifier_block *nb,
> -				     unsigned long limit, void *data)
> +static void sc2731_charger_work(struct work_struct *data)
>  {
>  	struct sc2731_charger_info *info =3D
> -		container_of(nb, struct sc2731_charger_info, usb_notify);
> -	int ret =3D 0;
> +		container_of(data, struct sc2731_charger_info, work);
> +	int ret;
> =20
>  	mutex_lock(&info->lock);
> =20
> -	if (limit > 0) {
> +	if (info->limit > 0) {
>  		/* set current limitation and start to charge */
> -		ret =3D sc2731_charger_set_current_limit(info, limit);
> +		ret =3D sc2731_charger_set_current_limit(info, info->limit);
>  		if (ret)
>  			goto out;
> =20
> -		ret =3D sc2731_charger_set_current(info, limit);
> +		ret =3D sc2731_charger_set_current(info, info->limit);
>  		if (ret)
>  			goto out;
> =20
> @@ -350,7 +351,19 @@ static int sc2731_charger_usb_change(struct notifier=
_block *nb,
> =20
>  out:
>  	mutex_unlock(&info->lock);
> -	return ret;
> +}
> +
> +static int sc2731_charger_usb_change(struct notifier_block *nb,
> +				     unsigned long limit, void *data)
> +{
> +	struct sc2731_charger_info *info =3D
> +		container_of(nb, struct sc2731_charger_info, usb_notify);
> +
> +	info->limit =3D limit;
> +
> +	schedule_work(&info->work);
> +
> +	return NOTIFY_OK;
>  }
> =20
>  static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
> @@ -432,6 +445,7 @@ static int sc2731_charger_probe(struct platform_devic=
e *pdev)
> =20
>  	mutex_init(&info->lock);
>  	info->dev =3D &pdev->dev;
> +	INIT_WORK(&info->work, sc2731_charger_work);
> =20
>  	info->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
>  	if (!info->regmap) {
> --=20
> 1.7.9.5
>=20

--e633v6t3dufbfteu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIWn8ACgkQ2O7X88g7
+prIDg//WcTO+jleuAT/tUwIb9FljSOiFsRfLFJjF6cNThXPpcz2rwEj1C0upbSg
38PKdhB12Ypn3zsQlxIA7jG38ueGvLKZMUbVW5b9Ch1MpuP/JuEKQbfqTr5rUf4m
26jkgQXAzVNqczjdrXoWVCdhRxVPqPGsUA+QKFpnGC+vTsYBVqXlmFDKPua2uWDd
AFbhjHhASs3/1XTasq7eUBqs1ZjgdyLAMArnRW2RGMxWGgSj5DQ5r6wgZeHEJUOZ
bT0eA6BCysVMViEleuZiwLkF3Sj+FGzJd5YcNpRcyW+zC5zGCnTLknQX+58STvyq
iCQLcl7fcdq8uui7qTtNrq5L4p7iRzg6DsENk3Pum/e1jvdX0cSgYCUc6zIXy9s0
9eMEPywWuSPx5e9Kr7GDEAkiNmJqtp5PQRq9njMXHt7f/9DN7y99ZLbZnj8caDa3
nFj7r/p9tLbj1HobYrX+9m4rdehKT4I0IX8Heb88CDGU7XRcx1vTBwpvqOQ6BoY3
7rCoMCDeOTBXDnrd7ohsX7KVnaWY1/FcMW4rn74UD+HjHRp4xDrEwIumJF1xF16Q
4AfoUy95EFSMelY+1OVfsnNec0kEoBWCcvzHDetLpvAlnE+ckMivFPmjoznbFTKh
64cTenkj5kEWUxUV07aBqWS7WgsnUUEe8ccr32bWrsY4VMhR2A4=
=0skI
-----END PGP SIGNATURE-----

--e633v6t3dufbfteu--
