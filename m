From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v2] thermal: tango: add resume support
Date: Mon, 18 Jul 2016 13:28:59 +0200
Message-ID: <20160718112859.GB18547@ulmo.ba.sec>
References: <57726196.5060909@free.fr>
 <7689133.3ycKRvbtrh@wuerfel>
 <20160718101338.GB422@ulmo.ba.sec>
 <2701749.GrMaU3rvHr@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33165 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbcGRL3D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2016 07:29:03 -0400
Received: by mail-pf0-f196.google.com with SMTP id i6so11053023pfe.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2016 04:29:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2701749.GrMaU3rvHr@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Sebastian Frias <sf84@laposte.net>, Kevin Hilman <khilman@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, Mason <slash.tmp@free.fr>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 01:10:07PM +0200, Arnd Bergmann wrote:
> On Monday, July 18, 2016 12:13:38 PM CEST Thierry Reding wrote:
> > On Mon, Jul 18, 2016 at 12:09:39PM +0200, Arnd Bergmann wrote:
> > > On Monday, July 18, 2016 11:33:28 AM CEST Thierry Reding wrote:
> > >=20
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_r=
esume);
> > > > > +
> > > > > +#define DEV_PM_OPS   &tango_thermal_pm
> > > > > +#else
> > > > > +#define DEV_PM_OPS   NULL
> > > > > +#endif
> > > >=20
> > > > In my experience it's often not useful to #ifdef the struct pm_ops.
> > > > These days you almost certainly want PM enabled, and the conditional
> > > > doesn't save you all that much in the first place, because it's not
> > > > unlikely for this to fit into some of the space that would be padded
> > > > out anyway.
> > >=20
> > > This will also generate a warning when CONFIG_PM_SLEEP is not set.
> > > Better write this as
> > >=20
> > > #define DEV_PM_OPS (IS_ENABLED(CONFIG_PM_SLEEP) ? &tango_thermal_pm :=
 NULL)
> > >=20
> > > so the compiler can drop the variable definition when it's not
> > > needed.
> >=20
> > My suggestion was to define tango_thermal_pm unconditionally to avoid
> > any of these tricks. For any real use-case in which the 92 bytes for the
> > struct dev_pm_ops would matter you most likely want PM_SLEEP anyway, so
> > I don't really see why we would even want to make it optional.
>=20
> Sure, leaving it unconditional works too.=20
>=20
> > > > As a side-note, I've noticed that this driver has the following
> > > > dependencies:
> > > >=20
> > > >         depends on ARCH_TANGO || COMPILE_TEST
> > > >=20
> > > > which, last I checked, is probably going to fail on some architectu=
res
> > > > because you need at least another one on HAS_IOMEM (for readl() and
> > > > writel()). That's a pre-existing problem, of course, so should be f=
ixed
> > > > in a separate patch.
> > >=20
> > > No need, we just merged a patch to no longer allow COMPILE_TEST on
> > > arch/um/, so we can safely rely on MMIO to be available for COMPILE_T=
EST.
> >=20
> > I thought at least S390 didn't have readl() and writel() either, at
> > least when PCI wasn't enabled, or some such.
>=20
> Yes, but they've never complained about COMPILE_TEST breakage because
> of that. Tile is in the same boat too in some configurations.

Ah, okay. I remember running into this occasionally when doing
randconfig builds on S390. That was many moons ago, so perhaps it's not
an issue anymore, and maybe I've become overly cautious about the
COMPILE_TEST dependency.

Thierry

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXjL17AAoJEN0jrNd/PrOhQnQP/2l2wLux0j7wh52CXNiQpvUz
r6a5rWGAMLieAIloi6+1u+UwsmkR6Kctj8K9qvPYETejYd87j0tZDLRG3tHn9Zxf
rjyZq8VfbpHzax5H3F32VO16FT78loeSqgY3kSaXvAzs7C75K+ZWjNpZRiRJai/8
sJ/XOypDYXPj0iNY7LRLOfMFO1slQpzCv+kzTSlAsOsAuqtI8L13gakZvwWgde52
nYyoFfUyA+BtL12ucuJ+65l+PdOZV3Hg3DFOtEyifPRWvwjSjMkk7TN8GJDzTLqa
IWJk9cyOekXLskzI6Shqext/+rakzYmOLVsdBE5AoXFtj+tZ2MHLJdY4Nlo1Xe00
Bb9tLu1QQfH4pGH7SrqC6r6PrdmkITKTf7yJZZvIT5m/beMXD0T4YsvYrSt9ooNM
ZlfLQJt9c/pg49qmVNzcWQdCLC+DA4kp5C6/wB3L5Ixm7BwXsWh1PU/a/Jcu+oLk
MEXShbWLY4kwYmR9F0//WibpMnhvdlsRUKilnK33gFD2Hrk9IrcboDBjL4pQf/Jj
LhMY85WjpTKHRb9GLT64I1foEfsaMgM9EZNMcX0HS+25zAG9u0DA2n7mz8mhSFel
Dei6EUYtM/3mnvaG/mOeyMvZcG2K5rmaAN6ZssdFbE3cM3rmOLDdGbwEsqbDHpwJ
L4T6fzW+cw7ydK0lLWlP
=eL45
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
