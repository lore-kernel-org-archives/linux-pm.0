From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 02/13] thermal: trivial: fix typo in comment
Date: Mon, 6 Apr 2015 18:49:00 -0700
Message-ID: <20150407014859.GC4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36473 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbbDGBsw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 21:48:52 -0400
Content-Disposition: inline
In-Reply-To: <1427385240-6086-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:53:49PM +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 0e4ad7c..c735ac4c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -402,7 +402,7 @@ static void handle_thermal_trip(struct thermal_zone_d=
evice *tz, int trip)
>  }
> =20
>  /**
> - * thermal_zone_get_temp() - returns its the temperature of thermal zone
> + * thermal_zone_get_temp() - returns the temperature of a thermal zone
>   * @tz: a valid pointer to a struct thermal_zone_device
>   * @temp: a valid pointer to where to store the resulting temperature.
>   *
> --=20
> 2.1.4
>=20

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVIzd1AAoJEMLUO4d9pOJW3J4H/2K5ZfpXe2W2lLGABdar5/tq
287oEzYOWA2v8Gpk850oTPB552n9ynTpxJk+W11rXQMihwyv4ZEK/koBCpiWJVGA
lDYh0bh6t9J6TClGqPIk/gO6T3N93dgDVHuiRbONknMBfbo4dzZyA4K+d5WT9bUv
Y/7X+WlJAoDFBgiLPhRISy8jKOloMOGHc5lV8z7VjXABt74H4Pyqw7M2SFwHaxx7
o2S55x0C6Z4N2XAZce50/C2rDWYuTeuGSoTAZ3PBjjLiWkx9Cf0Xz3JD0LBxogxI
xJgww9XWXn9GnlCsj3kEWQ20cgbt1YAM9HjRAL22rWiYmEVn0XAQUWv5dZIErmk=
=9Jxc
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
