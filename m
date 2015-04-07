From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 03/13] thermal: remove useless call to
 thermal_zone_device_set_polling
Date: Mon, 6 Apr 2015 19:56:32 -0700
Message-ID: <20150407025630.GJ4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ELVYuRnMxQ5nnKRy"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33717 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbbDGC4Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 22:56:24 -0400
Content-Disposition: inline
In-Reply-To: <1427385240-6086-4-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--ELVYuRnMxQ5nnKRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:53:50PM +0100, Sascha Hauer wrote:
> When the thermal zone has no get_temp callback then thermal_zone_device_r=
egister()
> calls thermal_zone_device_set_polling() with a polling delay of 0. This
> only cancels the poll_queue. Since the poll_queue hasn't been scheduled t=
his
> is a no-op. Remove it.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

This seams reasonable to me:

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  drivers/thermal/thermal_core.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index c735ac4c..dcea909 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1571,9 +1571,6 @@ struct thermal_zone_device *thermal_zone_device_reg=
ister(const char *type,
> =20
>  	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
> =20
> -	if (!tz->ops->get_temp)
> -		thermal_zone_device_set_polling(tz, 0);
> -
>  	thermal_zone_device_update(tz);
> =20
>  	return tz;
> --=20
> 2.1.4
>=20

--ELVYuRnMxQ5nnKRy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVI0dbAAoJEMLUO4d9pOJWyJUH/3UW3Qgs/KAdwlNTi/tyznph
IGl/Ga/Un738jNoPn2LQXhSjRho+XGGaDQ1wCk7SDaaujp3FYsmU5coordDbPMsi
YBN4kmGJQeBIzt5hXLVw1Ex7Q4gY+K7bo5bCqX5dvu4pLIwjBBK3SOHq/8PUe9RM
2jOR8FFBH/Nvfqg99sWrtvetHAcM9A8bAwQQlo6zwNO+A/BbnS/YSvQr+CmNbcMv
aXiXugniDaugitUhcGpoXQ33i+lKjivCHJ5lf+sABr8z8ibKktkmujNLeIKfePbs
AtvkYqZJIgOsEgbdF8rH4AbKxz7K79/J9xnri6fE7s9GvU942MtSBeSUutmad4o=
=YAEk
-----END PGP SIGNATURE-----

--ELVYuRnMxQ5nnKRy--
