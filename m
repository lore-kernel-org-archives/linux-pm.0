Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0B582B83;
	Wed,  9 Sep 2026 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990362; cv=pass; b=CJ31w6ac2Dh5UDx8Y0PK3SDwr8+FZf+PL8/BLuRJGGKS7wRmIn29evxd3PPDOUWRvcaPgTH0pJp6otIG4Y1jHbotABvT0LROsY9mpiGWo+k9v9586OkwQn9Z0LW0BC2CiKfJ0dy19k3dbx6NXVInd0mgmnUvNlECWvX5XJQe9yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990362; c=relaxed/simple;
	bh=jij9aMph/IM95aHFu70eR5G5nPikq10auLTjH1QNrb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCkHeLb8pK0+7mN7hIpIjQqZZaE8T88QOaZpCfwQbXyN4sisYW/652u2pjO2F+Pkfc4Fwk5mhJBv5nNk2gQ4pWNXQ6/Q2IO20++Slg5aCQVr4AdaWuP4qJg0MHzOB0cXF7nfDQ7CJkpb/rHhPeRt71vf/0cYS08v7fJRI2U/eSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=WDRhuCYQ; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="WDRhuCYQ"
ARC-Seal: i=1; a=rsa-sha256; t=1788990353; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eeVkjlUkIs7JXlpiZUF02SUptNqMuLSjuwJSj/63APeJOSXMYFIuPMGpkMZ8qyBxmleRCw0CfzKjfsZDZqMLbFx3g3Gkoz1Av+c9MTBuHf/VnRGPRNv34LweXQTLMfSwO3R3q4D0SDG/CQ8G68LHFybcw8824jLD12FbsYk62nU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788990353; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jij9aMph/IM95aHFu70eR5G5nPikq10auLTjH1QNrb8=; 
	b=eMqj73CzY5ZTIEnNGbnVotyTRWVxVLvf+bb+j5NAwI037dG5FVV2ba5JrTxtJwlApEqcZ2Z/MDKIzuEvfhqzljG3FLVH30vgXfXDQYGpnH8yrXANzE8zZFz3FzA2mVpSev6jLnhNjM4aCjaDEhdRDPhyfmAhsoa5MXICrnp2KJ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788990353;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=jij9aMph/IM95aHFu70eR5G5nPikq10auLTjH1QNrb8=;
	b=WDRhuCYQ6O/vYOo3C6f7lxBdhPJZGiP84uIbCm0QbHAyNhiYCVK4nCZgl9tKMyq2
	oWbvVbaXepHa1i6meAOUJ0PCvNd3udR1/akJTWwJkBMK7lkAxi4g1iJ7whj6AEcvVz2
	BHlo42PD1EczR+2FSuW1ojJB8XojUyVsloT1/mJs=
Received: by mx.zohomail.com with SMTPS id 1788990352817584.2100600651606;
	Wed, 9 Sep 2026 14:45:52 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 0C7D5183377; Wed, 09 Sep 2026 23:45:50 +0200 (CEST)
Date: Wed, 9 Sep 2026 23:45:50 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Yang Zi <2959243019@qq.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq256xx: fix uninitialized battery info
 pointer in bq256xx_hw_init
Message-ID: <aqHTVHiQKaeArxwt@venus>
References: <tencent_FEA132DE8F67C73343A948D94E5ED262F608@qq.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vp6ia2e2glk5o6n5"
Content-Disposition: inline
In-Reply-To: <tencent_FEA132DE8F67C73343A948D94E5ED262F608@qq.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.982.46
X-ZohoMailClient: External


--vp6ia2e2glk5o6n5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: bq256xx: fix uninitialized battery info
 pointer in bq256xx_hw_init
MIME-Version: 1.0

Hi,

On Tue, Aug 25, 2026 at 05:06:26PM +0800, Yang Zi wrote:
> In bq256xx_hw_init(), the local pointer `bat_info` is passed to
> power_supply_get_battery_info() without being initialized. When that
> function fails with an error other than -ENOMEM it does not set the
> output pointer, yet the code went on to dereference it while applying
> "default" values, leading to a general protection fault (NULL
> dereference).
>=20
> Initialize the pointer to NULL and return the error immediately instead
> of dereferencing an uninitialized pointer. The battery information is
> only used on the success path, where it is guaranteed to be valid.
>=20
> Signed-off-by: Yang Zi <2959243019@qq.com>
> ---

This does not apply:

Patch failed at 0001 power: supply: bq256xx: fix uninitialized battery info=
 pointer in bq256xx_hw_init
error: corrupt patch at line 6

Greetings,

-- Sebastian

> diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/suppl=
y/bq256xx_charger.c
> index 4b1f81b1ed86..6a5f73bcb928 100644
> --- a/drivers/power/supply/bq256xx_charger.c
> +++ b/drivers/power/supply/bq256xx_charger.c
> @@ -1556,7 +1556,7 @@ static int bq256xx_power_supply_init(struct bq256xx=
_device *bq,
> =A0
> =A0static int bq256xx_hw_init(struct bq256xx_device *bq)
> =A0{
> -=A0 =A0 struct power_supply_battery_info *bat_info;
> +=A0 =A0 struct power_supply_battery_info *bat_info =3D NULL;
> =A0 =A0 =A0int wd_reg_val =3D BQ256XX_WATCHDOG_DIS;
> =A0 =A0 =A0int ret =3D 0;
> =A0 =A0 =A0int i;
> @@ -1581,33 +1581,14 @@ static int bq256xx_hw_init(struct bq256xx_device =
*bq)
> =A0 =A0 =A0if (ret =3D=3D -ENOMEM)
> =A0 =A0 =A0 =A0 =A0return ret;
> =A0
> -=A0 =A0 if (ret) {
> -=A0 =A0 =A0 =A0 dev_warn(bq->dev, "battery info missing, default values =
will be applied\n");
> -
> -=A0 =A0 =A0 =A0 bat_info->constant_charge_current_max_ua =3D
> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->chip_info->bq256xx_def_ichg;
> -
> -=A0 =A0 =A0 =A0 bat_info->constant_charge_voltage_max_uv =3D
> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->chip_info->bq256xx_def_vbatreg;
> -
> -=A0 =A0 =A0 =A0 bat_info->precharge_current_ua =3D
> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->chip_info->bq256xx_def_iprechg;
> -
> -=A0 =A0 =A0 =A0 bat_info->charge_term_current_ua =3D
> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->chip_info->bq256xx_def_iterm;
> +=A0 =A0 if (ret)
> +=A0 =A0 =A0 =A0 return ret;
> =A0
> -=A0 =A0 =A0 =A0 bq->init_data.ichg_max =3D
> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->chip_info->bq256xx_max_ichg;
> +=A0 =A0 bq->init_data.ichg_max =3D
> +=A0 =A0 =A0 =A0 bat_info->constant_charge_current_max_ua;
> =A0
> -=A0 =A0 =A0 =A0 bq->init_data.vbatreg_max =3D
> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->chip_info->bq256xx_max_vbatreg;
> -=A0 =A0 } else {
> -=A0 =A0 =A0 =A0 bq->init_data.ichg_max =3D
> -=A0 =A0 =A0 =A0 =A0 =A0 bat_info->constant_charge_current_max_ua;
> -
> -=A0 =A0 =A0 =A0 bq->init_data.vbatreg_max =3D
> -=A0 =A0 =A0 =A0 =A0 =A0 bat_info->constant_charge_voltage_max_uv;
> -=A0 =A0 }
> +=A0 =A0 bq->init_data.vbatreg_max =3D
> +=A0 =A0 =A0 =A0 bat_info->constant_charge_voltage_max_uv;
> =A0
> =A0 =A0 =A0ret =3D bq->chip_info->bq256xx_set_vindpm(bq, bq->init_data.vi=
ndpm);
> =A0 =A0 =A0if (ret)
>=20
>=20
>=20

--vp6ia2e2glk5o6n5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqh04YACgkQ2O7X88g7
+pq59xAAnEoMbqjAxCnvDvMBgQ368GlS3phxoxr6A3KW7yvQMTrkrdBTKs8Dop0T
hqpIQlw/anFYLVv3tZZjJX6sRVXb7eNng1oHF/OYwX4lfXvYjBF4YVH4STeEycUL
qlN09X+wTBW0+3OeDS911EUdEbFz39DGqpRwNrmXVwoOKe/KjODJCtmwajE/cto4
extZWieywSP/akFug5dRYGg+j66JcTPwOHlQuunBEFSOrpDxP+wS7R4ZjqyzntNv
cQyHmiyuYXG10BhUpdnw25N3/Y6VWPeGTFqAcCsTKl4Dqj6Ojyt3MQ7GN0EooW2v
ayFCyJkxBhavKy/fmyYKRrcQU4FitXkk9p6wkAYDlHcJ9Dy/jgJ05fyAmSd8geiG
sBnwkJ7tkMCj1M/+N4QmRypVgZZupAfyo1Wvcp02FxCSmEJJwmgR/GJDyo1ptAbW
daBD4Sxv7HflMbk/p0skSQ/cr3VysVsM7gEnebGiIunpBOYaYjkh1pnE+ZP8YpwY
6rUZDH3NZXXpj/VLNdjOt8q2+Jya+pvo59dpgxV8zWGJqjQj5hBTj71AASYF0nK/
RcYqHGoNHAtsdU0WSMiTlMJ1/LupUDc/azHPGo8+xHJFM6VKHIKAQpU/VwXl8Y9q
jlPJK/MhToirw1IuJD6uSxSFMpiQjJ46rE+U1/3QNYD+90/7GUk=
=0ZdS
-----END PGP SIGNATURE-----

--vp6ia2e2glk5o6n5--
