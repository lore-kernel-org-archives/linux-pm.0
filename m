From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/5] power: supply: tps65217: Move IRQ related operation
 into single function
Date: Tue, 22 Nov 2016 17:49:11 +0100
Message-ID: <20161122164911.mz3igcnpps5bcjdn@earth>
References: <20161115131855.4175-1-woogyom.kim@gmail.com>
 <20161115131855.4175-2-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hu3nlrj4vx47zgqr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755917AbcKVQtf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 11:49:35 -0500
Content-Disposition: inline
In-Reply-To: <20161115131855.4175-2-woogyom.kim@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--hu3nlrj4vx47zgqr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 15, 2016 at 10:18:51PM +0900, Milo Kim wrote:
> TPS65217 charger driver handles the charger interrupt through the IRQ or
> polling. Both cases can be requested in single function.
>=20
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  drivers/power/supply/tps65217_charger.c | 70 ++++++++++++++++++---------=
------
>  1 file changed, 38 insertions(+), 32 deletions(-)

I don't see the advantage of this. It's more lines of codes than
before and does not really increase readability.

-- Sebastian

>=20
> diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supp=
ly/tps65217_charger.c
> index 9fd019f..04f8322 100644
> --- a/drivers/power/supply/tps65217_charger.c
> +++ b/drivers/power/supply/tps65217_charger.c
> @@ -195,12 +195,48 @@ static const struct power_supply_desc tps65217_char=
ger_desc =3D {
>  	.num_properties		=3D ARRAY_SIZE(tps65217_ac_props),
>  };
> =20
> +static int tps65217_charger_request_interrupt(struct platform_device *pd=
ev)
> +{
> +	struct tps65217_charger *charger =3D platform_get_drvdata(pdev);
> +	int irq;
> +	int ret;
> +
> +	irq =3D platform_get_irq_byname(pdev, "AC");
> +	if (irq < 0)
> +		irq =3D -ENXIO;
> +
> +	charger->irq =3D irq;
> +
> +	if (irq !=3D -ENXIO) {
> +		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						tps65217_charger_irq, 0,
> +						"tps65217-charger", charger);
> +		if (ret) {
> +			dev_err(charger->dev,
> +				"Unable to register irq %d err %d\n", irq, ret);
> +			return ret;
> +		}
> +
> +		/* Check current state */
> +		tps65217_charger_irq(irq, charger);
> +		return 0;
> +	}
> +
> +	charger->poll_task =3D kthread_run(tps65217_charger_poll_task, charger,
> +					 "ktps65217charger");
> +	if (IS_ERR(charger->poll_task)) {
> +		ret =3D PTR_ERR(charger->poll_task);
> +		dev_err(charger->dev, "Unable to run kthread err %d\n", ret);
> +	}
> +
> +	return 0;
> +}
> +
>  static int tps65217_charger_probe(struct platform_device *pdev)
>  {
>  	struct tps65217 *tps =3D dev_get_drvdata(pdev->dev.parent);
>  	struct tps65217_charger *charger;
>  	struct power_supply_config cfg =3D {};
> -	int irq;
>  	int ret;
> =20
>  	dev_dbg(&pdev->dev, "%s\n", __func__);
> @@ -224,43 +260,13 @@ static int tps65217_charger_probe(struct platform_d=
evice *pdev)
>  		return PTR_ERR(charger->ac);
>  	}
> =20
> -	irq =3D platform_get_irq_byname(pdev, "AC");
> -	if (irq < 0)
> -		irq =3D -ENXIO;
> -	charger->irq =3D irq;
> -
>  	ret =3D tps65217_config_charger(charger);
>  	if (ret < 0) {
>  		dev_err(charger->dev, "charger config failed, err %d\n", ret);
>  		return ret;
>  	}
> =20
> -	if (irq !=3D -ENXIO) {
> -		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -						tps65217_charger_irq,
> -						0, "tps65217-charger",
> -						charger);
> -		if (ret) {
> -			dev_err(charger->dev,
> -				"Unable to register irq %d err %d\n", irq,
> -				ret);
> -			return ret;
> -		}
> -
> -		/* Check current state */
> -		tps65217_charger_irq(irq, charger);
> -	} else {
> -		charger->poll_task =3D kthread_run(tps65217_charger_poll_task,
> -						charger, "ktps65217charger");
> -		if (IS_ERR(charger->poll_task)) {
> -			ret =3D PTR_ERR(charger->poll_task);
> -			dev_err(charger->dev,
> -				"Unable to run kthread err %d\n", ret);
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> +	return tps65217_charger_request_interrupt(pdev);
>  }
> =20
>  static int tps65217_charger_remove(struct platform_device *pdev)
> --=20
> 2.9.3
>=20

--hu3nlrj4vx47zgqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg0dwQACgkQ2O7X88g7
+ppgtg//Vkm9n4Eb9PAOhRw4z+Fnk/GAxSAzoRjUl1nphW3499fO8Kc9UHCiQ24K
2SLCC05aF1b//ZW7MkmsAaFBFQVNTtbDKnOYY/NByHjX12oBSMvhAr8VdqWB9O/K
3w3LqbCMPEj17U0JYSjRco1u5TQh5D6vxtPbfjZBfVpbOPyc+XsqLQJTITYaTNfX
bsTU/AXhp4siTT7i9mnmAY30YTDWCMz6HXeoL8pvwuutSBH9DzaVOKvw0xjfHcUp
viBGSHUATZQlth/T9vCLBrVMbn9WkziR1eNqmxqRoaSpIvZI7h/eiygdg8ua0uMM
xiMtJF3qvVBkwjnojmewt4Qoj6dWo6WR7iJbSbkmQaxOHpCp9S9o6hqJ3EMT6uFN
hXgNJlHsWnTimDPxHOUDhvzU1X94XKIfFVIHeg3K79+zd+b9D4OSt79eihlvq/Lg
ucblU5bwkmldOxESsdSkRfMF3oi2dSrn/48XC06EYHGDkcnDPdAj0qAce47kkr+P
3UyXagBA3AztH7/kxTRQs0xbz1J316T+qkFYUNpPu17gD2fCOc/hkUcMZfQYzvXr
2DNP85JdxNbMoqshK/TSJ3xutdPSCH56HU97B57BCNipw0DIwegSROrnbhfhP+zq
rX0WiVK4HRyL3na16WromlerJV3Q9bWi7BfOLYmrplv/uPEe/AE=
=TmBX
-----END PGP SIGNATURE-----

--hu3nlrj4vx47zgqr--
