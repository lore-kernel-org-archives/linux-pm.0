From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFT/RFC] power_supply: bq2415x_charger: Initialize workqueue
 before scheduling it
Date: Mon, 27 Jul 2015 16:22:29 +0200
Message-ID: <20150727142229.GD12993@earth>
References: <1436834053-2084-1-git-send-email-k.kozlowski@samsung.com>
 <201507252349.06519@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48292 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489AbbG0OWg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jul 2015 10:22:36 -0400
Content-Disposition: inline
In-Reply-To: <201507252349.06519@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 25, 2015 at 11:49:06PM +0200, Pali Roh=E1r wrote:
> On Tuesday 14 July 2015 02:34:13 Krzysztof Kozlowski wrote:
> > The driver during probe registers a power supply notifier
> > (with bq2415x_notifier_call() callback) and calls it manually right
> > after. The notifier callback function schedules driver's workqueue
> > (bq->work).
> >=20
> > However the workqueue was initialized after these two events (after
> > registering power supply notifier and calling manually the callback).
> >=20
> > When power supply core notified the driver (executing its
> > bq2415x_notifier_call() callback) the scheduled workqueue could be
> > still uninitialized.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reported-by: Pali Roh=E1r <pali.rohar@gmail.com>
> >=20
> > ---
> >=20
> > I don't have the hardware, please test. Additionally I could not find
> > the commit which introduced the issue so I did not cc-stable.
> > ---
> >  drivers/power/bq2415x_charger.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/bq2415x_charger.c
> > b/drivers/power/bq2415x_charger.c index e98dcb661cc9..527ed0f18796
> > 100644
> > --- a/drivers/power/bq2415x_charger.c
> > +++ b/drivers/power/bq2415x_charger.c
> > @@ -1601,6 +1601,7 @@ static int bq2415x_probe(struct i2c_client
> > *client, bq->reported_mode =3D BQ2415X_MODE_OFF;
> >  	bq->autotimer =3D 0;
> >  	bq->automode =3D 0;
> > +	INIT_DELAYED_WORK(&bq->work, bq2415x_timer_work);
> >=20
> >  	if (np || ACPI_HANDLE(bq->dev)) {
> >  		ret =3D device_property_read_u32(bq->dev,
> > @@ -1677,7 +1678,6 @@ static int bq2415x_probe(struct i2c_client
> > *client, dev_info(bq->dev, "automode not supported\n");
> >  	}
> >=20
> > -	INIT_DELAYED_WORK(&bq->work, bq2415x_timer_work);
> >  	bq2415x_set_autotimer(bq, 1);
> >=20
> >  	dev_info(bq->dev, "driver registered\n");
>=20
> Looks like this is really problem. I sent alternative patch to mailing=20
> list which should fix this problem too plus allows to load=20
> bq2415x_charger.ko in n900 qemu.

I have not yet reviewed your patch (just skipped over it), but the
qemu changes are a bit intrusive for -rc. I suggest to apply this
patch for 4.2-rc. The extended patch can then be added in 4.3.

-- Sebastian

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVtj6iAAoJENju1/PIO/qa8d8P/2z4cX4CZECrJspU4tgG1SAK
+yygwwtu7YUxY9D1G95Dfo5oK562BWFKry8vdeb8OJP6HhiHxN4pYmdL29eZyQC1
x7uXTkKWpkonPG1+2kILFrzXuTANjSL0G+NPk+a9v82PlxEe4jC1/kWSGdko/CSL
xBpP641/eAufY/d3J87qdiSOccxYCsqgIoJ1w14l5ytdlkTPzU1MK+PAf5lFpG5g
+ImK4GKGwGV2nmpGrpNcvht/PRTZ79j8YUBKwZ3YA/SEdfTpBBO+8AqMwYX68nEd
UviauA1aOjYsLjwaw7ef/9sOsojr1WQg0u3ru5LHuuDuYl5lKr6A3rrr2EQ4iZll
GP1lpjxPwhPzBaZJ2uRbMsW6R4k9BfN+9+SCEmd/T/tDHJGf3ob1y+LV1yyuiFIQ
jd88edcNBOm1t0WhSWdXYjA+L9fM6G3oipVJiDEYVO5JIig7X98+w4F/UN3FwyvP
nZdiwtxd8QQ9YtfNWZImZW87YFMfkWMqRe0qXlXND0EbS+Q6hkRjEvwdwDZ/yrQ8
F/LzGqLnYZ6beJCBh7uGnZO6wXm1P5nD6tv9sCILG+jJ8pujGqn4SeWRDUW0lie6
cL3O1qPZh3JS77jHhsmAzxW9CsGUQOzQC9kMIIRT4wqddOBrtrS9kWcs19U0ge93
vTiSxKsFH3jS+0YIvvpC
=aJDX
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
