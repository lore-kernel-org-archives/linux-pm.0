From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 15/17] thermal: st: allow compile test
Date: Sun, 13 Sep 2015 19:11:33 -0700
Message-ID: <20150914021131.GA925@localhost.localdomain>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
 <1441858273-4017-16-git-send-email-edubezval@gmail.com>
 <20150911092335.GK3260@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35508 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbbINCLh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2015 22:11:37 -0400
Content-Disposition: inline
In-Reply-To: <20150911092335.GK3260@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>, Fabian Frederick <fabf@skynet.be>, Wolfram Sang <wsa@the-dreams.de>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2015 at 10:23:35AM +0100, Lee Jones wrote:
> On Wed, 09 Sep 2015, Eduardo Valentin wrote:
>=20
> > Adding COMPILE_TEST flag to st driver to facilitate
> > maintenance.
> >=20
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Nicolas Boichat <drinkcat@chromium.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Fabian Frederick <fabf@skynet.be>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> >  drivers/thermal/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Sounds reasonable.
>=20
> So long as it's been tested and nothing breaks:
>=20
> Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks for the review. But now checking the compilation test using bfin
as target, I see several compilation issues.

So, I am leaving this one out for now. It requires further changes.

BR,

>=20
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 9069cc7..d94b4e9 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -350,7 +350,7 @@ source "drivers/thermal/samsung/Kconfig"
> >  endmenu
> > =20
> >  menu "STMicroelectronics thermal drivers"
> > -depends on ARCH_STI && OF
> > +depends on (ARCH_STI || COMPILE_TEST) && OF
> >  source "drivers/thermal/st/Kconfig"
> >  endmenu
> > =20
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJV9izOAAoJEMLUO4d9pOJWSgEH/1nlcUmLjGdrou57JlpC2xJb
hb8Xc7VKyf4McwIWmRZbK9MEg052sRZ7ZOz/HkjOWEVmhxFw5yshJ6Orkb20XslK
KZ5oNYCaVhLRnHjpaeH31IVcvdvqVrph7Ml0LhnSe7pLNGZrUogC3QUYa65drJLi
E1ldKVRP0xBrY1jRXX6b61r8APKQm2rF/GYLEI4yvUbC5BshirbCH0U0Ld5/egIb
P9FZ4+3Qyu3pJ4YRVUHQmk2ckzY4GyQUmJeX/cedvjFKw1MF791jM2Q2Ao+23do1
A7z+Zls8WH3x+meRfPAI8nPPktJBdOZsOQXwrFrfzhNX/+rhm0gH5xofbHjEf64=
=k7o0
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
