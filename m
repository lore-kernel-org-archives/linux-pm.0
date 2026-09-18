Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61640472557
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754362; cv=pass; b=U6ZU5dOqEcFrZsVpNwtFxBrGbAyCMTNFaAwCJeJcLvWcwIuVF6VPp8drFaP28x9ZIs6WkbBgGGbu0vAtPxWVMHc0qNSNUy/M3Z1+gvheXD9Z0iZqWk3GnPWl1s2LwTvZyoq4vkW4K/lWIGYrfKx92sE7UqthilqWk1PmbuS0fHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754362; c=relaxed/simple;
	bh=7f5gziOQsqSvthX4AN6Wbmx+9oDPJLoKp/VIUZqH/F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4O/EOn9zv97eYpuZhT30BexCCrizs77YBXbpF7H1i/5D0PT7rBo7NRdCrxudokqLGuEl999w9RwPs2MQaoKM5s7N8zOGXVhWh2vpFb3gL0MS2pMrI5lTkLlkByNbGMmrx8M9S2u7uq2gf70Jhb/x4tQdr4XAlrXL9XKziD+u+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=W+2RgyfS; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="W+2RgyfS"
ARC-Seal: i=1; a=rsa-sha256; t=1789754351; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mlB7qU5gcehEKzGxFzgUo0KtBETvwoRtLpQW/IKGcV5xe1eNrFxE9ZPAmDGwbNbo00jU32OeN7gTF2CF6Jfp8luTKkw/XRz2z0STvrYPFFL95+t6gDoUItAzRKGCLnYs3h/75df4PvqutUt538E/84628zQZ5VFUhZik6NV6yY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789754351; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IXnlYsOw284Jns76QNX5PPz8/Szr6hkOSfn2OKsgiLI=; 
	b=h/Y1olcmYtssgpRHtlLC4N/VrPektyfBQE6Cjjoo+TT4ltr/XOlSP6fFmHVoD31EIupWzv/AGGHgbtaICQfBUx+jtpeljOG32fMWiJvWVPehLREazBKJrr95IBy2lF7jWTj1gPA9pHNKqXOD2wheaGdtKIbuNa8Xf4ch1hccSBM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789754351;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=IXnlYsOw284Jns76QNX5PPz8/Szr6hkOSfn2OKsgiLI=;
	b=W+2RgyfSi0Qz+urepmJOA+qOijOidXtWLk1ckKOLGFDIeC+FLE+kici3HS2qhwnH
	3cTTkRjMXWP401Kq4y1F4CH9LVSC9fPRgEfXB3NUkXaUkElDkBdrWCJ/4S1jUu/ryQV
	p9sXg8EhPRQLJPNj/2L+lQswf8BbWEmhJF6O5rIo=
Received: by smtp.zohomail.com with SMTPS id 1789754351047914.3784682567832;
	Fri, 18 Sep 2026 10:59:11 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 62314180608; Fri, 18 Sep 2026 19:59:08 +0200 (CEST)
Date: Fri, 18 Sep 2026 19:59:08 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/4] pmdomain: rockchip: don't ignore clock lookup errors
 on attach
Message-ID: <aq16yrdiWH95uYQ8@venus>
References: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
 <1789733258-10133-4-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5zmlbusiipz75m4r"
Content-Disposition: inline
In-Reply-To: <1789733258-10133-4-git-send-email-shawn.lin@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.731.60
X-ZohoMailClient: External


--5zmlbusiipz75m4r
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4] pmdomain: rockchip: don't ignore clock lookup errors
 on attach
MIME-Version: 1.0

Hi,

On Fri, Sep 18, 2026 at 08:07:37PM +0800, Shawn Lin wrote:
> rockchip_pd_attach_dev() treated every of_clk_get() error as the end
> of the clock list, so a clock that exists but is not available yet
> (e.g. -EPROBE_DEFER) was silently skipped and the device ended up
> without pm_clk management.  Only -ENOENT means there are no more
> clocks.
>=20
> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain drive=
r")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/pmdomain/rockchip/pm-domains.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index b6b099b..e193f97 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -759,7 +759,19 @@ static int rockchip_pd_attach_dev(struct generic_pm_=
domain *genpd,
>  	}
> =20
>  	i =3D 0;
> -	while ((clk =3D of_clk_get(dev->of_node, i++)) && !IS_ERR(clk)) {
> +	while (1) {
> +		clk =3D of_clk_get(dev->of_node, i++);
> +		if (IS_ERR(clk)) {
> +			error =3D PTR_ERR(clk);
> +			if (error =3D=3D -ENOENT)
> +				break;
> +
> +			dev_err(dev, "failed to get clock %d: %d\n", i - 1,
> +				error);
> +			pm_clk_destroy(dev);
> +			return error;
> +		}
> +
>  		dev_dbg(dev, "adding clock '%pC' to list of PM clocks\n", clk);
>  		error =3D pm_clk_add_clk(dev, clk);
>  		if (error) {
> --=20
> 2.7.4
>=20
>=20

--5zmlbusiipz75m4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqte+sACgkQ2O7X88g7
+pp/rg/9E0K5Y3juU+WAyHN7VwCZTa/CXCWLdA2WG7AEvCX5FVLMV3zttcfHAImp
ejiJdooJY4jlBq0SL/PfPXWu1DUH2kjUl//7+vUJSI8IosuiecUlbKl1LuASXoSE
rY5omU+uFfBrydSKH2jrM9ztezETs/6RbZBcL5lFA8hwMSXLWfeXs0SXDOvedo9N
ZkZRVKVG8GffcdiaK42eT10AONWeerInHK1PAHjCHwdzpbd+HiZoOMYRJvIv2cZd
guCCZ3uf0nbLKpr/1oQeK3KPmG0Oh8sRZV4YdLNesdOp9CCno32XPmqBRPjEXCEM
lkV1GLWSmm2H7gQExCTLed5iDoYGrkJ+oGrmoil0sbpv32ReAZeJeg4YrBC8JCBi
XCU+EXehkZ4jZYNjEbqHQuKRobpA3PKU7VHTJbDW7St5k3Zqlw4hq8SuktiofNyL
Es9gAYXSjdhgPciyD+po19kokDHLooVWdIwTcWEuXbf/6IynTBq7jAMfO86D6KCO
RzeQXdeS2ldmiXwfTBxbc4ZUngOLlinP9mc+TVOgf077QDgx05/wgJmNUcGw6fO/
QfLvFGODmoh6I7FsxfTgF+OxaJdJuyfup1eIsJ+lJG3slj/0O517A1KpOzANGc6V
XdNLHFLDvzgrhzM8qCaeO855UyfNAcQCLchXwB8snaY07kWxBuU=
=/dh9
-----END PGP SIGNATURE-----

--5zmlbusiipz75m4r--
