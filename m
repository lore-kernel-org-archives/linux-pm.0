From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [RFT/RFC] power_supply: bq2415x_charger: Initialize workqueue before scheduling it
Date: Sat, 25 Jul 2015 23:49:06 +0200
Message-ID: <201507252349.06519@pali>
References: <1436834053-2084-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart23202602.oVPU8x2pus";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33127 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964868AbbGYVtK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2015 17:49:10 -0400
In-Reply-To: <1436834053-2084-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart23202602.oVPU8x2pus
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 14 July 2015 02:34:13 Krzysztof Kozlowski wrote:
> The driver during probe registers a power supply notifier
> (with bq2415x_notifier_call() callback) and calls it manually right
> after. The notifier callback function schedules driver's workqueue
> (bq->work).
>=20
> However the workqueue was initialized after these two events (after
> registering power supply notifier and calling manually the callback).
>=20
> When power supply core notified the driver (executing its
> bq2415x_notifier_call() callback) the scheduled workqueue could be
> still uninitialized.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> ---
>=20
> I don't have the hardware, please test. Additionally I could not find
> the commit which introduced the issue so I did not cc-stable.
> ---
>  drivers/power/bq2415x_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/bq2415x_charger.c
> b/drivers/power/bq2415x_charger.c index e98dcb661cc9..527ed0f18796
> 100644
> --- a/drivers/power/bq2415x_charger.c
> +++ b/drivers/power/bq2415x_charger.c
> @@ -1601,6 +1601,7 @@ static int bq2415x_probe(struct i2c_client
> *client, bq->reported_mode =3D BQ2415X_MODE_OFF;
>  	bq->autotimer =3D 0;
>  	bq->automode =3D 0;
> +	INIT_DELAYED_WORK(&bq->work, bq2415x_timer_work);
>=20
>  	if (np || ACPI_HANDLE(bq->dev)) {
>  		ret =3D device_property_read_u32(bq->dev,
> @@ -1677,7 +1678,6 @@ static int bq2415x_probe(struct i2c_client
> *client, dev_info(bq->dev, "automode not supported\n");
>  	}
>=20
> -	INIT_DELAYED_WORK(&bq->work, bq2415x_timer_work);
>  	bq2415x_set_autotimer(bq, 1);
>=20
>  	dev_info(bq->dev, "driver registered\n");

Looks like this is really problem. I sent alternative patch to mailing=20
list which should fix this problem too plus allows to load=20
bq2415x_charger.ko in n900 qemu.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart23202602.oVPU8x2pus
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW0BFIACgkQi/DJPQPkQ1JYjACgpGDJ1Lq1jFfNJ/uegNIbxnx5
0AAAnR9JwEAJlpRaONkA4TTpAO6MVvaw
=yluO
-----END PGP SIGNATURE-----

--nextPart23202602.oVPU8x2pus--
