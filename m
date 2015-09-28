From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] fix handling bq27xxx_read result
Date: Mon, 28 Sep 2015 10:57:05 +0200
Message-ID: <201509281057.05307@pali>
References: <1443430287-575-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1847815.4eCdhqXIaL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37768 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbbI1I5I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2015 04:57:08 -0400
In-Reply-To: <1443430287-575-1-git-send-email-a.hajda@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>

--nextPart1847815.4eCdhqXIaL
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 28 September 2015 10:51:27 Andrzej Hajda wrote:
> The function can return negative value.
>=20
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
>=20
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
>=20
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/power/bq27xxx_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/bq27xxx_battery.c
> b/drivers/power/bq27xxx_battery.c index 473aa2f..994c78d 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -691,7 +691,7 @@ static bool bq27xxx_battery_dead(struct
> bq27xxx_device_info *di, u16 flags) */
>  static int bq27xxx_battery_read_health(struct bq27xxx_device_info
> *di) {
> -	u16 flags;
> +	int flags;
>=20
>  	flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, false);
>  	if (flags < 0) {

Seems legal change, so

Acked-By: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1847815.4eCdhqXIaL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlYJAOEACgkQi/DJPQPkQ1KHYgCfYKbi1sHPHWJ6eHXJgzXdr9h4
/UUAn184LLK1kXy5dpCsGxgF/sufndQu
=Z+JE
-----END PGP SIGNATURE-----

--nextPart1847815.4eCdhqXIaL--
