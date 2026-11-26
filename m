Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795699919;
	b=HXCac7GTbbaS2H3bTSuYBHCe8gw0uKWSbscSjLEYOMVOIDrenJaWLe1bXdtg851Y0y41
	 bbZssVSrKEBcoYiL+1yMRmIC9vav/lhtQydQoPqRKuzn7SQfVqcz6amS7orvpBrBMprWt
	 nRC0KyFzeta+pYv/dPUDGsCFOQZb2FiPQxyQuZv9ihpdG8xvqq5J81rvh8H/sMPpJX7mV
	 V/bLFNHC9ZKM3X9snQUNvDhfFGM1V2yvO3nfN78jWWp1RQBuxp02GpSogmGCNyES5cy3/
	 3m0XsjpvaWOXtpU6YRxOuRblH+dXybD7AR3YYTe/xO9MNPJpyS0Bo1dMS67weMf0TXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699919;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8OFxv6MKKXSdqKHSw83//4iMpg5debE9kS/FM6OLb50=;
	b=IfkpHlxu0RRrL8iAuGELnfniwZa7cuocf0LmLtJ13XXq/uGxm3Oju7uHNf8cubBWu4xZ
	 1BLfaWuRGUWiTavjput/bSbR9bCfAmf4rHezBFGVJnz7yszL99izIaOgko0nNvLwDQvMo
	 loi1kyERqIypZUds397HnrOe1sJVTtmcHap/d/LWocszofiYnR0GUFYeBJv2xjduDhEyR
	 hKC1kpMHSNOzmtvdeoHrizsK9fY2sKKCI+oRH76lxGScUT8Ax5HRWfVBQNGpmTY057SzI
	 bxWpPHIml6KsckMtLPaLxA7YRvIiDfnrJ3wTkXlRDgwA+uK9CY0R8U6xVKWWQvtuGtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="lVnLx/XV";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jJtOP7JW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B210606A331
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B210606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lVnLx/XV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jJtOP7JW
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVQmm2758194
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8OFxv6MKKXSdqKHSw83//4iMpg5debE9kS/FM6OLb50=; b=lVnLx/XVkcJaiSpp
	oLrrfQ0e7ix1RT9OrfS39lYUO3LgCgDlR0pPQctKZyXiAKUmKYttNwqctB1Su//4
	bZyJYRE+/0ED3DvH+FJVuajrn7ZDd0FGi5N/+2ZljKaXaPrmEtLOoEjsWIS3xssN
	0/eULf2JflCZhznLeu1S7ucb7S0C9BpL5fjA8X/qc8uKZ60b4Y3JHpJOqN3eNTZq
	gqkxowsyWy6f6WnxdLPsUbtwcCtf+rneiRq68AiSgHp4hg/AAzVGOrd9qa2lk9kk
	W0SgyL6W6JjziNki682KZA7YwyL/Mgc17iCmLWwZ69dB+CVkgmsvSJaWBQodPWgj
	rxiKiw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahvkbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:31:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd60e4e8bc3so4792343a12.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 05:31:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795699917; cv=none;
        d=google.com; s=arc-20260327;
        b=RvYz68dmQIgE2zrsc95pRbYuBoVftqJ6AmVwVI3iorBumiYqT0EYV0g4G940mJpHie
         gsqZ48LvDlKK9FkfUOdtme/gJyycvNz03wjArcVz6ehgirBpVf6o45clZP5bSSjui12M
         V3i6kC7LGSWjVad6Futs9yaxktwmTMqEcbBhmPQUzVCPjqpdpSWWCegqStEqoUe0L1Om
         uJ9c3jyyroD/LhRLv5HcPpTm5BDdwx+1sbJsg83vDiRsH0WEGi769sGgd8oCZO0QgyH2
         LPzGFydtb79/KR+rn1tEG+fhStNP6Z3OwTmPX6/0Ao3fRBsLPk3cIouS9DQNml0uSklv
         ldAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8OFxv6MKKXSdqKHSw83//4iMpg5debE9kS/FM6OLb50=;
        fh=AqJ7DllkePLGsW4hfW+sny7mcSJf4uoivhpjVi8AOw4=;
        b=T4+GE9ESC4q//d7V3JBhpCwkOR4qwmEfFOB4R17pr6KA3dUbaJhXjvBZwK2z+dqJFo
         5qbTtlXINZiHRAQBJC7ujHcr0nryCLLo7TjKH2uNOiPNEcaH4gpxMHT4VZ2/UfJ3kEoM
         isM3skUlCmVOopIVr8SGK2x6CzsdM3r93YoKoZdJlD3UPI6J+5OzzK3b/vMHuN2ZZdxF
         nayLedbBkymlMiFFbH7wURFgmhBwwtm1KGa+2qJYDIYLQhT0RviBDubverg4se58o5EB
         yfc+w0/6u5wKoEQXUtj2EYnArk8TThXSqc4HdkIZNUagT7oFsMFY5JE3FFxWMSr1KgjQ
         9wGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795699917; x=1796304717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8OFxv6MKKXSdqKHSw83//4iMpg5debE9kS/FM6OLb50=;
        b=jJtOP7JW+89nqM23yCpbNbCwrlCI0B4q5yD+RzlKyvpWQOXvw2WeqFQCon2iuCxtmN
         9X/2Ow6JbFlvvFaaR15fah9xSoxj/Qy8ByXC7egAtrGSuBzKZe3xb+Eef6AfC/kZZO2D
         JZdm+MXNqxvQiJUw4x98cdW/Wl0wamr4naGOv0eJFURvxRwZDl0tdvTR1g2kAwIuCzsX
         12CQXHn4jMci1iA0px+mp2knagUHTAx1zpzzh4wGNKFs+i7FrqcWFmNCxY/uYwYQuBjh
         aQL+dPOCBTX8+XKmMF72Snq1CJL1gnf0ZGWS6MeBI+bCpdpEzUBn2wHEMxcwMtG5bRLu
         t2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699917; x=1796304717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8OFxv6MKKXSdqKHSw83//4iMpg5debE9kS/FM6OLb50=;
        b=CAT+irw6I6ETLU0PRcEpPmjM3KUy/jISiiomJ3NL8tr6ZPLiIcLxAmCiIehNSnk3AW
         Obv02twwgNY3qF7FMEUQTmojkadoykfutMsCdqUIXlknFKIwcWrr5cXuuqmyHmHvjmVs
         TKmcvfPnKQ/A2KOwgEO/uZp8sdalZqJUJsSP3ZFua7x5HP5By43DEeVEtmR79/T3AQRZ
         fWLx8SDvLyBhpVQMljdbOMCtVNk+UZgreIjetI0nQdphUL/Q2uuyDxBw4JUIMfks/3X2
         YzC4dDz8KcN0mIMNAevNd/5Ml8MQVyOeqdn9ZxOFF37f5Mo6jKBgDIf+lWppRd1e1vnf
         hi7w==
X-Forwarded-Encrypted: i=1; AL+hErGTXNIcTv9WMesl4WqoK7Is0E1duGNY2tgVfv5CJ4sq8kaGHY4hsrW5JGcEGLdjPvMpvOCe5TWMIg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/KHw9zVu9+7lkyuqNl4T8D5hvTNuZtBX2SFW+C491G1nuCkSXT
	qfl1CkibaeiNVEL70ZgAKs0BlpN6IknBuaL02+B9iW2XSLMR32Rb5+pZO7U6N1x8Xf9wAo7UsGT
	albbbpJH8Bp68vwvvwNCFbKjmlXsY7lY/99wM00+AcQFlXhLqfRrGu1PBKvtHa6mSVdqZG3F20N
	ZXuKzYyTTu17pLplp3noUVOwo/J8wBfFHd695f
X-Gm-Gg: AZFdTZeoO1emSLS1JASKjZ41+RvTUq/e2zBwMGdAOp6fQ0VGJaIzGuf8JuZ1+lsnQSN
	df6przw25pgd6bEsHHHjZ9dZF7jhVIx/0q47BGDnWyqUhutMAmafuJHfDK6/rRAvWUv9BbJOv0n
	8wj5qmbr/8THSp1/9NEGTTTZ9vmMoBfC6wNn6GnueU9zsM/8WYEeLs9PjZOA==
X-Received: by 2002:a05:6a20:748e:b0:3fb:4a1e:2f82 with SMTP id adf61e73a8af0-4014ce58b6emr21264797637.61.1795699917098;
        Thu, 26 Nov 2026 05:31:57 -0800 (PST)
X-Received: by 2002:a05:6a20:748e:b0:3fb:4a1e:2f82 with SMTP id
 adf61e73a8af0-4014ce58b6emr21264768637.61.1795699916655; Thu, 26 Nov 2026
 05:31:56 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <confirmed-20261105-18-6a8421e1b241@gmail.com>
In-Reply-To: <confirmed-20261105-18-6a8421e1b241@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 14:31:45 +0100
X-Gm-Features: Aa3M54ozD6ck_D13iF_4G2ldlHlAUxaHQPOAD28BUKrT-8-JuoTdL0auTG-EAf4
Message-ID: <CAPx+jO_btJdPP7Z-S-VCkM4hes33QKEJzjw-p7OhTcGRXirtTA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: gpcv2: Take a reference to each PGC node
To: Yige Jiang <yigejiang86@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: whN7b9gy09713LNKgSpxP53z1YsOmtdM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfX8shVmRWouvw9
 gpvUAIb1vXGVPLRcB3rJo4MIF+XlCTJjeBOt0Tml/NOhY7AS4czNtKXI0L27hRcpve59bjNFWy1
 1vuXbgIr3TWDSgqImyo0o2r/Dfmrax8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfX4wE38A630d+H
 ly2Lsgw9hBQ0TgAypquQsvPtgxc1LkZJv+QFSm986XyValZwbLiImuAkioDpjjOiyKtizdKkHaG
 IML5E5SN8qqh+RZcdkhzZ5rT78uVEN0uKFiF8ykoBGxYWp0I2Uu2yFIzS2iuhj62fNf4B4YJMxR
 PgKGmV48e28MTWGnhgcycAxqZcO2Y+jWuemaFIUZsAMIr/qCGo6ZcnGMQulYJ9NoucGRB7VabfF
 vfG4POD/PWTm99vU5TeKXhWMBrFCGeD4slDH/eLkPDfOCGqNjkGq97n0UellG18LeqZoUs2g5Sd
 Mwhb9+RCbAJdvhRkskAqGUjT0isXNS1xsVWPnBosuc3YItrQJhZU6hDcXyyeZKn/fcbXyPMiDxr
 6UlIeFCmyEDk7Wb3X28yDp93vhKwaOehnO3zH5oYS6QjmCRm+qPeSOles0bnmKAWL9iga8fumuG
 83BpczxXqln7uSBZXRA==
X-Proofpoint-ORIG-GUID: whN7b9gy09713LNKgSpxP53z1YsOmtdM
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b0834cd cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=zyzk0L4BWZHpzulOrW0A:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260052

On Mon, Nov 23, 2026 at 6:19=E2=80=AFPM Yige Jiang <yigejiang86@gmail.com> =
wrote:
>
> The child-node iterator owns the reference to each PGC node, but
> imx_gpcv2_probe() assigns the node to a newly allocated platform device
> without taking another reference. If platform_device_add() fails,
> platform_device_put() releases the node through platform_device_release()=
,
> and the iterator then drops the same reference again.
>
> Use platform_device_set_of_node() to give the child device its own node
> reference, paired with the put in platform_device_release().
>
> Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260530004541.E04701F00898@smtp.kernel=
.org/
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> AI assistance was used for analysis and patch preparation.
>
> Based on next-20261104 (8b7179210b22).
> Compile-tested: arm64, GCC 14.2.0, W=3D1, drivers/pmdomain/imx/gpcv2.o;
> baseline and patched objects built with no warnings.
> Static source review; no hardware, boot, or KASAN test was performed.
>
>  drivers/pmdomain/imx/gpcv2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index 6a54ee734514645db7e0628bdddcf579d1f0d904..7b377bf0196491298e9e772b9=
7d15a2bda9ff83a 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -1513,7 +1513,7 @@ static int imx_gpcv2_probe(struct platform_device *=
pdev)
>                 domain->genpd.power_off =3D imx_pgc_power_down;
>
>                 pd_pdev->dev.parent =3D dev;
> -               device_set_node(&pd_pdev->dev, of_fwnode_handle(np));
> +               platform_device_set_of_node(pd_pdev, np);
>
>                 ret =3D platform_device_add(pd_pdev);
>                 if (ret) {
>
> base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
