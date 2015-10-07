From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 3/4] power:bq27x00: don't fill system log by missing battery
Date: Thu, 8 Oct 2015 00:23:14 +0200
Message-ID: <201510080023.14795@pali>
References: <cover.1444243358.git.hns@goldelico.com> <73cb8d96728805597ecb50e7e7b51bf6272b6d61.1444243358.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2063884.UOCKiuylfk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35673 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756592AbbJGWXS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 18:23:18 -0400
Received: by wicge5 with SMTP id ge5so595359wic.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 15:23:16 -0700 (PDT)
In-Reply-To: <73cb8d96728805597ecb50e7e7b51bf6272b6d61.1444243358.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, NeilBrown <neilb@suse.de>

--nextPart2063884.UOCKiuylfk
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 07 October 2015 20:42:38 H. Nikolaus Schaller wrote:
> From: NeilBrown <neilb@suse.de>
>=20
> Print message that battery is not calibrated only during debug build
> but not during normal operation.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/power/bq27x00_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/bq27x00_battery.c
> b/drivers/power/bq27x00_battery.c index 8287261f..709d1e4 100644
> --- a/drivers/power/bq27x00_battery.c
> +++ b/drivers/power/bq27x00_battery.c
> @@ -491,7 +491,7 @@ static void bq27x00_update(struct
> bq27x00_device_info *di) if (cache.flags >=3D 0) {
>  		if (!is_bq27500 && !is_bq27425 && !is_bq27742 && !is_bq27510
>  				&& (cache.flags & BQ27000_FLAG_CI)) {
> -			dev_info(di->dev, "battery is not calibrated! ignoring=20
capacity
> values\n"); +			dev_dbg(di->dev, "battery is not calibrated!
> ignoring capacity values\n"); cache.capacity =3D -ENODATA;
>  			cache.energy =3D -ENODATA;
>  			cache.time_to_empty =3D -ENODATA;

Hi! I think that better approach would be to use WARN_ONCE or similar=20
macro. Still use INFO level, just warn about this problem only once...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2063884.UOCKiuylfk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlYVm1IACgkQi/DJPQPkQ1LMfgCfRFVID4aYMMl8e5tCgdosia1p
DF8AnR9dObkQAkqO58JGY0ewRhsuIarL
=fZ2Q
-----END PGP SIGNATURE-----

--nextPart2063884.UOCKiuylfk--
