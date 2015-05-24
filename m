From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] power: reset: ltc2952: use _optional variant of
 devm_gpiod_get
Date: Sun, 24 May 2015 21:46:45 +0200
Message-ID: <20150524194645.GH11066@earth>
References: <1431981907-32578-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1431981907-32578-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54704 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbbEXTrI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 24 May 2015 15:47:08 -0400
Content-Disposition: inline
In-Reply-To: <1431981907-32578-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, kernel@pengutronix.de, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-pm@vger.kernel.org


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 18, 2015 at 10:45:07PM +0200, Uwe Kleine-K=F6nig wrote:
> devm_gpiod_get_optional returns NULL if devm_gpiod_get would return an
> ENOENT error pointer.
>=20
> There is no semantic change intended.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks, queued.

> probably you could argue if the other errors returned by
> devm_gpiod_get_optional should be ignored or not. I'd say it would be cle=
aner
> to forward the error but as the driver explictly claims it should be ok, I
> kept this behaviour.
>=20
> For forwarding the error replace "data->gpio_trigger =3D NULL" by
> "return PTR_ERR(data->gpio_trigger)".

Looks sensible, but I took the patch as is for now, since I can't
test the changes (I don't have any ltc2952 including devices). Also
it should be a second patch, so that it can be reverted if needed.

-- Sebastian

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYiqlAAoJENju1/PIO/qa2G0P/0D34wCh2J9BID5TJ+FKwL5t
LE5zYlXSM3adhw65CA11g12Yfuw/r68yp9fDgbCmMnz3J7JDtIBBVbmkbowvKGjC
sIQyS650W/nyu2Sk9ZidAHgcNeaJFz0UpmE4taBmdQfKZTiynF8NzPleUVHkG98o
7fyA9LYgl4zruCWUktC/cDpU7W939zKrg9cDYHcNEdJxtAV2QZYikkTzdt+GZbB4
VX+GbcGLUjRCRC9Lx2DM+mE7XYo4CCEiZK8vSJSmBxQr2QDMK7yo7U7reZIMMOZO
YDWHEUXZzWY9u5UnAukAQzMrBoE0wLFYdZJeoO0/ofrPVdGK8VJ6VJETWT7kjA3I
Hf4ioEOezfoZsj4UtSDCKJTxVW6Muof7pJGP1h0lGohcvE9Hx7vc85bfHFL36/fw
TpeS+GhPnEh+hFWDPCEsHzz+U1FVzPnZbEreT7b6KA9mQsJ0POuL7KhzASQVZIPw
Dpe1eq+aHDvSQlxO+kUVB82VFZRGjiJBReuExzdl4FmFXu2mphtneYDiD+M23DoE
YEKqK9lbieBtG4V3aSog5+Lekka/ZjOwqd6o8OyGTuVHxUv2cWwxuma6Px4nXleF
76CDgl5DbLMvocMUj8FmNY4hvj0d5EpcUUOvEZP/0SsTnjSQsF+GtKpMN8ckbrar
AOBeEsN1f1RtBM43mlaC
=aytk
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--
