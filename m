From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 06/17] thermal: cpu_cooling: dts: Define device tree
 bindings for Exynos cpu cooling functionality
Date: Mon, 12 Jan 2015 10:24:20 -0400
Message-ID: <20150112142417.GA28377@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-7-git-send-email-l.majewski@samsung.com>
 <20150102181529.GC12130@developer>
 <20150112150916.43f5b7ff@amdc2363>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:52737 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbbALOYd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 09:24:33 -0500
Content-Disposition: inline
In-Reply-To: <20150112150916.43f5b7ff@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Mon, Jan 12, 2015 at 03:09:16PM +0100, Lukasz Majewski wrote:
> Hi Eduardo,
>=20
> > > Presented patch aims to move data necessary for correct CPU cooling
> > > device configuration from exynos_tmu_data.c to device tree. =20
> >=20
> > I believe the patch title is misleading. Looks like you are changing
> > something at cpu cooling, but in fact, you are changing DTS files. I
> > would suggest you to use a prefix like 'arm: dts: ....'
>=20
> Now this patch name is:
> thermal: cpu_cooling: dts: ......
>=20
> All the code in this patch adds bindings for 'thermal-zone' to map
> cooling device to proper trip points.
> In fact this is solely related to cpu_cooling...
>=20
> From the above, I think that the already provided convention is more
> suitable and "arm: dts: cpu_cooling: thermal" seems a bit awkward for
> me.
>=20
> If you don't regard my justification as valid, then I will fix this.

Still, the naming is confusing. With that prefix you are saying this
patch is something generic about cpu cooling and thermal dts. And that
is not what this patch is about.

Saying "arm: dts: add cpu cooling bindings for Exynos" is a short and
direct subject. Besides, you have the plus to call the attention of the
ARM and device tree maintainers. It will be also in my radar.


The original subject also makes me think you are dealing with C code,
while the former says already upfront that you are talking about arm dts
bindings.=20

Cheers,
>=20
> --=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUs9j+AAoJEMLUO4d9pOJWS3wH/Rqd70bP60PzUDtuZsL1HGdY
iGbR1Hb1FDN1ws4EqjZ+aqq6kE4Tt2+tK0uZvaGLZHv0gPtuiRQmhsT9QSIjMc1t
sgKolzOpVAlqf63pJrBsLwGKVEdtkqj3KJSj+s2sNS1UMLlq5xvWhABkUbAXf1Qv
pkM4FZue/u/9MYVByLmj8R+V755OA4dTDHjHRPGIGXo2Q0S+qDlIvZ/rs3oolwjw
nUSvdVJe1VKXKeJhPvxdTTRKOb9bF+s+TNbvbjndVre19LXvVj8jcWiPUO8EqngW
KkTI9lYIY250P96YzI3G0Z34gg9LUjPabNHN/ncZRw+FRx1m85wEBHyc9299Ak0=
=oGmc
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
