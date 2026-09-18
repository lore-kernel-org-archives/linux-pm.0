Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB05311958
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752132; cv=pass; b=DvTo29YiNuk5lfFVlLJSXJRlIbu8fEBZwU7o5Uz0fZgGEm/1TzRPhQYWdpmpykxAstcyEQ206rp1KnkjB5YXnkeMdToEdpIdSMI/kINyOkAExsRzLku3pOf0wuaKSWF8ROKd90l9brZUC/fVcORE7h4oIL/9/yozglgBccgwrsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752132; c=relaxed/simple;
	bh=RbuQ2xoNWUz90oZHxc7WsUesn3ha8foQz1Q4FdAuDuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8741XkPaXOLOTREdOvYSNjfpH2nRxbsVopnCoz3k1dtLwuCr92llqXB0WfqikuM/4jQNx0nbpXHR1PTBWbqpS2dTLSPyRsJNHYSTapVYDvjG8Pgl70CEhk63kSXjFf3T8WRnLzNzv5iIbtXe7YqB7U7ZDiXIF3iR3/KzSKd2ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=gV2nXM5a; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="gV2nXM5a"
ARC-Seal: i=1; a=rsa-sha256; t=1789752108; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RZxZTjq8ELyh5ooC3YKHTpN3/GwQsIhttVw6U4TWoULZtoVFo1A6VwOMhghctj+kLlysKSZsdEEX31oWwhSrTWbb580DkDm29Gbm4uH9BdrWAze7vtcQjOrcnFLM1KjB2wTz5NfacPh7T7lfInX1zIqAmehXs2ksKsZvkF5xW68=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789752108; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nJhdN5W7cyBCj3rMYlVRHVZUtD7sb0eyFPBg/7KmmVQ=; 
	b=DWJn6b+xBcQ5KdvWIqmRI1jaS5CPCfByDr2oAdiXQkUt/xXn4NYyFHXj5ph8TEjAqujtY0slcYBEc0IUfqzzUiZkiC/b/649D8luyQcr9vUpZd03SkI3utnciw4YWTCyJdjwsncxmcwjpgDO7y1tHH9u2LgTwQTmCX471tU4pYE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789752108;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=nJhdN5W7cyBCj3rMYlVRHVZUtD7sb0eyFPBg/7KmmVQ=;
	b=gV2nXM5aOfELxBap4kjMDPxFBNaKnhohRklPZNTnISQfLpr+45kz223b1JiIUdKJ
	R99p9Kal0Ju8HmSX1b36KYZhlsQeZ9CaPvx3gZqp1Kznc0/AeoO1U56/T33voz6POnm
	m052PI/H+ACCXXlqhqcREwKpMTDtb6g8TrHBoRaQ=
Received: by smtp.zohomail.com with SMTPS id 178975210711957.48448439606159;
	Fri, 18 Sep 2026 10:21:47 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 316E9180608; Fri, 18 Sep 2026 19:21:44 +0200 (CEST)
Date: Fri, 18 Sep 2026 19:21:44 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/4] pmdomain: rockchip: fix clock leak on domain probe
 failure
Message-ID: <aq1yU47vQT5OnxLo@venus>
References: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
 <1789733258-10133-3-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g5bh7ban3yhkibs2"
Content-Disposition: inline
In-Reply-To: <1789733258-10133-3-git-send-email-shawn.lin@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.731.60
X-ZohoMailClient: External


--g5bh7ban3yhkibs2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] pmdomain: rockchip: fix clock leak on domain probe
 failure
MIME-Version: 1.0

Hi,

On Fri, Sep 18, 2026 at 08:07:36PM +0800, Shawn Lin wrote:
> When of_clk_get() failed in the middle of the loop, the references of
> the clocks acquired so far were leaked instead of being released by
> the error path.
>=20
> Fixes: d909072d0521 ("soc: rockchip: power-domain: use clk_bulk APIs")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---

Right, but this should switch

pd->clks =3D devm_kcalloc(...);

to

pd->clks =3D devm_kzalloc(...);

at the same time to ensure that clk_bulk_put() does not run over
non-initialized data. Otherwise

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>=20
>  drivers/pmdomain/rockchip/pm-domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 068dd4b3..b6b099b 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -842,7 +842,7 @@ static int rockchip_pm_add_one_domain(struct rockchip=
_pmu *pmu,
>  			dev_err(pmu->dev,
>  				"%pOFn: failed to get clk at index %d: %d\n",
>  				node, i, error);
> -			return error;
> +			goto err_put_clocks;
>  		}
>  	}
> =20
> --=20
> 2.7.4
>=20
>=20

--g5bh7ban3yhkibs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqtcycACgkQ2O7X88g7
+pr9Yw/8CndNqYJovwX2ZguErJ3H2S6WUvoT3O6Q7xTVr6w0768YD1YZAmvhqqhx
NxyubJB20NXtKXsE79iym94HLExHk6drS6VFwmSZ3CseLK1ssDPYDrx2aX04yvWu
cntwCswjesboEHVEjfWy9ZIOcCSTaZUeTcRd1rgXedS5LDm5eB18NDUiKFjbWIA1
RURk7dhd84cq9tEZNMV+JCIxff2fNkLKwwnous95M5u/vfs2s1w0qbu+eGYrdXdQ
NrCEYTvvBmzl2QWJIFGY92914Myzjw1WBpnEqbCn7T4hm7f2NxFbdXGjen1VxuFs
i4uTU52cbgtm8CYzrgO3PbmUc5UdffwDMMxMVJXLgghxf32S8iPkIH1pjGC0QmFD
pqZSHFxJOEQRTdO+6c012waP671xPNJAmIdg2MP880lsoSKQihDn9aCuul/ujaEF
zY9dfCMIJYO3ltuItUmoXXZZQRKRH5Gh6Xl5cBIgx4wSh34jncplH+Kq6+QLvD18
WtJS2bw+W2XF3WS/ZDm3beVzyV3lq6iaJTN/C6iDfxMFN30AM0v9PJD4CoXsUMEl
b0ZvBDsR3dRyI7TV3mywN4gbzxpRd45O4raXgPX/3Y3kVQ2XXhKnC35X8myihfo7
3AzTYJki+QVayK9KL3ZVw+5QYNaz5AHgKYH/aBxq+Cp+Rp8UaqU=
=gy95
-----END PGP SIGNATURE-----

--g5bh7ban3yhkibs2--
