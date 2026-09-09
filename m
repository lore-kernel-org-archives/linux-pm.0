Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2CB475354;
	Wed,  9 Sep 2026 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989630; cv=pass; b=QDsX9f6jMfCXcpiMQYLAoA+mIWJMNvsmGMqKYslCsXxMfBdGzScGcxKTFrbdr60pF4HgUDGL7Z4Q9jZ8XpvoDY9+aShFBaTWad6asWQYOdIIMYlidNhXgsE5WCTqWQlaSqDvb+hrOuLmSck9bFXzRl0iDkpaSQx+gnzysN2+Yow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989630; c=relaxed/simple;
	bh=CMWvvbmwTpJpxRVSkyL2ArxTPtKtihk3Fd+UAgAbtDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5IzbVdpmqMZl8DcfVbivihv6Huas5aWlbcZXME8LsNBJMdbI1HUXP+9sCtq+gXc5K/tUnFNc3aswfMFeIKufKUtHrUweUp13csfvMT3RKWwlBsvcg7Q7LTSuhBmaJs75KXEn+Ke/NeqbyzoiUYpbGJYLXO8RZOuh5OWWMYh4Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Ms0wcapA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Ms0wcapA"
ARC-Seal: i=1; a=rsa-sha256; t=1788989608; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ObCXcB72YCyYRrvxmhSLQ1Nqmuoo7gaUYEMaJuh7Rd6UGai0KFYctV6Fh2AGETFoOVKDkGCPOZx6Dty5G0wJt6KrocNutntZs/cBjoBGkegIBbDKYPrZZhTg8QNtEfAwgk2I8XouiZ4PtN/itEG+EzhpH83ZCzNZQOnANFejbBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788989608; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OK/+i+bSuot0rWajR76Gmfv+pPtd96VADwafK/3Ut6I=; 
	b=cu9T77n45oC/tjSwpmaF1LiCz83V4g75SCHe9vrRkfkqZbT3hgvaR2QOfUG6kvPsbcONl/PpPY13a0sLHSHM/Idb5cklpPVq2UZXkogexkFXPTKtc/Bc+sYPNB+54kLtRQVKIxzzg/11CXCv2Y+MG0tg6pzAEQQi1UX87x1UHSA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788989608;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=OK/+i+bSuot0rWajR76Gmfv+pPtd96VADwafK/3Ut6I=;
	b=Ms0wcapA2R4VPsm84z5vbEOolbuMYodYG7nDzfuG75AhdFzJiXY5idw+SswpJ7fo
	MWFEZ1lePPZCn2H/MWtAPWsramR0sY231gFg/2DYIX2/Kt+lMOSXFFoIszNMyeSr3oL
	7qdA/uRcrAOeV7dg6vgeLU6ry4ewyVO3Xlrxz2Zg=
Received: by mx.zohomail.com with SMTPS id 1788989606504151.99293599189923;
	Wed, 9 Sep 2026 14:33:26 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id A8C86183377; Wed, 09 Sep 2026 23:33:23 +0200 (CEST)
Date: Wed, 9 Sep 2026 23:33:23 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, 
	"open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: Fix power limit documentation
Message-ID: <aqHQPhfxUkJlQJmv@venus>
References: <20260821153949.2914201-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="food2nm4pzpdq4iw"
Content-Disposition: inline
In-Reply-To: <20260821153949.2914201-1-daniel.lezcano@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.982.46
X-ZohoMailClient: External


--food2nm4pzpdq4iw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: Fix power limit documentation
MIME-Version: 1.0

Hi,

On Fri, Aug 21, 2026 at 05:39:49PM +0200, Daniel Lezcano wrote:
> The documentation for the input current and voltage limits recommends
> using those properties for problems that can be solved using a power
> limit. This contradicts the recommendation to prefer input_power_limit
> for such cases.
>=20
> Similarly, the input_power_limit documentation recommends using the
> current or voltage limits for problems that can be solved with a power
> limit, which conveys the opposite of the intended meaning.
>=20
> Fix the wording to clarify that input_power_limit should be preferred
> whenever a power limit can address the problem, while current or
> voltage limits should be used when it cannot.

Patch LGTM.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>

Is this intentional?

Greetings,

-- Sebastian

> ---
>  Documentation/ABI/testing/sysfs-class-power | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 32697b926cc8..f0ef87d365dd 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -600,8 +600,8 @@ Description:
>  		supply. Normally this is configured based on the type of
>  		connection made (e.g. A configured SDP should output a maximum
>  		of 500mA so the input current limit is set to the same value).
> -		Use preferably input_power_limit, and for problems that can be
> -		solved using power limit use input_current_limit.
> +		Use preferably input_power_limit, and for problems that can not
> +		be solved using power limit use input_current_limit.
> =20
>  		Access: Read, Write
> =20
> @@ -618,8 +618,8 @@ Description:
>  		input power to 5V when the screen is on to meet Google's skin
>  		temperature targets). Note that this feature should not be
>  		used for safety critical things.
> -		Use preferably input_power_limit, and for problems that can be
> -		solved using power limit use input_voltage_limit.
> +		Use preferably input_power_limit, and for problems that can not
> +		be solved using power limit use input_voltage_limit.
> =20
>  		Access: Read, Write
> =20
> @@ -633,7 +633,7 @@ Description:
>  		in the supply. Normally this is configured based on
>  		system-level knowledge or user input. Use preferably this
>  		feature to limit the incoming power and use current/voltage
> -		limit only for problems that can be solved using power limit.
> +		limit only for problems that can not be solved using power limit.
> =20
>  		Access: Read, Write
> =20
> --=20
> 2.43.0
>=20

--food2nm4pzpdq4iw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqh0J8ACgkQ2O7X88g7
+pqTWQ/9F0BEvTrZxKfzrF3WzUfSJqAuk2l4Phnjg75ZHNIC7zXjrPvoU4Ea6G+O
73QKquo8MfeYYF62cV5CL6bxVXyM2bomhsjG3BSjuo9Ec6/Yh/JzkMgSwaNDSfxM
iJ/FeSTV8vb3tSByB4/JZ+ABs1yJTvWxyjYNsC6UZWG51+ZoujfY2Fd1fZworoDd
pn9siIXzb1G4Asrgr6XrhtIQScu6kAiYhgDkt/oJX6lfOC39cyGzZ4QY3Swm0l5K
DY7zCTf7enBUECLvsfBKSt103anLgiCje0gTwIY6E2uS0lamDAybDUl+/0WR0O/7
ZfKRnSuXYa6I4VIKl4z5W4BV/1iLGg0adVFDkBsUXcWeQ8iPWL27XaZW61TgCbnG
0ce2PTbCRp9vPkgrrXpFUYKruvJVZ61VSGm1eFurWxsAV2wFYrlTwmxwdsi7DPpa
ya0qkIEV72DDWLWa/FvWnlGNpx4tzKGJauGXYf2oj0ggljDlRax3CkXbXAFe5M+/
FyWCGM6iLGArafIqMzcFY8p03fV2j0m3UKFS9upEUHWPp8e60PUybVI99AxWFAU8
GGYg5eVux98ySCSuNbll8ZmNib4zSjexg8V4NtoF+aqP2s1YUKcoESQRA9tJ4yVD
M8YkzhZz9LHX2a4JL3zzgrKU613EtGy4DEhH/06nXIO5F4tF5+8=
=tyMq
-----END PGP SIGNATURE-----

--food2nm4pzpdq4iw--
