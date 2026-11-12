Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794507216;
	b=fF0kR6vfrR2LltXMcsiOP11oypq/gMFK3MaYf7t/jeobXcEdqourjVd2/CfLW4tuBqAZ
	 L3/GRryNrE/3YY9ShoXJOkqMlBE7/vZ+bm3XVO8qJZTdDa9ZnNBosxjDQkQUsfbDbUOHa
	 GZtUP5o08kShBdj7iUdmtWJdVhJdgELPNUx85fGFX3p/2JA63b0Fu6ByBQM3MM9b0U675
	 YyM1f8UO24cRMD/tSljJAVUxPTZizQ3DpcxMacKW8vxlp9lOpT+fu0ESEPp0TnFwEyl/x
	 3pz70yl62wFWjsb9qqhumK59vEniDjKzlFObuXrLrwdkJtLdc8991nAWVkAzegSyVlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507216;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=clfRlB1cKPI2P2RGkED2YiH8vFJqIWTsVXpS+apuAnA=;
	b=h9vgYfl3vrS6m1bDnjwAo8A7O2aOe5tW+2gdtKBAIo8BhP7OyWlMSSIvHXBgksDNPD2g
	 IZGgoWGFyD6jv40yBIUi9sDxnbfpMCM05xFZv+uW8G6WYXtaTlSX0FUz6ZSIJIyHJArBD
	 lZtQkqeMqaXouKrHR30GQnd5IqSWKxXL7dkapiyX8p7wrHejJdaODW/KSsX6ye6YZmol1
	 9eDJrJm40otdkDHHje2AEZ/shotZ90q0GZrszmG1Op/yRH1j8W5SAGIRRKzEL/PdioNW+
	 ZOARH+Tu27KLDkpBr+MIXnR/lGMT6+CWMvCGGP86Z6+YkzWDxjb1WmyZlyy7ce8K6Iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=IJMMHEtB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE0606A31C;
	Thu, 12 Nov 2026 18:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45CE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=IJMMHEtB
ARC-Seal: i=1; a=rsa-sha256; t=1794507177; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eizwPx8KVqV00PIVxZYvQsUep5t+8EKtabRxDIND0DYEhcTdqV0HEincZbZl4jMyBnWDjO57rBEGXvoYXfpbg3HkTs4y6MU3iU0lLetS7vbVCPntMyD2UUnEizAg/ai7VU+CeA0Cqf2SLFUnxSipoL8EBA0OITGlE+9p3F9t/eg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794507177; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=clfRlB1cKPI2P2RGkED2YiH8vFJqIWTsVXpS+apuAnA=; 
	b=bb9NyM7Tl3qbVtWnGf6FW9HK1Qtn8fHMDmZktlw7AIiEOfmj67YsqR05Tk6oJZVJMnQyES9D69i4aEwPQAqcoeFvB1EQOh0wvZMUwo7NxvPCDbcvaxLqAZVMooYsBd/a05gvLdxRnD9kWK0VxBzP792EHRgzR2oqwK6Rp/lJ/oQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=IJMMHEtBUP+0yvSM2V2o1j1rmnCiI/A+0L+4VpnDZwkTRKGalkVUCBiFKXdmQBKo4DAvnpjhvfH77y584ccLS81lzuwjDkLqc64lOxFnGQ8Qg0c5W2dgVjU4mDnlASBqpHcgFxs6A16dMZ92lGcF5xKxtxssqeTgu4ywXByRD3s=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=clfRlB1cKPI2P2RGkED2YiH8vFJqIWTsVXpS+apuAnA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794507176475603.4857356077931;
	Thu, 12 Nov 2026 10:12:56 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 97ADA180570; Thu, 12 Nov 2026 19:12:51 +0100 (CET)
Date: Thu, 12 Nov 2026 19:12:51 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Leonard Lausen <leonard@lausen.nl>
Cc: ulfh@kernel.org, heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, detlev.casanova@collabora.com, finley.xiao@rock-chips.com, 
	zhangqing@rock-chips.com, inindev@gmail.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, gahing@gahingwoo.com
Subject: Re: [PATCH 1/2] pmdomain: rockchip: Manage the RK3576 GPU domain
 supply
Message-ID: <avYBfa10mzLxG0Xe@venus>
References: <20261019092417.391522-1-leonard@lausen.nl>
 <20261019092417.391522-2-leonard@lausen.nl>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3g4i4kdgz6zmtb4d"
Content-Disposition: inline
In-Reply-To: <20261019092417.391522-2-leonard@lausen.nl>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.497.36
X-ZohoMailClient: External


--3g4i4kdgz6zmtb4d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] pmdomain: rockchip: Manage the RK3576 GPU domain
 supply
MIME-Version: 1.0

Hi,

On Mon, Oct 19, 2026 at 09:24:15AM +0000, Leonard Lausen wrote:
> On the NanoPi M5, boot hangs during Panfrost initialization. Before this
> fix, booting required blacklisting Panfrost on the kernel command line.
> Loading Panfrost after boot reports a GPU power-domain acknowledgment
> timeout:
>=20
>   failed to get ack on domain 'gpu', val=3D0x113ff
>=20
> Add regulator support to the RK3576 domain descriptors and mark the GPU
> domain as regulator-dependent. This lets the existing Rockchip
> power-domain regulator handling manage the GPU domain supply.
>=20
> A corresponding domain-supply property is needed in the board DT.
>=20
> The regulator-capable descriptors are based on the regulator support in
> Jiaxing Hu's pending RK3576 NPU enablement series, without its NPU settle
> delay changes.
>=20
> Link: https://lore.kernel.org/all/20260924102135.92217-10-gahing@gahingwo=
o.com/
> Fixes: cfee1b507758 ("pmdomain: rockchip: Add support for RK3576 SoC")
> Signed-off-by: Leonard Lausen <leonard@lausen.nl>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/pmdomain/rockchip/pm-domains.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index e193f978d5f35..b41f9fcb62bfe 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -176,41 +176,42 @@ struct rockchip_pmu {
>  	.mem_offset =3D m_offset,				\
>  	.mem_status_mask =3D (m_status),			\
>  	.repair_status_mask =3D (r_status),		\
>  	.req_offset =3D r_offset,				\
>  	.req_w_mask =3D (req) << 16,			\
>  	.req_mask =3D (req),				\
>  	.idle_mask =3D (idle),				\
>  	.ack_mask =3D (ack),				\
>  	.active_wakeup =3D wakeup,			\
>  	.need_regulator =3D regulator,			\
>  }
> =20
> -#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status,=
 r_status, r_offset, req, idle, ack, g_mask, wakeup)	\
> +#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status,=
 r_status, r_offset, req, idle, ack, g_mask, wakeup, regulator)	\
>  {							\
>  	.name =3D _name,					\
>  	.pwr_offset =3D p_offset,				\
>  	.pwr_w_mask =3D (pwr) << 16,			\
>  	.pwr_mask =3D (pwr),				\
>  	.status_mask =3D (status),			\
>  	.mem_offset =3D m_offset,				\
>  	.mem_status_mask =3D (m_status),			\
>  	.repair_status_mask =3D (r_status),		\
>  	.req_offset =3D r_offset,				\
>  	.req_w_mask =3D (req) << 16,			\
>  	.req_mask =3D (req),				\
>  	.idle_mask =3D (idle),				\
>  	.clk_ungate_mask =3D (g_mask),			\
>  	.ack_mask =3D (ack),				\
>  	.active_wakeup =3D wakeup,			\
> +	.need_regulator =3D regulator,			\
>  }
> =20
>  #define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator=
)	\
>  {							\
>  	.name =3D _name,				\
>  	.pwr_w_mask =3D (pwr) << 16,			\
>  	.pwr_mask =3D (pwr),				\
>  	.status_mask =3D (status),			\
>  	.req_w_mask =3D (req) << 16,			\
>  	.req_mask =3D (req),				\
>  	.idle_mask =3D (idle),				\
>  	.ack_mask =3D (ack),				\
> @@ -250,25 +251,28 @@ struct rockchip_pmu {
>  	DOMAIN(name, pwr, status, req, req, req, wakeup)
> =20
>  #define DOMAIN_RK3528(name, pwr, req)		\
>  	DOMAIN_M(name, pwr, pwr, req, req, req, false)
> =20
>  #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)		\
>  	DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
> =20
>  #define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)		\
>  	DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
> =20
>  #define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, r=
eq, idle, g_mask, wakeup)	\
> -	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_of=
fset, req, idle, idle, g_mask, wakeup)
> +	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_of=
fset, req, idle, idle, g_mask, wakeup, false)
> +
> +#define DOMAIN_RK3576_R(name, p_offset, pwr, status, r_status, r_offset,=
 req, idle, g_mask, wakeup)	\
> +	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_of=
fset, req, idle, idle, g_mask, wakeup, true)
> =20
>  /*
>   * Dynamic Memory Controller may need to coordinate with us -- see
>   * rockchip_pmu_block().
>   *
>   * dmc_pmu_mutex protects registration-time races, so DMC driver doesn't=
 try to
>   * block() while we're initializing the PMU.
>   */
>  static DEFINE_MUTEX(dmc_pmu_mutex);
>  static struct rockchip_pmu *dmc_pmu;
> =20
>  /*
> @@ -1323,25 +1327,25 @@ static const struct rockchip_domain_info rk3576_p=
m_domains[] =3D {
>  	[RK3576_PD_VOP]		=3D DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(=
11), 0x0, 0x6000,  0x6000,  0x6000,  false),
>  	[RK3576_PD_VO1]		=3D DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(=
14), 0x0, BIT(12), BIT(12), 0x7000,  false),
>  	[RK3576_PD_VO0]		=3D DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(=
15), 0x0, BIT(11), BIT(11), 0x6800,  false),
>  	[RK3576_PD_USB]		=3D DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(=
16), 0x0, BIT(10), BIT(10), 0x6400,  true),
>  	[RK3576_PD_VI]		=3D DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(1=
7), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
>  	[RK3576_PD_VEPU0]	=3D DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT=
(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
>  	[RK3576_PD_VEPU1]	=3D DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT=
(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
>  	[RK3576_PD_VDEC]	=3D DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(=
20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
>  	[RK3576_PD_VPU]		=3D DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(=
21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
>  	[RK3576_PD_NPUTOP]	=3D DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BI=
T(22), 0x0, 0x18,    0x18,    0x18,    false),
>  	[RK3576_PD_NPU0]	=3D DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(=
23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
>  	[RK3576_PD_NPU1]	=3D DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(=
24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
> -	[RK3576_PD_GPU]		=3D DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(=
25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
> +	[RK3576_PD_GPU]		=3D DOMAIN_RK3576_R("gpu",  0x4, BIT(9),  0,      BIT(=
25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
>  };
> =20
>  static const struct rockchip_domain_info rk3588_pm_domains[] =3D {
>  	[RK3588_PD_GPU]		=3D DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x=
0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false, true),
>  	[RK3588_PD_NPU]		=3D DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x=
0, 0,       0,       0x0, 0,       0,       false, true),
>  	[RK3588_PD_VCODEC]	=3D DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  =
0x0, 0,       0,       0x0, 0,       0,       false, true),
>  	[RK3588_PD_NPUTOP]	=3D DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       =
0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
>  	[RK3588_PD_NPU1]	=3D DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x=
0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
>  	[RK3588_PD_NPU2]	=3D DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x=
0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
>  	[RK3588_PD_VENC0]	=3D DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0=
x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, false),
>  	[RK3588_PD_VENC1]	=3D DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0=
x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, false),
>  	[RK3588_PD_RKVDEC0]	=3D DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,      =
 0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, false),
> --=20
> 2.47.3
>=20
>=20

--3g4i4kdgz6zmtb4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr2AZ8ACgkQ2O7X88g7
+pqTGg/+IA/3t+nqg2axgiSAxUzY6beCjQNBUt8Uqeat0ODWUyGsy0oj/YRLr1WY
cb1ByCT+vYvwI4TARthWw9G4F51pdEndZ92BKDE3Nk79a+YIcNnfyWHpUkG8mi+1
N91UDLzcJGjpp+jkkpOeVsoqQdpmdioXAjVW/bYrAEg4ee4Mbr/xe+jwxl+Sr+dt
0lRY0zDTnFVZiepgumS99iyBMNnon3vtyQAZzi/CoQ6I0F0vwN6GQYm9PdOiOxtj
nLLnRSNIuT2S0DpcK1Jev0ABWRbbXRR1fieyKLbHDpHLXiQ6yk+8XHPM9f/zLVgq
z7CPhHCkIGGX25J4TRxcrtXffezrfMcexe8yFLnV1UWStl7GLvTdgTPt96Eol44U
wZ6DJxRhohwK07cj+Q6t0X5KSDuGLkjh2SAKd5KfbqJaJpkKKNYN7YU1tDRkhUDT
2ZyKJNxI8Osbnv8QiE45SIVGTKEjsbna2aWWyJc0VgFDyX2vog4gf1bDy0k8Bygc
SlkNyfck39DpLwO/xJ7YJPAVsSv8c+YJJxOBLeRuzsxpX2R63sOaVN5ji07j2gME
nLuuVb7x7HL1kJUqISSvj6e9bb3L5daMS6K2f+kbXenoYI8MMV3rkPsCmB9wLDG0
V90g8tcYmGmi5Eu9olMlkYkMNVD2DD5ULjbJ//qZK+bako4VG4o=
=Ajkk
-----END PGP SIGNATURE-----

--3g4i4kdgz6zmtb4d--
