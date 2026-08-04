Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E43E9580
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854292; cv=pass; b=dOMV0EmrkrdMW2G1N6cziWDRM7NaWjZtn+aPyaFgrrku4OriI10/7WAtZ65bvDCmVtjsCmcM2UW9JDliu9HSaB2uW5Qv2KXVQbL4DDJ6ml9Kphsf3xFYCc2AlAVZF/Dm96zpWvZmlx4pLGzP8ek1Z2l5O1qv3sbn66Dg2w04n10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854292; c=relaxed/simple;
	bh=YV0ZNwocf3a0+hyk0RkgISO6WOM8a/YiNQ9X0n8+F1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGPVX1cRwZuDqPWqhdmjdWHfly2KxuiXYI2cok5JdMtbLAI6GdjQ6S3tovUuiSDBZxASqkC9vI8L6bWlV1MqUp3qsgfAsLV7iVOgr6wN4mVepApBrSyXrqPjVtNtf0TWAxD4jrqaqTM5NaAUB46BFClbn2hSTpGXj4nAWokSals=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bnJhHFml; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ks4WbI42; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bnJhHFml";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ks4WbI42"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CX9oG4129540
	for <linux-pm@vger.kernel.org>; Tue, 4 Aug 2026 14:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n8ixtTzRipWSng2lUt2MxnHT7dTmpb44so3J9utVvq8=; b=bnJhHFml3sy2gaQz
	Ci9sZKYL5yG+Oj4FnR8ardvu1diFIEzPYOoDyi2MBDkws7UtwGx5DdY4SbgkVHM/
	rjB5F45uD1naCjeUuhfE2hn720XV1fP5rhFMk7CagCzppXhXY9cZcMcUHdpWF86k
	ang3AV6bobCsHplowoD7u1DdABblZtmgz4KNFHA7HmBegrvSLch4YcMlTB5u/3Xj
	V8wxWuiAavYP36IHqXQrqdbBJudqfgADLtBWEp7wSnwmSBkAgYPN3yJBEqYWu/gE
	hH6v86h/WN2eKhRULlmY19wxzW1YrgPDQPg6s+DZnZEYW3RBIQh/W3rQokgGChoo
	5pegZQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fug658jg4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 14:38:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8efe7db1c42so52644596d6.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 07:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785854289; cv=none;
        d=google.com; s=arc-20260327;
        b=bR8SRqt9X5xB5Q5CYyhrbaw2S2VZU+bWuftSmOx+YyLsozZZnaQ3XCfmt9M0o9gwob
         pQ5DnyIcASiJ2PRpCZ6nBpYnQfHhYky0wNDO3zEHDBba9v3P0FkEevFZExEU47n+3VGB
         CayIgieliyWL3LAAdSHqxDc9m/mTRESwtJ07rMvw8UPsI+QcaGVUnV4rS/iIECs3i1SS
         r552rzqf1Easb5GycLrI9wr+lc1k7mbWvlbTpVnt+amy/I58VU8DxFrPAka7lQ/TwPAj
         ZYjoJBV4wLSGZHsz8eDsxry1Y8LzD5yiKvghaBlLX8/S8LOqpdnF5BrBhkErkqMQmzk5
         p92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n8ixtTzRipWSng2lUt2MxnHT7dTmpb44so3J9utVvq8=;
        fh=d38TKmbocHEcTvIQEcWSTgLuRe9WFPM9Qi7WbAAChbM=;
        b=ocmHOOgiQmvxKDb3g5neKytIabrAC5eRfk9sjKSJH83RWa5vV5OjkZksijaJAuO0SY
         RQxXUxkFmQQVQho+TOmxyuUG8qqvRO/p+6cMklsBwUPyHdF7jvdeP1nV5aeAuDW2rUBm
         CuO7WDzOu9FzTQ5MQuFnzSMge0T3aoRJ9cnZM4heicl7LAuFloTb/cB6Lp3OmDI60qom
         oz37SvmCsw7dBaUGTHfSX7fEG/GocnRF+TNlDsKCJLlMk4rfMBZ8CjFndDNxZ4dwtFqd
         HC8gmNGovFvGPc1cLySybaVJdTkusuXZe6/SK5Rb5r+4PaX37XjwAUCozeaM/lxthLBo
         lqlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785854289; x=1786459089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n8ixtTzRipWSng2lUt2MxnHT7dTmpb44so3J9utVvq8=;
        b=Ks4WbI42a7tJKkLJA/mEEPksImWoeRSwxG43fRn/kM9DGAhvrjcuZc0qVly/SMhavg
         M80x9PplsCrvU/eQo822Cl7KQgJM3uVHUAoORQuOscfhPr3Q+t0WslpTZpHgruee2tea
         CPmeFGBKrEnU+wQBFfRjj+Riznb5+97j9vH1e8vF2YBUyW1W3fn/+DGgbWOzjtqUXX8f
         mDy0UaqOp8zzOgMKCS30AbvG7Y3GlGfAuW2ZyZh8XCBBqH0WtyQBskoQKwJ6+/QKUW0S
         NDW8WAgU6OzXgtoz5s0yldItrjBbTiKvtL1ptWwCSft23F4Uktyp3b/9uS9brAGFCrMf
         AYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785854289; x=1786459089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n8ixtTzRipWSng2lUt2MxnHT7dTmpb44so3J9utVvq8=;
        b=pOwDjS0sFmpsPptUxWfoaMv/CzcQTAzkz4Ww94aMmO5LcSHrR1gDV6f3/ldUWeuxv9
         DYICeDQBoQ+Iw6Vh6MvFPLk3dsoVG8faEIsqQ0AfnwKLY6ol8kqgKR7ZOnPHbFFbiVha
         /9qgouE07xa6zYrBXuc0DYF81XAGl27Yi1/JS6+waJJ8vGmQnihShpeDQMEnu5rT/d/F
         mgxtjVTHtBMjb3473wOseB0La6o6T0RKu+24AVqwsJB1LJohA8AHqXTplj5Xsc39uUtA
         ToZab8VdEeCZyDa64wfkwbgyISLBFY9t8ojSB9/TDXN6SuLH6w7z0a2qA/O4J7Ycj95t
         g4OA==
X-Forwarded-Encrypted: i=1; AHgh+RrTXi40bqrLmsnuDdEBCOL/M3h6hnxhzd3HVuzMDDJ68H/YXCcJF9UZ+FubeiVT6pnhar3kZQITgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ17MZR0JHPXcrVxHoT0HTYD/O2UtO6qBZPnyeCNz+Usv0KD49
	7NSe9XJrNpWF/zMMk8QLi6dVBqaCt+JnJ/YmLFmAv1ACy4mthFc+vDgxel5VboRzY+BRnHNAzpg
	5ugbPJIDzos0uclSJ+kRXB5YD5r+hY4sa1e0VObOxay7ZgOlbwejNk0CTTPlnFVjLCNreVe9uhe
	fmaW/QtZcNyXXkitR+vu6TTM5yXhqrGfERi78wnfcQHKKd
X-Gm-Gg: AR+sD11+SQ4mGjiuRY4tO0YfS5ehtsBLy0rF2iNZ+4hY9W/2lGljJISDEIhQYdQ9Lh9
	0KZkxswJRa7NV6sGFA/Cq9X3i8E6diQSBbB+c1T1coibIqBV7zLp/xW5gbXFiSKVj5kUaXqUnsy
	85jwN1UXzovZ3sBbFcrCXzE0B5V8b1BREjpR69OiX0mol3mf+KiFu2BvcPFg==
X-Received: by 2002:a05:6214:4009:b0:908:1bd5:9c38 with SMTP id 6a1803df08f44-9084957bcb6mr304720036d6.14.1785854288952;
        Tue, 04 Aug 2026 07:38:08 -0700 (PDT)
X-Received: by 2002:a05:6214:4009:b0:908:1bd5:9c38 with SMTP id
 6a1803df08f44-9084957bcb6mr304719426d6.14.1785854288513; Tue, 04 Aug 2026
 07:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729125907.830090-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20260729125907.830090-1-dmitry.osipenko@collabora.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 16:37:57 +0200
X-Gm-Features: AUfX_mz-i8dB5SWfHvWpOVnVTkawqldOEJi0_Rvnt1_rX3o7xhgWlAFvXqEMTd4
Message-ID: <CAPx+jO--DskGufFZyhObH_t+H_idykV0gBPqPC6=g5uFUAJeRQ@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: mediatek: Fix mt8183 hang on boot
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ISbcP4a9K2Ct5Jgr8LQxL2qIDkLRtJsd
X-Authority-Analysis: v=2.4 cv=fcydDUQF c=1 sm=1 tr=0 ts=6a71f951 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=QX4gbG5DAAAA:8 a=W51c6IlItZHyHODVoFAA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExOCBTYWx0ZWRfX8rZIGkobpooc
 sh74Te2yRl4AO23PI19M9piRHwYUbkwvABT/QnVUexf2N37Woi/XrlPwDuVjZcHkLCUfN6WHfM9
 gDbw8JGFmbpWf3pT1dV0Ey2GvZiyXsU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExOCBTYWx0ZWRfX7ATQhGKZJS3a
 sXBJAvI+JaO2S68sJq/MBVISXhAFUJVsfxL6NqagiT6GFRtursBni6V0Ap7B9kGfZGYKnpRRtfK
 jlXc0Sxm0b0BHeXa/esaGqheHKGcQRD1Kg1+M9PwVb0/lJwhVmO8kaX9VH2TScRL3nLin8V+LbU
 t7Y4amb2IRinODos7ixa0F14Z7mexlxmXG5GoxIrGFPZWFmcEpQFf8nfDMAJL84dTLVBMl0PWbS
 3ZNk1NOJdrgbctCN2fkcCV3n8Aa+3r0/xQGKgrxngsheRGn0HE1hVmHnN8ayU0oxYKagQZPnHld
 UqO3RNnDZoFg2aUE2OPLXX9gZHdzWzcIE/ZRns1KFq2tEx+h9sfod4Z5Bf6zGcC+NEXaCtFsK9G
 Uq4Fsbwg6G8m/sM703DvLXNyYqUxwnuMJswdkA1ERR1t+E9papA1GMKQ/Wu8c2DgRPVYPM7eYwl
 t4ZpF7+EKazWtGFRM7w==
X-Proofpoint-GUID: ISbcP4a9K2Ct5Jgr8LQxL2qIDkLRtJsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040118

On Wed, Jul 29, 2026 at 3:00=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Depending on firmware, part of the MFG domains may be partially left ON
> at boot time with kernel detecting PD as ON, while it's OFF.
>
> Some of MFG cores may be left powered after bootloader, to let the ACP to
> prefetch the GPU region when the display controller is brought up for a
> continuous splash animation performed by downstream stack.
>
> This doesn't play well with an eventual delay in probing upstream Panfros=
t
> driver when the display controller is fully set up, as that would make
> genpd's sync_state() to power off the domain while ACP tries to prefetch:
> this is causing an AXI stall, effectively freezing the AP indefinitely.
>
> In order to prevent trouble from happening, the sync_state() functionalit=
y
> must be obliterated on all of the MFG domains: while this guarantees a
> power leakage if the bootloader boots the kernel with MFG PDs partially
> powered on, this is the only way to ensure stable operation of the SoC
> during boot on devices with such firmware because, of course, those will
> never officially receive a firmware update.
>
> Fixes Kappa Chromebook hanging during system boot.
>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sy=
nc_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until la=
te_initcall_sync")
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
> v2 - Expanded commit message with more clarification about kernel wrongly
>      detecting PD state left after bootloader.
>
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
