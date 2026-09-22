Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A413876C3
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088401; cv=pass; b=PfeV15ANqSLfEj7SePTASLlkOYD7EbuDD4ssInHK2BfDkSh+xxLWYNNz/uNBdm1L0PoqKzxgUbYtSkcPGNJFq0aBCRIWqeGi+D4BBwUYWzOMhx4WhVZWY00NT8+ed6iWt26nYMkxAVhZ1NUnZHX4uAEbSR1tzpWGvrYURoA1B1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088401; c=relaxed/simple;
	bh=Qwx+kJuQICvSPr4P3roIQDm9q++mxK6wM7ysb0fmGAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBrdloVmsmY8gE0bDtuSNWSQKwWh0cMKUWADlbZkIp/LGnyhd8aPMpprJ2Z373bPcjm/PaMS73XaCncRv7zdwZLiwwErztHtF7mu758pcuYFKFqH0c6w+QbzyVjZBY3SONNPPvGj04uWQ7+Prnl80ISW6SeWry6/eguiFCeqdSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=atHxtnb5; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="atHxtnb5"
ARC-Seal: i=1; a=rsa-sha256; t=1790088386; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lINpbbHL8WlWkG1i8bb+xXn09sYPqdyfwfc33YCyvTUo0Jt9mTXD9i7JWSNZzhr3fzHwptTl051hqfG3mTgziQPzC/95iia+TLPtePCySYl4kGzGcOoiRW2sz9JIaE6ZGXBaLPPMEPYSA6DqsO3cp34mlQjHFEDq5Bi+TwVF/LY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790088386; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qwx+kJuQICvSPr4P3roIQDm9q++mxK6wM7ysb0fmGAI=; 
	b=N2jecwrujmVKknUdnZI8hpwvaQr4rHX3lmMIasWRHTo+M+W6isMc+5Co5h5BM1+HFjrvtT/bcvLYbCJOcOKOrlw4nYWGDTiuerDr8X2xaN1zB64S6TuYV1/pgGE54JIZyk4vewHwCbvdDduYiBLq1VG0Li9L79QUp5ppH4NnbAA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790088386;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Qwx+kJuQICvSPr4P3roIQDm9q++mxK6wM7ysb0fmGAI=;
	b=atHxtnb5L+z/h5X+XQtl3C6XGLBqqV9tev/82tkYT3Ybs3OsVcwCgXf2p7Too6Kz
	W6kXdnVxcx1S/NVQ2MQqvQ2gVX4sWDyHIJbQ2/t4LxXjmwdpFjDKT9Oqvzka3dpQYmV
	zHU/pTzCmaYwyGzL2Ihox7mtEBB2BQiCmC2BIetM=
Received: by smtp.zohomail.com with SMTPS id 179008838367530.32193819537838;
	Tue, 22 Sep 2026 07:46:23 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id BBD671805B9; Tue, 22 Sep 2026 16:46:20 +0200 (CEST)
Date: Tue, 22 Sep 2026 16:46:20 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/4] pmdomain: rockchip: fix clock leak on domain probe
 failure
Message-ID: <arKUZKPoySJBQ8Tz@venus>
References: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
 <1789733258-10133-3-git-send-email-shawn.lin@rock-chips.com>
 <aq1yU47vQT5OnxLo@venus>
 <27e3944f-81c6-48e4-8033-e30ae70f8e26@rock-chips.com>
 <3fa0fcbc-b6ff-4934-bb7d-b763d6f5f818@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q5tkxria2nmblprg"
Content-Disposition: inline
In-Reply-To: <3fa0fcbc-b6ff-4934-bb7d-b763d6f5f818@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.71.86
X-ZohoMailClient: External


--q5tkxria2nmblprg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] pmdomain: rockchip: fix clock leak on domain probe
 failure
MIME-Version: 1.0

Hi,

On Sun, Sep 20, 2026 at 09:15:52AM +0800, Shawn Lin wrote:
> Hi Sebastian
>=20
> =E5=9C=A8 2026/09/19 =E6=98=9F=E6=9C=9F=E5=85=AD 8:13, Shawn Lin =E5=86=
=99=E9=81=93:
> > Hi Sebastian
> >=20
> > =E5=9C=A8 2026/09/19 =E6=98=9F=E6=9C=9F=E5=85=AD 1:21, Sebastian Reiche=
l =E5=86=99=E9=81=93:
> > > Hi,
> > >=20
> > > On Fri, Sep 18, 2026 at 08:07:36PM +0800, Shawn Lin wrote:
> > > > When of_clk_get() failed in the middle of the loop, the references =
of
> > > > the clocks acquired so far were leaked instead of being released by
> > > > the error path.
> > > >=20
> > > > Fixes: d909072d0521 ("soc: rockchip: power-domain: use clk_bulk API=
s")
> > > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > > ---
> > >=20
> > > Right, but this should switch
> > >=20
> > > pd->clks =3D devm_kcalloc(...);
> > >=20
> > > to
> > >=20
> > > pd->clks =3D devm_kzalloc(...);
> > >=20
> > > at the same time to ensure that clk_bulk_put() does not run over
> > > non-initialized data. Otherwise
> >=20
> > Good catch, will improve it in v2.
> >=20
>=20
> I was too quick to response, but didn't looked into devm_kcalloc, just
> guess it didn't zero the data from the name. However it does zero the
> data by passing in __GFP_ZERO. So I need to respin v3 and drop
> devm_kzalloc change.

Sorry about that detour.

Greetings,

-- Sebastian

--q5tkxria2nmblprg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqylLUACgkQ2O7X88g7
+ppJ/g/9F/SNd3BhsI5ZrZp4u5k9pKbGJhgXPwsDBEqStk4Ya9bfB1Yyvbi73Pxp
iXn29jlgHJfkySob1TY9drXu0zUvfkYN+f/qitKodyC7LiIrcxMhETy3echyp9G7
+sR/CcY99MCYksk+s4yzMWXRO5cuFcwLYcuHk1YN1Q5/hpfnp+aUEhWrDdzE7Q5Q
DAZ1iYkrDT8fvYeY9JHlvCEF92KMKqybcEPCCiLQAWPR3IEAnfGvJkFmV5pAme9p
w42yj4TJUkVRVjR3hFVYDLB2Vw0VR1T7541oc5lvGxUNiLNQWk/esSYN5T2dIk21
6N2s7AbQ4XmBg//YVO/Qyf7QAXMPOqaVhLQo1dQAgSqxKsutsMlnaBfi3pIC2d2O
Zbb9WQ66iKzX8F5rqUPjbRsnJDLc94HvZYq+HCqc8Uq297jfVthyC3UbkeTnbewg
fF3xe8Ra4GOr/k2z70vPLySJXRQEzTB9mqju5SahcQ/4JH4Z0SQz06TdoixDb4gJ
sy9PpU80gL2FcK1l7ttYuazjqIqUCCTbBH7XHz5L2T/wowWuWHuTKFLfisEAGhHg
+KCqogjFJd2PR2/dEcquwwX1wgMYMb1nImjTLstOk7hf5H+SpAnuS6eI6Gp8cRTW
EPQuECwtF/LhjuoWKjXezBoIjtV9F8CLYyUrDQOwXRqEDOLwP1w=
=fNV2
-----END PGP SIGNATURE-----

--q5tkxria2nmblprg--
