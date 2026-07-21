Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89A2C21DD;
	Tue, 21 Jul 2026 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643602; cv=none; b=frSjO7gJW+EXTK9UvAqDNloK9H22oMsdc5xwZDy0lVAt1l4MYxcD0OZkUYYMBwoQzrxkHfas2vjfQwJ9zFqDVXtNULYuq/7Ridyz9ScoY9Ii9ENzE+OCLZ73CPTDwP1rNdZRt8ovpmfciZCsfjqw+HRlKlLO14312EoBnKMf+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643602; c=relaxed/simple;
	bh=7eml2cVgglNEXDFmlh7ik9YlzrAFl25/pITqfgn9Lys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OF+bTAEKqPKDmXV+VzGAca+VNwkshfpZyQWI/uTMC/nnYXh1slpjF+3MSslHXY9WM2v2ExsmsGTBykkdA9xKhLHXxqXLdyZaOZO7oK31judMnQLO4sEt3pTPduLEPbkSyug11LgCG5/GMIScwu22kJXQeh7h2pXZFkPKbscDMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=OVpTMXCr; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="OVpTMXCr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=lqOes41LH2R5Gf0PK0AJH1iaQEMKUucvCK1kHGbVyJk=; b=OVpTMXCriwGe3iTno5qEzPtJiz
	BwnAKcp1blHGzxRomYNZbj4wiM8wGslAXG5VKLG58zJYWbXbuyHhjuf8Q13exCxzKGQBNnrnPQ8mG
	0Cd8Q+WaGQrDAmmdv9SVW4lB5NEvHzqrdmAVo9MlTvSe+E/comWlnOz2lQZLH1Fq4SvOom6SPUpYm
	xnIXPJD8eGd48hzgOrOdR35dtjCoMJ53cwXWtQjUYgH38VAuerJcGNXQbos/4YvyrCVkhIp/fR5rX
	j99ydA/2WVJqpIx3KPgwXRNRsOrgCuypPYcjVQezr3SzbhXtzXROZKjh72At4SkjpatbmCjMLsKj4
	C7fjjqBQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulfh@kernel.org>, MidG971 <midgy971@gmail.com>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, ulf.hansson@oss.qualcomm.com,
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Midgy BALON <midgy971@gmail.com>
Subject:
 Re: [PATCH] pmdomain: rockchip: Add a regulator to the RK3568 NPU power
 domain
Date: Tue, 21 Jul 2026 16:19:40 +0200
Message-ID: <8838591.5OynTdThKG@diego>
In-Reply-To: <20260708234614.499613-1-midgy971@gmail.com>
References: <20260708234614.499613-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 9. Juli 2026, 01:46:14 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb MidG971:
> From: Midgy BALON <midgy971@gmail.com>
>=20
> The RK3568 NPU rail (vdd_npu) needs to be enabled before the domain is
> powered on and disabled after it is powered off. Give DOMAIN_RK3568 a
> regulator parameter (like DOMAIN_RK3588 already has) so the NPU domain
> can set need_regulator, letting genpd manage the rail wired up as the
> domain's domain-supply instead of marking it always-on in DT.
>=20
> Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Signed-off-by: Midgy BALON <midgy971@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> This patch was part of the RFC NPU series [1]; Ulf Hansson and Heiko
> St=C3=BCbner reviewed it there and confirmed it can be applied independen=
tly of
> the rest of the (still-RFC) rocket driver and DT patches, so it is repost=
ed
> standalone. The NPU domain's domain-supply DT wiring follows in a separate
> patch, so this change alone is a no-op at runtime.
>=20
> Changes since the RFC posting:
> - Move DOMAIN_M_R below the other DOMAIN_M_* macros so they stay
>   alphabetically sorted (Heiko St=C3=BCbner).
>=20
> [1] https://lore.kernel.org/linux-rockchip/20260613070116.438906-1-midgy9=
71@gmail.com/
>=20
>  drivers/pmdomain/rockchip/pm-domains.c | 36 ++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 490bbb1d1d8e8..ba66ae7194289 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -204,6 +204,20 @@ struct rockchip_pmu {
>  	.active_wakeup =3D wakeup,			\
>  }
> =20
> +#define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator=
)	\
> +{							\
> +	.name =3D _name,				\
> +	.pwr_w_mask =3D (pwr) << 16,			\
> +	.pwr_mask =3D (pwr),				\
> +	.status_mask =3D (status),			\
> +	.req_w_mask =3D (req) << 16,			\
> +	.req_mask =3D (req),				\
> +	.idle_mask =3D (idle),				\
> +	.ack_mask =3D (ack),				\
> +	.active_wakeup =3D wakeup,			\
> +	.need_regulator =3D regulator,			\
> +}
> +
>  #define DOMAIN_RK3036(_name, req, ack, idle, wakeup)		\
>  {							\
>  	.name =3D _name,				\
> @@ -241,8 +255,8 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)		\
>  	DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
> =20
> -#define DOMAIN_RK3568(name, pwr, req, wakeup)		\
> -	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
> +#define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)		\
> +	DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
> =20
>  #define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, r=
eq, idle, g_mask, wakeup)	\
>  	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_of=
fset, req, idle, idle, g_mask, wakeup)
> @@ -1274,15 +1288,15 @@ static const struct rockchip_domain_info rk3562_p=
m_domains[] =3D {
>  };
> =20
>  static const struct rockchip_domain_info rk3568_pm_domains[] =3D {
> -	[RK3568_PD_NPU]		=3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false),
> -	[RK3568_PD_GPU]		=3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false),
> -	[RK3568_PD_VI]		=3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),  false),
> -	[RK3568_PD_VO]		=3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),  false),
> -	[RK3568_PD_RGA]		=3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),  false),
> -	[RK3568_PD_VPU]		=3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),  false),
> -	[RK3568_PD_RKVDEC]	=3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),  false),
> -	[RK3568_PD_RKVENC]	=3D DOMAIN_RK3568("venc", BIT(3), BIT(7),  false),
> -	[RK3568_PD_PIPE]	=3D DOMAIN_RK3568("pipe", BIT(8), BIT(11), false),
> +	[RK3568_PD_NPU]		=3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false, true=
),
> +	[RK3568_PD_GPU]		=3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false, fals=
e),
> +	[RK3568_PD_VI]		=3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),  false, false=
),
> +	[RK3568_PD_VO]		=3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),  false, false=
),
> +	[RK3568_PD_RGA]		=3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),  false, fals=
e),
> +	[RK3568_PD_VPU]		=3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),  false, fals=
e),
> +	[RK3568_PD_RKVDEC]	=3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),  false, fa=
lse),
> +	[RK3568_PD_RKVENC]	=3D DOMAIN_RK3568("venc", BIT(3), BIT(7),  false, fa=
lse),
> +	[RK3568_PD_PIPE]	=3D DOMAIN_RK3568("pipe", BIT(8), BIT(11), false, fals=
e),
>  };
> =20
>  static const struct rockchip_domain_info rk3576_pm_domains[] =3D {
>=20




