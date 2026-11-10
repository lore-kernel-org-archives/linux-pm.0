Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794308108;
	b=lkyDqzoXX78dcLG4Gsz5fS5i0pssT1lt4o/4ghKI03AKKhcA6N6mQZypFMFQYsrGWLQw
	 NUoozAt2j1VSyckff2JEJxFlNUtpO8h5cu0tOrSLAhiUIhXGPWd9EFlZrD29Uf0UGvBIe
	 T5TNgVN+tumS27AimPEdVUBU+bUzZRFAK2PEbxS+IVq0KLhXSYUEnMnEmV5JtjB52x4+z
	 w4a+ZWe0Stt41zt1EJGn0hVlMK/Q8+ccy7Vi0rM/oNWdekCidRxvkW7brmuEJ4EFe9Wzv
	 NevQcQsQX7p1X5QQPbV5xTht5t6LIb36opBNLxe5JFjhCVrdq4npyWOOJdKT7OURDEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308108;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0zn2h/mfdeJyzmrvYGtYi3WlYP6oFtDlczeBFhJTZ50=;
	b=DQNhVbaPF0+SxIPkOE02H8Xu+RWJhxVe5Sf207Zo0jDGMBitMJ21DkxzqaWawhAf6zjQ
	 N+TMgp5wrW3qVzDMDu8mJLWnq7IpsNvpt9d41FO6kyZ8bXrLr1Yh03838nnQpqBxtMxvu
	 649iZL84l51vvNPVCGnX95YmFodkSinT8Fa1P65owTDMCOQT5yRM7AO41u16kIULJ93eF
	 tGif9Y0rgVcFv7NeZFxXdk62SEii4O0B9ujrIG5N6u0hVCcgcJw1ET6iZB//eB8kokEs3
	 jvhohYBA07h0L4XHmz22EcPsVNZ7Dd0qM30B5y0PZcT1TDhMmcrnKzNLzgHs5Zw2ugQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SIq2FKal;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ixu68jdj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4C606A33B
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC4C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SIq2FKal;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ixu68jdj
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7l4w81155038
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0zn2h/mfdeJyzmrvYGtYi3WlYP6oFtDlczeBFhJTZ50=; b=SIq2FKalNnAEkO2P
	oIkOZMlWpOUnJ9sGWRZrSd9VTJoz1ggGjeIgAcwU7l+QMtNkT0zVc6JPRXaYU99N
	LzFJZwYiQjttoE7IbpNIV+HBteYxQr5flBOYSR9G4gADntAZfgCxaW8Crp1DuiLa
	c47wDPuFdtAOCJu4ueco1U6A7wGwrhQMNbq0ZMQHHTq7FlquqlorT6j4DzV3Posc
	qe/bHHKmGwQ1P+zR8Ot6kd24HmnhH00i5gbJkRv3alyFe4cwKk2azhHErstl/geT
	KmZTB7ADiQlKqGB5wim9lEcjL/UGXrg9AMpkaWgK+mv29UUB75zXBJSSdcGiIbwS
	YhZliQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hutv49rp8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed2803f863so19329645ad.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 02:55:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794308106; cv=none;
        d=google.com; s=arc-20260327;
        b=NHO2ylBSQ2hwL4O7kPOfFMYsCaLx4PRm2EHEUcdHiJpnzP4Fuz4AxUhh0py39I/EuT
         ZMsaPE60p6esATS9RE7Cr5jJgbyTR5N+juZ9GDBl57EXbpoGHIuOV7VmSx8j5PbEtb1f
         WlVqHVZrQvSkj3a3rGxK2wdDhE6WMAkvQlRThzLklxRNXP0tNLxtg88MdeKuFNu/JBsp
         bStoOq1qTgHZvZgsTvwhXbPG0XeG102U+8SaLq8xwj/uY5pmBPdpT+VDfwSw6Blbm03N
         wzzJhmJ4l/2dX+CW+sTjjOO4GzUkQnOtfzaaEA0Eo+XZco9s/kwCRKaDzhWOB8Y0Az4M
         67AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0zn2h/mfdeJyzmrvYGtYi3WlYP6oFtDlczeBFhJTZ50=;
        fh=Tm19lqWCvbR8M+n2Y0KdsDm9K6pVeBHJeq7eM1T6GYU=;
        b=MxVj74hgiSY0W6v3RVAPzcTvhB7Acjx1JJDFaz+krMD3axq2SAmBm7vzTQVUnKsmPn
         4k/6Ic6jtymSPzImKhCpVQd/jwANsFx1gj/1hk9BG4ofDDaNFFEwUil0DCFaDpe8AMj0
         aY8rXdJzP2YfesxQmAJftKAk116oZhtD4frJcZOVEbALLLgYxG1Akc1W1fWIWCjOazPY
         vllxpQ+jO5oOSXjlGlhXb/2Kh2c7LdvjlxHRvEi854axN+knqzqAL2QFVI07a4nmVq3u
         3W5l+i0ZT2usecBzFKVTGuWyjPJ4SXaFAIaE+EN16M25z1ahO1SV7gYdQ8xuLC+Acnwo
         3dSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794308106; x=1794912906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0zn2h/mfdeJyzmrvYGtYi3WlYP6oFtDlczeBFhJTZ50=;
        b=Ixu68jdjORJV+29LCoUTkG9/C9Y/3u1BuHfccLfXT0SKH9NniBdnTZU5bN/hByFXVU
         wdUgjmVUDa73T5P73fDTh9EV2NnF7wFSD7/zNPjgTzXW4JXdDmhuYjQHC7OkqI39cySB
         K6100VKZfZVL9i91uyqTQmisjJ6oTrR/YGQIZUW+Yz32nq/tea1hA2w7Xkbl3gDlCqlA
         M2GotgE9gcNlTsXCMvr9EYMmXh7FPVoc7VV9TMV0Y7NH8K/v2azScxJRS4j8mBDCauhT
         JO4bKsLUbBCT8XZTb9yFswVD3E6tcJ/YqhOkiov1onoYWQm6c8EBmO0Twp4Nsw7atIBH
         K5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308106; x=1794912906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0zn2h/mfdeJyzmrvYGtYi3WlYP6oFtDlczeBFhJTZ50=;
        b=zlxXDxArsQJB2HrJ3Pvm6+TCil+N74/kHd0Ckq+qNGMD7/mQV/yXvW8Zd71VT/jlCc
         It/BrcrzlzisK6WmAD3D36sihvzfXMJ2CW7KqkVrnypWmUrFmZ4iSMAssRtv2hZ8r4g6
         lma+Q1pVWgwMjBP1uUFSVdt4HUCo+rT7VYHES2z+Y4ocFAAk/1CFeVzmPiUtTny0RCFU
         uiaac+sT521W3s4m5qFWH4Sc5cgXb72IZbkbKg38ooQRngsllGRQhDBwrCfEXSEcWPs+
         613JI8S8LzqpkHJzrQwR+FzjWN4rJoNUcYDbbV7lz3cSXO3EgUZBqXzQNgykhfG0xch8
         eB3Q==
X-Forwarded-Encrypted: i=1; AL+hErHbIIyFE6zEm2PM/gRdzZH6oEeo6HZBRAFQqZTJgKkZ1KQGqYZ80ETg5lQOtfS+ZlLwdPe+CA1ZUA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/noHyNXYh24KtqH8IAi8xaZZeHFQzT4WjATGiaIe8j482TX8lM
	dHyWAFoTREK8VwFth872+FDbTvpPMnXNYEVN8sGZ67NAE+VF9hhKG/jMgHW6TBCf/jV+XkLjmxi
	Kq+8kIh5qt09ewMgxZOZC/t4eXBeI02hqgpbG8rkY4yKxvvzy1DzMdKoQLiXt2Tksp6X0b4YAbH
	Qd8z+Ke5u69NiLeQH3cLM2Ar1NUCppoLLxm+0V
X-Gm-Gg: AYBFou13zTNsbdeFfvmJz59x3Zn7Mj45ldD1tyaD4vLuFdXxJ3Uz/8ANb0fPNCFTryD
	SqSqpm4/B/ahdKmCZtMF15xj2m3Qc9NbKX55kjYj3UZl233mrFFspz9FCXo8/VOLW+hHV1637ZC
	13nGJNxpuDtjztucIKxxNffLvGyB0CujY51wd9KN7C3Y0cyYmlH8/v4R4pxQ==
X-Received: by 2002:a17:903:1a0c:b0:2ed:4ea4:2dba with SMTP id d9443c01a7336-2edb8fb3d86mr20040095ad.5.1794308106423;
        Tue, 10 Nov 2026 02:55:06 -0800 (PST)
X-Received: by 2002:a17:903:1a0c:b0:2ed:4ea4:2dba with SMTP id
 d9443c01a7336-2edb8fb3d86mr20039865ad.5.1794308105831; Tue, 10 Nov 2026
 02:55:05 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260926-b4-mt7629-scpsys-v1-1-e02d03d2151e@gmail.com>
In-Reply-To: <20260926-b4-mt7629-scpsys-v1-1-e02d03d2151e@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 11:54:53 +0100
X-Gm-Features: AclHuK-wCHxxV1sk9ELba0eXodmE19efdczWGBPVlSLOk0ffW72xQC95zfSkjvQ
Message-ID: <CAPx+jO8r=bBSZiw3SVfyaU6XRWtPGMj-okMT3=NnTY=Su+fwEg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: scpsys: add MT7629 support
To: Chuanhong Guo <gch981213@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfXyT5hMVBrqzW0
 y1ueEpcuN6bj/q4LH4/62YtXWKyC1e7lhEK7kvwjq58RezMXnSj80lFYLsU6aa/k1OohL7fiGMO
 d0qbGxL9HDHE+SQL1AHe9bhM+eoGyHw=
X-Proofpoint-ORIG-GUID: 8OI5L6N4kBvotmS52DRzTBG5an0ChUOq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX8HagvfFb1xqW
 8ZYYM6xx3QJ7UFumwTgoZCRi0RY8UGxoksCFHaFb16dTU/ialrh+gZEMOktGk2ea6LqEtBF5peC
 QaBuLZMpanZrCsDajap7r7TitS8p0H/jD5mue14/TXes4jxH01d3q5SnSs/yjkMVSPBL3CCrigI
 InlbKs+lUV7YoATkI6DTmpE3GEHJTKjGHN+PnV13hPDe1fU3huiDPsLUVdtmjgRpoOc0nNzs2Ao
 oO1gLMSqydsOLZQI1eOTU0URTBVG/8rf+CH69/CDHFFpwgh4gj8ObCLhLm5hy2rkdsbGdI5ePkE
 4rCH4/TBsvQYvO8C3vqY56PUnOwFxOyrqWqxysdZ6FlhJx3xPQ0/iixboYxRRGRQ/gpTakPWLf1
 7xoTgHUyYZnXs5BR25o9UkYL6zI1q6dbsoh/bmS8l/9DFkwYkc8Z4SOT89/AaECXa88Qb440hEU
 XUAmT7w9uYjyMx/mR4Q==
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6af2f80b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=3fVjQ_tGrbk1vConURoA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 8OI5L6N4kBvotmS52DRzTBG5an0ChUOq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100043

On Sat, Sep 26, 2026 at 11:59=E2=80=AFAM Chuanhong Guo <gch981213@gmail.com=
> wrote:
>
> MT7629 currently uses the MT7622 domain table through the device tree
> fallback compatible. Attempting to power on the WB domain triggers a
> warning during boot, and powering off AUDSYS times out.
>
> Add an MT7629-specific match entry to register only ETHSYS, HIF0 and
> HIF1, matching the domains exposed by the vendor driver. These occupy
> the first three entries in the MT7622 domain table.
>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-scpsys.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/me=
diatek/mtk-scpsys.c
> index efc8f276ffce..2b5bd8d61cb5 100644
> --- a/drivers/pmdomain/mediatek/mtk-scpsys.c
> +++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
> @@ -1073,6 +1073,17 @@ static const struct scp_soc_data mt7623a_data =3D =
{
>         .bus_prot_reg_update =3D true,
>  };
>
> +static const struct scp_soc_data mt7629_data =3D {
> +       /* Reuse the MT7622 entries from ETHSYS through HIF1. */
> +       .domains =3D scp_domain_data_mt7622,
> +       .num_domains =3D MT7622_POWER_DOMAIN_HIF1 + 1,
> +       .regs =3D {
> +               .pwr_sta_offs =3D SPM_PWR_STATUS,
> +               .pwr_sta2nd_offs =3D SPM_PWR_STATUS_2ND,
> +       },
> +       .bus_prot_reg_update =3D true,
> +};
> +
>  static const struct scp_soc_data mt8173_data =3D {
>         .domains =3D scp_domain_data_mt8173,
>         .num_domains =3D ARRAY_SIZE(scp_domain_data_mt8173),
> @@ -1105,6 +1116,9 @@ static const struct of_device_id of_scpsys_match_tb=
l[] =3D {
>         }, {
>                 .compatible =3D "mediatek,mt7623a-scpsys",
>                 .data =3D &mt7623a_data,
> +       }, {
> +               .compatible =3D "mediatek,mt7629-scpsys",
> +               .data =3D &mt7629_data,
>         }, {
>                 .compatible =3D "mediatek,mt8173-scpsys",
>                 .data =3D &mt8173_data,
>
> ---
> base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
> change-id: 20260926-b4-mt7629-scpsys-88d0cf37c6e2
>
> Best regards,
> --
> Chuanhong Guo <gch981213@gmail.com>
>
