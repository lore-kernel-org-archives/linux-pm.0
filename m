Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3983AFAEF
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 04:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783310541; cv=none; b=Opczm1wU3kLqPQQrhlQ63CCASMAHmGCnAi1zDiGRjjSJkLg3ul3uVPPW05fzy+prx15XACcRjAtX57KAoTp1G94lBUKn/DQtaWFT13GnPTw8WXZz5XBgE3z8fDY6Es9ZxgUOSipQSiomvsNCYWuaUx9YO0q9NkmnxeHJ0unmssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783310541; c=relaxed/simple;
	bh=/zEYG/OBL95Gx+ohWenrEwBrbR/oRwYUWrQ9Ykaz6mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFnCd0rcVEEt/odFMf2gpyideEr77GIml5cfQLTsLiCYeM8MQXFhaNKupknK9+3kXAQSuhxIvP1NJLOCzd1ndoT6kAuwmPt+TQU0V2g55cVE3FMSfJPoHvAdRts7vCkYzF+wJhythrjqCP7H5JV0qxpKG36UJIIb0kH/9rg8354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l+8T7Kr/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dP1rIobj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l+8T7Kr/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dP1rIobj"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641jEj3624558
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 04:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xYD6MPNhjaepPf2j/e7u1phNicmKefuDIWGw2TPtec0=; b=l+8T7Kr/uK4TBVTU
	Pcq2uNQWgznHCUVF8Qmxsw67O2OAN+nsf6KRaiPXzLCONsxvRKUZ4vI+yl99aJrq
	tVpZERs5rRgBWlIROjEBXbuTDLMgxDOn7H8npFh/Ymse+K3bomTsmztmn5Rwk73j
	nkyY38gI8nAyl94Re7RikK+nYVm907iR3A8S+vxeBgIVmbRxLwnTWT3UVB9nurhA
	4P4qYnZntKBVE33u8YDID2KTUtFHPJuU2RCkYlyO330kFpDeq5ismBB1OysQ/ATg
	xEZe5gS8IrSeDF7jyPn64X5Lcbnp9BsHTlpCyvFaLYHAXYdIEBsBBSbK8Ggkm2Bl
	gsaPcA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4svbsx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 04:02:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c9d8549d55so20271885ad.0
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 21:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783310538; x=1783915338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xYD6MPNhjaepPf2j/e7u1phNicmKefuDIWGw2TPtec0=;
        b=dP1rIobjLPLaXRzdlfDJaOiK4aqfsoTY6unyX6hIiR4S3/phMBh8wPu+Rq2Hg9yy9l
         38pTTtHEV2VpndTv/6JQfnAQRnwLHvQS7rrwT5/MtB63hlqXMLIyFQBNNHvC1nxGbSNq
         fEBxNHgaiEW4xpcFtVywL913hP/DEVnuYP5khCILcn+nsolJ3+RvzLOG8RE9LPr2Wsrj
         HEpy5+m/pdi9IMsQSpRkXpQOobG6xToaNjokxnu9FUO/1hrEGx0ZtUFKEYAbiaquayC+
         9Ull9Ly5m4cX18Yava1EJa7V6fYVC1Xi5I87SMlM/OOqo/U9o5LANikJXrJPi2jrZzOH
         b9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783310538; x=1783915338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYD6MPNhjaepPf2j/e7u1phNicmKefuDIWGw2TPtec0=;
        b=noGtOZkOi8iP6PLgEk4sIJ+YBpcNBgCS3s2ZA58f90huIoxMLpymK1c1esa7FyfCSl
         eXbPCgFk300h1xsGYvBlW7WXX6QpyX6zmSWZ/A4VH1vIKHeimYz8/7uh+N+KJQcB00Mb
         +J9Y+r3NSBwj6YHAFBxIjd5qr5mV+kLYfNI27GMs6LpXcnEsCNSpOenMAyDyRLNteW5C
         YdbhKM56QaqJaG938Q1JgdoRk3unKY9jYf+9Vw9DJggNz7x9FwK0x+4/ybgaZtgCYI3E
         Bk+Cq9Jr/yMG6YW8n+PMtdygeoyG3m/QEfHqQQmbNaRkIOTEy0HWI7FuuqHEoAOy0I81
         toLA==
X-Forwarded-Encrypted: i=1; AHgh+RrE/dcOGzYucMBnOtJqmhqbjUVSAuYoEyDSzP3Gk13a3bodoM1M/rkfNTLv1/5N9q9zL8o/zIwrUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/14D5fksUskudrleJHHkCNg3MYIEWMEhH/ecZKd+2WlceYVJz
	rNSUR14yQ/h1qj8vFtOQDCfyjn74QMwOhLBWHaTG62PTUTyQIvnHfSVRfb7BO0lLVAjFSfQeYBv
	zReUxVNuAnfT2rs7f46KXckbWvxhJ5GuLFjAoTF6JFpCP9WWO64zk/Lf+QDnUmg==
X-Gm-Gg: AfdE7cl6VDKhj53rxxkCwB2g1kB+N29OncS3WvDoRQBXbPPIjT9qtypJIClneBiQ6Qr
	OZqyY7eigf4yjzuasKfyrPusYGYOAr29j4Qm+j15MlX8Qhxa8hBpDTtbOVSiXpi9q+2HMg2WvVX
	Ww9UMNmO1h2WdJoSwass9hlASFB8lELxjSFJ2Wsm661cL8OnVCM7EQwVg435yCwY8dIqdWek7bA
	uK8/hZf8HJ3Ts1AfQOGwZI2XK4eSdWV5O2i2tV0MvqAIgoTrXXmE2jFV7lXfhM4OYDV8X3kBv3p
	GIKPnjqT5MylerLLWeVpPWVc0gXAs/wMkk20LMnpRY4KmWcYnJZTWw47YPXuv6pmt0Cd63Ct5gZ
	6QPsHV29dWfDN/tp+kl0hMbXtt6uob6qJFlQ4rUnvf7GgFumzHRSu+04cyOEhNxcWXlwGY5mHiV
	fe3Q==
X-Received: by 2002:a17:902:e78b:b0:2cc:98b4:e7e2 with SMTP id d9443c01a7336-2cc98b4e9b8mr26412325ad.44.1783310538323;
        Sun, 05 Jul 2026 21:02:18 -0700 (PDT)
X-Received: by 2002:a17:902:e78b:b0:2cc:98b4:e7e2 with SMTP id d9443c01a7336-2cc98b4e9b8mr26412065ad.44.1783310537847;
        Sun, 05 Jul 2026 21:02:17 -0700 (PDT)
Received: from ?IPV6:240e:45b:7f94:5e4f:58a7:34e3:be58:6dcf? ([240e:45b:7f94:5e4f:58a7:34e3:be58:6dcf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7765773sm42121215ad.40.2026.07.05.21.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 21:02:17 -0700 (PDT)
Message-ID: <70ef1fd5-ec5f-40e2-b5fc-f8e1978bc87d@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 12:02:08 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: apple-soc: Calculate frequency as a 64-bit value
To: Sasha Finkelstein <k@chaosmail.tech>, Sven Peter <sven@kernel.org>,
        Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260703-cpufreq-64-v1-1-c406c705319a@chaosmail.tech>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260703-cpufreq-64-v1-1-c406c705319a@chaosmail.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDAzNiBTYWx0ZWRfX2lCG8iYDtf3H
 kJlkk7u2Ip5OLY74+oBiM35On63pHx2Tw5txF4GUXedz2Z3MWMMuHS5/2pH0ceZsJ+VoQN+qEuJ
 E/k3+jkfokUFVBnO5c9hKrM2hNYM1n0=
X-Proofpoint-ORIG-GUID: AxPEnrvjEJtS2Xt7NcQdeui0_gVXLJrc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDAzNiBTYWx0ZWRfX4vsX+8sQ/Xda
 PXJslnrEa1DL2bIy/nbY1Zbe+O2WfQDCrdM78pt6q4nMRBPpi7WccbEyMSXTX3fAWkeMpCuHDVL
 EfHmbctYIXmjjMjMRcVkn3Y59pvPa/LQUhSzkSaM2rWo1v0keOnL32nTji133P5Tc5uGtYkbco8
 10+oKHqZ6aAzPLxkmrl0m19SZSQ7AqDBlCDPnSJpJAlxyrJmZRm906hxWKKP9Xi7LokZnb/SEJR
 lstMqnfjhyfbMZX8w/Fp5eEmb+QQaV9ZLyTuPgz1WSfmoQiL2liO46o5psIgUdADcVOmu8zIQvh
 jxdewAfGCESDyOuUyU14V7skmSD5aLUyKkPtDOV1QUdHi29LjI8x/KthnWrSV5Q+AgVrw7rXuwK
 cC2c0dMNF5CWCeCt6PHEZyF7mb+J1FBq2QSwzWjEGsRrS06GB+uxphU7LqoCntmhBLa0H6MisIk
 Sj7x8a1bdtkgBW58/Lw==
X-Proofpoint-GUID: AxPEnrvjEJtS2Xt7NcQdeui0_gVXLJrc
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4b28cb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=xkNotnLeK6pRB5HCSP8A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060036

On 7/4/2026 2:52 AM, Sasha Finkelstein wrote:
> The current frequency calculation is done in 32 bit, causing problems
> if run on a future SoC that can boost higher than 4.2GHz.

Hi Sasha,

> 
> Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
> ---
>   drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> index 638e5bf72185..6a0f1d36578f 100644
> --- a/drivers/cpufreq/apple-soc-cpufreq.c
> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -288,7 +288,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
>   
>   	/* Get OPP levels (p-state indexes) and stash them in driver_data */
>   	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -		unsigned long rate = freq_table[i].frequency * 1000 + 999;
> +		unsigned long rate = freq_table[i].frequency * 1000UL + 999UL;

A couple of minor comments:

1. The `999UL` doesn't seem necessary, since the multiplication is
already carried out in `unsigned long` due to `1000UL`, and the
constant would be promoted automatically.

2. David's point about using `unsigned long` for frequencies is worth
considering. That said, the type here is effectively dictated by the
OPP API (`dev_pm_opp_find_freq_floor()` takes an `unsigned long *`),
and this driver already depends on 64BIT, so the proposed change seems
reasonable to me in practice.


>   		struct dev_pm_opp *opp = dev_pm_opp_find_freq_floor(cpu_dev, &rate);
>   
>   		if (IS_ERR(opp)) {
> 
> ---
> base-commit: 4a50a141f05a8d1737661b19ee22ff8455b94409
> change-id: 20260703-cpufreq-64-2a23d7261e09
> 
> Best regards,
> --
> Sasha Finkelstein <k@chaosmail.tech>
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
