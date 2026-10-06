Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF8B457E53
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292751; cv=none; b=suZ0WtVjaY4boGJDort4A/ApMTv+dcS9+43hHi8/WnG98+SG5piWdIy/PW5902Cixw74O/cGVVEq3yrGEHtdsm6WyQo9T+GEQln4e3gJMBDJhue0tWrsTEM7WHJqLHyu2z75acmB6deFfQlatT7FsKNA5QbdjhnelJoomemTedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292751; c=relaxed/simple;
	bh=eszSZMOJpj74kh0VdtVM25yFcD4ep3fqH84k7hrgH0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzS7kr48vSPaO7WgjMiqAQRD2H1fdgj+meKlUojfPRtEvHzctThL8VpUtnYtRnHbzZJgI1mhrjC4iMv/g63dp1Xaty2VfYJGgz81WpSLE6G3wlyzosPQsuzFpgUWY3DRSr1JCSB+7+21IAfuWEkyFzfpkCH7WGzYNeiXiHn2pUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=djpO39YQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OquInDAz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="djpO39YQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OquInDAz"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPOqA088449
	for <linux-pm@vger.kernel.org>; Tue, 6 Oct 2026 13:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3977fqgFQopqrOyetisycUnU
	JNoVrBq+V4kqibqFyZQ=; b=djpO39YQ55MRcLvTrU8FokAtAmc25B8PO6rhSyDs
	RJU4RGI6ZtKkLJ8bTvW2KxxuFZFTSiujmfX1/X85RxYrkbuMuL1CgeaZnPL9i4qF
	54XN73PDYKUfTJzZ1A3S386RM5q3T2Sh5TRNp1ckEIAV07+4eJaoO/nPw/BG83Fi
	Hq3N/Fcw6MgPuaQSCfzrNrI8fBoqq5IpYeht+/An7rgZhb+bGiAgShgYGyFrIdpk
	s+cxaQhxcHjn0+TsjzuOfzlXjRy53E4l9GFJ8lea3j5Vdc77CMbIMIuVau5+QeXb
	siQygViHTHY1l1TttPP8fjQWhuqepsqUcAca25vW3utrNg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xf7rruc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 13:19:09 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7bf71bbf197so2559660137.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791292748; x=1791897548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3977fqgFQopqrOyetisycUnUJNoVrBq+V4kqibqFyZQ=;
        b=OquInDAzKHPBlexKLw5dAfzB0MyjUhrgX66xMm2UkWAwUZ2xReEAxfiPp/yvk+ybUL
         Mf7cHwXFFg4HjqD8wibuLz7jX1b6mp0lmjgc90KsSx/ehABx1xjoA92jqIU8F5f+wy4p
         MX2xsDtuOhU+rdwMeRRwdGpxAvRQf/Q6T5H+KGPC9NCuIwkSvFZJ4SDc9anVa34jel6S
         Y7kZX5SfIE2opA/jSRCjmio0Z6YcAwnCrhKlsssgaOV5iPjeWWDc+K4Hsc8IBCILBYT4
         P9bkU0yeflx3FmdhH7LqXyObYt9TSfZPHUIJrs2pVe8YO6tlnO80L7a7aElYDrN9PJDS
         1+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791292748; x=1791897548;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3977fqgFQopqrOyetisycUnUJNoVrBq+V4kqibqFyZQ=;
        b=CstcIALP33+F346CxPwvNFDK86QYr9Q1rvJUOv2Nuyyvfjx0Dz5kbhDHu+oqrcJrqr
         nWGLHkTF5I2ZGg6qdgBfkCJEV/IpsR5tWC+qBmDaH/1g+S0s2dhqklY4vNXfA3m0qdTz
         o84htZgWwVJPsVvXRxU3hWk6o21H5Zk3leSfUOzhkxvaptnPO33tKJQfLLelBLoMYrhT
         tTcNG8RMXQF9VZFu+59PFYUT3JyLYn0vmOJPWrYeSX046rqOrsZGsgjDiVk3cOgruzYY
         nJJ8ul7NkBt4kjFxK+qHRxey0/wZveuqcw/qFu9TN4KXDsNAc6n1pEhz1SDEwHZYyZ5y
         GAtw==
X-Forwarded-Encrypted: i=1; AKwUvBz1zhwRKJFoIOzOuW2BZL9SBHMHOJl3AGq/f5Vn1ahlMvyjgmnmpI3RBenaAUbZQih4uhTibhNuxg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLpP4RihShYdK5IFvXOaAOWXV1LzrmGfNturMKLzrbRfl1PAiSd
	XDJEskD6gC1ceXg5uyAmdSyvL2sBvC1ue+W1IFAERMDYO3bgyamBGV6P6oej5rZwRJhp72APqVz
	gdOZi26qKvESKk5bR61VasaLB9GRR6qDsCAfndDsigNPpmgAZ35sAxu+EsURC1w==
X-Gm-Gg: AYBFou2t12mRem7/mRbAAEn/XiioIttLGrZDoaR1sg+xz8WSFh/hNB8G69Tqxff0q05
	WUZX1UfgYaaUluJnw5uI3Z+5AziM8rlYv5LztomZy1v4tQt3KpcZ7Dp4SL6+oHkm6veGG7QuhD4
	4NNFCbjnXmqHUJhqeWIpW8mUVR+hjqWQ9jsklU//FzyV0vFt3obMdnlx4R7WS0vDVVlkco72jsM
	UYjK5tJ6IMSpgcniBJv/D8ta4d3jak6mJK5mVwVwyVQS5NF4jDmCD0cgfdwPU34lNQzW/gL5u8z
	M5+U5IFxB53QyaGxFaHPwzCWeQtavvSLMp64tBv0RJ0a4u0oDzJugvwC1z1tseiOHf4nOwSH3vB
	JyWxu5yQDAA4wFjLMGED/BFnWKeEomUdmnKe5r3bQLXuz3xL1BVk/66c4Dq+cv+bPGsKl1pwvH/
	PBd5WjTl0+8a7G
X-Received: by 2002:a05:6102:b15:b0:7a7:198a:c2bd with SMTP id ada2fe7eead31-7c87c9235c2mr384674137.37.1791292748040;
        Tue, 06 Oct 2026 06:19:08 -0700 (PDT)
X-Received: by 2002:a05:6102:b15:b0:7a7:198a:c2bd with SMTP id ada2fe7eead31-7c87c9235c2mr384647137.37.1791292747447;
        Tue, 06 Oct 2026 06:19:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a99ea94684sm885231fa.26.2026.10.06.06.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:19:06 -0700 (PDT)
Date: Tue, 6 Oct 2026 16:19:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: muzafferkadir@mainlining.org
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 4/7] thermal: qcom: tsens: Add support for MSM8952
 tsens
Message-ID: <suzsbvsdlfrfsnvaerphqdycaaaiu5inh5uw5wups4jmfozkbt@n4lsb5pfdhbw>
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
 <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX/gJVG5iGK4On
 UFAevi2NKRQnSSjPuZPwJ5k2+w1uq5yLphqwq7yE+AvEHuWuNFlEYN+sSdNv+Jk7v9NXiIVTuQ6
 0wc/ndUeaYCXaC60xavVxO6AVm4/whY=
X-Authority-Analysis: v=2.4 cv=FpSQbGrq c=1 sm=1 tr=0 ts=6ac4f54d cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=Oh2cFVv5AAAA:8
 a=OuZLqq7tAAAA:8 a=Nmgb9aOmcCZNRWd-E-8A:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=7KeoIwV6GZqOttXkcoxL:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX+IDhgBDmNeOo
 bCU1qhk94e0v4hvzc7quZypzig9MPx2NuyKBJzxhsvQIgUqkxvVhIg65iKF9a8h579C9hnzitMb
 ZcPcrTbIhX6L1en1bTFHBP+k4mdRFme7IU9sXXwQ/v+a1Oaqj8kwdxIh9QqbdpFREb3EG/lmDtd
 bmxamtI3kvGqN7039zvFnlOgrKJCRrNs+QsCCPi025ZxIL7ei4Fs3AwfZ185ocdXzYHB4u1ck6c
 a0xPoWdv8Ec29EjQAxkZIoBaeyIONfpr2dkJ56eGbcS5bDCimEkmmZqoT0A89xOImYIsAhl8qv5
 fMQX4DwHh8QrWgjxUotad3vyImPrIPIPR+vzkWXGowrMYRHamdtBIxhio59/okm4kik56ZVuCoh
 6et6lBrXJMJtH1nLz9bGZQTvQGd08E/0bWRbQDFXgSChjSX1l142ofQ+Ns63KB2lrIwUv5eEYyQ
 t0Rjz5Y5H+DOB9mQsEw==
X-Proofpoint-ORIG-GUID: Rn5b2I1dtbJWnF6v7JkTXYBC_WoFhvtz
X-Proofpoint-GUID: Rn5b2I1dtbJWnF6v7JkTXYBC_WoFhvtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060052

On Tue, Oct 06, 2026 at 03:15:11PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add support for tsens v1 block that exists on MSM8952
> with 11 tsens sensors. Sensor Offsets and slope values
> are taken from downstream.
> 
> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  drivers/thermal/qcom/tsens-v1.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    |  3 +++
>  drivers/thermal/qcom/tsens.h    |  2 +-
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index faa5d00788ca..f4201748ea29 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
>  
> +static int __init init_8952(struct tsens_priv *priv)
> +{
> +	for (int i = 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope = 3200;

Where are these values coming from? The driver that you pointed out
reads them from the QFPROM (like other tsens platforms do).

> +
> +	priv->sensor[0].p1_calib_offset = 2;
> +	priv->sensor[0].p2_calib_offset = -1;

-- 
With best wishes
Dmitry
