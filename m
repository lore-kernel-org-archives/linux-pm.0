From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/6] power/reset/rmobile-reset.c: Fix !HAS_IOMEM build
Date: Fri, 20 Mar 2015 13:31:53 +0100
Message-ID: <20150320123153.GA7734@earth>
References: <1426541230-928-1-git-send-email-richard@nod.at>
 <1426541230-928-4-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42636 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbbCTMcP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Mar 2015 08:32:15 -0400
Content-Disposition: inline
In-Reply-To: <1426541230-928-4-git-send-email-richard@nod.at>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, dwmw2@infradead.org, dbaryshkov@gmail.com, jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Mon, Mar 16, 2015 at 10:27:08PM +0100, Richard Weinberger wrote:
> Fixes:
> drivers/power/reset/rmobile-reset.c: In function =E2=80=98rmobile_reset_p=
robe=E2=80=99:
> drivers/power/reset/rmobile-reset.c:61:2: error: implicit declaration of =
function =E2=80=98iounmap=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>   iounmap(sysc_base2);
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>

Thanks, applied:

http://git.infradead.org/battery-2.6.git/commit/039ab50bda5606307138b1baa1f=
18c7e33d357e4

-- Sebastian

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVDBM2AAoJENju1/PIO/qa2vEP/RgVin1l7LgiOycaX4gUsp69
vBEJkmD20Ea2K4059n1zYCpPr5GAcFgQwgAguRwe0+lCyhh2rZPit44sTYBhftDu
xX0nlaAGNPQpIiPp7kI3DCc5wXzYlS50XsNUKwXbuCVoX7k7UU+ENRAzxsmSLJlk
Yw/WxMVjo6dJo0z8urTEUx9kNhq72hvgvXj+cdI4zQcMN02gOmaaRR/l647EE93P
XH930b5BPYoLY42OtvpnoKfVP0L7PwRUWk79anGZdE6NJ9RbHKIdzQ0uyyGqjwYu
ll2NPeP4vDzd12V0X7FFvBNQr1o74yEZubFNPFQcKaOhyku3CEUXpIvw/laubLkQ
ZAuANPAxyvK6zKOUxUfJB+AyRyIpTy9nQsirlK47HvHnjpJKRFSgnwZdaqXSeb85
40wGorpmeKgfRsQS7khaYjAuIFWXYJDyspMJiEgJM8syPwiEbqyqXgtgMo5BpqdE
0IxXD/FxdN3brNJ5hN3f0AlzYHbD5PDvzSJ8rmxVrqed4fPfQTgA0wjlGSOt1wDm
MT9hTLbb3vpHQm/rjMVqAWkppAbMmQgilylna4yKX6sDOo/c6MlNzjGOpy4vQNDM
1DyJsqv8NM9BmFIhMrXzir6wzRomSwJ2pQzU5vY5g2+v5EB+6a0V03YkxJ2jDcyI
cS5zZMgQfF6jecedCUjV
=1OZn
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
