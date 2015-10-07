From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 4/4] w1:slaves:bq27000: load battery driver kernel module if required
Date: Thu, 8 Oct 2015 00:26:21 +0200
Message-ID: <201510080026.21233@pali>
References: <cover.1444243358.git.hns@goldelico.com> <c9ee31c641a8612c49172123cd56407484e699d6.1444243358.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9966930.0hnHccjWvP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35008 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbbJGW0X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 18:26:23 -0400
Received: by wicge5 with SMTP id ge5so662375wic.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 15:26:22 -0700 (PDT)
In-Reply-To: <c9ee31c641a8612c49172123cd56407484e699d6.1444243358.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

--nextPart9966930.0hnHccjWvP
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 07 October 2015 20:42:39 H. Nikolaus Schaller wrote:
> Explicitly call request_module() in the wrapper so that the
> bq27x00_battery driver is loded on demand, when compiled as module.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/w1/slaves/w1_bq27000.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/w1/slaves/w1_bq27000.c
> b/drivers/w1/slaves/w1_bq27000.c index caafb17..745bd6e 100644
> --- a/drivers/w1/slaves/w1_bq27000.c
> +++ b/drivers/w1/slaves/w1_bq27000.c
> @@ -49,6 +49,8 @@ static int w1_bq27000_add_slave(struct w1_slave
> *sl) int ret;
>  	struct platform_device *pdev;
>=20
> +	request_module("bq27x00_battery");  /* load as module if needed */
> +
>  	pdev =3D platform_device_alloc("bq27000-battery", -1);
>  	if (!pdev) {
>  		ret =3D -ENOMEM;

Hi! Function platform_device_alloc would allocate kernel device and it=20
should also load appropriate kernel driver (via platform:bq27000-battery=20
alias). If that does not work, problem is somewhere else. Maybe depmod=20
is not properly generated? Or bq27x00_batter.ko modules does not contain=20
needed alias?

Adding request_module() here is not proper solution. Real problem is=20
somewhere else... Anyway there is series of patches for bq27x00_battery=20
which should cleanup some problems, so maybe they also fix your problem.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart9966930.0hnHccjWvP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlYVnA0ACgkQi/DJPQPkQ1LLWACgy6LNJondpNGxosMorQU1ZXYE
UdQAoKp0/pvMsyFYQvBOgRclSPiZEQ6O
=VAH2
-----END PGP SIGNATURE-----

--nextPart9966930.0hnHccjWvP--
