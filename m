From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v11 02/10] i2c: i2c-smbus: Move i2c_setup_smbus_alert
 from i2c-smbus to i2c-core-smbus
Date: Mon, 6 Nov 2017 22:36:46 +0100
Message-ID: <20171106213646.2h3zsitnlablblli@ninjato>
References: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
 <1503567070-115646-3-git-send-email-preid@electromag.com.au>
 <20171029154408.vmjkpj7ybqyrj3ke@ninjato>
 <1397131b-c22d-9872-dbe0-9b691553cb9e@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ksr3k7u5lydgerui"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397131b-c22d-9872-dbe0-9b691553cb9e-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--ksr3k7u5lydgerui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Phil,

(CCing Jean for some additional expertise)

> > > In preparation to adding of_i2c_setup_smbus_alert() move
> > > i2c_setup_smbus_alert() to core module. of_i2c_setup_smbus_alert()
> > > will call i2c_setup_smbus_alert() and this avoid module dependecy iss=
ues.
> >=20
> > I am not very happy with this but don't want to cause another delay. So,
> > I hope we can discuss and fix it incrementally.
> >=20
> > From what it does, I really think both setup_alert functions belong
> > to i2c-smbus.c. Three possibilities come to my mind (untested,
> > though):
> >=20
> > a) use try_then_request_module somehow
> >=20
> > b) add to CONFIG_I2C something like: select I2C_SMBUS if OF
> >=20
> > c) get rid of i2c-smbus.c entirely and move it all into the core
> >=20
> > Dunno if a) or b) have been tried in the course of this series
> > already?
> >=20
>=20
> Nope hadn't tried either a) or b). a) is not something I was aware of.
> Had a brief play and not sure how to make this work. This gives me the
> same linking problem.

Which one? I2C core is built-in and the driver is a module? And
i2c-smbus is a module then, too?

> A variant of b) was tried by selecting I2C_SMBUS from driver modules
> having smbalert support, but that caused problems if the i2c core was
> builtin and the driver was a module. But this looks to work for me.

It should work(tm). Yet, it will cause overhead, because OF is big these
days and I2C_SMBUS is still rare.

> A variant of c) with option to exclude the i2c-smbus code still.
> Add i2c-smbus to the i2c-core module by:
> Change Kconfig I2C_SMBUS to a bool
> add i2c-smbus to i2c-core object.
> fixup duplicate init_module calls etc.

I see. From my side, why not. But I'd really like Jean's opinion here on
why i2c-smbus.c was a seperate module and not included in the core.
Because I split the I2C core into multiple source files recently, we
could have a seperate source file for i2c-smbus-alert without ifdeffery
but with some Makefile magic.

> Possibly also rename i2c-smbus to i2c-smbus-alert?

Why the rename? I thought we put all the code into the core?

> Let me know your preference and I'll put something together.

Thanks for the assistance. I am afraid we need a bit more discussion
first, though.

All the best,

   Wolfram


--ksr3k7u5lydgerui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloA1e4ACgkQFA3kzBSg
KbbU6w/+JNqHTikgpzfxNi6pv4i0tL3vEVoTmKG8OQxNwtr170155uXfnGhN8rHr
bCdjT8IclkwLjYnL3G+l+4csQOeM7XE8Hkn5mU0XnuEmuurL82Oj+8jTAn/o/y3E
of5tebhv+7GT4j+MiQ2Mjo+WC9qKniYNPNPOnij64vdHLpdqOVb5WBgYAxW9+7r2
H3syOdkV59VlI5OtQ1NIJ+u+dyi8rMQZPD5KQEnRs+wTBgTdMsU4vm3UZaBZ+130
ViuQ5AUemxaWtM1sfwnwPISGbBwhyqexdhsi2IErBvzYofazAaOIGigc3hvHXn7g
UIxGtS5ZGzvc2rsjCQ/XiD+SWh/05PlJIREsp7xJaRWlL6wecX3bBxzsun/KmF8e
1NK1/MtcOAH04UzA5bfd1gmQxfeSnMzut4zM+Y/uVqInxlskzxr/jzaM/NJgPWEm
w2t8nvAIgZUKAr/5r7x0FLhtpKgtgXBRtFaecyX6nmj0Sc6Y8SWncfxBJossMtIc
s3dkYT2gjEyIb26N3eFQSVHP10y08cxZzqmyt8Y1fj2ZbI7yQVsZap2YR+O/bd6S
yHcGBnx2Eyi1jW3Ko/l/2/xSfNt1QrWcpNvndAEiSk3M/60zMvrx3sJ3J6sBHvM1
29f29qFQDDGoiYIMNqic2t/XXu2jIPoWeztfojgdZAHSIsRY0lY=
=Yr6y
-----END PGP SIGNATURE-----

--ksr3k7u5lydgerui--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
