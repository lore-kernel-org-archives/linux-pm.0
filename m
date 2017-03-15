From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1] power: supply: bq25890: Use gpiod_get()
Date: Wed, 15 Mar 2017 22:18:55 +0100
Message-ID: <20170315211855.gih23pquxdufahbf@earth>
References: <20170220171223.40799-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="meqe5ebpqfsbupgu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbdCOVTB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 17:19:01 -0400
Content-Disposition: inline
In-Reply-To: <20170220171223.40799-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pm@vger.kernel.org


--meqe5ebpqfsbupgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 20, 2017 at 07:12:23PM +0200, Andy Shevchenko wrote:
> Since index is always 0, replace gpiod_get_index() by gpiod_get().
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index f993a55cde20..8e2c41ded171 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -723,7 +723,7 @@ static int bq25890_irq_probe(struct bq25890_device *b=
q)
>  {
>  	struct gpio_desc *irq;
> =20
> -	irq =3D devm_gpiod_get_index(bq->dev, BQ25890_IRQ_PIN, 0, GPIOD_IN);
> +	irq =3D devm_gpiod_get(bq->dev, BQ25890_IRQ_PIN, GPIOD_IN);
>  	if (IS_ERR(irq)) {
>  		dev_err(bq->dev, "Could not probe irq pin.\n");
>  		return PTR_ERR(irq);

Thanks, queued.

-- Sebastian

--meqe5ebpqfsbupgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJr78ACgkQ2O7X88g7
+ppS/xAAqEOyk7s8Odn1Kqb2dFNTL4IBCtNtUhDhznvTQWJHakKq3ahUOIq5Rls6
MQrl6Ng8uIt3DQoO9xsDEPduj3VbzGxTY5/IHz93cYdJbZKHVR/LNeg1QzHS/7Lw
/I2Cu8ZOnXm4gRz+hRxeQowavBCClheK7kqCz/rbdLgrqILMoxmiiAJM5aCNZvkb
WR7BSArAUHoWEOGft5yj4uS5NwcnXkt1kYg3yYNlhZe1TPy2gWbiPRIIhlecxZd8
/sZ/pB0k0lDgC50m48XwrqxWnTR6SoUHnL8Yq0QoT4VwTH87zMYTiUo+G50Zm2V0
tR8QOoH7PTdwrZHrquEnxB/PFxkHIrYpOrZScbGg8B0OnTll9Q2oLeuggnCi9YLQ
BLAHKnvEkYjD7f4CxUNaIo4Yl1HyWoapkTHiHLVe9bqOf9qmzu7g5vyLhG++kUuf
A+ZGsxLDLKt6izEGS5NzFNXi4ZDW8fa3snTmr/gfgYMTW8unTe+kXZQgUGBAiWDD
dS8V/f2XsWOaSLZt8UGm7YaPCbPbwU++ViRnmda8+u6N/B2Gkl+WHJYL/kzpRH+V
z6CS+Kbogvu6dmVVFAoFSShncQTNiWd2vI0Xjg09DjLJkQDyODbGsDNHZzRotMvJ
Y6+1D75/qR1QMsC28wDo0IV98J78P1SRB4mdn7SdzX9up55svYU=
=t9hr
-----END PGP SIGNATURE-----

--meqe5ebpqfsbupgu--
