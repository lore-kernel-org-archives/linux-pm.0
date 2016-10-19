From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
Date: Wed, 19 Oct 2016 04:56:57 +0200
Message-ID: <20161019025656.564mntn7mt7ei36m@earth>
References: <20161005155112.13774-1-hdegoede@redhat.com>
 <20161005155112.13774-2-hdegoede@redhat.com>
 <20161019025154.rmw56aoh27wbrene@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3tgrbcy642jlayy4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932580AbcJSC5B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Oct 2016 22:57:01 -0400
Content-Disposition: inline
In-Reply-To: <20161019025154.rmw56aoh27wbrene@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Dennis Gilmore <dennis@ausil.us>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--3tgrbcy642jlayy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 19, 2016 at 04:51:55AM +0200, Sebastian Reichel wrote:
> > diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> > index b1b8658..d35a5fe 100644
> > --- a/drivers/mfd/axp20x-i2c.c
> > +++ b/drivers/mfd/axp20x-i2c.c
> > @@ -69,10 +69,11 @@ static const struct of_device_id axp20x_i2c_of_matc=
h[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
> > =20
> > -/*
> > - * This is useless for OF-enabled devices, but it is needed by I2C sub=
system
> > - */
> >  static const struct i2c_device_id axp20x_i2c_id[] =3D {
> > +	{ "axp152", 0 },
> > +	{ "axp202", 0 },
> > +	{ "axp209", 0 },
> > +	{ "axp221", 0 },
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
>=20
> Thanks, queued.

My mistake. It should obviously go through mfd. So take this instead:

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--3tgrbcy642jlayy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBuD4AAoJENju1/PIO/qaLpMP/R4RUbae4zSacpcdXgUeCc/P
oMuae5gNxXq7tseHtHg3kmE2jQkPz1KDvwTLe5/iURzfa0JWNCmv/DN7AC3nxXKf
JshmvxRgbVtXF3LmCZO/qAWN2vrya4q33JaVFgm0kPauVBxDaUS6vP8UZOznk/+O
W3CYyq4P5+4LyY3a1CA+kgSavwAWl/4HOYePPzigKIvT6bjJpZg1WMeLbJqfD62c
eUSZmxZd1y3KKTxf0sfD9wfwAidL0gwpBclzCRb0LD0Pi4jKG1uV5lKmfy+GWnsy
2r/w3YyNPbXsbLH51sFQUFuXsEQDSg4Gxmh5lTD7uv2o4PbR4CziKBB7E/yN1Qzj
pKqWJD4wMMZKUPflccTFZLoGwDp+DgYE6GzUcvL/VMUExjhe9cQAqHZd6uQyKpSl
Gs3bB5QPTHyKripxuN1kGmdle9JgiwKUbTiMu2Ttw84G88bfEqrj9UGuknrEhSUW
w0f+lGDeJxc7mSHZrnQFXd536wplrVSo9HpWIu8D7yHhT/ggmNTPTN0qidNl67cV
iMSpa7Z49J594BMdXUoT8YCAE76YDzrsgFIxHA6s4cKuxWfhV7X9UV4BT3ON20WW
F8RT+ngj1N+8dJQ2ltXhofUeIuOcnDygxip7bfN61V9HyG7z/deonG/PeQKOU2Eu
NNCkVaR3cZczFGKOZaMI
=GJjL
-----END PGP SIGNATURE-----

--3tgrbcy642jlayy4--
