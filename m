From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for SAMSUNG THERMAL DRIVER
Date: Tue, 24 Feb 2015 14:22:22 -0400
Message-ID: <20150224182216.GC3448@developer.amazonguestwifi.org>
References: <1424791888-27796-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46724 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbbBXSVu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 13:21:50 -0500
Received: by pabkx10 with SMTP id kx10so37821293pab.13
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2015 10:21:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1424791888-27796-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2015 at 04:31:28PM +0100, Lukasz Majewski wrote:
> This patch adds entry for SAMSUNG THERMAL DRIVER in the MAINTAINERS file.
> It has been agreed, that pull request are going to be sent to Eduardo
> Valentin.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddc5a8c..be837a0d22 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8481,6 +8481,14 @@ S:	Supported
>  L:	netdev@vger.kernel.org
>  F:	drivers/net/ethernet/samsung/sxgbe/
> =20
> +SAMSUNG THERMAL DRIVER
> +M:	Lukasz Majewski <l.majewski@samsung.com>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-samsung-soc@vger.kernel.org
> +S:	Supported
> +T:	https://github.com/lmajewski/linux-samsung-thermal.git
> +F:	drivers/thermal/samsung/
> +
>  SAMSUNG USB2 PHY DRIVER
>  M:	Kamil Debski <k.debski@samsung.com>
>  L:	linux-kernel@vger.kernel.org
> --=20
> 2.0.0.rc2
>=20

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7MFRAAoJEMLUO4d9pOJW6zgH/jZCKjWGql04bNkQRjVt5Jub
yBJiY3Q7Ya8Zm554ZFDmGFMmfeVhkQNTJGCdSy7+LDaY0mzEYUzWPlm1m1GyGYBI
dN2P19L6MR1M5zF5k5NDu5ApVj2wEXNEEWj8DkNEaZeZVZOlXez/l0J4f+NCSrNf
GstFRqUs4wkY9qRaNxZ/bWsCa9vBkoMaCvuhNg+mxlW5/Afp3DEfs49ckqW0BjwX
/QhpQAKDsVJst8C9a9MxcoDhETjoK18RAUU2cdVXVtNzTDOI/rFVgt1LN8VU5AFf
NNLj1R9P3wZK2ffBVuDoRqXVb+c6HvNu2KaR5uhII6sDjKjhUbd47nj8nvkFAwo=
=7rxX
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
