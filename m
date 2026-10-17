Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F61377A80;
	Sat, 17 Oct 2026 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280461; cv=pass; b=ptQkLkwrJ5UvgkD8a2oW6yNgNTocqsq09X43HZuGu84u1PUZUZiAuDsenfSPLjHXfRWRlDYhgM97mA4+3Z2iqKup4jteZ5UptYdDYs3U0acMZXtz0AoWdv+L0mMi+QNxaaOH4DGPRzUmsg30BdzyblifHUZMcghlm90M01nTLyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280461; c=relaxed/simple;
	bh=HKCE5kSx8rfPKOvH0oLMIpJGr0H+NJ1B31iLq4QZBMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/Y1SNbNXNtS6wuAiRCpUIEHfq1js6/TV4ooifhJsbs2r29feEoDWw9hkJ8UnRkG75hFyvNusazZewYX9nsVMxljFj0ybVFPYwzmwYRFTVGyF49++V2KPP+KHDkvIOOIjSsCGQcdyvl+gChFOK7CBBetQpw/UnAGduw+fjk5wdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Ugb6gcFt; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Ugb6gcFt"
ARC-Seal: i=1; a=rsa-sha256; t=1792280456; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dRznbVqJcd2Yyo5yUCoEXJtsyl/tZCagv/aQlld3AGqiO3f7Ysj6Gj6B++UFCsJVJkOvqfScuHI3uUlBFe28un6WfaGQU6a6dOrl06jZCdsVkrWWSY2nIehEapyS7gFKjeD3Be0fQZ9VrmrsdjkyvVbiMUImGVX+rtnGH0emm7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792280456; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G+LD6xsNiBTNSUcEMt9t/Ej7njPOEIyzHTwNSY6PgZc=; 
	b=IXbcKP3WnsRTYPfxxzW6hi/nSjFgaCZbJjSDFGFoTG/96w3FOyDZpAE0DJJNaBoA5D9Ja4S6Mrje5Zwnkm28C3Kuq5ezzatI+J3fBAmMR4ZyyKSrTbxSnGDAJh0qdXeTIzQRVtVroQPld3Anl75TC0aG7mfvhAjWd3kHCSpXr2c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792280456;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=G+LD6xsNiBTNSUcEMt9t/Ej7njPOEIyzHTwNSY6PgZc=;
	b=Ugb6gcFtkRsbJtdSvTQnxIUm8C2n9kBx8ma6bVrcO3eun2tPDii7IAqfy2OFF+VL
	hMf3Trmv7oduwE0JJbb//IvpIZKeokRnoxgWbQDeG+G9l4fTuqaT9XfZBdpB7jvPwMR
	61Gjzl/aPtT3MHnqZCOnO3bIVLqrIaRbqWwTO9QM=
Received: by smtp.zohomail.com with SMTPS id 1792280453389574.9724940157063;
	Sat, 17 Oct 2026 16:40:53 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 0A445182317; Sun, 18 Oct 2026 01:40:51 +0200 (CEST)
Date: Sun, 18 Oct 2026 01:40:51 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: iav@iav.lv
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: gpio-charger: Report not charging without
 input power
Message-ID: <atQGuQPnMCwJvCtg@venus>
References: <20261008-gpio-charger-offline-v1-1-78740b558402@iav.lv>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pd4l5pl67qk6df45"
Content-Disposition: inline
In-Reply-To: <20261008-gpio-charger-offline-v1-1-78740b558402@iav.lv>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.264.81
X-ZohoMailClient: External


--pd4l5pl67qk6df45
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: gpio-charger: Report not charging without
 input power
MIME-Version: 1.0

Hi,

On Thu, Oct 08, 2026 at 04:27:29AM +0300, Igor Velkov via B4 Relay wrote:
> From: Igor Velkov <iav@iav.lv>
>=20
> The status property follows only the charge-status GPIO. Without input
> power a charger such as the BQ24133 releases its open-drain STAT pin,
> and depending on the board the GPIO then reads as charging.
>=20
> On Kobol Helios64 the board runs from its battery after a mains loss,
> and the charger reports online 0 with status "Charging".
>=20
> Report "Not charging" whenever the online GPIO is present and inactive.
>=20
> Tested on Helios64: on battery the status now reads "Not charging".
>=20
> Assisted-by: LLM
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---

Not charging means that the battery neither charges nor discharges.
I.e. the system runs from external power. So without the charger
being online, this should be POWER_SUPPLY_STATUS_DISCHARGING.

Also please add a Fixes tag.

Greetings,

-- Sebastian

>  drivers/power/supply/gpio-charger.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/g=
pio-charger.c
> index 2504190eba82..2fdff5f8b5ad 100644
> --- a/drivers/power/supply/gpio-charger.c
> +++ b/drivers/power/supply/gpio-charger.c
> @@ -101,7 +101,10 @@ static int gpio_charger_get_property(struct power_su=
pply *psy,
>  		val->intval =3D gpiod_get_value_cansleep(gpio_charger->gpiod);
>  		break;
>  	case POWER_SUPPLY_PROP_STATUS:
> -		if (gpiod_get_value_cansleep(gpio_charger->charge_status))
> +		/* Without input power the charger cannot charge, whatever its status =
pin says */
> +		if (gpio_charger->gpiod && !gpiod_get_value_cansleep(gpio_charger->gpi=
od))
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		else if (gpiod_get_value_cansleep(gpio_charger->charge_status))
>  			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>  		else
>  			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>=20
> ---
> base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
> change-id: 20261008-gpio-charger-offline-cf51542a10ef
>=20
> Best regards,
> --=20
> Igor Velkov <iav@iav.lv>
>=20
>=20

--pd4l5pl67qk6df45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrUB3AACgkQ2O7X88g7
+pqswQ/4v+h7Z5Zkwwzm8ym3407QDtsbjiStivpR8VQNUirmH08lcr5Aa574xREP
rQPeNsTrVxkpcue+6W7EM76X1fMTzXPJQneEcMhDYezGrivMZ9Wqn8eGoXtK43D2
ludnHE1cGZ6qdgLWHnFYFDFR4Ie0h+9oQ7izI/KUnDrGRzK2FBvCsZzH4cqQx0af
S1BHEydDckpbI250koa+Kh7HBALOZ5J3YmTjGUBCA6oVck78C5g8Z3CUI/Z46gCm
izbYr0LrmoP52Zwl/Zp0tAwzzIKBamnP+abOmFflK2023RjVAPCsleFXRUXVHTiM
gr640v99LYeEU4371G/Ghoe7LuKjmsels/QsOT6j55bBTC4Zcdht9naN9X9QRF5d
uEpMz2DuDdOxvYyoJ62jB0iIXHu8jazOctGS6YisQkz5UrkdHarG9KGGYhlnEbmL
kD6ljBeDyCxgrU4whyRKzDZGiz6dMK5JFlsWGPu4KbuJKRbKACUk/0cGeqxzqQjb
ztOeqszqxnm7xlVuNVL/4EsGSjVAvmIVdYIcRfpzx+USJkZxpMYJe6/XoAjnmN2a
pPC3CZbDk9EIgxJ831J/M42jzLI4tVu0HG8QTm5o7jqRDEE4ca4crBUsavAHUFYB
fMvXMMcYArm7NIfZFb0lMqrrDtapuFG8r5bayY+NmxyhKoSCiA==
=U8V2
-----END PGP SIGNATURE-----

--pd4l5pl67qk6df45--
