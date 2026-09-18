Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AAA40F731
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751907; cv=pass; b=grZ9AF/hxxib/hHfNYb6ihUEHmm469d1RbTFeNCcoopWWFDql36B4DmPsC+cPNnhZact+qsIgGxeayHMWB0OnpJaLUlYBYUgP1+SZ75IaDb1h8zfYblTM2w+jSgxtdvDNpImCOI4BXfzZKqaI4Xf9IY3oy++xFd5I69RMaGUPOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751907; c=relaxed/simple;
	bh=baNTiU0Ge5JKSg0vveRJoFcH4P7+fXffSB7N2f5YXvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSR944hDL49/pvdrHgvCRkC2yuKUtfZgnl3/r/gdQfJMkGtYP4jCXOtgh253nFkvvl7ARAI9BjG/DJoj0UboEmY/Bt08e/8MbtWKGCuud4uNgLnnAHLuZgCXHdIgZAci17DSj2LhSVreUa1oFlhQR90yNGa29xLEAdb4k78CCYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=XdoP3s1g; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="XdoP3s1g"
ARC-Seal: i=1; a=rsa-sha256; t=1789751892; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AKQIVUtce15rN7YtbUkY+oIv0+pQQo8yYTXfO9Bpv43QOfXGTrk/gD2wIocWi1SiAnVz4SSP+S0qLkDeL1UwLuPB0eXbvowabXiefTUIuTq+uFfjG41YG7QZbOjc5/eBtve7XvrNHXg6l25O7gjUATpcjWDPyuNpHAl6Qp6zC0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789751892; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cqGV5TncVBfqRBfIGHqaR/O3l9aJDP51aY7gB/A23dY=; 
	b=HqCeWoQ6oW3NJT2sc+BE9rCB1eAAkKN7G4B5R3tm2d5dO9zVCDuNSRm1+V9XAvC7dnQlL+3A0rC5u4UmFUfC4dXEV/dTALRoHOlW2kCpze180kgDul/ZsLmpyn81kaghckuVyvNoavYhH/piz7YKvwZ8Hb6fw89zc4LTC+83NQk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789751892;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=cqGV5TncVBfqRBfIGHqaR/O3l9aJDP51aY7gB/A23dY=;
	b=XdoP3s1gDSGFwRVPCa9OJrL8O0SMEtxMdg9dkI621FY+rYyJJzIua23vrOYckqfo
	SA5TlvVmN5X9CGoSiI/x+P8HOfB1dNZ6uDDqf8tM6qXHTNdZrH8Wd+x44FqaPa5Wbtt
	Vu797YGs4tuTXT4xC/E4RHZBc3udvewDzgUm26N4=
Received: by smtp.zohomail.com with SMTPS id 1789751891867230.6014382620166;
	Fri, 18 Sep 2026 10:18:11 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id C8949180608; Fri, 18 Sep 2026 19:18:08 +0200 (CEST)
Date: Fri, 18 Sep 2026 19:18:08 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] pmdomain: rockchip: propagate subdomain add errors
Message-ID: <aq1xu_BpTn8its-c@venus>
References: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
 <1789733258-10133-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rvy76fgiuogebomc"
Content-Disposition: inline
In-Reply-To: <1789733258-10133-2-git-send-email-shawn.lin@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.731.60
X-ZohoMailClient: External


--rvy76fgiuogebomc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] pmdomain: rockchip: propagate subdomain add errors
MIME-Version: 1.0

Hi,

On Fri, Sep 18, 2026 at 08:07:35PM +0800, Shawn Lin wrote:
> rockchip_pm_add_subdomain() ignored the return value of its recursive
> call, so a failure deeper in the hierarchy was silently dropped and
> probe still succeeded with an incomplete domain tree.
>=20
> Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-po=
wer domains")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/pmdomain/rockchip/pm-domains.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index ba66ae7..068dd4b3 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -1018,7 +1018,9 @@ static int rockchip_pm_add_subdomain(struct rockchi=
p_pmu *pmu,
>  				parent_domain->name, child_domain->name);
>  		}
> =20
> -		rockchip_pm_add_subdomain(pmu, np);
> +		error =3D rockchip_pm_add_subdomain(pmu, np);
> +		if (error)
> +			return error;
>  	}
> =20
>  	return 0;
> --=20
> 2.7.4
>=20
>=20

--rvy76fgiuogebomc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqtckQACgkQ2O7X88g7
+ppUmw/8CQ6n/lH7j9AfTxWcl0JELNNq0EdQ/G5E0lrhCX75yfPFm87ujCTclW7H
+0oneEZusiJ+S4wsdaSplWmLxCHsQj1J8kwHGA1m7ujfj7909RIYZPe9XIffHGAI
BFt3ixnyoBaFb/atRra1PfxRrZCROR8/Ma+hMif7YqwHpp+3EKkbdZ47iryN8mzn
DwEAZXe3tVUi1KXLMDAmWuwtK3giR1qbhWZr+jiP4pLuf50J1rRNVD0SXIU9cf1C
BeWdy8Doqla6LEDE94jNZHf3xziLnnOl0KnlNaDvKVPv3tXEDko30YNpQclQ44nS
utMqRyvsBINDfzYI43gPZqtdj6l5oLXF7+xQKr/dOsshlCM7ZYt7wNyW6i1Br4+c
48J0sgMt2ksT9mqw0u0Txo2ovp1YCNoUarIWE1EnUTKplo0y7mfF+av2S0RJE4Ne
TCFkx9q6Husnvo5x7WgPCjv9gqu4a7u5j4ezlo1I/BKRVln2XiElvlk5XD1UdXRa
h6AMC1aa8ej+RROIxnc7V69qWSOlRQ0Vzd3pRtZvCpgzIrY7xQVfiOuMWWZppqPZ
0cr1UVKXKkfE57GDfQRbWMhZ/gq2zC8ya84UrryNUDNtDpieKSpeI2aZZvTnAbXK
SQrDO9H0bPnzNVSMvHMi/dao9qtbL4p7jmDPG9OPQwRNs4UuRwA=
=DhDc
-----END PGP SIGNATURE-----

--rvy76fgiuogebomc--
