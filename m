Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CD3E0220
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277573; cv=pass; b=ft9UlJFTrHpO6pdMxOL8VawTYFoVVbiYy1TbuaW8lbJ2H4IMd2LPthy3FmoudvIJ8GZHK6EHf6Jl3TervaLHJcEHzD2gEYVgv/j6pZHGjMC50rQL0468SDxOj8CZEpUrnPHwIyRJTAxGB0inr/spXNkLUMFxNbJ80sPz7h0kIj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277573; c=relaxed/simple;
	bh=XLo1O6Y/6Eo3OAdKCdgs0D45eVegKXe63+OLb+kXWng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpZGw3Xcd5FdjBINcwdh1FfB0pBad7aElrLUqt3FpA+xW56jF2u2w6BvUz3WQeB8+2aAe8Mwx39ZAbDPztLRT9VvKtOQ/HsNZj5DzM6I5uqEFl055QE7rVnQS000B84bbhPNIIi0dBLcYTNpBJfuiRsk2O3fCAn6hvX3eBzc18w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=feYTI9+A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zmalf/Cp; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="feYTI9+A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zmalf/Cp"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8iDU2825141
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 15:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZesAiea/HD1vlRsrFj0Au2AyHXRN8QeZN3AWkJ1tr+4=; b=feYTI9+AXed/U2aQ
	urR4ihwgtlD6ItpFSuAQtQEVdpvW/fhqqnRBzvM8xzz9hcvZK3m3gA19/Y8/s6co
	STQk+LdhxM8bCRTz5CeG1xf4+1Bd0Osr3fH50gOkQlcSbZpzi/0FVSDyG9RFqoRU
	QUw1PuLsqUbMfpGZeJk/ZLXRdguuyBWlBZBv8zcKoazxEe8k7zD58ccU4eAl7dWl
	yHxtugvSRYVgOOAe2HecNQDneJIXfyWjML+QoJCW7tqM4OGxoiPEg5KoeZnhHu4Q
	/6rGV/R30g4y9ExEGzEwmxUS+9DNxqYesPbcPBJmpIFk1ud+YEDSKJQqXAG4FDsl
	Lp1Bzw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp7cbc0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 15:46:10 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso25579a12.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 08:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788277570; cv=none;
        d=google.com; s=arc-20260327;
        b=YnW4FCbvZa5bHq1Bzs7GXb/WIkWPlzGx2Lh36p1p8Y0rWRG1lUVgg328VJh4kwNIz0
         TmCfdWn2SWYGzVKnsIW3gurP2oNYooumic/pcD+92umOuokxn2beCZR8G1FmdV7vt/ou
         5SOOpueCdFHR9q9mrHtPa0HqhSlKLm1njXZVvuqC4GziCXX8IO3YSdFjnXU+36UtzuzG
         2HPNeQ/SMiDIAVwbppncTsyecFj9Qrt7b8qnqveNtvUzmtuQueoNSfMKQFTbbS/6f+Tp
         Mrn/qoyd3K2SZ9HeV+9VHUBlEvDBPk4gGzyUycLFwBG9rit2cDG8HYCJUc3FqkLQGVqe
         IBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZesAiea/HD1vlRsrFj0Au2AyHXRN8QeZN3AWkJ1tr+4=;
        fh=GwCcwF67WaIJsUDatCX6eeXH6rIVRo7N8kfWv75WgC0=;
        b=i+naQoHPAD6Wn82C/SE8PwkXEH8ROjZWk9fZizOD7/oKIh+9USHBlSC1cH9uqobdhN
         h1A8/5WpXsLiHYgTLgkGzu7dZIAFO2ThT32tTKhXpbUgG/ZYvFTT2JzS1YtsdlJrSvUq
         swviac5og2C0Imd/AbYTq1Dx2hdyvwM9de+7+zIYxcBlEnB+RDJveZJYsJDaR8psM/wE
         Rahr0ir9XcXdqmDGsGmtmgxJhCB6N/5mlrSVOmKjj16eUD0JpJDYczqknTZr8pZqggXN
         cDcDOygdx/lkkAUT0RhpnaoIv28gMJd5gAm8FkUvUTQZVJ7FZ4cZmfaj+EIPZ+I48e+C
         QNAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788277570; x=1788882370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZesAiea/HD1vlRsrFj0Au2AyHXRN8QeZN3AWkJ1tr+4=;
        b=Zmalf/CpZqZ90n6GiN/drfFuPtW6C3zLI7PxjwV4tjDMIUGqe7t9NmsU1JSUwGkXLB
         CJEwDCKywBSB3VH0MVY92OhMmezz98siPKY6Kngj5fL6ORV/Mfq5QzuvBrbcQYeT+cgI
         pngsqpQGD5dz4+FMovzbP9SqJTdY3YdkrOShCgYpQ6UB8gEDFCgr4IfFBJJPAIgjBLWc
         JWEojhrB5WIbLIAO2uVklaSufuBNPst28xSBCeOnpSKZUd9NKYIeIz0fqLJCk5u3cJ0C
         VqFJOYuRRzFTPF1F5DN2DEQNVmp77HTDDvgAL1MJBeXvCdjGOnWLtj6N95aezmmJXVIA
         0WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277570; x=1788882370;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZesAiea/HD1vlRsrFj0Au2AyHXRN8QeZN3AWkJ1tr+4=;
        b=bxW8D72wKsVao2pIAc1PIZ8kOPBhG/rU7MW84jAd0D5ShssAeW8r9stku74gCNlD7X
         v1enmrYfBrmmzWD4NdFjh8X1BIECbJBRuupU3CUin238EwLPvFP6bAiwP+ioatKJuFUD
         Zf14YKX9P/AV39VofiJMyOwcClKW6zOboNhIervaiBklAxu/7g++7K0U6JdO/u/28CVY
         37Fzdytp6lpTP5DeTyq2lR829i+8Z8xVN3eSYIyIJcQYG2rquG0r+6mEI55DBl5v7yzh
         RmYxiULqjQBg4xhvKyBSspOrUDXX6HXF3ifbYB1BG6DCQcNk2gbYrowj5VhWrneqWzg+
         G56g==
X-Forwarded-Encrypted: i=1; AHgh+RqbOiJ6G604Yujs/M3zKWisxp4cbn2+RCQ+O0l9/eEN8rFwFQyP/rmYiVfRj1LF9y4H2YwQyPn1xA==@vger.kernel.org
X-Gm-Message-State: AFuF++kq2OqhnuG9TOKAdADeByRjbDi4uzVfQkZ54ULyb5gQ+Y7YgddC
	n04m7wJZa5AJ/7ddDP9bqFCLbGtdilpTX8JLvJzvRq5TEsa6oW4knWexsPJ34eEqjSwm8oN0RzC
	vvw+e+SGI2qOuxIIJI0RT/Gb9+7iPN94P0VIaf+87SBmZybePx0X1Xw0Ifr9QiAPrGlkbZWN6H0
	pR5qRFKRPWoHXWjNXjoo5jDkQa3bR48t2xKUPE
X-Gm-Gg: AR+sD135RZHcCFYAyagbjLbJUCgKLGeEDkXx9jfQKUuMAlZdP2O8sJ7b17bBxaSMknE
	8TWSfbZde+nCvKo3Y+sma0mW06g4bfDeZZ+NT4aVQsSONTRJX2+0pxFYIL5YOO38NitG47YTNve
	bghv5zTz1XiFCHwMYhoilin7UyMhjnnA7+kuL1w6k3gUelZDE4paGfMe8CpA==
X-Received: by 2002:a05:6a20:2d24:b0:3d3:af66:9f61 with SMTP id adf61e73a8af0-3d7b0858c0dmr13796015637.27.1788277569839;
        Tue, 01 Sep 2026 08:46:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d24:b0:3d3:af66:9f61 with SMTP id
 adf61e73a8af0-3d7b0858c0dmr13795922637.27.1788277569390; Tue, 01 Sep 2026
 08:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821085222.140633-1-ansuelsmth@gmail.com>
In-Reply-To: <20260821085222.140633-1-ansuelsmth@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:45:57 +0200
X-Gm-Features: AcwNN1X-ZkG58Ju7YGsTebESlLv7OBivRQr4LICy-o3mSGUv_1-w5G-mpWoo6R8
Message-ID: <CAPx+jO_T3qLTYh3VORuPB7_caWXXOXy4XYfwXhT4THEjTghj4g@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: airoha: fix unselectable AIROHA_CPU_PM_DOMAIN kconfig
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=OcyoyBTY c=1 sm=1 tr=0 ts=6a96f342 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=95gA0qMHRU8tCJvgjbwA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: QyS5NLQGtTZSs0gfpA6aBezs4cIvv-uV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzOSBTYWx0ZWRfX1R2YNNVk6bZM
 7nEDKTkuUudOs2caFT/6qsxFmwUJvD4tttgvu4rFJwtWM3g4Mto/1vfwVrka8wdszHNapYsVLV4
 IMhPevrwA0WVhnUMO8/QPSfASb8jxZQ=
X-Proofpoint-GUID: QyS5NLQGtTZSs0gfpA6aBezs4cIvv-uV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzOSBTYWx0ZWRfXzixJ19RpOs2U
 fyqMsLR666phx42cd5NXg11qgio3Sy3zgSBklwF2z3AOQgxIPDpt46WxDIOLAekYZgdOhNd4S90
 IWkjqWlMcdYEPVzD/EGU1rommpo3wTylpjf5iHGc/Wz9JvIyiRrJWZi/wMgaKp5uaPO3+Xm1zTh
 xzvK8mBzuqnZ7n3MQmc7FYplgu+dws43dbsehkZr3h5J0Db7Ab+0EoOuxyzHu+vfliCCppHeeR/
 HXAVsBEd6nDmmWbeePP5FFTvR6nJ+8GAI3FrGGAGWzSd9Z9Lu7x4Oq7z2BkCPz6owVcQBcmtqvv
 HGLN9f36EINq/Xtv8OOwEkAhNd0jKbZ0Bn3OH5wQ0pFgsWlCJAjsExP7K9/JzIE/muP4HaBe4vB
 kfswakBdhNsTxVPxhs+qm5XI/G0/kAZ+ky5GNzle0gEJtK/DgsIM+ml2JgKOKuJu+s74Bhj+vLN
 OEzyQJ+A95dLC69IbqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010139

On Fri, Aug 21, 2026 at 10:52=E2=80=AFAM Christian Marangi <ansuelsmth@gmai=
l.com> wrote:
>
> The AIROHA_CPU_PM_DOMAIN config was wrongly guarded under the Mediatek PM
> Domains menu and was unselectable.
>
> Move it outside the menu so it's now visible and correctly selectable by
> default on Airoha SoC.
>
> Cc: stable@vger.kernel.org
> Fixes: 82e703dd438b ("pmdomain: airoha: Add Airoha CPU PM Domain support"=
)
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/Kconfig b/drivers/pmdomain/mediate=
k/Kconfig
> index 8923e6516441..a2eb704a773c 100644
> --- a/drivers/pmdomain/mediatek/Kconfig
> +++ b/drivers/pmdomain/mediatek/Kconfig
> @@ -43,9 +43,12 @@ config MTK_MFG_PM_DOMAIN
>           This driver is required for the Mali GPU to work at all on MT81=
96 and
>           MT6991.
>
> +endmenu
> +
>  config AIROHA_CPU_PM_DOMAIN
>         tristate "Airoha CPU power domain"
>         default ARCH_AIROHA
> +       depends on ARCH_AIROHA || COMPILE_TEST
>         depends on HAVE_ARM_SMCCC
>         depends on PM
>         select PM_GENERIC_DOMAINS
> @@ -54,5 +57,3 @@ config AIROHA_CPU_PM_DOMAIN
>
>           CPU frequency and power is controlled by ATF with SMC command t=
o
>           set performance states.
> -
> -endmenu
> --
> 2.53.0
>
