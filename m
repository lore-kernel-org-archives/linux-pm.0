Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712B449EB2;
	Fri, 24 Jul 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934448; cv=pass; b=nH5w4ok/91n6zRtCcReA6eRoayj0NwsYVIZSPBiId+PoLBXqoopxPVf3v/3BESSITo5Jum5yXerB1hnQ/4GrWoaeyoFV7ubDyOhfj/xt7xNgmhMjJRmxhX7XBrw6l4eV9ooHQg9hHvT2aK6TKPeXTrcdaap2uJcuJb61CNqPk/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934448; c=relaxed/simple;
	bh=POSyp7/AzPCrYbFMudCHYxJz8x3pBogPCCl8rwuzgXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob3D+2iM4wiXfBvxIXa1zsLIJmHE6k2OVmIIsPNP0TbX7UfUHkLqlyhx1aIjaPioFwaTznHwk+QFllC4UJizLGglegx5nsg6OFYdhyeIKHrILt5ybvEpiv6RKS2tRYxEvg1ba/z/pw57khe08fiETUwUPJW/uCRtR8QwtKxiIwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=d/YaRts2; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="d/YaRts2"
ARC-Seal: i=1; a=rsa-sha256; t=1784934418; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PIsoldVCNl8KNqkvvugErXsTK4GlbDWR7BWGHZiP5qLOdFOj3lP8mriQj3+H6EJMvvYM0pxJfe3IVn+dFdzuwhtLYAlr7s/IT/9UyhQ2WgTZni+vlBzuNQgwEuHk4gYCA54AcyPZp/26iPqcYLOh9uwfbN+rJX1n2W6Kw1TdztA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784934418; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eNHyd/euFTVrkS4fN2LnO/aDM3esBeFYAWolCNxzNnY=; 
	b=S4xVDq5xV/fHFZm1TbvWJ9In2K7OgS1Auv0P4MKHM8H9yBptuAJ4zJsKURyaTmO2k1dJPgROlV0J411J6DPmLO0yKSLvd1tWTFelyCF21FtR/J/aZ+ddRP11vhWbD5XOD6wsUo6BqPlfaIOWl8W4EZkFo1O8cNNYCtMwDKgY5WI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784934418;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=eNHyd/euFTVrkS4fN2LnO/aDM3esBeFYAWolCNxzNnY=;
	b=d/YaRts21p7y2/UkMf7jhwRLbS0e5QvialBxQeE7WsOsVYOgqJBTbD0va2afsTZ4
	BtLIccGY1t5FSD6okURWBwBRGKOREBZ/zyp785azWgAXl5A/osFjxs8s/kXl5dH5Iya
	Z+zLfNaOc+TO4Pm4mYjQmjukmU62Wc2iur+TdQfk=
Received: by mx.zohomail.com with SMTPS id 1784934417201371.1223292984564;
	Fri, 24 Jul 2026 16:06:57 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 1B93B181F16; Sat, 25 Jul 2026 01:06:54 +0200 (CEST)
Date: Sat, 25 Jul 2026 01:06:53 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jianing Li <m13940358460@163.com>
Cc: Iskren Chernev <me@iskren.info>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Matheus Castello <matheus@castello.eng.br>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: max17040: propagate register read errors
Message-ID: <amPv06CIZIELsv6w@venus>
References: <20260724094759.3568-1-m13940358460@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t34zahgebrdsvas4"
Content-Disposition: inline
In-Reply-To: <20260724094759.3568-1-m13940358460@163.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.919.37
X-ZohoMailClient: External


--t34zahgebrdsvas4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: max17040: propagate register read errors
MIME-Version: 1.0

Hi,

On Fri, Jul 24, 2026 at 05:47:59PM +0800, Jianing Li wrote:
> max17040_get_vcell() and max17040_get_soc() ignore errors returned by
> regmap_read().  When an I2C transfer fails, the uninitialized register
> value is converted and reported to userspace as a valid voltage or state
> of charge.  The polling worker can also replace the cached state of charge
> with the bogus value and emit a spurious change event.
>=20
> Propagate read errors through the power supply get_property callback and
> keep the last valid cached state of charge when polling fails.
>=20
> Fixes: c6f4a42de60b ("Add MAX17040 Fuel Gauge driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jianing Li <m13940358460@163.com>
> ---
>  drivers/power/supply/max17040_battery.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index e94d53b36aa4..948670fb6c4a 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -192,19 +192,21 @@ static int max17040_raw_vcell_to_uvolts(struct max1=
7040_chip *chip, u16 vcell)
>  static int max17040_get_vcell(struct max17040_chip *chip)
>  {
>  	u32 vcell;
> +	int ret;
> =20
> -	regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
> +	ret =3D regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
> =20
> -	return max17040_raw_vcell_to_uvolts(chip, vcell);
> +	return ret ? ret : max17040_raw_vcell_to_uvolts(chip, vcell);

Please follow the common convention, i.e.

ret =3D foo();
if (ret)
    return ret;

return bar();

Greetings,

-- Sebastian

--t34zahgebrdsvas4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpj8AkACgkQ2O7X88g7
+pqiRg//Zug3MEhye5rhHIX32jPPiqHFK0y1VPdrRBu9yIK4ALHTK7VVn+3NKwil
JzxVGA38QgyqyntRyG2t9G8FL1/srjIOBtxifEwJX3E8TLhrfpq71dZBVdJWxMkO
Xa/wibdfX73YoqQxMsGxV/agFiYdXgLmFUjFW6fqk6LSa1bFJqEboWMBtOZt/Tc4
UMUuAHe8S/nRun2WDMBBV7yu53MClJU2jSLL91WurgtRJzYPXwkdocaGY8iztIWN
MQR+V4JIqPAw3CwjrJvcRSt3ktTueqm8cFz/LW15Xn+0AUP0qjpbnDdF88/t9frl
Ll+g5La9jMiRqQxViEdekaola0LJjrSeosB4HFGAJQ69DTTVPf9MDH4BA4iW1kqJ
dprNb6X9w117wVc3wHXJO6wS5/MCDYX+vPQjIz21GHLOeG4jyYkg2Fi2XVaICD8R
6E+a2g5b+9UeTGCHx7uHdwU3NdmgrEwwCKcO6qneYUYNfU2TcVHDESpxYrm1eIbM
8fRhpgdQS3TxyVFXiVFPz0kFMDTWCKys0GO7HETdMWOxmeV50Tr/nMRbYLrfJMFH
Pah70ftLkUlNakYCW+KVbWNG5rwWsniJqmIDk1ycf6hPeZlwRqyr8mCq7ce2EavZ
/Ud8XJ6xIri9IHQBbqJLOV+z3WolHq+i58iXHtTMvfQJynHTgrg=
=/ufL
-----END PGP SIGNATURE-----

--t34zahgebrdsvas4--
