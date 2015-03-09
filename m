From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: generic-adc-battery: Fix power_supply_property
 returned value
Date: Mon, 9 Mar 2015 02:54:54 +0100
Message-ID: <20150309015453.GB941@earth>
References: <1425842480-8746-1-git-send-email-nicolassaenzj@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35838 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254AbbCIBzL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 8 Mar 2015 21:55:11 -0400
Content-Disposition: inline
In-Reply-To: <1425842480-8746-1-git-send-email-nicolassaenzj@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: nicolassaenzj@gmail.com
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 08, 2015 at 07:21:20PM +0000, nicolassaenzj@gmail.com wrote:
> From: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
>=20
> The POWER_SUPPLY_PROP_STATUS case in gab_get_property() wasn't providing =
any
> value.

Thanks, queued:

http://git.infradead.org/battery-2.6.git/commit/0595439a0a8740f776a0ae367a4=
c7f243add24ec

-- Sebastian

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/P1tAAoJENju1/PIO/qao1UP/1Hc7JDErrTY45fs5oBTKY6y
9vLHl45Q3C2+OGvuqNe/j7/z/WVQe+k+idCFTy8JhmfIWVlvlw/2GsWSopAbs13p
o4Ky8rbGucW7fizVSyt8a1kddsdTKAZ54vq6K8wIzZzO2JaYvLyQdIPgA1c0Q519
v7FBQo5IP/9TDcuYx6fAGBf29mA0r4D0NPNlLQBi1v3Ii/0iMIZ8f6HXEPs945HU
aww9oK2DuEGS2tehbqpBpaIkPI/rqUYif4jpjAoRL2QGmhsMWvGux4eX73TSfrJA
CRrtV11CqjL/yX5WgDkcly8UoBELriQa+FQ1DHfZXoj/0zAsmOTW2bkckmpz0lZe
Rew2PUkwa514wE1Br1PHARGflmzR88Q/thbSVmhJkg6RP7cLh0iLojLWf7cgvQIi
YdPzbPAzPaOC2XbwpdK6O55mboGuXd760TccLWP2BviHUwldOdZ7c6xTNuOuixxI
y681cneYugEhuXuNItt4EeaNprckbH5Lvk+EolBGxSRjTHMwNRlsbqP1krwAaEZE
prybIyQSjsQv2sDlvrpe5poWbPHdKFvweNPe/mLs8MeibJ74eniP/rurEkyiYuW8
l6DYKiNAhlTJkbAdw8HEHTAam6zbisLWIkTY98PzJ3Vh5IEY+vt5ocIQ8KA4DEAA
6CW11pThu/9FJGMgEGzB
=PNbh
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
