From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 06/15] Platform: OLPC: Add XO-1.75 EC driver
Date: Mon, 19 Nov 2018 11:40:46 +0100
Message-ID: <20181119104046.GC28607@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-7-lkundrak@v3.sk>
 <CAHp75VcefOJHZ3WdZYrGEJFjqg2s1oJ75Jg9gKmQFre_ScAPZg@mail.gmail.com>
 <8881f5e48613c9d9d133e3964031fe2ab57f4801.camel@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8881f5e48613c9d9d133e3964031fe2ab57f4801.camel@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, quozl@laptop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi <linux-spi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Platform Driver <platform-driver-x8>
List-Id: linux-pm@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/ctype.h>
> > > +#include <linux/olpc-ec.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/reboot.h>
> > > +#include <linux/input.h>
> > > +#include <linux/kfifo.h>
> > > +#include <linux/module.h>
> > > +#include <linux/power_supply.h>
> >=20
> > Easy to maintain when it's sorted.

No / it depends.

> > > +       channel =3D priv->rx_buf[0];
> > > +       byte =3D priv->rx_buf[1];
> >=20
> > Maybe specific structures would fit better?
> >=20
> > Like
> >=20
> > struct olpc_ec_resp_hdr {
> >  u8 channel;
> >  u8 byte;
> > ...
> > }

Structures have padding and other nastyness...

> > > +                       pm_wakeup_event(priv->pwrbtn->dev.parent,
> > > 1000);
> >=20
> > Magic number.

Nothing wrong with magic numbers.

> > > +       args[0] =3D mask & 0xff;
> > > +       args[1] =3D (mask >> 8) & 0xff;
> >=20
> > ...mask >> 0;
> > ...mask >> 8;

No, please.

> > __maybe_unused  instead of ugly #ifdef?
> >=20
> > > +{
> > > +       struct platform_device *pdev =3D to_platform_device(dev);
> > > +       struct olpc_xo175_ec *priv =3D platform_get_drvdata(pdev);
> >=20
> > dev_get_drvdata() or how is it called?
> >=20
> > > +       unsigned char hintargs[5];
> >=20
> > struct olpc_ec_hint_cmd {
> > u8 ...
> > u32 ...
> > };
> >=20
> > ?

No, unless you want to break the code. Or add __attribute__ packed and
deal with endianness.

Just no.

> > > +       static unsigned int suspend_count;
> >=20
> > u32 I suppose.

You know, there's semantic difference between unsigned int and
u32. And this sounds like candidate for unsigned int.

> > > +       /* Enable all EC events while we're awake */
> > > +       olpc_xo175_ec_set_event_mask(0xffff);
> >=20
> > #define EC_ALL_EVENTS GENMASK(15, 0)

Actually that's less readable. Just don't.

> > > +static const struct of_device_id olpc_xo175_ec_of_match[] =3D {
> > > +       { .compatible =3D "olpc,xo1.75-ec" },
> > > +       { },
> >=20
> > No comma for terminators.

Comma is fine.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvyky4ACgkQMOfwapXb+vI2VACgq3L4bT9Babbvon3rC4cRz11g
UaAAoJve3CamopvVPFBQrLLdYPAzTcuv
=Tfuz
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
