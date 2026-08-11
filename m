Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74B435529
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443369; cv=pass; b=l+7PkaKoTB891pJ9fHfZj7UD/3BsuEjwXdARFodjM/bS8MmRGgMcUeOzrWJXAEwrqRx6FNnmJZWsdvA8eEEFiJYKlsI/cuhGIp6+AaTvuphyBhzDRy6/6ULGiGmcWnwbx0NN4A1n/0SiFQmIUQ0LtDKV2cj8nkSIxjH1at/Djbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443369; c=relaxed/simple;
	bh=znnZzewmT/F+iDUDEdTCsDpOgnBadsJdR7cElUaBUOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmEi+7XQnraoX/SEFGHKljGknEw0dMUjYEoBrZuHMsOHsrpDk3vAEM4LCAOAdx4CNa8kGnwxs5EFgeBWNf/byCAuWcQbhS64APKgqW/BV/IXZYxaatjibI/lzZDNzTrnSXqx3eBg66RGWlCW5DKyb9UxggrIk13HDMrUxIIyHGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FvTFNqLy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iZIHkbwd; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FvTFNqLy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iZIHkbwd"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B7BTFs2687295
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D1A+fYhAaYvLK7iwOnTwEkzymFsvkfIMelFoOJLNgsE=; b=FvTFNqLyABeuXzPB
	JJDdFJyL4xN4kBlV2cIMSnlV4VLON76bY8JUi6orFGZQ10VMbqjaxlk+/rfcPMPJ
	O68fc/ldHJBPO3AKiaUC+LOLzMAgjeTOvphAsgkcpISNxu6oY64QHN8UNIA2/YQC
	hgb9NgXtorLXwL3xqvV8A9pUBbuQOZQrPeoPz95Wgr8BlS7WqtssKv1Jan0So6Sd
	tqPCQnu8jUmLyhxFMKuQuo0BTkbUxQz0xKDy474mcyEPGNQep04Jnk6trQe/A/c8
	cXqbI5i9S+VaY0eN5HlQVzlZc4gSwWBGcvDikgYcYAAE/6Lg5avY7R9f6REuTC+1
	vlr7oQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjskpcc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:16:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbedbd182f5so94756a12.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786443364; cv=none;
        d=google.com; s=arc-20260327;
        b=OslcFDgqw9w5A+OvtEfwivSP8MZmBmIJflHtun4e4U+rS8j3TzHX+YAL8H2GE5wZBu
         Y8vZBVbs2PkieZp4OKHO43uhKqqziir9rO1LwIFwBO8xst83cJd7h89NGy5fQefDD4ap
         cCtqBd/9jliQ+9a/ggesf9wXrwEExRN3DO2DAxlwthRUdZVHxdG9G1+PE6DnQNFoMi6B
         o8UADqCxmrAYEarNPs0HlNn+CF7hi5VfAF5s1hpUMf8QspPTkEyewZNm9CDlVH9gcWnl
         80MGCAu8H9pEjSb0EvQjwSdA4nJLfYdgt+W3s8p4K5GAf+rduLZjzDcI497qtmGhpORW
         w/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D1A+fYhAaYvLK7iwOnTwEkzymFsvkfIMelFoOJLNgsE=;
        fh=dedLhQMDjCd6n1la/sRndcZjfArmy7Via62Zf92feds=;
        b=aqJ1Yc8YG5Lhlr1xu3BQL4EWdJ6MUTTJl3Bl1eYx54DXJN6rjo3adquIFJ/t+ZoGU7
         w125djDZEhtHiADdmiiGsRkREco4S5orcPwpiQ4aE+Z5UKljPpgWuEQ2D2GONQXPY+31
         MWQjX0fcBiFiT1zi+86G0ahxdJdHGjRy1ZYX+Js7usV+vtWjUH0RmnQ0j9GZvVmzqJWe
         98P7kua1wgoCI14OMupKf2w9MhjXP3cS+9IctMnrfEaA0IvzFW+0BQ1NtTnN7jt1YuxX
         62PZgqlE8H9lalpv1h+jsmRSmNWc26ncQSJ2vLYlxVYOVYWhm1ICjcbGAgrpYpy4WYSR
         QYPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786443364; x=1787048164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D1A+fYhAaYvLK7iwOnTwEkzymFsvkfIMelFoOJLNgsE=;
        b=iZIHkbwdCgsJfhSU6sBtTRRZ2Lqu9GlrBQoDp62X/3Gxn2OhcV86lV+5R1yefDn6Wo
         CHlJ17RlGX1xiueN7um4BLDFNrBe4xXDjth0SvdOC8kutZdCC/XKn9BdeqW0/oEPQQiE
         ggIq2WEXvlPs9PmBGiBXtkQDX/atCBIx27gXINzvdDoDNMg3+K8Q5FRlyw2Eq8/8tqfl
         soQd7vEmfq/7WBYBFK3Jg9LFchS+0Xtnc/K5iSK7PFNQy4ccW68X9jWKc3iCl/zOWytN
         I/wvjhXl6fW60RwvlzEbf2PNgt7+IKe01U3RFrWKAa6cSNVM79Y8QfMuoEVIzRay/XGR
         maJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443364; x=1787048164;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D1A+fYhAaYvLK7iwOnTwEkzymFsvkfIMelFoOJLNgsE=;
        b=TE+/4q3/TbFDOUVci65Qgo8Tk7GNl47HtFmy3KyWsP2dijIDMPQfKt1n2klQBay+o3
         oaEVFg+RiTEZlIhlDPKSeFWoVCwZsWTGRX2gQ2bxFtLsPPQwWPJws29LutL8KVtyUCYN
         gePK+/5LPj2rfToxATHysAgKIZ8Mx3E5wtRPHFlHGOTscPtdvxgoejOzQhopA4AS4xUS
         TJYm4IlmgU/uED+/QulhiS+APk0Q6Iy472D69vicAa6ZEJaPJvGXkOZHglDVp4kclNsi
         8QGSZatUgjt4/4+T84TVphrIu8g5/u0oEl8+kUMEf4Wl3wtx54q0mho/06WOo3yig1wI
         b0mQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqbk4AJS7dg9xuYDeeYuD0MIJhQ49car6Po7rqu5rb+SEkjNB3i/1oaocmVK8ynA9zQ117w8iEpIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJXNzXMiybG/a5eKP/XApzMEKKSOVd973FWlJtzhudWKBUHs2
	3EUmjdRTXcxiKI+8MkIJqmHLZ00VE9CIWHLfI+LtwcpU5tFEPh4qVnilEZZgjptEYHWN+mpoeoX
	3f8Nn6ouSyOz6/id4aysqdYt3OBL664TSMRIKJHe9rjfSbO0qn4EPCNaUNSh76vK3cQfcCj3qO1
	EhDyhXznWomt093K+ibG3TNPpySNdvLpGOTmiae1yDoSYMAQ8=
X-Gm-Gg: AR+sD10EsdrECwDEI2FKW1znMcLlIBNBeQR19SoSUQ+0iHpZnnqVKftGXR0Ia8Ok9ZE
	PrNauRZrrXaOvL4duT56soTpbIppJJvYBtNTEi0YaRv7/topiM4JvfJzqsuJiiI4PWy78abGXvq
	Hs63a0fXSaYOXKK6eMgU+JGP9ieNQeV7GFew1fRMJh2o+T1NIg6cyc6HpXgw==
X-Received: by 2002:a05:6a20:9e0e:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3cc2e09b3a8mr2330216637.14.1786443364309;
        Tue, 11 Aug 2026 03:16:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:9e0e:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3cc2e09b3a8mr2330159637.14.1786443363796; Tue, 11 Aug 2026
 03:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4bd0cc7f26c1bcdc260edb994b4971cb5dd3a10.1786438424.git.geert+renesas@glider.be>
In-Reply-To: <d4bd0cc7f26c1bcdc260edb994b4971cb5dd3a10.1786438424.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 12:15:52 +0200
X-Gm-Features: AUfX_mzo9d9Ehsy0kJYEaUYUeD_sgjALUKL1j-gAwWg-EJiCOYrFK7gAGqoA0_A
Message-ID: <CAPx+jO-uXbNpFPzbAbDkBQh2-xf4r1NXk2PdQvOh9ZOfEQ71gQ@mail.gmail.com>
Subject: Re: [PATCH v4] pmdomain: renesas: Add R-Car X5H MDLC driver
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4NCBTYWx0ZWRfX17950BMZROuy
 Ow+wxUV8khjY+UeDV0t7KoKQ+7vfhOUeAybjSSliCIy2x9bGb/CHt83f5BGANTtaaP80g6GUGDB
 EJp+u9UXad3xAL4vMARCjiDFHJfzFZo=
X-Proofpoint-GUID: wx-6aXEfYHky0boCsq-Lg5UHYmG3mzPY
X-Proofpoint-ORIG-GUID: wx-6aXEfYHky0boCsq-Lg5UHYmG3mzPY
X-Authority-Analysis: v=2.4 cv=cfDiaHDM c=1 sm=1 tr=0 ts=6a7af665 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=TwdlpdOv2MY0_bTcK8AA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4NCBTYWx0ZWRfXw+FFzvzalHyt
 pvPV1iN+UEN3gNlCMgXp0S5fQGgN7ivEQpukH+tHG1KhEkqLSzAltfOxvvzQ5EwKmeTHCuqQB2e
 cZnyVFEbSfF5CzYnRsATw7CsQMu2hUuA3CrVJDqUD7KXpC0xGf+TO8aItYSkwZeW2lDDtlMOV5T
 8n7xyPmf3f6b0+qyWhw9FjfVG5BzKbPc5x0R/ewGy1oueCeoT0GYoVX1pNqfbOLW7XG0GZIvq5r
 HSNwNOM1Fi7zv4IELedQmNfvZe/LPAoosM7BhR52g1h3tAVcQFHqDw8LrRgXPiMCsVcjB3dJY3e
 Evyqsl0FyG3Htx0hnYxc77hHYh7NQ6QKcBGHLQ1ADq7ZaZHbVv8QAKneSLwP9Maww3kdXvKEQtK
 or54sbbvajjjggN0rmwTddxNBmPmtFUXNOSiDvmXMUjChiJWjNb1qicWJqkCyQ9kMEc8CLSKdlJ
 AFT7xWc5vh+qCh32fhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110084

On Tue, Aug 11, 2026 at 10:58=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Add a minimal Module Controller driver for the R-Car X5H (R8A78000) SoC.
> For now this just supports the always-on power domains, and dummy module
> clocks and resets for the serial console (which is enabled by the boot
> loader).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Hi Geert,

I had a closer look at the attach part and there is few questions,
please see below.

> ---
> v4:
>   - Extract from series "[PATCH v3 0/6] R-Car X5H CPG/MDLC support"[1],
>   - Rebase on top of pmdomain/next,
>
> v3:
>   - Replace <linux/mod_devicetable.h> by more specific
>     <linux/device-id/of.h> in v7.2-rc2,
>   - Add a comment to document only always-on domains are supported,
>   - Consistently use /* sentinel */ for zero sentinels,
>   - Drop trailing commas from sentinels,
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
>
> [1] https://lore.kernel.org/all/cover.1785941595.git.geert+renesas@glider=
.be
> ---
>  drivers/pmdomain/renesas/Kconfig         |   4 +
>  drivers/pmdomain/renesas/Makefile        |   1 +
>  drivers/pmdomain/renesas/r8a78000-mdlc.c | 330 +++++++++++++++++++++++
>  drivers/soc/renesas/Kconfig              |   1 +
>  4 files changed, 336 insertions(+)
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
> index 0000000000000000..5c8acead7cff9bdd
> --- /dev/null
> +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * R-Car X5H Module Controller
> + *
> + * Copyright (C) 2026 Glider bv
> + */
> +
> +#include <linux/dev_printk.h>
> +#include <linux/device-id/of.h>
> +#include <linux/module.h>
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
> +       }
> +
> +       /* For now only always-on domains are supported */
> +       dev_err(dev, "Unknown power domain 0x%x\n", id);
> +       return ERR_PTR(-ENOENT);
> +}
> +
> +#define rcdev_to_priv(_rcdev)  \
> +       container_of(_rcdev, struct r8a78000_mdlc_priv, rcdev)
> +
> +static const struct mod_map *mod_map_find(const struct mod_map *map, u32=
 id)
> +{
> +       if (!map)
> +               return NULL;
> +
> +       for (; map->hw_id >=3D 0; map++) {
> +               if (map->hw_id =3D=3D id)
> +                       return map;
> +       }
> +
> +       return NULL;
> +}
> +
> +static int r8a78000_mdlc_reset_xlate(struct reset_controller_dev *rcdev,
> +                                    const struct of_phandle_args *spec)
> +{
> +       struct r8a78000_mdlc_priv *priv =3D rcdev_to_priv(rcdev);
> +       struct device *dev =3D priv->dev;
> +       const struct mod_map *map;
> +       u32 id;
> +
> +       if (spec->args_count !=3D 1)
> +               return -EINVAL;
> +
> +       id =3D spec->args[0];
> +
> +       map =3D mod_map_find(priv->mod_map, id);
> +       if (!map) {
> +               dev_err(dev, "Unknown reset 0x%x\n", id);
> +               return -ENOENT;
> +       }
> +
> +       dev_dbg(dev, "Ignoring HW reset 0x%x\n", id);
> +       return id;
> +}
> +
> +#define DEFINE_MDLC_RESET_WRAPPER(op)                                   =
   \
> +       static int r8a78000_mdlc_ ## op(struct reset_controller_dev *rcde=
v, \
> +                                       unsigned long id)                =
   \
> +       {                                                                =
   \
> +               struct r8a78000_mdlc_priv *priv =3D rcdev_to_priv(rcdev);=
     \
> +                                                                        =
   \
> +               dev_dbg(priv->dev, "%s: Ignoring\n", __func__);          =
   \
> +               return 0;                                                =
   \
> +       }
> +
> +DEFINE_MDLC_RESET_WRAPPER(reset)
> +DEFINE_MDLC_RESET_WRAPPER(assert)
> +DEFINE_MDLC_RESET_WRAPPER(deassert)
> +DEFINE_MDLC_RESET_WRAPPER(status)
> +
> +static const struct reset_control_ops r8a78000_mdlc_reset_ops =3D {
> +       .reset =3D r8a78000_mdlc_reset,
> +       .assert =3D r8a78000_mdlc_assert,
> +       .deassert =3D r8a78000_mdlc_deassert,
> +       .status =3D r8a78000_mdlc_status,
> +};
> +
> +static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
> +                                   struct device *dev)
> +{
> +       struct device_node *np =3D dev->of_node;
> +       struct r8a78000_mdlc_priv *priv;
> +       struct of_phandle_args pd_spec;
> +       const struct mod_map *map;
> +       unsigned int id;
> +       int ret;
> +
> +       ret =3D of_parse_phandle_with_args(np, "power-domains",
> +                                        "#power-domain-cells", 0, &pd_sp=
ec);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (pd_spec.args_count !=3D 2) {
> +               of_node_put(pd_spec.np);
> +               return -EINVAL;
> +       }

Is the above check really needed?

Assuming r8a78000_genpd_xlate() is used for attaching, then the
args_count must always be 2, otherwise we return an error code when
trying to attach the device to its genpd, right?

> +
> +       scoped_guard(mutex, &r8a78000_mdlc_lock) {
> +               hlist_for_each_entry(priv, &r8a78000_mdlc_list, link) {
> +                       if (priv->np =3D=3D pd_spec.np)
> +                               break;
> +               }
> +       }
> +
> +       if (!priv) {
> +               dev_err(dev, "%s: MDLC %pOF not found\n", __func__, pd_sp=
ec.np);
> +               of_node_put(pd_spec.np);
> +               return -ENODEV;
> +       }
> +
> +       id =3D pd_spec.args[1];
> +       of_node_put(pd_spec.np);
> +
> +       map =3D mod_map_find(priv->mod_map, id);
> +       if (!map) {
> +               dev_err(dev, "Unknown module 0x%x\n", id);
> +               return -ENOENT;
> +       }

Would it not be better (if possible) to do the above verification as a
part of the r8a78000_genpd_xlate() instead?

> +
> +       dev_dbg(dev, "Ignoring HW module 0x%x\n", id);
> +       return 0;
> +}
> +
> +static void r8a78000_mdlc_unlink(void *data)
> +{
> +       struct r8a78000_mdlc_priv *priv =3D data;
> +
> +       scoped_guard(mutex, &r8a78000_mdlc_lock) {
> +               hlist_del(&priv->link);
> +       }
> +}
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
> +       return 0;
> +}
> +
> +static const struct mod_map r8a78000_mdlc_perw_mod_default[] =3D {
> +       { 0x54 },       /* HSCIF0 */
> +       { -1 }
> +};
> +
> +static const struct mdlc_info r8a78000_mdlc_default[] =3D {
> +       {
> +               .base =3D 0xc05d0000 /* mdlc_perw */,
> +               .mod_map =3D r8a78000_mdlc_perw_mod_default,
> +       },
> +       { /* sentinel */ }
> +};
> +
> +static const struct of_device_id r8a78000_mdlc_match[] =3D {
> +       {
> +               .compatible =3D "renesas,r8a78000-mdlc",
> +               .data =3D &r8a78000_mdlc_default,
> +       },
> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver r8a78000_mdlc_driver =3D {
> +       .probe =3D r8a78000_mdlc_probe,
> +       .driver =3D {
> +               .name =3D "r8a78000-mdlc",
> +               .of_match_table =3D r8a78000_mdlc_match,
> +               .suppress_bind_attrs =3D true,
> +       },
> +};
> +
> +builtin_platform_driver(r8a78000_mdlc_driver)
> +
> +MODULE_DESCRIPTION("R-Car X5H MDLC Driver");
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 2ab150d04bb1f1ef..d4055250de72f1fe 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -358,6 +358,7 @@ config ARCH_R8A78000
>         default y if ARCH_RENESAS
>         default ARCH_RENESAS
>         select ARCH_RCAR_GEN5
> +       select MDLC_R8A78000
>         help
>           This enables support for the Renesas R-Car X5H SoC.
>
> --
> 2.43.0
>

Kind regards
Uffe
