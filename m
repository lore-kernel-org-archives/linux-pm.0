From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v2] thermal: tango: add resume support
Date: Mon, 18 Jul 2016 12:13:38 +0200
Message-ID: <20160718101338.GB422@ulmo.ba.sec>
References: <57726196.5060909@free.fr>
 <20160718093328.GB32259@ulmo.ba.sec>
 <7689133.3ycKRvbtrh@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33436 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbcGRKNs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2016 06:13:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id i6so10923028pfe.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2016 03:13:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7689133.3ycKRvbtrh@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Mason <slash.tmp@free.fr>, Sebastian Frias <sf84@laposte.net>, linux-pm <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 12:09:39PM +0200, Arnd Bergmann wrote:
> On Monday, July 18, 2016 11:33:28 AM CEST Thierry Reding wrote:
>=20
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_resum=
e);
> > > +
> > > +#define DEV_PM_OPS   &tango_thermal_pm
> > > +#else
> > > +#define DEV_PM_OPS   NULL
> > > +#endif
> >=20
> > In my experience it's often not useful to #ifdef the struct pm_ops.
> > These days you almost certainly want PM enabled, and the conditional
> > doesn't save you all that much in the first place, because it's not
> > unlikely for this to fit into some of the space that would be padded
> > out anyway.
>=20
> This will also generate a warning when CONFIG_PM_SLEEP is not set.
> Better write this as
>=20
> #define DEV_PM_OPS (IS_ENABLED(CONFIG_PM_SLEEP) ? &tango_thermal_pm : NUL=
L)
>=20
> so the compiler can drop the variable definition when it's not
> needed.

My suggestion was to define tango_thermal_pm unconditionally to avoid
any of these tricks. For any real use-case in which the 92 bytes for the
struct dev_pm_ops would matter you most likely want PM_SLEEP anyway, so
I don't really see why we would even want to make it optional.

> > As a side-note, I've noticed that this driver has the following
> > dependencies:
> >=20
> >         depends on ARCH_TANGO || COMPILE_TEST
> >=20
> > which, last I checked, is probably going to fail on some architectures
> > because you need at least another one on HAS_IOMEM (for readl() and
> > writel()). That's a pre-existing problem, of course, so should be fixed
> > in a separate patch.
>=20
> No need, we just merged a patch to no longer allow COMPILE_TEST on
> arch/um/, so we can safely rely on MMIO to be available for COMPILE_TEST.

I thought at least S390 didn't have readl() and writel() either, at
least when PCI wasn't enabled, or some such.

Thierry

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXjKvQAAoJEN0jrNd/PrOhsTUQAI2FHBE25g4Yhp4V6yux1ZjC
l4/Sjni0pLXyDgXb0E/Y7kFhkv3oAfO3U/xMv2dg7z0gSwoizrqmKMGper1n+SkR
NyN9lcPn9aPv3UhyeF/tJaJcZHxFT2/BK/j+gINc5jeyYQ6NVXKJXQMqNXI9jLtE
cTv7ew7wFV8bub87313nnp/B3FUNErJGmEdaWCVq4qDjM+LYclDzVszeh0ch0mHe
yAQZguAbXfkAHmGD4hX/Q7V35PsHGrrrbDxsQ7JknFGuUg2jHT5wENMitzOFQZZQ
dzwM0VoU1Msm/kqpKvE2rL4swHPiovXsxq2L7f0m4H54Q/1YWTwoezeU7PKPSlHU
Q26Fseze5GnpCLUpPb0VJy8NvD5qpj8ysF2axINUlBmZhC+0zFAsntyZEq7twIfT
Xd/iGy7ayvX9s7QagEbJE/xKJQLv6EMre0KcH87JW5wpBe3yyTdG8klO4Hcluk92
1mCTsRdmiRqLYULMGwOG6iw45Y9hhxmb8haqBVj3hipJ+5YfmazhHg6fvV0zRIlc
bdY9+Cd/zw/mmtYjxCf1E/zelOSZlpCkvAHW4pF/unWMhyf1wHTw9lX5n4Zfd5ev
kwJTVXU7pMTFPCz8umaKObs9oPx3Rq/lIkPmcFLomYwYm/H6nUJF0zL162KaExyF
8+7hZRXs14t7WpKd3UW9
=8ULe
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
