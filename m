Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163E352038
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481728; cv=pass; b=gvxgKvUuyFJWZHKBawdQFc1SLks+kB2Xq68nzapTztWpf9ckGd5LkGDZON/1f9HiwzMDn7ASsW30iP0PMW9q415W2ByhJuwPDehOIoGcamXGv5Omvu/5z2eUs7aC/vEaGrWGJeTNceh3ND6dUgn0O3UUOlZAp9/rmSsmQIEbgzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481728; c=relaxed/simple;
	bh=No7+C8S9AW4FLnpcoGbXBfC3nW4Kvq/yHClQY6ndrgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McL5E4wMppQNiT2XNi8VcpPZ2pNF6ee0X8TNuKX1PgQCbaezO+Psl4Pga4YYxStOU9o6Ml9BiIs7QWxTZfnUdLI6cz3/KuOLQ/7xSZkNcEYrXK/GltABrJLCkp1nd9bqLXPDmT3MkD/ib8om9bsrtTZ9KsbFNw6xHdz5LgRqnzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XmrpaKZi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRKlo1zd; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XmrpaKZi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NRKlo1zd"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RIFL2076177
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 10:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ENWTTyz1dB4FHEiWpExoeF0j7dMymKgaFvfH6YbqIQA=; b=XmrpaKZigwia/7BY
	DCjkUP+LzEvNycdfLoO5/BLfMGABaH18v7DbZ0POu67u3H5IgMW75BXxhwpEeQj/
	PDNoDIf3n+cRt6WlYOt8mb09cJyhMObuWCMx497xl614LZRPIFwMzLrA2IXjW/LT
	rgkZFG12prZa/OJC5QUT3qDit1Z8AZPCJLj4+fl+g27leNvpdFN+yr7MEp5CJVtP
	kfFkuyheLAoVOLJXTFA2MiOGkmqZZUyYdefv3f3qzuUYladbXjT8ikhI02GJJsGz
	QB7o1d9GVv9HABFLI8KWBJEJ6vQ8rNYmLbGTe0CZiWHouz9Z1QdlNkNA4W9foDUM
	KPv7wQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev1912n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 10:15:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8cecf8bb835so7680726d6.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 03:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481725; cv=none;
        d=google.com; s=arc-20240605;
        b=ECRC4Eg5A2CCea1i0X7JXKkIC09wskibJTFNj5WupMSvwXWSP87rk1JT9PJi2zRRdk
         A0iqYRs17bJBhBCGC+2RkIU+L29QxMCZvRPxmn9uKTSiF3RK1xr2Va/pFczBf/kX/NnM
         xyuGwa1keO9wKKJhnr1gPcs+KOMIBYmU4sEzrnmga5kI9DinkgLlRtDzuTMjxG7WV/Re
         rwIJ2D1LWRMRtVHP8yCjRPaQLPbpUYP+OWlN1amwz/JLdp+tPVQ409WEiLHPTitiZiJ2
         qtJREuvZKZ2CUYg1d+DY3dlSHseF+Qb/CyAmm1pbVPYbf2MdNPLwy2x9Be/XmtbOu2s3
         L2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ENWTTyz1dB4FHEiWpExoeF0j7dMymKgaFvfH6YbqIQA=;
        fh=bXAUjzOG6fGvOlW+Io+ALrkefe9a+8w4P1P1wZyJI04=;
        b=LOvTxgLLJiXMS05NPblrqBDAi25HKgPufzdxSomHniaHyEWbtVDcS69/AX9wl1Mmpc
         1H8LkCBV0DxbT2b9S5YXg2UaPMVxpH93CTIvR1n8W9p0x7q+yI3xAEPrrTbnMuztlkLz
         INnwzFcgz8/s90FrY2A8KjCPr0itTz2DRcgWhQnKaWOL8cKTAc5M2X8ACPnBh1Emd2mr
         WHxOs8/QD4ipUv/9zdk3tADi9d4QwHllEkT32A05aFpJJ7s75SaRUQuHGqGu5JV48ehe
         U1J9FiVujxvIzaJLbhmgj2r3ef2FrRsP2XTyKH57j7oXk+ICrqXWuaGRShq+eTOIyD6T
         U2MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481725; x=1781086525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENWTTyz1dB4FHEiWpExoeF0j7dMymKgaFvfH6YbqIQA=;
        b=NRKlo1zd2R9LnLLdEyAKHgbB2I135rTxKvU9bH6C3pa4B+LLAQIarjUpZZYD5ft7e6
         usHNTPc9wnjpoZrZFYIGjV0CAgJah98I5UXBCB9JdwWpQvEZouBV7chSrgJ6UQkuL37p
         cA+uWDvz78lI5zkP9PIvzD/4/hpFuCzNAdUi9vhKZ3fFLLjqPdXpv/+A60REpVoJFy9M
         EMbfhZFzNaTZM8jIz/rKws//JocyHbt7NdeSEGKou+4ke1iirKpi3O3NiafAe5MI2FqT
         NR/xBD9j7Ld/z7Tf4jTGX1xhkunTqCQpQqwfYwKrSI9xnrnFgLj0UYbenGbJsToX/dLg
         Jqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481725; x=1781086525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENWTTyz1dB4FHEiWpExoeF0j7dMymKgaFvfH6YbqIQA=;
        b=s9EX/g7hjQGfIcwYRQQDLJpioPNwBuoEN3NjZDlo9spEecWq1tSpZpa5BnpzccG/lL
         4/Ct/08qT9P9VxUBD50JHMbdXUZfnQUvMQ+Ns+o2FvAYz87DsOXCOne7gOqsN4rT5KDk
         uwXUFSEoltR8tohe3+4rTpQOe9QxQmCrJFjHVMbgzr5SlCyrVBenp3zJIURGGyovZWqb
         anFQWXsWjPEenSiYzPkmsRm054jt++OZGHwmzj5k6xy/EhsuuGHb0L4fIFFwdlmCeOET
         qHeHSCz9/o78ePm8zM0KTGwAqxJAlripX6s+eSVcM+bmZapGOLai1BfgyRs51AX1hkmO
         zjNA==
X-Forwarded-Encrypted: i=1; AFNElJ99bkxcRI3RouT49w3SNJYlbOnhb0V/SiqjaeaUKwzkteJZnDWd9Ne+DpIPD07YjA4MTxDFoxsOSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHAkI+Gm9turI1IeRCl9De9hCM/649ryKEjgjvYFxFjmKN8bX8
	PVd6KrBa1LrbNiV6s1q43UefaieXaGQvwLmxT0nEvD/tDIRTVyeNib4O8dVSm7cVAc1jCtRySMN
	gCd5evj6KsjUz+LFl2xsfKj74lT4AkBWbnSbiJdWt/0SV9LY8M7QmN3CNGiCpeU8Tnn2T+yVhLY
	v6cCGM049jeufmmTo4qEVOSq8otev7UJvZJadu
X-Gm-Gg: Acq92OG6KIKH+joy6ueyI+CQMRDX+spfaJPMOffvKeDak8RWdMw/TM1hC5w0q/g8lL9
	TO4dAIJTtLZlp9JbXxyKj+o4jIbacV/h+hWp7T1MoM+U8d/IXDpJMA9sWbHPSqBloevobYeXObd
	GPyZsUCoq0XkFBcW/zmEbLdjMGC6S35VA35G6Fi6qxvDisuFA1lFm3A3mx87hdAPWhOh2thbArT
	2RXGjgZEbuOtwhM
X-Received: by 2002:a05:6214:3204:b0:8ca:25e6:e892 with SMTP id 6a1803df08f44-8cecdc15d66mr42033496d6.2.1780481724710;
        Wed, 03 Jun 2026 03:15:24 -0700 (PDT)
X-Received: by 2002:a05:6214:3204:b0:8ca:25e6:e892 with SMTP id
 6a1803df08f44-8cecdc15d66mr42033086d6.2.1780481724247; Wed, 03 Jun 2026
 03:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510-pck600-a733-gpu-v1-1-d6393646d714@gmail.com>
In-Reply-To: <20260510-pck600-a733-gpu-v1-1-d6393646d714@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:15:12 +0200
X-Gm-Features: AVHnY4K08klW06vk2eW3sXiNnVn0avH1wL4mD1fro5ZcJ4CYf6HKE76f_6zfqQk
Message-ID: <CAPx+jO9GrBPZvBr6pU7GpGdp=+xKQb4YSQut-M1LONEMnwkDxA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: sunxi: support power domain flags for pck600
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Mikhail Kalashnikov <iuncuim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: C8Skv68QleNOeQLD3VU3tO93T1nxPREA
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a1ffebd cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=gYkhY3VTAAAA:20 a=pGLkceISAAAA:8
 a=fAHllOzSo_MIxufCVBsA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: C8Skv68QleNOeQLD3VU3tO93T1nxPREA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfX7/0W5Bvk/fIz
 ylyBnrea3+p8wXl9+tEbPm4zdC1NUyHb6qzgfPKDdLYkL/ucZo6JiLXty2j0Dq0vYkBXQYVjIxd
 RLflGbRXLXGEiN2jS8uLJCv+xSHHgasWmO+7pHsRzXtyj/QklEEfjcDgMk6SG49vCedRque41mX
 Civc1w01rH14X6QMR1aGr4YAntDrPzhk+DoEHjaxsdHZL11ORDMs4195zmB4O4qz9rPvAnwmuq4
 pG9Ow2jsSclHEsPkvoSskgTAotBZdtWb/ByO0CI7SptkxavQ+sy9uLkAAOJx2af6L0/H0nBpTBR
 X8QtAEZpgP64eDEzVlWF7b5/S+R/FRzP5D4K39wg0IbT2qfNMwSw9US9+wF0cYYLYqdPJY5XuKY
 DYZr5scXcCAtkhgU+rnwIPQ1qbkZcBwV9KISGqm8RnEPaldhR5l79gxkq9qbNrI3J+shyD3hDU5
 Qe+oUz51xQCesJ5pmXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030097

On Sun, May 10, 2026 at 7:25=E2=80=AFAM Yuanshen Cao <alex.caoys@gmail.com>=
 wrote:
>
> Hi everyone,
>
> This patch refactors the sunxi pck600 power domain implementation to
> support individual power domain flags.
>
> While bringing up the PowerVR GPU on the A733 (Radxa Cubie A7Z), we
> found that one of the GPU power domains must be configured as "always
> on." While the Radxa BSP device tree leaves the GPU power domain nodes
> commented out, the GPU driver code contains traces indicating an "always
> on" requirement [1].
>
> Currently, sunxi_pck600_desc only supports specifying pd_names. This
> patch introduces sunxi_pck600_pd_desc, which stores both the name and
> its associated flags. This also (more or less) aligns the implementation
> with the existing sun50i PPU handling of always-on domains.
>
> With this change, individual power domains can now be configured more
> granularly. In particular, the GPU_CORE domain in sun60i_a733_pck600_pds
> can now be explicitly marked with GENPD_FLAG_ALWAYS_ON.
>
> The patch was tested on the Radxa Cubie A7Z, where the GPU now functions
> as expected.
>
> Thanks to Icenowy for her support and expertise on sunxi and PowerVR,
> and thanks to Mikhail for identifying this exact cause of the GPU
> bring-up issue.
>
> [1] https://github.com/radxa/allwinner-bsp/blob/cubie-aiot-v1.4.6/modules=
/gpu/img-bxm/linux/rogue_km/services/system/rogue/rgx_sunxi/sunxi_platform.=
c#L62
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/sunxi/sun55i-pck600.c | 31 ++++++++++++++++++++--------=
---
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pmdomain/sunxi/sun55i-pck600.c b/drivers/pmdomain/su=
nxi/sun55i-pck600.c
> index 1d47bbd35ced..8a37d11b65a2 100644
> --- a/drivers/pmdomain/sunxi/sun55i-pck600.c
> +++ b/drivers/pmdomain/sunxi/sun55i-pck600.c
> @@ -41,8 +41,13 @@
>
>  #define PPU_REG_SIZE   0x1000
>
> +struct sunxi_pck600_pd_desc {
> +       const char *name;
> +       unsigned int flags;
> +};
> +
>  struct sunxi_pck600_desc {
> -       const char * const *pd_names;
> +       const struct sunxi_pck600_pd_desc *pd_descs;
>         unsigned int num_domains;
>         u32 logic_power_switch0_delay_offset;
>         u32 logic_power_switch1_delay_offset;
> @@ -164,10 +169,12 @@ static int sunxi_pck600_probe(struct platform_devic=
e *pdev)
>
>         for (i =3D 0; i < desc->num_domains; i++) {
>                 struct sunxi_pck600_pd *pd =3D &pck->pds[i];
> +               const struct sunxi_pck600_pd_desc *pd_desc =3D &desc->pd_=
descs[i];
>
> -               pd->genpd.name =3D desc->pd_names[i];
> +               pd->genpd.name =3D pd_desc->name;
>                 pd->genpd.power_off =3D sunxi_pck600_power_off;
>                 pd->genpd.power_on =3D sunxi_pck600_power_on;
> +               pd->genpd.flags =3D pd_desc->flags;
>                 pd->base =3D base + PPU_REG_SIZE * i;
>
>                 sunxi_pck600_pd_setup(pd, desc);
> @@ -195,13 +202,14 @@ static int sunxi_pck600_probe(struct platform_devic=
e *pdev)
>         return ret;
>  }
>
> -static const char * const sun55i_a523_pck600_pd_names[] =3D {
> -       "VE", "GPU", "VI", "VO0", "VO1", "DE", "NAND", "PCIE"
> +static const struct sunxi_pck600_pd_desc sun55i_a523_pck600_pds[] =3D {
> +       { "VE", }, { "GPU", }, { "VI", }, { "VO0", }, { "VO1", },
> +       { "DE", }, { "NAND", }, { "PCIE", },
>  };
>
>  static const struct sunxi_pck600_desc sun55i_a523_pck600_desc =3D {
> -       .pd_names =3D sun55i_a523_pck600_pd_names,
> -       .num_domains =3D ARRAY_SIZE(sun55i_a523_pck600_pd_names),
> +       .pd_descs =3D sun55i_a523_pck600_pds,
> +       .num_domains =3D ARRAY_SIZE(sun55i_a523_pck600_pds),
>         .logic_power_switch0_delay_offset =3D 0xc00,
>         .logic_power_switch1_delay_offset =3D 0xc04,
>         .off2on_delay_offset =3D 0xc10,
> @@ -213,14 +221,15 @@ static const struct sunxi_pck600_desc sun55i_a523_p=
ck600_desc =3D {
>         .has_rst_clk =3D true,
>  };
>
> -static const char * const sun60i_a733_pck600_pd_names[] =3D {
> -       "VI", "DE_SYS", "VE_DEC", "VE_ENC", "NPU",
> -       "GPU_TOP", "GPU_CORE", "PCIE", "USB2", "VO", "VO1"
> +static const struct sunxi_pck600_pd_desc sun60i_a733_pck600_pds[] =3D {
> +       { "VI", }, { "DE_SYS", }, { "VE_DEC", }, { "VE_ENC", }, { "NPU", =
},
> +       { "GPU_TOP", }, { "GPU_CORE", GENPD_FLAG_ALWAYS_ON },
> +       { "PCIE", }, { "USB2", }, { "VO", }, { "VO1", },
>  };
>
>  static const struct sunxi_pck600_desc sun60i_a733_pck600_desc =3D {
> -       .pd_names =3D sun60i_a733_pck600_pd_names,
> -       .num_domains =3D ARRAY_SIZE(sun60i_a733_pck600_pd_names),
> +       .pd_descs =3D sun60i_a733_pck600_pds,
> +       .num_domains =3D ARRAY_SIZE(sun60i_a733_pck600_pds),
>         .logic_power_switch0_delay_offset =3D 0xc00,
>         .logic_power_switch1_delay_offset =3D 0xc04,
>         .off2on_delay_offset =3D 0xc10,
>
> ---
> base-commit: 1bfaee9d3351b9b32a99766bbfb1f5baed60ddef
> change-id: 20260510-pck600-a733-gpu-dcbfc0c7ce99
>
> Best regards,
> --
> Yuanshen Cao <alex.caoys@gmail.com>
