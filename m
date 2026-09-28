Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390954DAFA5
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613373; cv=none; b=s4wJbWJHPDpfhhvSahMUK5YQrJ8DM6YJcBcynraAxEbM+ucc57CwsM9KlcPz01C11egBHVYycclCHMdL1bwOmfmFXy+xKbzYxDr+VuILFCXC1Q9G//x+UYV6gZxmgiOonjVcS1YYzKihHsFZKz7olDuoPNHra9JABiVZxM4VqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613373; c=relaxed/simple;
	bh=5Bse2fT5PEeE2ZVpJ9CgSCLiMtm00Fz6FKnsCeX9VNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qp7I7Kfzyehs+itoV/79/BY0aeR2GPQhBM1VgHMVWsuhXUKTuCHcyLmnXKgL48MkuQKuXWgP4YbskkXqLvm4BBgRXzwklBm89Aefn7Zk6I7Qn5b1PnkBZqRYW5Biaoz0bhqVCud5aKCOHMK+P60gh0bzxfPErcWcksFY39henkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hm5TY4rB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BIngxMCT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hm5TY4rB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BIngxMCT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEe3se2298461
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 16:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QS4Zvm2fMkFT1Xejfavg+2iFbRFKudzStoeESSaSE9s=; b=hm5TY4rBy7OOkpHS
	YiUMri0VUXQm0o3osNeLtGi1qQnFIp1M3P5tpcF5VHprtrNUp7DPEqasQ9xahX2c
	9lxat1WEACx5ST4JU6IVAi9P/xQxmbRyjZ+9Tm/nTaVoKpQq5A+NqswPBZsNqAjS
	Z1pfwYgAhDs4VrqZmB2zhD0rtkcB+XuB3hDK+vwkfH05SlKOgZSjmEn0mJieVkG+
	SXENZYROjvp3d6Supu9lbD6cf/6hVPlIFJPUoaSDLLWIAFHqTVjt5x9uj5aXWA/1
	6JMKypsKT+zUio6n0uMyFvsAac6iM+snaGQ/0tgmtzFOM8Q8DbwjbW/DYbPy63VC
	/+6iSQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynb6hsfm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 16:36:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936708f129aso642698285a.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790613370; x=1791218170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QS4Zvm2fMkFT1Xejfavg+2iFbRFKudzStoeESSaSE9s=;
        b=BIngxMCTmAzAnuYMMhHcDXSBrbF6SQkmjmVfbjvGHA0aGvWKzU+l2sUSk08bnNbxzE
         wOdXU3F4lh2PeW0I+IQiVkwzXjyl6NuH2+yX2WAAzj3Qpm5eWQvrd5VtyRBuYTB8RkUo
         psgJKJ7TrftzXFynvxchUPN4mWk29nfsmancCt6T2XSKWuNwsZGoP2bKlGBBi+24KSkm
         W4LBSZouGz0lmpXsSklOnlmgKXubjV5XRvd4DOTNCXMBaSyrg9RQvORRbmK/tg9L0Qk5
         zvf4uIRrJbS0KTktxEHKwSxrYctjfoOFKhs9WCh6bBRt02o9my7xj3Z1Mx3dZWTc/sha
         wc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613370; x=1791218170;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QS4Zvm2fMkFT1Xejfavg+2iFbRFKudzStoeESSaSE9s=;
        b=Qhxru47T7C7flG5Z/JWTzxG5MZ6nWZLf/dZhZFkW29jwF29JXPGZ0fBwo4tNsxgd8r
         dWbaCvEPO9h4ZlwxWLfa0QtbUuQvMa7lbG66jBsw6kt85UAj4yZLdF6t1NLNPLXO9Pw7
         tO6QLT+BLGR1XEX1wN10PwMkGz9VoTuEgVKk5yDvkbwWUSPxjo/szBdjyfh4JSp3VUyA
         hv7Im+8ZVSClkJ0yK50uFpnuKAWG4AX5PGucuzhHRxw1JDhLu6XW8D2LmKya4gTYKLbU
         5+GF2EgxTDv/fPWlTLhZrzAeaJ3x4pEhjRHkjKSCfPtmas3nFV2YHAN3EX/g4b+6kfy3
         33kw==
X-Forwarded-Encrypted: i=1; AKwUvBy3bY+FG9yc3eXmTePlTPkh2QxJuFOm7E3KN9TOrhYOYB7RGqgEbzmvOH4D7iQdUSFjQTHwyjV8TQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kdPEjqehHWvWyvufAyTCJt+auiyMXGkwaeFNGz+qRe5GpYmy6a
	trNNhOLJkpVXD7JZ3IEq4CVnMllxrtUoom6P/c/k6es++DHD7uZU3jl2z74iYMY2wCMmqGZ0BfT
	BlMBeL/+SNjy0H2s+cKViAaUjVbmgnUYs1IJov5qOb0L0YNcETW4PLWuQF6GULQ==
X-Gm-Gg: AYBFou1FzH2bzCz9oSxHflUO6V9T2gH69ZaFPH/f2VNRmRoLZmxYDRBPy+KAz3rjXOi
	fWdiUNPfa9BSHuWZ0k+JArZEzLhjJ57iFxI2HTAhxxG2bRkfPvL234b5wOb4xomdV+02OPJ+jX6
	8n/GOxQq2kSeNOcMCb0eAUbwHSHZkY25+ZM0ymX7Mc/mEMb879oUH8dlzmwzEOcMb6+58Q/z/pK
	4ye3zYU4ex8sLbWVoFLyZzkX7g62aa9QTOVoA/Kp4Ujlpk4pD61zauOYYEXFIbXCc4QyrE84G4u
	tJxdZ/z/MYU18jEDKukJ5xd++Yt11l5YN6NlD8NOvP4w7xbPKoSJuES+IIlVRof0gwZ1C6n3Z52
	GqjHE141F+QxhjoluWg==
X-Received: by 2002:a05:620a:4625:b0:93c:6ac4:1dde with SMTP id af79cd13be357-93c6ac41f66mr1062099285a.54.1790613369534;
        Mon, 28 Sep 2026 09:36:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4625:b0:93c:6ac4:1dde with SMTP id af79cd13be357-93c6ac41f66mr1062091585a.54.1790613368885;
        Mon, 28 Sep 2026 09:36:08 -0700 (PDT)
Received: from [192.168.10.46] ([37.167.7.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfec770sm3568945e9.8.2026.09.28.09.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 09:36:07 -0700 (PDT)
Message-ID: <e2c60ddc-b28f-4e49-9d52-590f14f374b5@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:36:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] thermal: rzg3e: Propagate reset assertion failure
 from suspend
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
        John Madieu <john.madieu.xa@bp.renesas.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260828092123.9707-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260828092123.9707-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfX5Z5KaW/vqyAl
 f7I8KQOL3eM6ibprJ+YNNcegArn8KRmZvltEXPvzhSGslK/fGes4jIVf9We/wH8VCHxHqCpJdAL
 iUMmqZN0C2lMz56rF3V3FKG1R0Z/Bt0+ZByixloLEmI4irVvHLsUisxUkSStLmIzJq/gEJQ6RvJ
 ROnfYksGafRk+Cxs8UBvSPE5JxArjuOSJ07rRL5uvtTpMHQwpgeZcI3nYD7XiZQZmxk53VVXpYf
 ZkFyxvreAZ2eGxKwEbB1ndlyi56U9lNQAsaQ1r/X74uik4MlJD8ibwjp3zXjIJxmgaeP9hXNejF
 slP8W/azEg8AeSOGXkv0QG6wklTiBXmmsJ53Xw2P7TZwjKzbfm1YVVs4xW43KOwZ80zE7C6eKpm
 GGF8r049AC2JaxaV05pa+l37JSd3SCF713yGN4Kae4/Av4AglYoF3XMMN+HlP3CPmGK3/Kom0XU
 DoA5aSmOeaEqbvInnNw==
X-Authority-Analysis: v=2.4 cv=K+e3jCWI c=1 sm=1 tr=0 ts=6aba977a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=K71sKCzDSiMJbZmyObbiAA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=6_r1RUB3d7dz1aBDPoQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfX5uzB9smZTsoy
 PfV5OxbGkHFO81pdquA5e0bDNktMl5U+ouSv3m0X10czn9Ko226fp7Bg9lSQBy0FuMFggkKNHPx
 4TqRZJiRtQL41YPAZEgmg5+lSPOVKdM=
X-Proofpoint-ORIG-GUID: v5qjHfrm5nfHA7TB1ZqQAb_LP2FZSeYF
X-Proofpoint-GUID: v5qjHfrm5nfHA7TB1ZqQAb_LP2FZSeYF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280066

On 8/28/26 11:21, Pengpeng Hou wrote:
> rzg3e_thermal_suspend() powers off an active sensor and then ignores
> failure to assert its reset.  System sleep can therefore continue
> without the clean reset state expected by resume.
> 
> Return the reset error and, when the sensor had been active, try to
> restore power before failing suspend.  This remains an RFC because a
> reset assertion failure can represent partial hardware state and the
> preferred recovery policy needs platform confirmation.
> 
> The issue was identified via static analysis and manually reviewed.
> 
> Assisted-by: LLM
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/thermal/renesas/rzg3e_thermal.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
> index c44f5b8858d0..7686a45341b3 100644
> --- a/drivers/thermal/renesas/rzg3e_thermal.c
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -499,15 +499,19 @@ static int rzg3e_thermal_runtime_resume(struct device *dev)
>   static int rzg3e_thermal_suspend(struct device *dev)
>   {
>   	struct rzg3e_thermal_priv *priv = dev_get_drvdata(dev);
> +	bool active = pm_runtime_active(dev);
> +	int ret;
>   
>   	/* If device is active, power it off */
> -	if (pm_runtime_active(dev))
> +	if (active)
>   		rzg3e_thermal_power_off(priv);
>   
>   	/* Assert reset to ensure clean state after resume */
> -	reset_control_assert(priv->rstc);
> +	ret = reset_control_assert(priv->rstc);
> +	if (ret && active)
> +		rzg3e_thermal_power_on(priv);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int rzg3e_thermal_resume(struct device *dev)

Sounds reasonable

John ?
