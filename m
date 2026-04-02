Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7841935F600;
	Thu,  2 Apr 2026 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168914; cv=pass; b=c9NhW/NwlD8Cd9ZVizfQVYVVwbjd0l/XpXddJ+/31NCEMUz+r1/V61HnM/6rQCcm1VNcgkp4/v0ReCN+jCuRl8KspLjo78U3YMJf8t1+GMVGyiKgb5W6ByQK6jviQnz2tABg8CNQk1DD78jZoLySDFk/zU8FlPs0GUwz6UuIHcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168914; c=relaxed/simple;
	bh=cWzhn33xN51nFRRVvV+KNBhpCFESH6n3aNwLqKxIu0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlXamX1LBbh+bW1c6X/ABMwbEwiL/209wp+If4Ao+mYYUENe0FEDse1vNZvfWu9dGvxMOmbx0vr/VhI19Y9ID2YfiULgVVvjRvnplXz/iDDBBBWFzzSm0zfGM6Ik8t8s55ufsJwAqy18o2MOxfNHX111jnEjgSkfOGmStC555aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=OrPGrj6H; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="OrPGrj6H"
ARC-Seal: i=1; a=rsa-sha256; t=1775168906; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X4VT53uawtnjS1Niwvm5ZXCp/7cNdPRHYjAqgi0fd/Y+Sf+bHMXUaeFwLxvUozbSyIOV6uyGygXwqtGZIybHzh/s9XEho1tuoXBX01AnSKptTNua0/nZyJVYi9Cilps8UBSSt6rK8pQkNEYTHWmJZFCLy69tRozPV2q1OgbZkmE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775168906; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FkxMUYx+N68uEm8Mh0vleqxZg/nlV5YrzMF+2ER7ebo=; 
	b=NA46oTftH2KOo5VVC4u4KMrA3DMqf7+mlJiCh1CbSIOXHP+9zYGEKOFVhhTrAy72ZCP0j5GVTpbzOB6F1ZUhJUwZ5Ozp7lPODet2iE+337fpY1nzGjr3lWO+Zd/p5jBsd4ylIybu9rgwbZ3LqaOBx2TAEriAU9pSLzTw3Dlq7qI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775168906;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=FkxMUYx+N68uEm8Mh0vleqxZg/nlV5YrzMF+2ER7ebo=;
	b=OrPGrj6H1ZF2YPsCwWSKm38HhIOjBd1lBJENb6dCnBCKn2TOUZ/H/V/cxvQbbQ7U
	xunz6FU1mOWGj4i8fFwsZlf74Ug7M9kBtPkauSYBqaX8Ltl+TPoFFzNjnXnkQDJFMEn
	GhiJXaHdSVYM3kFwbrJOip0QY9LsIgLh63+n4Tfg=
Received: by mx.zohomail.com with SMTPS id 1775168905106236.55627358469133;
	Thu, 2 Apr 2026 15:28:25 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 067321812B4; Fri, 03 Apr 2026 00:28:22 +0200 (CEST)
Date: Fri, 3 Apr 2026 00:28:21 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: amitsd@google.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: [PATCH] power: supply: max77759_charger: fix voltage scale (mV
 -> uV)
Message-ID: <ac7s4IzdF1KGu1mO@venus>
References: <20260402-fix-psy-max77759-usb-next-v1-1-427f5af566c3@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dx6jhw4hlgbh6bru"
Content-Disposition: inline
In-Reply-To: <20260402-fix-psy-max77759-usb-next-v1-1-427f5af566c3@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.1.0.1.4.3/275.137.35
X-ZohoMailClient: External


--dx6jhw4hlgbh6bru
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: max77759_charger: fix voltage scale (mV
 -> uV)
MIME-Version: 1.0

Hi,

On Thu, Apr 02, 2026 at 07:15:29AM +0000, Amit Sunil Dhamne via B4 Relay wr=
ote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> CONSTANT_CHARGE_VOLTAGE_MAX property incorrectly uses mV instead of uV.
> Add fix to use uV as per the power-supply subsystem convention.
>=20
> Also, add a note indicating all the properties use non negative values.
> A negative value indicates failure with the appropriate error value. In
> that case, it should not be taken as a measurement value or status.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
> This patch is a follow-up to the series [1]. [1] has been accepted in
> the USB subsystem tree (usb-next). However, since Sebastian has additional
> feedback [2], I am sending this patch to address it. Please note that this
> patch is based out of usb-next branch on usb tree. This patch should be
> applied on top of 70d7dd27f6dc ("power: supply: max77759: add charger dri=
ver").
>=20
> [1] https://lore.kernel.org/all/20260325-max77759-charger-v9-0-4486dd297a=
dc@google.com/
> [2] https://lore.kernel.org/all/ac2jYUA2F5oQsA2g@venus/#t
> ---

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

> Output of power supply selftest:
> root@google-gs:/data/power_supply# ./test_power_supply_properties.sh
> TAP version 13
> 1..66
>  # Testing device max77759-charger
> ok 1 max77759-charger.exists
> ok 2 max77759-charger.uevent.NAME
> ok 3 max77759-charger.sysfs.type
> ok 4 max77759-charger.uevent.TYPE
> ok 5 max77759-charger.sysfs.usb_type # SKIP
>  # Reported: '1' ()
> ok 6 max77759-charger.sysfs.online
>  # Reported: '1' ()
> ok 7 max77759-charger.sysfs.present
>  # Reported: 'Charging'
> ok 8 max77759-charger.sysfs.status
> ok 9 max77759-charger.sysfs.capacity # SKIP
> ok 10 max77759-charger.sysfs.capacity_level # SKIP
> ok 11 max77759-charger.sysfs.model_name # SKIP
> ok 12 max77759-charger.sysfs.manufacturer # SKIP
> ok 13 max77759-charger.sysfs.serial_number # SKIP
> ok 14 max77759-charger.sysfs.technology # SKIP
> ok 15 max77759-charger.sysfs.cycle_count # SKIP
> ok 16 max77759-charger.sysfs.scope # SKIP
>  # Reported: '3000000' uA (3000 mA)
> ok 17 max77759-charger.sysfs.input_current_limit
> ok 18 max77759-charger.sysfs.input_voltage_limit # SKIP
> ok 19 max77759-charger.sysfs.voltage_now # SKIP
> ok 20 max77759-charger.sysfs.voltage_min # SKIP
> ok 21 max77759-charger.sysfs.voltage_max # SKIP
> ok 22 max77759-charger.sysfs.voltage_min_design # SKIP
> ok 23 max77759-charger.sysfs.voltage_max_design # SKIP
> ok 24 max77759-charger.sysfs.current_now # SKIP
> ok 25 max77759-charger.sysfs.current_max # SKIP
> ok 26 max77759-charger.sysfs.charge_now # SKIP
> ok 27 max77759-charger.sysfs.charge_full # SKIP
> ok 28 max77759-charger.sysfs.charge_full_design # SKIP
> ok 29 max77759-charger.sysfs.power_now # SKIP
> ok 30 max77759-charger.sysfs.energy_now # SKIP
> ok 31 max77759-charger.sysfs.energy_full # SKIP
> ok 32 max77759-charger.sysfs.energy_full_design # SKIP
> ok 33 max77759-charger.sysfs.energy_full_design # SKIP
>  # Testing device tcpm-source-psy-1-0025
> ok 34 tcpm-source-psy-1-0025.exists
> ok 35 tcpm-source-psy-1-0025.uevent.NAME
> ok 36 tcpm-source-psy-1-0025.sysfs.type
> ok 37 tcpm-source-psy-1-0025.uevent.TYPE
>  # Reported: 'C [PD] PD_PPS PD_SPR_AVS PD_PPS_SPR_AVS' ()
> ok 38 tcpm-source-psy-1-0025.sysfs.usb_type
>  # Reported: '1' ()
> ok 39 tcpm-source-psy-1-0025.sysfs.online
> ok 40 tcpm-source-psy-1-0025.sysfs.present # SKIP
> ok 41 tcpm-source-psy-1-0025.sysfs.status # SKIP
> ok 42 tcpm-source-psy-1-0025.sysfs.capacity # SKIP
> ok 43 tcpm-source-psy-1-0025.sysfs.capacity_level # SKIP
> ok 44 tcpm-source-psy-1-0025.sysfs.model_name # SKIP
> ok 45 tcpm-source-psy-1-0025.sysfs.manufacturer # SKIP
> ok 46 tcpm-source-psy-1-0025.sysfs.serial_number # SKIP
> ok 47 tcpm-source-psy-1-0025.sysfs.technology # SKIP
> ok 48 tcpm-source-psy-1-0025.sysfs.cycle_count # SKIP
> ok 49 tcpm-source-psy-1-0025.sysfs.scope # SKIP
> ok 50 tcpm-source-psy-1-0025.sysfs.input_current_limit # SKIP
> ok 51 tcpm-source-psy-1-0025.sysfs.input_voltage_limit # SKIP
>  # Reported: '5000000' uV (5 V)
> ok 52 tcpm-source-psy-1-0025.sysfs.voltage_now
>  # Reported: '5000000' uV (5 V)
> ok 53 tcpm-source-psy-1-0025.sysfs.voltage_min
>  # Reported: '5000000' uV (5 V)
> ok 54 tcpm-source-psy-1-0025.sysfs.voltage_max
> ok 55 tcpm-source-psy-1-0025.sysfs.voltage_min_design # SKIP
> ok 56 tcpm-source-psy-1-0025.sysfs.voltage_max_design # SKIP
>  # Reported: '3000000' uA (3000 mA)
> ok 57 tcpm-source-psy-1-0025.sysfs.current_now
>  # Reported: '3000000' uA (3000 mA)
> ok 58 tcpm-source-psy-1-0025.sysfs.current_max
> ok 59 tcpm-source-psy-1-0025.sysfs.charge_now # SKIP
> ok 60 tcpm-source-psy-1-0025.sysfs.charge_full # SKIP
> ok 61 tcpm-source-psy-1-0025.sysfs.charge_full_design # SKIP
> ok 62 tcpm-source-psy-1-0025.sysfs.power_now # SKIP
> ok 63 tcpm-source-psy-1-0025.sysfs.energy_now # SKIP
> ok 64 tcpm-source-psy-1-0025.sysfs.energy_full # SKIP
> ok 65 tcpm-source-psy-1-0025.sysfs.energy_full_design # SKIP
> ok 66 tcpm-source-psy-1-0025.sysfs.energy_full_design # SKIP
>  # 47 skipped test(s) detected.  Consider enabling relevant config option=
s to improve coverage.
>  # Totals: pass:19 fail:0 xfail:0 xpass:0 skip:47 error:0
> ---
>  drivers/power/supply/max77759_charger.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supp=
ly/max77759_charger.c
> index 9bb414599f16..58594bb78426 100644
> --- a/drivers/power/supply/max77759_charger.c
> +++ b/drivers/power/supply/max77759_charger.c
> @@ -26,7 +26,7 @@
> =20
>  /* Default values for Fast Charge Current & Float Voltage */
>  #define CHG_CC_DEFAULT_UA			2266770
> -#define CHG_FV_DEFAULT_MV			4300
> +#define CHG_FV_DEFAULT_UV			4300000
> =20
>  #define MAX_NUM_RETRIES				3
>  #define PSY_WORK_RETRY_DELAY_MS			10
> @@ -61,10 +61,10 @@ static const struct linear_range chgcc_limit_ranges[]=
 =3D {
>  	LINEAR_RANGE(200000, 0x3, 0x3C, 66670),
>  };
> =20
> -/* Charge Termination Voltage Limits (in mV) */
> +/* Charge Termination Voltage Limits (in uV) */
>  static const struct linear_range chg_cv_prm_ranges[] =3D {
> -	LINEAR_RANGE(3800, 0x38, 0x39, 100),
> -	LINEAR_RANGE(4000, 0x0, 0x32, 10),
> +	LINEAR_RANGE(3800000, 0x38, 0x39, 100000),
> +	LINEAR_RANGE(4000000, 0x0, 0x32, 10000),
>  };
> =20
>  /* USB input current limits (in uA) */
> @@ -310,14 +310,14 @@ static int get_float_voltage(struct max77759_charge=
r *chg)
>  	return ret ? ret : val;
>  }
> =20
> -static int set_float_voltage_limit(struct max77759_charger *chg, u32 fv_=
mv)
> +static int set_float_voltage_limit(struct max77759_charger *chg, u32 fv_=
uv)
>  {
>  	u32 regval;
>  	bool found;
> =20
>  	linear_range_get_selector_high_array(chg_cv_prm_ranges,
>  					     ARRAY_SIZE(chg_cv_prm_ranges),
> -					     fv_mv, &regval, &found);
> +					     fv_uv, &regval, &found);
>  	if (!found)
>  		return -EINVAL;
> =20
> @@ -370,6 +370,11 @@ static const enum power_supply_property max77759_cha=
rger_props[] =3D {
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  };
> =20
> +/*
> + * Note: None of the properties in this driver support usage of negative=
 values.
> + * If you do see one, it's because the function is reporting an error va=
lue and
> + * should not be taken as a measurement value or status.
> + */
>  static int max77759_charger_get_property(struct power_supply *psy,
>  					 enum power_supply_property psp,
>  					 union power_supply_propval *pval)
> @@ -557,10 +562,10 @@ static int max77759_charger_init(struct max77759_ch=
arger *chg)
>  		return ret;
> =20
>  	if (power_supply_get_battery_info(chg->psy, &info)) {
> -		fv =3D CHG_FV_DEFAULT_MV;
> +		fv =3D CHG_FV_DEFAULT_UV;
>  		fast_chg_curr =3D CHG_CC_DEFAULT_UA;
>  	} else {
> -		fv =3D info->constant_charge_voltage_max_uv / 1000;
> +		fv =3D info->constant_charge_voltage_max_uv;
>  		fast_chg_curr =3D info->constant_charge_current_max_ua;
>  	}
> =20
>=20
> ---
> base-commit: 81ebd43cc0d6d106ce7b6ccbf7b5e40ca7f5503d
> change-id: 20260402-fix-psy-max77759-usb-next-15a4f86a08ce
>=20
> Best regards,
> --=20
> Amit Sunil Dhamne <amitsd@google.com>
>=20
>=20

--dx6jhw4hlgbh6bru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmnO7YEACgkQ2O7X88g7
+pr9ig/9F9w6eJfG3PUgCOqQcRT+kudS/TQkIq6nvAg6aacY7eZ0AgjGW8swlEgt
0loTiMR2TU2ALt6eSF2Avq2r2+c7yXzcBI0geTJRSCdsZ0gqx4mDG6Z64C9nrH5m
OeBMMZ+Tjqk9L0bw075fDhlUeRAy9jvHMU5k06TGeKYl343YFGB+yJMd7+9mg9rT
gOYCCv9JVvH7t1y3OyREe2f9qPOKH93/0fJPAOh0BmEijEAkQT1mnKLAqJjiyV49
/7Cyy6P+JOQ5fdyfBf+K6cZ8WMyhsM4a8HGOd+qpyWCEtdO+0UQKJZ6oP9QX2HR8
esFn9zkTEHwhsvRrWfYd7F+HjZQgUzRRFTXWL1xbt7xww84/8+VQYSPJAoncG9r0
H+L0Y7lJphSQQ9zQ3UtO8VRRmmO7cPJq/tn4ymOimeNjQZ3a/Ot+93vWsKHljaSo
S/1G42yTpc8Hfc1B0XFkeNRmQTdTciEbLszgVfZKrUh1WAg6p1JtA/6XAXsL6WXS
B1Cf9YeOneeJR1AiVgK3DdjL+7fP4HkNMxr2uWhdLVT8h0zXbCM9epxb4VwxI/rM
0MX8V6tANlBWiBD7RwoDAFdHsRSb3xOni1y97/1d6u6ZvOjIttob2wlDr1QWc9Ic
OGO51COYWxXGnR/14jXRv/duiVNQvkEHe5X+DdPq/yDMsnl/hEc=
=j6ci
-----END PGP SIGNATURE-----

--dx6jhw4hlgbh6bru--
