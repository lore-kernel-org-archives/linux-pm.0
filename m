From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/2] power:bq27xxx: fix reading for bq27000 and bq27010
Date: Fri, 25 Dec 2015 14:20:04 +0100
Message-ID: <201512251420.04591@pali>
References: <cover.1450347172.git.hns@goldelico.com> <deacb36df6842521628c0d324c2c8033733e2cb5.1450347172.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1498204.KtfT7oAkIG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38777 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbbLYNUi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Dec 2015 08:20:38 -0500
In-Reply-To: <deacb36df6842521628c0d324c2c8033733e2cb5.1450347172.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com

--nextPart1498204.KtfT7oAkIG
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 17 December 2015 11:12:53 H. Nikolaus Schaller wrote:
> bug: the driver reports funny capacity values:
>=20
> root@letux:/sys/class/power_supply/bq27000-battery# cat uevent
> POWER_SUPPLY_NAME=3Dbq27000-battery
> POWER_SUPPLY_STATUS=3DCharging
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_VOLTAGE_NOW=3D3702000
> POWER_SUPPLY_CURRENT_NOW=3D-464635
> POWER_SUPPLY_CAPACITY=3D1536			<- over 100% is magic
> POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
> POWER_SUPPLY_TEMP=3D311
> POWER_SUPPLY_TIME_TO_FULL_NOW=3D10440
> POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> POWER_SUPPLY_CHARGE_FULL=3D805450
> POWER_SUPPLY_CHARGE_NOW=3D1068
> POWER_SUPPLY_CHARGE_FULL_DESIGN=3D8844998	<- battery has just 1200 mAh
> POWER_SUPPLY_CYCLE_COUNT=3D21
> POWER_SUPPLY_ENERGY_NOW=3D0
> POWER_SUPPLY_POWER_AVG=3D0
> POWER_SUPPLY_HEALTH=3DGood
> POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
>=20
> reason: the state of charge and the design capacity register are
> single byte only. The design capacity returns the higer order byte.
>=20
> tested: GTA04 with Openmoko/FIC HF08x battery (using hdq)
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/power/bq27xxx_battery.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/bq27xxx_battery.c
> b/drivers/power/bq27xxx_battery.c index 880233c..e54a125 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -471,7 +471,10 @@ static int bq27xxx_battery_read_soc(struct
> bq27xxx_device_info *di) {
>  	int soc;
>=20
> -	soc =3D bq27xxx_read(di, BQ27XXX_REG_SOC, false);
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010)
> +		soc =3D bq27xxx_read(di, BQ27XXX_REG_SOC, true);
> +	else
> +		soc =3D bq27xxx_read(di, BQ27XXX_REG_SOC, false);
>=20
>  	if (soc < 0)
>  		dev_dbg(di->dev, "error reading State-of-Charge\n");
> @@ -536,7 +539,10 @@ static int bq27xxx_battery_read_dcap(struct
> bq27xxx_device_info *di) {
>  	int dcap;
>=20
> -	dcap =3D bq27xxx_read(di, BQ27XXX_REG_DCAP, false);
> +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010)
> +		dcap =3D bq27xxx_read(di, BQ27XXX_REG_DCAP, true);
> +	else
> +		dcap =3D bq27xxx_read(di, BQ27XXX_REG_DCAP, false);
>=20
>  	if (dcap < 0) {
>  		dev_dbg(di->dev, "error reading initial last measured
> discharge\n"); @@ -544,7 +550,7 @@ static int
> bq27xxx_battery_read_dcap(struct bq27xxx_device_info *di) }
>=20
>  	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010)
> -		dcap *=3D BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
> +		dcap =3D (dcap << 8) * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
>  	else
>  		dcap *=3D 1000;

Hi!

This patch fixes commit d74534c27775857cb09abd0f92ed9539dc8d0a93 (power:=20
bq27xxx_battery: Add support for additional bq27xxx family devices) in=20
which this bug (all 3 patch chunks) were introduced.

Before that commit code was very similar after applying this patch. So:

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1498204.KtfT7oAkIG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlZ9QoQACgkQi/DJPQPkQ1K9mQCeNOiWObtzJEkr0KiyMkD7u0Cm
KD8AoIxGV1PFFA4sSGa7cqwC/Pw81C4y
=8b05
-----END PGP SIGNATURE-----

--nextPart1498204.KtfT7oAkIG--
