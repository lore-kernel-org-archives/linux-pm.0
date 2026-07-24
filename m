Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B829D270
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905309; cv=pass; b=eOH9L3fo7YEGHFMuUN25LnQzn6P62kUBwYciDiswlZkjUSl9l8VPwz2yQYr9CI2gpV8TvND89z7PaZfUQpglSapXlsSTLblleBljrvvwqwgmNa42TeVyA9hh5Caq1WUoEM0n/okqwrwNM4aIk+rLvpzd9x/YlJVR6SIsfbbaGXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905309; c=relaxed/simple;
	bh=EqDR5beolQbAND9edYz9jbgsmTNRiGSPJrAez8I3okw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyBLvtNsYWRj2KWnY6ixY3fgC1qxW6V0I89uCSG438eChZPqSQPmE4Kz63Bsq1bTDmWtu4HT4ur3N9k7xKoe6gyeeGdM+WI3yqTpFR2BC3PQFOnE5bdb9qzKpt/5XgiEVwyzStfeF5x3pTaw2NcCPTiCUvRUK4zFoBOt2iSoe6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y4OGqcDo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VAs5+kuA; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4OGqcDo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VAs5+kuA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbNpb3335787
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uD+5izwod7lzNMQrYKeunGpTKt32Jca4KiCQa3SdMss=; b=Y4OGqcDoSP91mLoj
	Ie/WNF1TbGYkZhheGKZuMX7DXMpAOzWGIEIkPV97Pilj/04TI6bPRTjT7cwbc/dR
	mdNLx93Phh11sEc9a9uh+h9xGPWpE9wEVWkFPD62qsIkVp0ewA/IvuCopDh9xPRf
	Odv/D+eUk8/HMyqxdQfGlARylz7WlM6PPSi/GE5GYO2d6LFBc/To4woo9XLp/W68
	9pneAbBjBA33iRUWbUF3T/kqgkHKigWGA8ORqYjSPRELA8hvAma+vewxRqXomP1L
	WjTEtCcONNzguVikCaGnqoQ6IeWIp8rj5XvTYrMOYYsbEC3tos5PNrNfYPTORVw4
	UM4FZw==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5bys8cx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:01:46 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-667bb944299so529338d50.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784905306; cv=none;
        d=google.com; s=arc-20260327;
        b=L9m/O6prVU1a/t77kVMLjeQIFBS2hqrRt0hTNZSUnJAuiwOBPV9fq/7RbP0bbVr6PN
         I9y1aKXy95zLzgVNN7MB6faQIjYi30K3LeQzp0qWrg2a5peNRZpbbB1R48IUajWF/oAU
         C7AHYra2qK7ur1aAuaZXeVQqo7oYnX/S3C49MgcYszxsz4RbWJ3XqRCO+XkXtoYse8YT
         z5X/7gbuw6XghvqS/htwJF8mp8mSzt43hsjAiTsDfoggRuomvRGd0jprO0N6RlJvWAlR
         7Ce2F12mV1QEwCgoT0GVix8WbflvJhFVsD+0xg9MEBxjvRrXa8RBn9BvN2MHnrkm2KFT
         SN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uD+5izwod7lzNMQrYKeunGpTKt32Jca4KiCQa3SdMss=;
        fh=xKBHZWR7yN0Hlqfi1sRt+twpHgs/411vwzMxTWi/X2c=;
        b=JsbmVPOThhqeAPOhP8QFsaS7LTxSDh2pNhcGorjtFeVVYBuhJ3g/fAGFJaJ/SG9hJu
         DhDAIUXmamOLngTlBT5rcnDJFtb8uWtnAKOLYGpvRz6N1oUvFcmRzKtNYlqn4I/prSOi
         lD1IzkQbW20t/TN+8vjjrtkrcDLwPUuPsZ7/axcxOfcrzyKEBQ6c3uP0tb1eAdojb92J
         rJaBKfWrJF0RIu2zH+mZ8c+605mbBoetXFpQVZ60kv9QNiEkn+TF8ABRUG8RlgsGf7zA
         qTbP3HbgtxTvSnasOjljLxPKGW9JBQQDkAENucozndcE+pYJimSEKQky5K1UUhoAop/S
         PEPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905306; x=1785510106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uD+5izwod7lzNMQrYKeunGpTKt32Jca4KiCQa3SdMss=;
        b=VAs5+kuAYC/8ocCfDAZxsMVcrBo3SKZ23f7beBvvEqm9CW2SuyBQ7bS0GHG1qkasEB
         p/jW7UTjgNJtT70Ci9rJgATPTf4F3FvAy0SC2nj+MFyuQIUo4mAMZsYNxxGo7mvY41mK
         SjFmarEhCwZGFnIJgYqPc/ADCYxih6fdWIbFq8i7p79RWKi/muQw8VYQ9yqUA4/HiqLx
         FwzNvHFIVthMGWX7ZCk5OVeUneEtYTKL5JwPP0Vlh0zhgclnYmaOtY2rD95LXGmE6QaS
         mIr4I3KRJrHK2u9yXF/nzBuPpbjaGLzx68KoqdVkq9D4Z0CsYPD/hSdfQKtQ2G1sr9UB
         RQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905306; x=1785510106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uD+5izwod7lzNMQrYKeunGpTKt32Jca4KiCQa3SdMss=;
        b=SweS8QljRnhTAQ4A/58rooz2WPrIiPZmCDZs4MnHnkAJBIymwKgC9pGQnlm10wYfVZ
         MdUmyFlgA766vtZ+Hfi9fnLlzBPxysY+gUU8NPSPSJMn2jn9H74XCqyDz+svcahvTreY
         lqdLN0ZWrtw49i6FVG2yXWjr+gaTxru9AwDhCn9yKUg5cMDGKXdGvKkm3mvRu20qD3qO
         uTHG2cVyh0ysBNXorL3MRSTMc515egZaVZ4k/VKeZfJj0CVdCWfJ0siqI30J6AIyZha9
         jGw/eIjds/jLyYoyWYBkjoekyvuqBMrWh5V/5cFD0kew/ACYEL+b+i5uHPb7MKrg0SHs
         o3/w==
X-Forwarded-Encrypted: i=1; AHgh+RpMRxZNGN8ffsWUD9A70BrbFNPANwL3o0up98YZwduSKCIF71k5/6e9Jm2z+rbSxzHlxSAqV97fmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7tC5DkSrkjCBPA+psZ8if8Q5XdIXsFRThOaA/VDK7rRVzncK
	vwREqFApDZHYmpZ+og8prOHtiudpERbWjiBsIDHC7jX8HNHFwEo63YZhgrQeqnxQBKXhD+Il82w
	MuAenJNR8IpqdhXak7/4wh/Cl+64bsFK+N0n972xwwlOhf1JFNSoArrAng+eHrtiOhs7HY6h/6l
	C8nMKGiFLwJPjnrBjEij2WXxWf5XvVjxfR6Ba6
X-Gm-Gg: AR+sD10hUJqVHSm964ub9zQLS3gTfJRbGGtyQ276/CH4LMiC+Hgp3lby+c4Gm4YMO6p
	oOGtdtkdvm8LM7il++IpOuJhoK8YwHgdITTIWFDEEwa1gHMVwJo0tkwboo7oh5SmxfcGLL7d0GE
	uKyv8sNwtllMOyif0PGyEnqyM61txNNEct0DEt2/LWBuIYHniTvXUj8cSVxA==
X-Received: by 2002:a05:690e:440d:b0:668:7e4:aeac with SMTP id 956f58d0204a3-668a504e648mr1538828d50.106.1784905306071;
        Fri, 24 Jul 2026 08:01:46 -0700 (PDT)
X-Received: by 2002:a05:690e:440d:b0:668:7e4:aeac with SMTP id
 956f58d0204a3-668a504e648mr1538798d50.106.1784905305595; Fri, 24 Jul 2026
 08:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132729.302067-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20260722132729.302067-1-dmitry.osipenko@collabora.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:01:34 +0200
X-Gm-Features: AUfX_mzjLOgOcCUz76_T9HJlbASNTyiIQVZ65cjhf0ZB5m8FWwTsm9XV6DD0K38
Message-ID: <CAPx+jO-1_ZpYcnPtoYxRn5vv34tiP7TXnjKZ3SaWkEzdeTfXpA@mail.gmail.com>
Subject: Re: [PATCH v1] pmdomain: mediatek: Fix MT8183 hang on boot
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: P8eDsVJtpK3JHoOGFdg1zHx9uL80LlO8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNSBTYWx0ZWRfX2jDxDK/lFvun
 XLnSxdkgpDwb4Pmj0OXNNQ9h6d74O09otJTRUyYC+tu11VX4Xpii4WTDDDRx0GwPqg9KJv5qRD3
 mv9VAqbOzBMbdJbYiV51BWMN+dmtC+c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNSBTYWx0ZWRfX8GaK6Mj6fZR8
 VFt1mabOWW3NMPsh1DH6MFgRv2chajLawbd8beEOMDqeuI+HnFlvE0P9sHNBRTqvwuMwaHoa919
 H9+HbYGN8TJDfybw/dNEQL7Ipi2usUuOwmIHbXNKaTfOvnBdrGnyFuFYkNR47VQDX8wnbRfeIVU
 iP0WmKyvC1oXsL4kHptKo4cLMEw0/WjkNYitYoj8+sREhxtIXsSA5DqKolYjre+MFABADAyQw5c
 M+DmDOmVkiafX7uYQibf/aLkoBy7Bpf/2XOSLxLwxsCSdNJMScJdfy72FDhWxZiijP1/82zh5l2
 FmxxZ7SBsQS1pqxDzhDekZtI++BMgZ4kUXLkpWKubIEynhH3NabNR38l6nYu/e6BcTtQ4PJXAho
 lPTUAepq5m9FO+Y6wfSueWGs9qAPXAzlaEt/Q39eoR39iHs+3b0FCyHLtRKNDAj2Ns5V0W/njk8
 dYSeVwBmH+ztvdISx+Q==
X-Proofpoint-GUID: P8eDsVJtpK3JHoOGFdg1zHx9uL80LlO8
X-Authority-Analysis: v=2.4 cv=GMA41ONK c=1 sm=1 tr=0 ts=6a637e5a cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=QX4gbG5DAAAA:8 a=W51c6IlItZHyHODVoFAA:9
 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240135

On Wed, Jul 22, 2026 at 3:28=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Depending on firmware, part of the MFG domains may be left ON at boot
> leaving only some MFG cores powered, to let the ACP to prefetch the GPU
> region when the display controller is brought up. This doesn't play well
> with an eventual delay in probing Panfrost when the display controller is
> fully set up, as that would make genpd's sync_state() to power off the
> domain while ACP tries to prefetch: this is causing an AXI stall,
> effectively freezing the AP indefinitely. In order to prevent this from

I haven't made any detailed investigation, but to me, it sounds like
there is a missing consumer somewhere.

Should the ACP/panfrost devices be a consumer of the MFG domains as
well? Or perhaps, if the ACP/panfrost should rely on the display
controller to be probed and powered-on, to be able to probe?

> happening, the sync_state() functionality must be obliterated on all of
> the MFG domains: while this guarantees a power leakage if the bootloader
> boots the kernel with MFG PDs partially powered on, this is the only way
> to ensure stable operation of the SoC during boot on devices with such
> firmware because, of course, those will never officially receive a
> firmware update.
>
> Fixes Kappa Chromebook hanging during system boot.
>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sy=
nc_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until la=
te_initcall_sync")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Kind regards
Uffe

> ---
>  drivers/pmdomain/mediatek/mt8183-pm-domains.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mt8183-pm-domains.h b/drivers/pmdo=
main/mediatek/mt8183-pm-domains.h
> index 3742782a2702..5e33b8628e85 100644
> --- a/drivers/pmdomain/mediatek/mt8183-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
> @@ -47,7 +47,7 @@ static const struct scpsys_domain_data scpsys_domain_da=
ta_mt8183[] =3D {
>                 .pwr_sta2nd_offs =3D 0x0184,
>                 .sram_pdn_bits =3D 0,
>                 .sram_pdn_ack_bits =3D 0,
> -               .caps =3D MTK_SCPD_DOMAIN_SUPPLY,
> +               .caps =3D MTK_SCPD_DOMAIN_SUPPLY | MTK_SCPD_KEEP_DEFAULT_=
OFF,
>         },
>         [MT8183_POWER_DOMAIN_MFG] =3D {
>                 .name =3D "mfg",
> @@ -57,7 +57,7 @@ static const struct scpsys_domain_data scpsys_domain_da=
ta_mt8183[] =3D {
>                 .pwr_sta2nd_offs =3D 0x0184,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> -               .caps =3D MTK_SCPD_DOMAIN_SUPPLY,
> +               .caps =3D MTK_SCPD_DOMAIN_SUPPLY | MTK_SCPD_KEEP_DEFAULT_=
OFF,
>         },
>         [MT8183_POWER_DOMAIN_MFG_CORE0] =3D {
>                 .name =3D "mfg_core0",
> @@ -67,6 +67,7 @@ static const struct scpsys_domain_data scpsys_domain_da=
ta_mt8183[] =3D {
>                 .pwr_sta2nd_offs =3D 0x0184,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> +               .caps =3D MTK_SCPD_KEEP_DEFAULT_OFF,
>         },
>         [MT8183_POWER_DOMAIN_MFG_CORE1] =3D {
>                 .name =3D "mfg_core1",
> @@ -76,6 +77,7 @@ static const struct scpsys_domain_data scpsys_domain_da=
ta_mt8183[] =3D {
>                 .pwr_sta2nd_offs =3D 0x0184,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> +               .caps =3D MTK_SCPD_KEEP_DEFAULT_OFF,
>         },
>         [MT8183_POWER_DOMAIN_MFG_2D] =3D {
>                 .name =3D "mfg_2d",
> @@ -85,6 +87,7 @@ static const struct scpsys_domain_data scpsys_domain_da=
ta_mt8183[] =3D {
>                 .pwr_sta2nd_offs =3D 0x0184,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> +               .caps =3D MTK_SCPD_KEEP_DEFAULT_OFF,
>                 .bp_cfg =3D {
>                         BUS_PROT_WR(INFRA,
>                                     MT8183_TOP_AXI_PROT_EN_1_MFG,
> --
> 2.54.0
>
