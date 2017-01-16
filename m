From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] drivers: power: supply: Compress return logic into one
 line.
Date: Tue, 17 Jan 2017 00:42:38 +0100
Message-ID: <20170116234238.wqj4qmtm5uln2nsw@earth>
References: <20170112024557.GA23047@embeddedgus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s663nf3j47vqffxi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170112024557.GA23047@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--s663nf3j47vqffxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 11, 2017 at 08:45:57PM -0600, Gustavo A. R. Silva wrote:
> Simplify return logic to avoid unnecessary variable assignments.
> These issues were detected using Coccinelle and the following semantic pa=
tch:
>=20
> @@
> local idexpression ret;
> expression e;
> @@
>=20
> -ret =3D
> +return
>      e;
> -return ret;
>=20
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/power/supply/pcf50633-charger.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/pcf50633-charger.c b/drivers/power/supp=
ly/pcf50633-charger.c
> index d05597b..b3c1873 100644
> --- a/drivers/power/supply/pcf50633-charger.c
> +++ b/drivers/power/supply/pcf50633-charger.c
> @@ -393,7 +393,6 @@ static int pcf50633_mbc_probe(struct platform_device =
*pdev)
>  {
>  	struct power_supply_config psy_cfg =3D {};
>  	struct pcf50633_mbc *mbc;
> -	int ret;
>  	int i;
>  	u8 mbcs1;
> =20
> @@ -419,8 +418,7 @@ static int pcf50633_mbc_probe(struct platform_device =
*pdev)
>  					     &psy_cfg);
>  	if (IS_ERR(mbc->adapter)) {
>  		dev_err(mbc->pcf->dev, "failed to register adapter\n");
> -		ret =3D PTR_ERR(mbc->adapter);
> -		return ret;
> +		return PTR_ERR(mbc->adapter);
>  	}
> =20
>  	mbc->usb =3D power_supply_register(&pdev->dev, &pcf50633_mbc_usb_desc,
> @@ -428,8 +426,7 @@ static int pcf50633_mbc_probe(struct platform_device =
*pdev)
>  	if (IS_ERR(mbc->usb)) {
>  		dev_err(mbc->pcf->dev, "failed to register usb\n");
>  		power_supply_unregister(mbc->adapter);
> -		ret =3D PTR_ERR(mbc->usb);
> -		return ret;
> +		return PTR_ERR(mbc->usb);
>  	}
> =20
>  	mbc->ac =3D power_supply_register(&pdev->dev, &pcf50633_mbc_ac_desc,
> @@ -438,12 +435,10 @@ static int pcf50633_mbc_probe(struct platform_devic=
e *pdev)
>  		dev_err(mbc->pcf->dev, "failed to register ac\n");
>  		power_supply_unregister(mbc->adapter);
>  		power_supply_unregister(mbc->usb);
> -		ret =3D PTR_ERR(mbc->ac);
> -		return ret;
> +		return PTR_ERR(mbc->ac);
>  	}
> =20
> -	ret =3D sysfs_create_group(&pdev->dev.kobj, &mbc_attr_group);
> -	if (ret)
> +	if (sysfs_create_group(&pdev->dev.kobj, &mbc_attr_group))
>  		dev_err(mbc->pcf->dev, "failed to create sysfs entries\n");
> =20
>  	mbcs1 =3D pcf50633_reg_read(mbc->pcf, PCF50633_REG_MBCS1);

Thanks, queued.

-- Sebastian

--s663nf3j47vqffxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh9Wm4ACgkQ2O7X88g7
+pq03g//ZQVf0TR5cbDjy/6JI27pwvBy16R+wxN6y3+bhxAPhzpXJUhsvY43Zc1U
RJblzYXG9777C7AJzKW4+BAIZBklcLVxrl8JaiSGr1M57vS/vkFwX7Z6gruvNSO0
bFYus7Pek1zF/qXd8/VSjGrrvZYUqFPeQpYbqWTqwkCM6LMFA91AqXqzuS26Cec6
+WYoC8hx2H4InzjSZz3oqSpYzY8a8vA5xbcyM13FD3dm7nyIw7lN18RxVdQEOlS9
SIDz0HYepit5g+jZO+/qftgFXpY4PadieCrfPpgJX2AXwxwvr8Jp+q06vppCZoVo
6Zdo69JqMOJXioHlq9qIQrBZV5hqsPf87DmN+iMYp8N5pEHyvalRMOg0Yqtb3Cun
rf4k6osE3or6ez6tquUmEoW4WanhqN9WCcVxuHAA+PmjL3PYxoWwqhC+K960fkdZ
J7TvfIP9oDsR3bpaISpd0yJgeQHHtTd4IJQ78gH7M3RS1KSMOi08OyrO0Q4qq6Cy
Gbao20s0puFbd0qSiaN8yN7RvQqSkb8D6Cm/6h/9a0068xnGNb+cIFy35NiSNUwt
74F+rB4f/6I00CYDV09C8d7c2IdbANzbDOrruJVfva3hN0i8z6tHm5Amq2QTqTN2
FOAAa2ta0o6pkYqioGTFJABAGMS3/SAjMPojcGTbI6zUXzBBa1w=
=2RTJ
-----END PGP SIGNATURE-----

--s663nf3j47vqffxi--
