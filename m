From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v9 0/2] power: act8945a: add charger driver for the
 sub-device of ACT8945A MFD
Date: Wed, 24 Feb 2016 19:17:27 +0100
Message-ID: <20160224181727.GA19106@earth>
References: <1455524524-9359-1-git-send-email-wenyou.yang@atmel.com>
 <B256D81BAE5131468A838E5D7A243641D6428FF2@penmbx01>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36533 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbcBXSRc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Feb 2016 13:17:32 -0500
Content-Disposition: inline
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D6428FF2@penmbx01>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Lee Jones <lee.jones@linaro.org>, Peter Korsgaard <jacmet@gmail.com>, "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 24, 2016 at 09:33:13AM +0000, Yang, Wenyou wrote:
> > -----Original Message-----
> > From: Wenyou Yang [mailto:wenyou.yang@atmel.com]
> > Sent: 2016=E5=B9=B42=E6=9C=8815=E6=97=A5 16:22
> > To: Sebastian Reichel <sre@kernel.org>; Dmitry Eremin-Solenikov
> > <dbaryshkov@gmail.com>; David Woodhouse <dwmw2@infradead.org>; Rob
> > Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark Bro=
wn
> > <broonie@kernel.org>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kum=
ar
> > Gala <galak@codeaurora.org>
> > Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>; Javier Martinez Cani=
llas
> > <javier@dowhile0.org>; Lee Jones <lee.jones@linaro.org>; Peter Korsgaard
> > <jacmet@gmail.com>; Ferre, Nicolas <Nicolas.FERRE@atmel.com>; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > pm@vger.kernel.org; Yang, Wenyou <Wenyou.Yang@atmel.com>
> > Subject: [PATCH v9 0/2] power: act8945a: add charger driver for the sub=
-device
> > of ACT8945A MFD
> >=20
> > The ACT8945A is a Multi Function Device with the following subdevices:
> >  - Regulator
> >  - Charger
>=20
> I would like to know if this patch set is okay to apply.
> Or any comments?

No comments, I just queued it with "|| COMPILE_TEST" dependency
added.

-- Sebastian

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWzfO3AAoJENju1/PIO/qadikQAKHipmyxC1J0ZC39Umd6udU9
s61s415DQN/yRJIdGkEbj6NkespKzus9hYLSene52QWvhLERMduIG2p36g+JOveF
2xhqLyMDwGMidlnzDrDmB91WprtZAchjzQxe/CNWyvwbbzPGcfP92nNqONtv6iFt
9pgz7oUohwq/Iu78clWe2MHy8diVsNUGMgE3z2L7ZjsZhFkzChy6nnLiTT7lDN2M
4G5NoCea389KG+ASFobXKnvVIlJSXv2jdLqVUJzmMgmVoexokF4mJGk4qUAJoUvw
oF62WFHitzF/f6zXl7EeULHTIyKZhhWkzwZyh3o2LigXqQ4+fqlDuNeBeBvoDEEb
zs4K7oASMQNlcu7zgpbbX9t+9caVjLEBCR1lDaTOvHooph65PzL4sRk6P0i8CXt1
pSfmVjerlhHFIV34z2RnLt7KHA0pcJ9Z9FNpEaaMN0XskvmTdTUbw/De9+qV6sH4
akk97/iqyr8M2NjTDF4j9FlRiXwhOYCTf+eIdmv53ikrNYtT8JtogsAHmJKzpDYD
s2bRsXOoor0MDi8MBkkBjJw9fGKlflBgrZsyPb9G7Yu2nKNKTTVQdnpKWzXa+hHw
eCSZk75BQ662llnfxCoEu/ApWXKiyrSiWzQBOsKGp0ngO/xBcD8zD5Q4pK0fF2WM
+A9VxsRNwKja6G8lbDqN
=9wf+
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
