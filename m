Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA693DF01F
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217804; cv=none; b=IS3HyPh7rbOIjbgpk2mE8SoYdPhhgSxGj6vrGRRtjZrlF0bQLAaBgshqsDJTegNPyj45jFLAvwnpmHe8JbbYSNjI0QddGni1HztyUgRmXOSy22OjCSI7cyyW52rdMRrUXlGWkY7i/7l6wyNUXaTncYdeu4pcxG6LU4regTcC2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217804; c=relaxed/simple;
	bh=eWXjDm/rNRBZghDqHn6cqTEJsRLefjaNGwagAb1uQXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPbz5BU1EEvMySEUSW0v1prcP4qZnQjD3SXSRGGRM7tI0BF9w09gICokPRKcX08J5Xq4CWY8w/pv1MCsMmtohv66fQRIbghCdLMvv8KkUYyGa6vJuraK8vG95eMZQ34XODzGa8KkaYYA9VAaI+JMW5aFBAaEIXO6pc1cgnQNkN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTQq2QvM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aKp4aleV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTQq2QvM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aKp4aleV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6nOZ73732945
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 09:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K+pxcnC7LlOtfUPE7WuTxX2VzzLJtGCT7IRYPoYVTdU=; b=jTQq2QvMSp0y/uZN
	xox1lfpNY6g4oK03nKR3XiaprcFddensAQirhiFcrHptE6B59srTccg81Ye0Kkec
	7UAemEp+19KkAnoWW6EAu/kewplyAfz7UHdb6m8IMnlVoOSVXUKaqBICyDwbdRWz
	1aIdWiBU1syOy8qIo4Y6lnfddKhhJKnicaxMDJhkORoX7c0OgPVLMfWtpDScbWBW
	uIqllcZRvDbzqIh6UQvdzPaepsmziToG77R7CPxQWf7KoqG++h02gGValP+yT9vZ
	1RPdfumxjSTtqHwvjj6FTqady8l+08Bq+gFceuYigW+81EpA3ytx6xHBe4rmEteQ
	Zw1iUA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vn88hx7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 09:23:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8488ac68185so3776609b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787217800; x=1787822600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+pxcnC7LlOtfUPE7WuTxX2VzzLJtGCT7IRYPoYVTdU=;
        b=aKp4aleVVc7/K6fjBd5U5hBIPsk94yhLm0SxJjhMY5hEI8RBYhuIJGAZC6XZKNIMrT
         N+QD6aI5vjB6/ezLs+WpJLpVsGdCNNoywZSBWzx5dMCY74Io15Sg3I2D+5b5VyAZKN/k
         bZBmK3V71XNSbkrq+QoV417Dw0y6ka7B5v7z/A7jFhgV16cVs1K1C1atKjuaFNJdFlUY
         vR9WWSBoL+IBloEwrz2bHGZbn7Q8XrHHTKT3GD9aynXM5F4Mb+hD28jtVTrffGdVh81M
         ustDko27Un9mMpmLde2phm8KQSmmrlCmYHUb7GEq1RbuStgZTfWZxwdahiVqteMp6YGg
         aiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217800; x=1787822600;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+pxcnC7LlOtfUPE7WuTxX2VzzLJtGCT7IRYPoYVTdU=;
        b=S4rbbGMZh84MxGn+BYkDbCLDlJx9oUzrr4AWMF31K2mebkAIPbxt6OL45Wz/6vovLU
         tqDm9xTc9O+r327YzRQt4qdnm9dPt1R5s+hcdFryxNgAzGf22VHxoDAFIF99Gze0Ivp3
         YSEVwHImykf/4+AYF6tw2HXih14+Cxi8kltGDJ21ieojUKZH6quBuEpMd30Dqk+J8SV3
         xkQYdq/Go5T27AQj4yhB3DQP4BwegX9hc2IWP8vCq8D4O1OIeslD/UtKqLNYux27B/CF
         X3lBvsFNKf6YcVwH4R4H5Leq5//Naxx5dh3DylFV4GiZzOtvLe3x+nn1tS3mJKedZlF9
         Gmlw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9gzWAbyb8VMK5/mm0M9RdPfI9uXVF0YrHYue67WhuUtdHTvLkpgs8NvzGI62FJdjLVO9DRamt1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0ZknDrPXbtLkK0iit3Iuk4MIeOiZHFEplXh0pm5PN0BHmolF
	GYiIYqMR/MjWkV36BAO16YiKfy2ay8TLxhL7kLnqfnN4YR688p96qmm2IlkO9/CGS0zCCyvVP0Z
	a2p7I7fbmsPHif55Cip7AjvMmZh09ZTJa+7tFeB++G3gTbz+7dHzSfSTuGW5kS8Bd0EZaeg==
X-Gm-Gg: AR+sD10AOcl2WpUZEkZopdCYrNxncOh5rKn/dTdgvGVLgB9uaVxBKKrg+s8OscbbOI2
	U8ozukPG2+G5+kvR8J+m6JncGtvjYb27kGZLQHRA29tOez8K6bmLO6H/7rsey/fBp+3RNXWA4VL
	TuaiKjNdiPYdpVlwuLRM69tLsAJlvD225R24G0USAzH7m33vHiNQ+IcnmaHigCSdj0Zv4mxQTP+
	hckhSlTJbG7qaod3tRL3nVzR0ewU+7tG/Ylel5TRmvFCjdTrWJPYOurkxI48zsfdUEucJ/6Chvj
	PIHatKB2S8OF0Ajz8iWvUdpceIxmThZ21rgCjoNIVeqqQrH80qc6vtbaT35dW1B6keKyExx/FRP
	VC3xF6zYHcpxNhjCJ0LFdXpgt35ejori8gttwS39ZWOWOuLjppaByLqR0E/yPKM2WQnBSMc4l
X-Received: by 2002:a05:6a21:48c:b0:3bf:7081:9356 with SMTP id adf61e73a8af0-3cd0126b6cfmr21929945637.17.1787217800531;
        Thu, 20 Aug 2026 02:23:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:48c:b0:3bf:7081:9356 with SMTP id adf61e73a8af0-3cd0126b6cfmr21929856637.17.1787217800100;
        Thu, 20 Aug 2026 02:23:20 -0700 (PDT)
Received: from [10.133.33.222] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15523b579sm1611537a12.3.2026.08.20.02.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:23:19 -0700 (PDT)
Message-ID: <0b8371b8-408c-48a3-a41f-2e2f1079d315@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 17:23:14 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] cpufreq: loongson3: Make this drvier depend on
 MACH_LOONGSON64
To: Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-2-chenhuacai@loongson.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260818123921.3600606-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA2OCBTYWx0ZWRfX43eSMTc5x8G1
 xOkc7O0Afx92/LWpk4HFQTpygZN2/5dprnk4niRZk/zeimb1oDyiiDijTOqPSSa7pm2LHEns6Em
 ZLb6BXfZjdA2x5587ARNp4GbXb9gMt3EjLfvFw2Pm1NHR47vaEICrtDRDtJsB7TvlFnjhjgA/IV
 bAp+WlUC9eD2czZMA19FMfDWLyJaaum94iCdpcxa6s3cWz+dvvJjdAvkNeyp52xCeSODyVxxduJ
 /U/9LaITUri9BGKt67Xcx9QU3ytlUKmpr+qLSmCtYBpZR0SbShigNRt99qovJXJMKFvgX+WJfHP
 nxxfjhuMxhqaffoy4W9U2bprInINKA5ncRFrH7YzJZ/S8AAhs506ZkWrg2egzAyDtQIZJOWXett
 pWUlD8r035M7iX5FPKRA1iB9y7ul1lTfAkGi4KNa+YrO2QLC3AqG+ihQxiK20hjKGxUUPGqu11m
 9JNZJu2LoG2mshF+6+Q==
X-Authority-Analysis: v=2.4 cv=KpJ9H2WN c=1 sm=1 tr=0 ts=6a86c789 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=FBMUh9G_Qb7lsv0hvtoA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA2OCBTYWx0ZWRfX2eD4JrR3RbfV
 CJJYWjGaTODwsVZTlM2vraR1TucAv714u/4Zln+i105Cn7Ku9+M0q4CFU2uRlHrL2LB+Jvk9Twz
 8m1WcUkpldJ9AbTopiUQWhv9L+L8cWA=
X-Proofpoint-ORIG-GUID: _s1dy1mJz1tNAiT-8NJPZlBe1cBMgI4Q
X-Proofpoint-GUID: _s1dy1mJz1tNAiT-8NJPZlBe1cBMgI4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200068

Hello Huacai,
Just share a few inline comments/questions below:

On 8/18/2026 8:39 PM, Huacai Chen wrote:
> 32BIT Loongson machines don't have SMC and FreqCtrl registers, so make
> this drvier depend on MACH_LOONGSON64.

Typo --> driver? Likewise the subject.

> 
> Cc: stable@vger.kernel.org

Nit, it is better to add fixes tag?  For example:

ccf51454145b ("cpufreq: Add Loongson-3 CPUFreq driver support")

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/cpufreq/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index db83f3365698..edc1299098d4 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -288,6 +288,7 @@ endif
>   if LOONGARCH
>   config LOONGSON3_CPUFREQ
>   	tristate "Loongson3 CPUFreq Driver"
> +	depends on MACH_LOONGSON64

Small nit:

Please feel free to correct me.

There are two MACH_LOONGSON64 symbols in the tree:
   arch/loongarch/Kconfig: config MACH_LOONGSON64
                                  def_bool 64BIT

   arch/mips/Kconfig:      config MACH_LOONGSON64
                                  bool "Loongson 64-bit family of
                                  machines"
                                  select ...

The one that actually applies here is the LoongArch one, i.e. this is
really just "depends on 64BIT".  Since drivers/cpufreq/Kconfig is a
shared file that also contains an "if MIPS" block, please at least
is it better to mention it in the changelog which MACH_LOONGSON64 is
using, because the LoongArch one has no prompt and is therefore
invisible in menuconfig. Or just write "depends on 64BIT"?


>   	help
>   	  This option adds a CPUFreq driver for Loongson processors which
>   	  support software configurable cpu frequency.


-- 
Thx and BRs,
Zhongqiu Han
