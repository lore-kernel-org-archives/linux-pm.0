Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51633B6CC;
	Mon, 22 Jun 2026 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160776; cv=pass; b=GLJWbVgr+KhG+aC77J/RNOHgc4JSqEGdYJlqb4M2cH1Uo+WxTbqX2HgikzQAjN7tTkxwtn6OwDuumPYnDxG/AnJAp3+C0KYrvrc1tRCXeY1ganxPzH9otw/yFdfHTtR8VnplnE0dnliAKWngj2XhsC1brqVto2EOye4ixTQq7nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160776; c=relaxed/simple;
	bh=8E+zo3epG5UbHIE6dvZd295ETNqsIe8nvkav0aVNdhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWtCHk0IrQVy/n/C4O0XnsMErgn+q0fPWF5bTD6jWBwkKMDcZH+fCMdRFFJr886E1u81CrAp/VqO+zbtYivC58wKy4CZDkbemF0upU+x+Sbh0u64nIW8ZzjOXPvmOiTdsWcUAdfzTdupHzrpRYfZBK26TOntz9pQTOKcYzf732g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=IGN0NqyZ; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="IGN0NqyZ"
ARC-Seal: i=1; a=rsa-sha256; t=1782160770; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MyEiTQBnMJzL0iMpe5JQkqJswNbkR5aB8OVtvai0dqwsIFdMF20aMmJVXNPM3aP6p0Oh0FTlpQmedqjpt+9D3fm9iodegDnUhHrow9rquEIZJUiD3QxdS7JU3rYa/3LbFc9Fj0Efl++fIyMmSuSlSsZEQWYhRF7tI4a6tKciwro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782160770; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZWV9XUGm7wyBv5OH0Inbg59Z0ZmiXoglZ0ddkdwp2Sg=; 
	b=YNYOWa4zLsPb1J0VrAqJ7XROsaVbcz25CApp2LfIz6mipquIZOqMWMLu2Ahdgegq5g8NBHwFamlJYcZvIKKhsTPbNUd65bZUJFyOayRaYuzOWLgK9rdZHlIFRa0XX7K0FM7OFTcnaeOkHYVvmWy8UYt+FGmHxG3SewjC7Nckl/A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782160770;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ZWV9XUGm7wyBv5OH0Inbg59Z0ZmiXoglZ0ddkdwp2Sg=;
	b=IGN0NqyZ+SLpQ736cGvPlKtzQFqjvd5t3N2LQ3vrdpS1wh5E6ixElUg0HL7eY5QO
	NLGbI3kb0I4KkITUWjjTHCq/geQPPFS3eWOEfr0nBBianS7AUyvJbkGdym/0rK0B/P3
	H4X1LberhVMrBzdoqqoJHPXk7LEPLLmtrIMIGfd8=
Received: by mx.zohomail.com with SMTPS id 1782160769019771.28670404611;
	Mon, 22 Jun 2026 13:39:29 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 5197E1824A2; Mon, 22 Jun 2026 22:39:26 +0200 (CEST)
Date: Mon, 22 Jun 2026 22:39:26 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Boris Shtrasman <borissh1983@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: sbs-battery: Add PbAc, NiZn, RAM, and
 ZnAr support
Message-ID: <ajmc_naB7zYv0SPY@venus>
References: <20260621145952.56720-1-borissh1983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22tzcc2pyc72oi4u"
Content-Disposition: inline
In-Reply-To: <20260621145952.56720-1-borissh1983@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/282.152.77
X-ZohoMailClient: External


--22tzcc2pyc72oi4u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: sbs-battery: Add PbAc, NiZn, RAM, and
 ZnAr support
MIME-Version: 1.0

Hi,

On Sun, Jun 21, 2026 at 05:59:52PM +0300, Boris Shtrasman wrote:
> Add support for PbAc, NiZn, RAM, and ZnAr chemistries as defined in the
> Smart Battery Data Specification v1.1 (Section 5.1.30 DeviceChemistry).
>=20
> Currently, the sbs-battery driver only handles LION, LiP, NiCd and NiMH.
> The Smart Battery specification defines 8 possible values:
>  - Lead Acid (PbAc)
>  - Lithium Ion (LION)
>  - Nickel Cadmium (NiCd)
>  - Nickel Metal Hydride (NiMH)
>  - Nickel Zinc (NiZn)
>  - Rechargeable Alkaline-Manganese (RAM)
>  - Zinc Air (ZnAr)
>  - Lithium Polymer (LiP)
>=20
> Map the missing specification values to their respective core kernel
> POWER_SUPPLY_TECHNOLOGY definitions.
>=20
> Link: https://sbs-forum.org/specs/sbdat110.pdf
> Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
> ---
>  drivers/power/supply/sbs-battery.c | 8 ++++++++
>  include/linux/power_supply.h       | 4 ++++

This should be two patches, one for the power-supply core and one
for the SBS battery driver.

>  2 files changed, 12 insertions(+)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 43c48196c167..42a941e99155 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -860,6 +860,14 @@ static int sbs_get_chemistry(struct sbs_info *chip,
>  		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_NiCd;
>  	else if (!strncasecmp(chemistry, "NiMH", 4))
>  		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_NiMH;
> +	else if (!strncasecmp(chemistry, "PbAc", 4))
> +		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_PbAc;
> +	else if (!strncasecmp(chemistry, "NiZn", 4))
> +		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_NiZn;
> +	else if (!strncasecmp(chemistry, "RAM", 3))
> +		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_RAM;
> +	else if (!strncasecmp(chemistry, "ZnAr", 4))
> +		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_ZnAr;
>  	else
>  		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> =20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 7a5e4c3242a0..034800cd21da 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -83,6 +83,10 @@ enum {
>  	POWER_SUPPLY_TECHNOLOGY_LiFe,
>  	POWER_SUPPLY_TECHNOLOGY_NiCd,
>  	POWER_SUPPLY_TECHNOLOGY_LiMn,
> +	POWER_SUPPLY_TECHNOLOGY_PbAc,
> +	POWER_SUPPLY_TECHNOLOGY_NiZn,
> +	POWER_SUPPLY_TECHNOLOGY_RAM,
> +	POWER_SUPPLY_TECHNOLOGY_ZnAr,
>  };

You need to update the ABI Documentation and the sysfs code to
handle the new properties.

Greetings,

-- Sebastian

--22tzcc2pyc72oi4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmo5nX0ACgkQ2O7X88g7
+ppwGhAAgWOl2IRnTLBI6k1PTFziIBQvK7t8wHwosJi6JXSNv/rCsNT1KUPmhBkF
FFFW/deVUfia/IIoHzz11E3s5cIIVVvfxOyzl1YCM1HwD1fwj9U6WL81y2GpRUTT
9cuKqpwABuoz+QGDk9NQIj/tHMmbRUSTaI2klsRFuubZVp4EWJjWvbMXtHrL8kZi
ZGSp+Jodaofn+tIGStNIMM/De9XMWb67j+PSsa1Qm4bwLmqdZgMbAbEl5lB2iu6h
MxW66DRZ2cFwDP2/ts+vsfyB9S0D0ULWRZvwAxw91ZgWp2WkqN8tsdQfyJnkjg9O
C9VXo2HZ+TDWuT7GJmZ0pmNgeZ2jW7Nhp96zb5b5Mypwzr0WFlX9JoxHAnwBpDBY
00TF0On+OhPxH8RdG6p+PaW9rtlY6y8uy3wl8Musu2xRKSgvipBcXjnqBRZYOf1X
AETXJ+wRdvVIIbcXV0BuY6EuHj/ZbyevQviVDJTPT6aH3yoQT6w6enqCb0W1FXAs
Ph5ZcCfJLBWE3H7ncKVHh8UEghdAl05mi3l9lx9YTXT51nnckmRnryFxKPKPt33F
CTzB291YYaAmALMkyfLKyJtTb030XIlxwI8cVHIG7e/LB8LEFXkjIxIpwAMRos3C
d1C47VcuQrIQ0/MjVxDXYwcJOfzfj+h3E3Ds2QubGaIU2Wr97eE=
=jBQN
-----END PGP SIGNATURE-----

--22tzcc2pyc72oi4u--
