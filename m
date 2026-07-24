Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D8234D915
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906747; cv=pass; b=ZQQd7mewg0lpO9PtKsXP7n2uwul6utPoXhxyqej3N1RFKiWgu31LGgfPAcV0i2R8yKkmWdqKFAQIDSUzOXlhb/9wUGyRpvjScQh3tr+mlK+4bBoH1gKxTKuGn1N9RflM/tggxqNP3ZDJeP3FX6NpzE9/KqxbtnxRyDg/QGldXcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906747; c=relaxed/simple;
	bh=4yOVodZzM/KR943GEkikdOIdqlRD8ioz3XZaX7Swa2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Txtb/+z/piNLQHSulifBS1+gUlL/nIY+74UEOnoPB1L/LW77G7v562R8uGx/aWcB7T+93108Gj5dpQPw0xTGdMNxkLQowZVghAT5enIt3WRYAIIb4zvo62dtxoNUxr2x6zLZptFtRI0eMME6GyQC4j37+VMCUykAH2uFkzHekWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lUQ69t8r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cassZWXr; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lUQ69t8r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cassZWXr"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbBUI3089353
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gF/UkUqvrY1lcjLFHPeP744pWwMQJ7+CJ8FQ/U44hAw=; b=lUQ69t8r3RQ0hcwP
	F3p3KZcjvfYHlLOc9loUKm351F5eve2wv3d4XMk+XrsMxRN7RlNpFYWE+yjRBWCO
	q+6aOOoQX4zuDIoN4r4Xq65hVaMKtAN1iS8EE0uALs1dS/zO+b+qptb3kY+AGD9L
	iEeHPlz880faD+3qbfF6MXEUko4W/KzCS/irSMbceWx1sGxIRO2sxzfNkhvxRqnu
	FUKnBfB3UkLRGnNJRkm+bvOpHYxTW075adGj6sd51Y1m1QJRj2u1CTMmHGdFGKLx
	PH0wHKNebbZgmaQDL3OiUq8Md+iAS5iGtjFrDWSqlLnnUVqKcYwRr+uWBrXqfcep
	C18zWw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cggk6c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:25:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0199faafso8951121cf.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784906743; cv=none;
        d=google.com; s=arc-20260327;
        b=al3yUqU4oNmx6hy6NZHcahxg4X5iAY2D4EKI55GCE6by4h02B/B0xsEmTR3gYIn+wD
         QU+O1y62Yl00POMSoPdAP+TAY+vg6dGcyC9PzspHfGkX+Yo9twa5mW+YPzu7wyQRKGOi
         GoZodJpeXCD7tj7DyzLfyKWUTpeYKhaan9q7SjoCXZKuLJ/T5O+Wk3akvimArW/Um8/v
         YGfzLsfC2tJwrm3wm23NxESrrlRs4LxYuYiJzEcS82qxlip6OYAqrUCaNcfupID/kuuE
         FWPhgAG6ZzV7sUOiztyhtmbSzRpchkcRU47ZadF8o+/JxjzVGikS21NwBUeFvWz7emPu
         OK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gF/UkUqvrY1lcjLFHPeP744pWwMQJ7+CJ8FQ/U44hAw=;
        fh=zV7oIfOrPrL/2ILheO+FDEUZ72BsO3iN/DytSGOhj+8=;
        b=NnK7PAlvFjq8PgoHlXs+/srDhqE43JLvQUXxB7mnT3soqMcuY7I6Aas0q87nasuhWv
         uJom/2VxNdG4j0FQuMxcmQ8xM2ks6Nt1mISXkWm7wSW57I2/I9giQYI0W8Z+5Sw4XoJo
         McOZiul+0my+ZZZE93wD2Tsm3h/fo57mNKGQVwdutIdESKeH8jvY9B87PcHXTRu4o6Yo
         ov0+bTjKtwWRiMuBwSO/IIFjmxiSZV5gX5/L1DyGhnl467bCMlWhIvNx88tWqUhYG4LX
         Sm54TOxKr2P5sTqFQ6tKGr0ZAgT6mpRQ0oVksRLWSzcYWVA3raXjv29z/mqpmLjFxd6h
         Xa4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784906743; x=1785511543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gF/UkUqvrY1lcjLFHPeP744pWwMQJ7+CJ8FQ/U44hAw=;
        b=cassZWXrfw6eiNpEd9F/qND6kD7VKGVX0VhtGODf1WGw4qjvKCuKFx4TCtgOpAPZps
         c8Lh24g7m2l2M5hnWM3NZR7IWFLcslYY+74QjwA4hxqk5rfwSydWojvl3ClwM1PZ5pUi
         fnSI67hwqQa6ChnyTRJI2hI1nAh+GShJuyNUaxdY996HAw1MLfmX95XrTNoRIc3pgrnG
         ySUMq9ndifzrtEP5F0sLlTNVRvtFPXmBaFo7tv5kLI4InrZVG8zDcjzc7wynHqijPhfs
         jgCOGJbO2K2r7Ma/LOuSFA6gsxN0/Xd7gecltDDNSfBHHrFb7uEfanfFFVnQAKaHpBmd
         ddxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906743; x=1785511543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gF/UkUqvrY1lcjLFHPeP744pWwMQJ7+CJ8FQ/U44hAw=;
        b=FqSDBet2SeoUWAfwyre/gqFrGK61qC3JRplYm8upsivJXtrbT+ZWw/Oubq3AUj9I8Q
         5DrKrtBRooEbPF8Jg75+ypyJw7Sz00DRXENXP3unKP2RX6M5VpNFOGd9KIxUFxJhckHv
         fDBv6NXgjHTHTu9T8GQeRdga6juj0v4REKLQ9DDH0rUsaB0csF7wF1id79wCK7FmbtVA
         g7H6089s0hN/UOOSa5buJq8oLhJY7/njBQLPv5VG2Pi6UHOSQaT1fHqQvyUqSwaf4+kG
         2MywLDn7ax/veXJA5pM6X2LDg35PHeyNhlguBFqro5lXslAMzPgqqG5lMC8T1go4mkgv
         D2qA==
X-Forwarded-Encrypted: i=1; AHgh+RqIqWp0dcQAXsnn2v16yYoFNskaNPQggfM2mfWleefPElkocbyr/r/TMQCTZLS9V3Ye5jZfPXpiuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjtRUPNAJrw8E6BJBnbFGcuyb0HuSso/w0Gm/Q/PX95clVTRR
	pLc7eQEeyATHyvHpkMUw8EVUNG4iqQXzo/eVRHlowyvHQJHtokFogkTVZ0uZ37cVmYxymlBN4oO
	jVbhZoGiHRzPmzfqLuQJpn5qNAC7QSkZ4JsiQv7mqTlEPUbZQCLbSfLUP0LxvUOmvu07L/kGwyn
	ZUyvHdTvaaGhXzqIXmnVTs05oFFpn5QD/la/mj
X-Gm-Gg: AR+sD10617mar73lqQA0LV4wuck05ze81clGjhdyydslP7Dn7BDxxefea1wm/0D0Tj6
	FKz8LgOJqZpc83cNITx+M5OiQwyuMIxxPyutYlZMzeGMAOtw08CXu4AkrV88jqZA0GHbmq3RwCL
	TpIDPqWfbA52BnCLYmDsCegS2Kimuev3toUcs4/ZLZ2/dnxSlYo8B4/2kuVA==
X-Received: by 2002:a05:622a:22c3:10b0:529:a2ed:bcd4 with SMTP id d75a77b69052e-529a2edced5mr2053161cf.50.1784906742965;
        Fri, 24 Jul 2026 08:25:42 -0700 (PDT)
X-Received: by 2002:a05:622a:22c3:10b0:529:a2ed:bcd4 with SMTP id
 d75a77b69052e-529a2edced5mr2052841cf.50.1784906742426; Fri, 24 Jul 2026
 08:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-mt6858-pmdomain-v3-0-8966d8de93c8@jolla.com>
In-Reply-To: <20260720-mt6858-pmdomain-v3-0-8966d8de93c8@jolla.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:25:31 +0200
X-Gm-Features: AUfX_mz33HxJNiHzlKKDq7YYI97h7l3wukc4IVOHOz1B7cIf_lHzlGi_RyWl1W8
Message-ID: <CAPx+jO8gRxfM=pxMjHrJNcexOzDRiHjauVVDbpGutPKaApghdQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] pmdomain: mediatek: Add MT6858 support
To: nikolai.burov@jolla.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        Nikolai Burov <nikolai.burov+review@abscue.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzOCBTYWx0ZWRfX3XYgpUqGptot
 CU+JuIHIyqgAC+LvD1skoLYStG0wNgLsXOUXRGYCmK/qg7f1feHTeYwLaNoRLfQdXUbzAGXYIch
 j1CLVt3XjnE44OUwUIUTRhdJyxdoO3KArCzNx31TnkMONd4ifmXUg8kdmzce2sBZuYLhfA7uY4r
 xzBGX1V6HNkfJrSkYkWger5wPbZKLmBStDPiwcZ8f6FbnSKSS5OHNJ2St0H+7ISH3Iw4RC+AQhS
 eaNbf3LmM0+24WxMqByMD3wC5sWs4f+jfTAjHATpP6W+2/cG45NyPmwf4JtLnZu2lJUCeW9CyW7
 bOH+gx8mgl9pGV+CIzxXHuz7reeogAuWshOojwJfPc57RBwVzJW4egxWlgQgsienskF/VZ+Y3bf
 nFktoGvVyuCPP/FxleDAjSiJy1UVVACtgnglQNfoXg84mBDDDQH6597LTTsAJmRqfouVqxXBB2p
 qncc27vKCX1wyFKLJng==
X-Proofpoint-GUID: sBl7r32vO2Gr2cGCwcvG8oUcuxeY-DkX
X-Proofpoint-ORIG-GUID: sBl7r32vO2Gr2cGCwcvG8oUcuxeY-DkX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzOCBTYWx0ZWRfX1rrqxB5GRDuy
 3gIsgmNdqzLtP92qxcwfStEmlOWtZCONpQr+Xf0kAtbr62QGCd9RixaPsYm9Es8E0hpIxNpLeBH
 Li6MY4osU0Z3/4TI0RmJhyPZJiOOhoU=
X-Authority-Analysis: v=2.4 cv=P9sKQCAu c=1 sm=1 tr=0 ts=6a6383f8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bC-a23v3AAAA:8 a=R3Y5_zZgAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=QX4gbG5DAAAA:8 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8
 a=m8CDPgaNMIpP4pNAotQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=chadc-dSXXc7PrnZVOv-:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240138

On Mon, Jul 20, 2026 at 10:46=E2=80=AFPM Nikolai Burov via B4 Relay
<devnull+nikolai.burov.jolla.com@kernel.org> wrote:
>
> Add power domain driver support for the MediaTek Dimensity 7100 (MT6858)
> SoC. On this SoC, there are some new subsystem-specific bus protection
> blocks, which are listed here in ascending address order:
>
> - IMG_SUB0 at 0x1502f000
> - CAM_SUB1 at 0x1a00c000
> - CAM_SUB0 at 0x1a00d000
> - IPE_SUB0 at 0x1b00e000
>
> The VLPCFG bus configuration registers at 0x1c00c000 are also new.
>
> Additionally, implement the SMC-based power sequence required for
> enabling the modem power domain on this SoC.
>
> Signed-off-by: Nikolai Burov <nikolai.burov@jolla.com>
> ---
> Changes in v3:
> - Fix error path to also skip sram_pdn for MODEM_SECURE_PWRSEQ
>   (discovered in Sashiko report)
> - Link to v2: https://patch.msgid.link/20260715-mt6858-pmdomain-v2-0-6293=
e87fc093@jolla.com
>
> Changes in v2:
> - Rebase
> - MTK_SCPD_MODEM_SECURE -> MTK_SCPD_MODEM_SECURE_PWRSEQ
> - Convert SMC command enum to defines
> - Based on the new SIMPLE_PWRSEQ changes, skip the sram_pdn stage for
>   MODEM_SECURE_PWRSEQ too since it wasn't intended to have an effect
> - Clarify that the SMC call also handles bus protection
> - Simply if/else code based on the assumption *_PWRSEQ are mutually
>   exclusive
> - Add comment explaining that PWR_STA_2ND is skipped for modem
>   (mentioned in Sashiko report)
> - Link to v1: https://patch.msgid.link/20260714-mt6858-pmdomain-v1-0-4f09=
bbb822e0@jolla.com
>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> To: Ulf Hansson <ulfh@kernel.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
>
> ---
> Nikolai Burov (3):
>       dt-bindings: power: Add MediaTek MT6858 power domain controller
>       pmdomain: mediatek: Add support for secure modem power domain contr=
ol
>       pmdomain: mediatek: Add support for MT6858 SoC
>
>  .../bindings/power/mediatek,power-controller.yaml  |  21 +-
>  drivers/pmdomain/mediatek/mt6858-pm-domains.h      | 466 +++++++++++++++=
++++++
>  drivers/pmdomain/mediatek/mtk-pm-domains.c         |  55 ++-
>  drivers/pmdomain/mediatek/mtk-pm-domains.h         |   6 +
>  include/dt-bindings/power/mediatek,mt6858-power.h  |  23 +
>  include/linux/soc/mediatek/mtk_sip_svc.h           |   3 +
>  6 files changed, 568 insertions(+), 6 deletions(-)
> ---
> base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
> change-id: 20260712-mt6858-pmdomain-b1b456c96675
>
> Best regards,
> --
> Nikolai Burov <nikolai.burov@jolla.com>
>
>

The v3 series applied for next, thanks!

Kind regards
Uffe
