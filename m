Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592148;
	b=i3AvikcMhbZfWpYmZowNPbE0fHUn8ZIlPfJI48qq4Y9NHp2ukAdR/Yngk+Ef0tSQQpUj
	 j+Yhmbx7l/VBo1TzRlYqzVDtOItAZo9DrsOxvAvuGsgDy2aSInm9vSeXha5GgJRPWADNC
	 /f+3ZHKK1GzR1/gBFFW6bnLjrHB0Zkklt2SHSXGqhU3Gtx7Jf/b1h+b90Rx03iCPdTQBu
	 DXd+c+r6CcS0UrzVV/OvxQ77nN8j1RugxFiFWARbF9iYcrXoGegMGq5f3rsrUyPmLWUfH
	 5FC2eCbTcS0D7XOcAuECPwNejIbD11zgKQe8tuxmQ+gd9yjtyqd6LsuCBRuuSMtHx1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592148;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=h7ZMjOHZnub7I02GGs2+ZNq38w9ZfRd8s4DzV2qSzx4=;
	b=uCAvbtdySstvXMyhHsfpmHjwTO3m58wZJJluQruYNWtTJtga/fZZLY5h8UNJUTbKu8gu
	 D57Xt+BcLS1BVxkh+AwRxT1MKwt2YvjEuoBQ0LXwqng8JuzYRqFtQ67S3phzQJ/QWCKhX
	 Jsi0pBWIvkmsyG1bfoARymRAhI7lwMNn4XRYN5MzBViovlQ3jXEtF+yG5jPKF2MR275tp
	 X9odH4J4NgPT120IANN1iz98Mp12qcqnArOyfE7H5Id2moQb3XJGZwJ/hfX7YxdM3orkf
	 wrcGIYOq1ZQldXRxPEQYghPuePAiCuM+2thGDaCU0OXs+jMcyE4/KIPDzzb6wOQ2e9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dd2YORBp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eZKgA8Ux;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FA6079D78
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 227FA6079D78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dd2YORBp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eZKgA8Ux
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADGXJCN2808715
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h7ZMjOHZnub7I02GGs2+ZNq38w9ZfRd8s4DzV2qSzx4=; b=Dd2YORBp7MJYX8GR
	WMxdTmllHObR7E31WjlBbKI/1aHD9DXvwhN4/JFeb9FOinbvyqhZzG9w2U2krmuf
	U5L9GnSKOmR3KbR67NLZpwtNC1yl/9DQVus402t3tDOVbInxwsfvsujM/rKo6oR6
	nzzDC3r/Jyy5vw5VS7ol+iz3dXp+mX5XRvgzMPL0ywUzDgf81zCbt5Qj8vr+DZLH
	hggBhc9r+rTrBQITwdOnzIeqXfzkrqNZ43BtLiosV5iheoX0+JvsHSHkt6nxJNKY
	nYm2koN3rnjwYAgXvcC0vk4p2S2W1/tsdkCDfTVZh8mTgj37DFuj7ZwY0T1tMXNM
	vWWkiQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx662r8fn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:49:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b18a173e48so966593a91.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:49:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592146; cv=none;
        d=google.com; s=arc-20260327;
        b=JNnT6Ooj5jjkMoLNO9UdDOSUyxt7hYrQHboJRNc+oS8t0hpQH8uxeUO6Epi/uE7PTt
         Hb5cCZ7Rv0/SYrHNsl5/wf1tY6ZvjQNuzmRzyg6wikdcCTG0JBiZ7OgCaUC33lncbSyM
         ZkzdIzo7d6HwIYNrlMLPHBrKEXean6Qj6dUIiE4YYWJXhZthVYQLd///Bh4A/rfTUBAG
         d3S2o1csjgBqWtmZDJHmFfd9VxthBzLdHM2Iach5ti7cD+AJKdTIz8Kd/TphH21SKdji
         xCJ5ob5sf2zGIoT0ZBkOwkYSMzruzrxaAzGjbJuay0z4ZYkzMvCQd9tW9ygcZJUHBRVZ
         9SKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h7ZMjOHZnub7I02GGs2+ZNq38w9ZfRd8s4DzV2qSzx4=;
        fh=e7fAE+XL/6Pd46FEn0R3aVD0pgvF1puFJbvcFwqdKPk=;
        b=kSR/kLy2JEo8k+CAmCg2rYkr/QL1mBJVjQNgh8Xo2Eex+Qu/Joj7Gz7vbUYo/Ig+hh
         bzjdj5rjY0Tx9Zc1F/L6R2ZIJhZmlCWPrX3pVgn9ra1WYC47/z0Bwdfs4BV7H7va9Oly
         idRbUZ+AeyvwCRq+YUKYgC0M/+l6mN9ZQiIfgA7MeRykfOVQrx8K8UXu17BNowlH171M
         igTzH+Br5w96QooUjd+j6dzcsiLY36w58+q8mSmD+ZvlhvrPeoz8NdqXlRPqzbeSjxEf
         tHwCJZawaZVWLNKyyMrtd+TkcIDj9IWaLUS/fSpXAHPt306MSSMwn4K1HxAPti7J0w2j
         +xcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794592146; x=1795196946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h7ZMjOHZnub7I02GGs2+ZNq38w9ZfRd8s4DzV2qSzx4=;
        b=eZKgA8Uxe9vc+C7/19XrPKEOsprszcU6Jy4jahhbXaNGqOrIY9g5eDfoNnjW2fmy9s
         s1EcDnnY+PF41b/HdsOaqCcaqywMkx7vOue9pqAyP9WB+6iKHbkuPKYjgX8H+J6XvV+a
         LIwssgclUOseCBPJpIXIGuCM0ngYesxKL5Wj6r6EpeuC4BUwgvlvJ2mJtSLdje3EmUTQ
         rIBofXh/dRyeC+Al43zcPQ61RevdKt0/wTNIfGpCLkAeCwSZMz9RMWqGRhJ34+8dtIqJ
         6xX6p2bhTp16B41TkqJTMbDxDOauJBfPZC/Ow9Jb3RhQm07pbk1rPN5KIpDTUjGaNcFR
         BKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592146; x=1795196946;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h7ZMjOHZnub7I02GGs2+ZNq38w9ZfRd8s4DzV2qSzx4=;
        b=Rh8wx26tw6Il5W/f/agvcJybq3fqT/MNmUM6V88mVz2sxGdytHGOpgU5TvXVQqks0o
         gdOFh2IXz2WIOVKSFjVldUYqq3Gk6loJPsNqmxbN60xM2ZO9or7HWHWjp2q25WzuRhn5
         Pnw/wBYJnR/eK4y06eKwB7te8gvIY7CuI75T243jo3aUzeFswQtIm2HwJWGO4f0ZFWFt
         xd9Lr7g4kJHVkC5BGTeG5r1D8pd6zJwlehoShxfliTTveENhMfmrR10g80+ggMbfC+gQ
         SI14NDECTCL0P3WbN2ZCMS4lXcX9z/8f1rvwtPfPw1Lp0eSVAw2g72vu7ylRsNwkuzH0
         QzoA==
X-Forwarded-Encrypted: i=1; AL+hErEYT5mbRQ0nmUDvxpVLW3ZtzPXoxqd+UkwaBM4eaeeZxpmLfq+RQA0ZcttzBPC1JJ+pulddIY96eA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9pN65Au9VOhhMqoiiesYLoysrHKjTyAWNk7JwHinUATwnA2Q1j
	qmljW4SVeZE+hecxzQgr5kl4nLgoi4eAo+eIvd/RxKmQkIDpbv0pTWD3V+SEy0HRfsFz6QKwGq5
	L+BN6KlDVjdTZzLB8UQdZ9LGEkrNAWT6zWDBWLFBomjEJehT2HNg8lzO3Jq5mwtAHwV0T7pyK6Z
	vimCdYaSUHCKCz5K3YLm8mH7m4KRHyj5BbPMGn
X-Gm-Gg: AYBFou1Ggbl5rK3nlFvukKAeAUckkE8klQ3ewKYnRXJk9CTSYxnGztpY1P0bUMNVs/d
	leQREi1Tw2iJG8d73C7l+XM0Hgfl7cSIWH/cAOG0sHwnMaGDDkox4j3dMlDVGteNw1pr2Kape7R
	e/R7iDTUkfRZv7w+2J+EkLd1i1WVhvKRA4+4EcmR0bg9yBrIVd/PcDxPwYbw==
X-Received: by 2002:a17:90b:3eca:b0:3b0:b64e:1e34 with SMTP id 98e67ed59e1d1-3b1b0ba6480mr3020198a91.51.1794592145867;
        Fri, 13 Nov 2026 09:49:05 -0800 (PST)
X-Received: by 2002:a17:90b:3eca:b0:3b0:b64e:1e34 with SMTP id
 98e67ed59e1d1-3b1b0ba6480mr3020179a91.51.1794592145385; Fri, 13 Nov 2026
 09:49:05 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101-rbrue-suez-upstreaming-mtk-pmdomain-defer-v1-1-b4c41cf3935f@gmail.com>
In-Reply-To: <20261101-rbrue-suez-upstreaming-mtk-pmdomain-defer-v1-1-b4c41cf3935f@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:48:53 +0100
X-Gm-Features: AclHuK_o-18EjhupOpQOHXsSHQhEk8A1OgSO8CQWrvzqq3tyYIcyEkcdDS0ZD6Q
Message-ID: <CAPx+jO94U8b_PNJbbuzzFtF2HFeM7sYaT+oZoLJUfvThXkFYjA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: Don't power cycle domains on probe deferral
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <eballetbo@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 0688qlZeaFivr5XN_yjrfnQu2I2nbqhz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX/2vTV1GXzi0i
 oUfJYOZ4Lb+8/xeQGMlqLJlNincJcvMBStGJEytW90q7zbge+H2GeXC3IWkYrBIOdraUuQfBot0
 /u+PHVtvizEe0WvPKBold1YDItkxgLEWoOdF8jN08ajMLgECo+Ygc0xHpXK/uzu7xe5z2LcxcvD
 xJGnVT5bVtOStf860sTsbv0N50MRVFGUXnsXKRqmE/EBh1oNb20/9/FVMpbvhiVtryBC3gA17P3
 GMdpPLxMUHB2nSkEqcp86YNNiY7y1tcIoirQbr/D2NLzsY7ue5MX78AOJCU1SJ5SGG7JJvF0cRn
 crEl4EmvLFcqNx7vK790MmgdC0lenvS9cMpRzc0BMa4Gdee+kqyVYl3zXf3iMtHpk/A0vTp3n/I
 yUiUY525VSCKOe7airV9n/0i5bDO4zWnM1en4qm5NvRcHE2g/GAZyO5GvP4A+aul6vUl8F1Apuq
 ZJcWI/8t0gX7XvtaNJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfXwRbSaZGJ30TW
 XnjZW8BDNNxZKw6DvwaMFKrzze3/G0f/dGbjkeHJWdUROA5tCHG9t1EN1XFi9KsTz8EBYfgWWHg
 n5tZOTrKJBQlqgqV80oJn54RJh2eark=
X-Proofpoint-GUID: 0688qlZeaFivr5XN_yjrfnQu2I2nbqhz
X-Authority-Analysis: v=2.4 cv=M/nYuCws c=1 sm=1 tr=0 ts=6af74d93 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=qXiDfWie0P3iMaLS2MUA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130070

On Mon, Nov 2, 2026 at 6:44=E2=80=AFAM Ryan Brue <ryanbrue.dev@gmail.com> w=
rote:
>
> scpsys_add_one_domain() powers each domain on as soon as it is added,
> before the probe has looked up the supplies and clocks of the domains
> after it. When one of those is not available yet the probe defers, and
> the cleanup powers off every domain added so far, whatever state it was
> found in. The retry then powers them all on again.
>
> A bootloader that leaves the display scanning out does not survive
> that. On the Amazon Fire HD 10 (MT8173), mfg_async's domain-supply comes
> from the MT6397 PMIC, which registers after the power controller first
> probes, and power cycling the MM domain under the running display hangs
> the SoC on almost every boot.
>
> Power the domains on only once all of them have been added, so that a
> deferral leaves the hardware as it was found, and on cleanup power off
> only the domains this probe has turned on.
>
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
>
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

This looks good to me. However, the patch no longer applies to my
fixes branch, due to other related patches being queued.

Please rebase and resubmit a new version.

Kind regards
Uffe



> ---
> Found on an Amazon Fire HD 10 (2017), an MT8173 tablet whose board DTS
> is not upstream yet. Its bootloader (LK) leaves DISP_OVL0 scanning out
> when it starts the kernel, and the MT6397 regulators register about 50 ms
> after the power controller first probes, so the probe often defers.
>
> The deferral was forced for the A/B with a local test knob that returns
> -EPROBE_DEFER at the first domain with a domain-supply. Each boot attempt
> was counted from the host's USB log, since a hung board is reset by the
> watchdog into the same kernel. The hang does not happen when the
> display is stopped before the power controller probes, which is what
> our downstream kernel does today.
>
> elm, hana and the MT8173 EVB also give mfg_async a domain-supply, from a
> DA9211 on I2C, so they probably take the same deferral path. Whether
> their firmware leaves anything running across it, I don't know.
>
> Only MT8173 (direct control) was tested. The HW-voter cleanup changes
> the same way, powering off only what this probe powered on, but there is
> no such hardware here.
>
> This patch was developed with the help of an LLM.
> ---
> With the deferral forced at mfg_async on every boot and the bootloader's
> display left running, 61 of 63 boot attempts hung before userspace
> without this patch, and none of 5 with it. With the patch, the cleanup
> left MM on as the bootloader had left it on every boot; without it, it
> powered off all seven domains the probe had turned on, MM included.
> ---
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 60 ++++++++++++++++++------=
------
>  1 file changed, 37 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomai=
n/mediatek/mtk-pm-domains.c
> index f0fa79e01f9c..6a81aadc18f3 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -982,12 +982,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scps=
ys *scpsys, struct device_no
>                 pd->genpd.flags |=3D GENPD_FLAG_IRQ_SAFE;
>         }
>
> -       /*
> -        * Initially turn on all domains to make the domains usable
> -        * with !CONFIG_PM and to get the hardware in sync with the
> -        * software.  The unused domains will be switched off during
> -        * late_init time.
> -        */
>         if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF)) {
>                 bool domain_is_on;
>
> @@ -999,15 +993,8 @@ generic_pm_domain *scpsys_add_one_domain(struct scps=
ys *scpsys, struct device_no
>                 if (domain_is_on)
>                         dev_warn(scpsys->dev,
>                                  "%pOF: A default off power domain has be=
en ON\n", node);
> -       } else {
> -               ret =3D pd->genpd.power_on(&pd->genpd);
> -               if (ret < 0) {
> -                       dev_err(scpsys->dev, "%pOF: failed to power on do=
main: %d\n", node, ret);
> -                       goto err_put_subsys_clocks;
> -               }
> -
> -               if (MTK_SCPD_CAPS(pd, MTK_SCPD_ALWAYS_ON))
> -                       pd->genpd.flags |=3D GENPD_FLAG_ALWAYS_ON;
> +       } else if (MTK_SCPD_CAPS(pd, MTK_SCPD_ALWAYS_ON)) {
> +               pd->genpd.flags |=3D GENPD_FLAG_ALWAYS_ON;
>         }
>
>         if (MTK_SCPD_CAPS(pd, MTK_SCPD_ACTIVE_WAKEUP))
> @@ -1085,7 +1072,7 @@ static int scpsys_add_subdomain(struct scpsys *scps=
ys, struct device_node *paren
>         return ret;
>  }
>
> -static void scpsys_remove_one_domain(struct scpsys_domain *pd)
> +static void scpsys_remove_one_domain(struct scpsys_domain *pd, bool powe=
red_on)
>  {
>         struct scpsys *scpsys =3D pd->scpsys;
>         int ret;
> @@ -1100,11 +1087,10 @@ static void scpsys_remove_one_domain(struct scpsy=
s_domain *pd)
>                         "failed to remove domain '%s' : %d - state may be=
 inconsistent\n",
>                         pd->genpd.name, ret);
>
> -       if (scpsys->soc_data->type =3D=3D SCPSYS_MTCMOS_TYPE_HW_VOTER) {
> -               if (scpsys_hwv_domain_is_enable_done(pd))
> +       if (powered_on) {
> +               if (scpsys->soc_data->type =3D=3D SCPSYS_MTCMOS_TYPE_HW_V=
OTER)
>                         scpsys_hwv_power_off_internal(pd);
> -       } else {
> -               if (scpsys_domain_is_on(pd) || MTK_SCPD_CAPS(pd, MTK_SCPD=
_SIMPLE_PWRSEQ))
> +               else
>                         scpsys_power_off_internal(pd);
>         }
>
> @@ -1112,7 +1098,8 @@ static void scpsys_remove_one_domain(struct scpsys_=
domain *pd)
>         clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
>  }
>
> -static void scpsys_domain_cleanup(struct scpsys *scpsys, u8 *domains_idx=
, u8 num_probed)
> +static void scpsys_domain_cleanup(struct scpsys *scpsys, u8 *domains_idx=
,
> +                                 u8 num_probed, u8 num_powered)
>  {
>         struct generic_pm_domain *genpd;
>         struct scpsys_domain *pd;
> @@ -1124,7 +1111,8 @@ static void scpsys_domain_cleanup(struct scpsys *sc=
psys, u8 *domains_idx, u8 num
>                 genpd =3D scpsys->pd_data.domains[pd_idx];
>                 if (genpd) {
>                         pd =3D to_scpsys_domain(genpd);
> -                       scpsys_remove_one_domain(pd);
> +                       scpsys_remove_one_domain(pd, i < num_powered &&
> +                                                !MTK_SCPD_CAPS(pd, MTK_S=
CPD_KEEP_DEFAULT_OFF));
>                 }
>         }
>  }
> @@ -1361,6 +1349,7 @@ static int scpsys_probe(struct platform_device *pde=
v)
>         struct scpsys *scpsys;
>         int num_domains, ret;
>         u8 num_added_pds =3D 0;
> +       u8 num_powered_pds =3D 0;
>         u8 *added_pds_idx;
>
>         soc =3D of_device_get_match_data(&pdev->dev);
> @@ -1436,6 +1425,31 @@ static int scpsys_probe(struct platform_device *pd=
ev)
>                 return ret;
>         }
>
> +       /*
> +        * Initially turn on all domains to make the domains usable
> +        * with !CONFIG_PM and to get the hardware in sync with the
> +        * software.  The unused domains will be switched off during
> +        * late_init time.
> +        *
> +        * Do this only once every domain has got its supply and clocks,
> +        * so that a probe deferral leaves the hardware as it was found:
> +        * the bootloader may still be using a domain that is already on.
> +        */
> +       for (; num_powered_pds < num_added_pds; num_powered_pds++) {
> +               struct scpsys_domain *pd;
> +
> +               pd =3D to_scpsys_domain(scpsys->domains[added_pds_idx[num=
_powered_pds]]);
> +               if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
> +                       continue;
> +
> +               ret =3D pd->genpd.power_on(&pd->genpd);
> +               if (ret < 0) {
> +                       dev_err(dev, "%s: failed to power on domain: %d\n=
",
> +                               pd->genpd.name, ret);
> +                       goto err_cleanup_domains;
> +               }
> +       }
> +
>         ret =3D of_genpd_add_provider_onecell(np, &scpsys->pd_data);
>         if (ret) {
>                 dev_err(dev, "failed to add provider: %d\n", ret);
> @@ -1446,7 +1460,7 @@ static int scpsys_probe(struct platform_device *pde=
v)
>         return 0;
>
>  err_cleanup_domains:
> -       scpsys_domain_cleanup(scpsys, added_pds_idx, num_added_pds);
> +       scpsys_domain_cleanup(scpsys, added_pds_idx, num_added_pds, num_p=
owered_pds);
>         return ret;
>  }
>
>
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261009-rbrue-suez-upstreaming-mtk-pmdomain-defer-0cc87eb8240=
0
>
> Best regards,
> --
> Ryan Brue <ryanbrue.dev@gmail.com>
>
