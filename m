Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99503932C6
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030694; cv=pass; b=Ffzs10dRa+bTuCT62TRMBwHUJMXn0Gr+BUvCuu6A0qiYRdxlxaGf0dl5eLRIBKHDPpIOmtAiCnw1zzeqlaH+jJxQhka3KtkGOpRdWvaKDONWlGWqWE6qoBtJxn/p4lZPC5tA832BrCJBZn07RHwa0AqyWIczNwTrIcEc5+fYH10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030694; c=relaxed/simple;
	bh=IhOcu2PS4sBOU1d9rNLBRpPlon4qfEEhIsBef1KmHjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZ3rU3L59AuRqjmUcduTkhoVNDvwJug5ZEFAwI8ZoH3e0zirTqHFC+3VRW3q0lMbNhDmYIu53iwoDwyldpZqpsEBcrPxxxEhGxWkyG7DhamowzDb4QTevCKmMtM8z82ikHn2FXFM0G1W9ditWy8juUekXgtI3ZN5uzYC9MZHW6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gmCTbNOv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bq+aTNBR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gmCTbNOv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bq+aTNBR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBNv57231236
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 12:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YAksXXcYTs7qreOl6ykQXBvBHyCNYeVnc316wr7L798=; b=gmCTbNOvkkQQpDE7
	WXD2MuP7stI2PhhR6m9lpRh1z2YICzJdC+2PemJb2sWi5uUH2dHiIzphkM+yoiiB
	59oQY6vUmBuuDkAWRUoJCrSTHgXAtkSc0lQ4mGSWJ8W/Prr43ZWKXLsO6Zz0Y5js
	ZgMzc220iHs2jLL6DiRc1R2dfSn55rxqWZ96fq0JrUB3eYUU0eMytj08MT0X+kN4
	qw4fhvR92SSAtAq3+IKEn2n82M88v91ywjkrkzp6ChZBP2mp7xaQk6Tb9QglSO0A
	9LVAtYSGzjx6fgrcAM7R1iK6nIZlsgbTGvlKy3eDjJGffWkIZKlzuAs4NkHy8VE+
	IQNTiw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44p3h32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 12:04:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ac0a54110so663359985a.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 05:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784030690; cv=none;
        d=google.com; s=arc-20260327;
        b=L0237lTr3PxHo4HCxTCsyds+JFvRCM3n88SIYbPgpZbtbJLMEblCVWVwvjidS2FH7Q
         uJLKeoMABXq0QJkWkELNeUvjs2uZZKhTkspojX+aDDIHQm8l/CiOdsDJTN1c9QEjRybf
         X4jySooLmSFHgeZple8fCe5vxm69YII5/RDQI9NqKlfs2nkN6ZrZ42aaSzChjgodTFOl
         /b6ay16kOnMO7wuxLw4Mv+avsAJCofy6dP68S+/c6mo48vk1Qu5CBXexu58XwlFUZt0I
         awWrw4dx9dfuNz0GmXkRW30RhUso0FHura1Fa3b/b0AJdAFS46ygh007LzctVRQFVu7E
         0LiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YAksXXcYTs7qreOl6ykQXBvBHyCNYeVnc316wr7L798=;
        fh=Q0X3UgicSF8BQ7urVR6jtgNWZYVDW9B1D2XEz0E6ZW8=;
        b=ctHOEbLdJ0N24J/DrrZGYm9Oo1uMizIUPJQHV4V5gk7V0oT9Ivw7jLsbna9P8o8SQI
         +tQLSiwfeZp2cOd4HZw8D1op6HPY959OhnLc5FmTv4Yr4KwaYp/h3J7Rv5ua0d1MKlT8
         dj+oNPskMou7B5L7e8srKaf8TE2wNAQtREalYUsnKq6BCBENlhpY4HVZmc/FKtQ8Jh42
         ps8hAxhJJxTY+BzxvgOQYwMkzuH2/4XY5/C0xUlq8EXWo+BZ6DD7OUTNslI3uS1akcK+
         /9Nj6vWf7Bc2wOOO7wNu7PMjN/bZ2zJN3AdRBkVrS+ku3TOoSeuLxvS+O8Dh9fLeLuRL
         0uWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784030690; x=1784635490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YAksXXcYTs7qreOl6ykQXBvBHyCNYeVnc316wr7L798=;
        b=Bq+aTNBRekkBpgaP26yUPGCQewSP1dIbyAOXSeg92wehaX+Qm9ULcLGxcqXU5Zsdvi
         oMX8XO4v0SjMkmzlYsaySCaITYG4p9VG4N2jo3n6NbxYXRYpgfma5Aac64iIq32qJzA0
         CoLuzbgwRKmovI8fGsUjhwUecpibRgWMaykoeA0zRd20pPrxK1/S0fQ2vgSKoEjeI/kb
         FN3kpik/1XJHkQj/6FAoTTV/3p4kqN80wvHAaj3ed58mBnEf7Qv9Rx/x9oncyv5rcVoi
         u4sEOsi9J46ckJhKXgtfrf2Z1H7+icR4WqOwSATXCs6kk9b11EMJCd7zOxKuR+BUIHTi
         iE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030690; x=1784635490;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YAksXXcYTs7qreOl6ykQXBvBHyCNYeVnc316wr7L798=;
        b=BucgVp8cnbt++vCWpEXvtXzDRpI1na7dCKZ+tAn4lURXdY18Msdu3XfQl0wf+wgyWO
         D3H+Uowqoe/WjtkNRCq0qo4+5z0U4gUsqfxOa9fwbLlQDygfxlNy+mm1A+01l7ghxL1s
         HoRHc/oBftMtR+hvR+Bppk0XH7HQyAQY8LRmsWh9BuEMl3M1m8/C4EJsn15ggu90DkE7
         pBFTkRyz+k7dRT2v0H66X7IU0qsKhEMuGCyLi+dNmFcDaAhA0isQF3tjvcL2wrcYejMK
         jmIAf35B4HEB41Rl9sH84/FCWIcpYapBM6wyz5pBO46T5SIFQ4aurFg33sP20y9TRSDc
         Fscw==
X-Forwarded-Encrypted: i=1; AHgh+RqJnY8i49EJGcS0WO0syslE0dTxZsYAtF/Vpqaplmwtqqps+HTmNYe75HGiPdh7viRAmT2GP+Odzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcmVNV1vrutd2QONrqRZ7MN1JuP0lHbI8jeuEOXKPoSqEhX+0y
	PCQYDeW+Q8crYHZm31cey4zKpYyQfeIEplkIfAMNnlcOYsJXpqoExrEx9TnL5N8/+fMCw7Y7fkZ
	jiFOc49u9tsPZ21bYovmoLGo2yVzcMJ9oqPYg2N68hfcXKL8JH8AqKlrOghAk2YkglzI9eJPVb2
	QN5fXBtlUmFUlJ00BRsc2Dhn8ZFxgPZdXT6SJx
X-Gm-Gg: AfdE7ckAT8dA/hHoZPUkklyTSpqVU1xlLe8sI3sdtXOVQvDHGzXjjuGSCKJQ1E0ugWw
	L+ON0aZHgfVN+vQd8wkBuG22YqtyQYkd5VWtzmFGAuZOCUYgx1xh6KbDmCnB3xJIcAHDNE/+hnM
	jORBEGmglKrM5GKDMd5yhVUBcIVFXu7ocxvkhmyctiLTjxhUMcmfmgiIj9ezA9bmQnPVSD
X-Received: by 2002:ac8:5f91:0:b0:51c:7b12:5fff with SMTP id d75a77b69052e-51cbf2ddef5mr127882981cf.75.1784030690344;
        Tue, 14 Jul 2026 05:04:50 -0700 (PDT)
X-Received: by 2002:ac8:5f91:0:b0:51c:7b12:5fff with SMTP id
 d75a77b69052e-51cbf2ddef5mr127882421cf.75.1784030689773; Tue, 14 Jul 2026
 05:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505142.git.geert+renesas@glider.be> <23f979b0903ca11513ac339ab8b6dd40435603c5.1783505142.git.geert+renesas@glider.be>
In-Reply-To: <23f979b0903ca11513ac339ab8b6dd40435603c5.1783505142.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 14:04:38 +0200
X-Gm-Features: AUfX_mz0pm1bKZMzEgKkx0pxSzyNhryLI17GoLwTGSkPYUe4ECmwKPI1jisfYfg
Message-ID: <CAPx+jO-=LF9CvYDrC3O_GBtfHU6GYvq524OLmTG8R1-u27oyKw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] pmdomain: renesas: Add R-Car X5H MDLC driver
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyNSBTYWx0ZWRfX706BSfcwoPJI
 R6uHOYn0ZSHmD3hxlNV3lsesDXx7g9onAf6Kxf3WFtZ+MCDQ/+GR5Fp4hstVrpjnqBNCJZgqUx/
 kLpJgG0Xtx/0G5XXcjmyoS8wsom/lMs=
X-Proofpoint-GUID: nHxEKFgBsP-txFHGzUBQymi737LbOuCe
X-Proofpoint-ORIG-GUID: nHxEKFgBsP-txFHGzUBQymi737LbOuCe
X-Authority-Analysis: v=2.4 cv=BZroFLt2 c=1 sm=1 tr=0 ts=6a5625e3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=UmYWVhtEHbvSSgRh88EA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyNSBTYWx0ZWRfXxW4ZmtAgEr+l
 2qmY24xIto9FGIlOMFgluzDmYaWPPGTb+po3OiBsF6tVZVjBclLDEP2ttJTc28qRwRl+Xo92L5Z
 /D/abIe+gf1wdETApR9s8PLxfgGzwypY728nmFLr/I6jL+WPr3DWBHvj7CxNmoeoD0kWcU5Jh+L
 4AA+04LZbBUAHkyopLARFclmxVryG2Z08ge3Bj1k/ptO+EdVFVANmwPq+MECvM737GALGGZvEP9
 ofy6PW4hswqYlgbS9WIVOQsqO4x8zcqF/EgVnXqZaBcBTJ1YJIgljTBqLebNeu9she+NRH9aF5C
 Gii1QEIjhqAyz4LExMAIAMzcItAYx0Etl+eIxKilscvZCj3kByFTg0bMeHaSBGWbagylTNk16tR
 h3pgOqCEWwbnFh7GboL6tWY+4uuf/8lzjEHqAi4yTf5Z0G+1DOnZPlqCBQmZSEfvfIB3OTE5tLL
 YzSpLFDGcf/vqmsDjPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140125

On Wed, Jul 8, 2026 at 12:15=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Add a minimal Module Controller driver for the R-Car X5H (R8A78000) SoC.
> For now this just supports the always-on power domains, and dummy clocks
> and resets for the serial console (which is enabled by the boot loader).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Calling genpd_add_provider() instead of of_genpd_add_provider_onecell()
> would be sufficient, but the former is private.

Right. Callers that need their own xlate callback should just assign
it before calling of_genpd_add_provider_onecell(), as the below code
does.

>
> v2:
>   - Spin off from "pmdomain: renesas: Add R-Car X5H MDLC SCMI remapping
>     driver",
>   - Add default support not using SCMI,
>   - Drop all SCMI remapping support,
>   - Document use of -1 as a sentinel,
>   - Rename struct r8a78000_mdlc_info to mdlc_info,
>   - Print HW IDs in hexadecimal,
>   - Reduce log level for unsupported MDLC instances from warn to dbg,
> ---
>  drivers/pmdomain/renesas/Kconfig         |   4 +
>  drivers/pmdomain/renesas/Makefile        |   1 +
>  drivers/pmdomain/renesas/r8a78000-mdlc.c | 329 +++++++++++++++++++++++
>  drivers/soc/renesas/Kconfig              |   1 +
>  4 files changed, 335 insertions(+)
>  create mode 100644 drivers/pmdomain/renesas/r8a78000-mdlc.c
>
> diff --git a/drivers/pmdomain/renesas/Kconfig b/drivers/pmdomain/renesas/=
Kconfig
> index b507c3e0d723efc6..f2f52d3c29a083f1 100644
> --- a/drivers/pmdomain/renesas/Kconfig
> +++ b/drivers/pmdomain/renesas/Kconfig
> @@ -13,6 +13,10 @@ config SYSC_RMOBILE
>         bool "System Controller support for R-Mobile" if COMPILE_TEST
>
>  # SoC
> +config MDLC_R8A78000
> +       bool "Module Controller support for R8A78000 (R-Car X5H)" if COMP=
ILE_TEST
> +       select RESET_CONTROLLER
> +
>  config SYSC_R8A7742
>         bool "System Controller support for R8A7742 (RZ/G1H)" if COMPILE_=
TEST
>         select SYSC_RCAR
> diff --git a/drivers/pmdomain/renesas/Makefile b/drivers/pmdomain/renesas=
/Makefile
> index 0391e6e67440a786..17849aad37a5ac4f 100644
> --- a/drivers/pmdomain/renesas/Makefile
> +++ b/drivers/pmdomain/renesas/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # SoC
> +obj-$(CONFIG_MDLC_R8A78000)    +=3D r8a78000-mdlc.o
>  obj-$(CONFIG_SYSC_R8A7742)     +=3D r8a7742-sysc.o
>  obj-$(CONFIG_SYSC_R8A7743)     +=3D r8a7743-sysc.o
>  obj-$(CONFIG_SYSC_R8A7745)     +=3D r8a7745-sysc.o
> diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/=
renesas/r8a78000-mdlc.c
> new file mode 100644
> index 0000000000000000..ed367e921a3341a7
> --- /dev/null
> +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * R-Car X5H Module Controller
> + *
> + * Copyright (C) 2026 Glider bv
> + */
> +
> +#include <linux/dev_printk.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/power/renesas,r8a78000-mdlc.h>
> +
> +struct mod_map {
> +       int hw_id;              /* Hardware module ID or -1 sentinel */
> +};
> +
> +struct mdlc_info {
> +       u32 base;
> +       const struct mod_map *mod_map;
> +};
> +
> +/**
> + * struct r8a78000_mdlc_priv - Module Controller Private Data
> + *
> + * @link: Link into list of MDLC instances
> + * @genpd_data: PM domain provider data
> + * @rcdev: Reset controller entity
> + * @dev: MDLC device
> + * @np: Device node in DT representing the MDLC
> + * @mod_map: Mapping from hardware module IDs
> + */
> +struct r8a78000_mdlc_priv {
> +       struct hlist_node link;
> +       struct genpd_onecell_data genpd_data;
> +       struct reset_controller_dev rcdev;
> +       struct device *dev;
> +       struct device_node *np;
> +       const struct mod_map *mod_map;
> +};
> +
> +static struct generic_pm_domain *r8a78000_genpd_always_on;
> +static HLIST_HEAD(r8a78000_mdlc_list);
> +static DEFINE_MUTEX(r8a78000_mdlc_lock);       /* protects the two above=
 */
> +
> +static struct generic_pm_domain *r8a78000_genpd_xlate(
> +                       const struct of_phandle_args *spec, void *data)
> +{
> +       struct r8a78000_mdlc_priv *priv =3D container_of(data,
> +                                       struct r8a78000_mdlc_priv, genpd_=
data);
> +       struct device *dev =3D priv->dev;
> +       u32 id;
> +
> +       if (spec->args_count !=3D 2)
> +               return ERR_PTR(-EINVAL);
> +
> +       id =3D spec->args[0];
> +
> +       if (id >=3D R8A78000_MDLC_PD_AON) {
> +               dev_dbg(dev,
> +                       "Mapping HW power domain 0x%x to always-on domain=
\n",
> +                       id);
> +               return r8a78000_genpd_always_on;

This looks odd, but perhaps it's just a temporary mapping that you
intend to change later, no?

> +       }
> +
> +       dev_err(dev, "Unknown power domain 0x%x\n", id);
> +       return ERR_PTR(-ENOENT);
> +}

[...]

> +
> +static void r8a78000_genpd_del_provider(void *data)
> +{
> +       of_genpd_del_provider(data);
> +}
> +
> +static int r8a78000_genpd_always_on_singleton(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd;
> +       int ret;
> +
> +       guard(mutex)(&r8a78000_mdlc_lock);
> +
> +       if (r8a78000_genpd_always_on)
> +               return 0;
> +

I guess the mutex is used to protect the global
r8a78000_genpd_always_on, but it looks like that isn't really needed
based upon how things are being called during the probe.

> +       genpd =3D kzalloc_obj(*genpd);
> +       if (!genpd)
> +               return -ENOMEM;
> +
> +       genpd->name =3D "always-on";
> +       genpd->attach_dev =3D r8a78000_mdlc_attach_dev;
> +
> +       ret =3D pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
> +       if (ret) {
> +               kfree(genpd);
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to create always-on domain\n=
");
> +       }
> +
> +       r8a78000_genpd_always_on =3D genpd;
> +       return 0;
> +}
> +
> +static int r8a78000_mdlc_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *np =3D dev->of_node;
> +       struct r8a78000_mdlc_priv *priv;
> +       const struct mdlc_info *info;
> +       struct resource *res;
> +       int ret;
> +
> +       ret =3D r8a78000_genpd_always_on_singleton(dev);
> +       if (ret)
> +               return ret;
> +
> +       info =3D of_device_get_match_data(dev);
> +       if (!info)
> +               return -ENODEV;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev =3D dev;
> +       priv->np =3D np;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -ENODEV;
> +
> +       for (; info->base; info++) {
> +               if (info->base =3D=3D res->start)
> +                       break;
> +       }
> +
> +       if (!info->base) {
> +               dev_dbg(dev, "Unsupported MDLC instance 0x%pa\n", &res->s=
tart);
> +               return -ENODEV;
> +       }
> +
> +       priv->mod_map =3D info->mod_map;
> +
> +       scoped_guard(mutex, &r8a78000_mdlc_lock) {
> +               hlist_add_head(&priv->link, &r8a78000_mdlc_list);
> +       }
> +
> +       ret =3D devm_add_action_or_reset(dev, r8a78000_mdlc_unlink, priv)=
;
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to add action\n");
> +
> +       /* Note that no actual domains are registered, just need translat=
ion */
> +       priv->genpd_data.xlate =3D r8a78000_genpd_xlate;
> +       ret =3D of_genpd_add_provider_onecell(np, &priv->genpd_data);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to register genpd provider\n=
");
> +
> +       ret =3D devm_add_action_or_reset(dev, r8a78000_genpd_del_provider=
, np);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "failed to add unregister action\n")=
;
> +
> +       priv->rcdev.ops =3D &r8a78000_mdlc_reset_ops;
> +       priv->rcdev.of_node =3D np;
> +       priv->rcdev.of_reset_n_cells =3D 1;
> +       priv->rcdev.of_xlate =3D r8a78000_mdlc_reset_xlate;
> +
> +       ret =3D devm_reset_controller_register(dev, &priv->rcdev);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to register reset controller=
\n");
> +

In some of the error paths above it looks like we end up leaking the
data allocated for r8a78000_genpd_always_on. Perhaps clean up that
somewhere here.

> +       return 0;
> +}

[...]

In regards to the merge strategy, I intend to pick patch 2 (shared via
the immutable dt branch) and $subject patch. Please let me know if
there are any issues with that.

Kind regards
Uffe
