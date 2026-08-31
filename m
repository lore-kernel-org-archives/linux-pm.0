Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5CC3F39EF
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178413; cv=none; b=BoHt08VZe/xwv1wO9bM3IO007AaUVXd+kunz58Lotb0/MdkbMO0eTlrxlWUkwMUbaLDZslW9Ka2riI0aYFW4qs8qhNF2vOpX1SkhJbXcPno1AsuHp97Ab5tIKOlN6FY4tqnoslNwJFVnE0ra9XZzQqYXJY2ZAZ7S0iI/aJiAod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178413; c=relaxed/simple;
	bh=W7oVC5G0884AZPyE65UiWJ1KXp3T+1x42mQd/RoFa0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOC5ajh+VoA50H4mhVexTIeZhrdcXxdDI0ElbeUhgctQHao09IGKJg0hNM1DE+TWLmSU7CwCEk0nEQ52UyJefXjNMPet44ihYhVPKNm+6758e2mXS+FsbfSujNr0mFSU4SqWSJkF5w1jJ+lDEPF7jA2gO93dHcHprtA6gJ/ETVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WcPTRl6j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Re6HFx2Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WcPTRl6j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Re6HFx2Q"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBAHqQ2891640
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 12:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3v7/7zOpatqMjIRSG2k+WttNKWDhQ8qN2/MptY1PKJU=; b=WcPTRl6jwocuyGJ7
	YaA67ViWoD/ILF4AjxDgcJwIKWUhojyCg/JFZRmo/swUQgPC8A7Uk+sa+5wsfyAz
	CLEbdq0CnzTJ05d0jNf+FaOOw1Qt/nQ5W/q1ZuBDiapTxnm+ckRVekZ/64POftu6
	bO657UEWDof97ef25YfESr2z3Aq9ZegSlBaKqEo4twh5CenzgoGdSbdQpMqJ/blA
	1IDCJ/jWScmeLQt4X8ABUQMLMBaPCvykkBiHmKOah00tOL2Fsu4GS5H7lrn7+PIA
	ldHs2qwJ9d3wKReqSB1Hc6IC0xeFCm5UDaMykSkfPNNVxBixOBhWx7djRc0sZYpW
	zF4vlw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd556s4m8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 12:13:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so6463443a91.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788178409; x=1788783209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3v7/7zOpatqMjIRSG2k+WttNKWDhQ8qN2/MptY1PKJU=;
        b=Re6HFx2QcrRhF+vKcw3W+P0HBrBTdc2Cx4bvWi1GSoQiCKy5cLoRUJs0wi9Kru9Gl/
         EUD4Z+Tq7iWW7urRLt6URapev//liqSkejArZjOKRvvx/g3TS3FbnHLw8/i2qJkGGfIa
         XBvsMGZzCqqNqAvk7qe4dvGeLeT1iWv3K9Fd4u7Kei5706qdyU+LtlTa12KxNk/YDAmI
         Xxf63oIycGoNpYrOqeABPk1o7OG+vOwvKmDWdpLBv8ZmLAxYK5Hrljc/R7zJHSCXrBpZ
         zROOMfQA6WltoE0CJDoiSjkmCj7WDCpxoF7nMSVF9SyWCWvedwYEznBYSCGMBFY3s3et
         1B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788178409; x=1788783209;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3v7/7zOpatqMjIRSG2k+WttNKWDhQ8qN2/MptY1PKJU=;
        b=TVDjcXDCluLfdtoe8uO72YM1Zh5S9elK3gxoaxqB0ynZfbTpf5BViqjBoR75/hwT7h
         c1wAu2zHoa+xRM5LO5mbqlyu+32PPpcPFS271w4gHu46zLTu9/X/m/88XepEjswXAYd+
         7hDdGtNtCTMDZAuA5vIbOioZA1S2n3cRM9fQ+tlCUhuKGxe/qRJW4e5Lesct/f4EwUU3
         Wr4ned174qSiRhi9S8bOuy9+i1GaymYXPEaJznkQJTOsj82KMus2etbm7DphTL5hRav5
         lkKZ3GKNifIjUgfbemxrM5qT4GdorW+fFbmPIiPoa2ZyiUaJueEPyJpRwsK2Gcvui33b
         QXlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQjPUn1clYu3Q4zglPOgMEPxh3Pl25C+cM4M8RHyPEVNvEnUQ43Hht4yGR9gGgDlUwHKJuWcoLZw==@vger.kernel.org
X-Gm-Message-State: AFuF++kC5h7llRjzVkqqVuHGa7sNgJnkL8F1g5n1gPjinr7UzHv34kz1
	qEOx31UpO7qyPeqNqGYr3inmLvGiLI6pWzd3LoU7Kk7T2VD8U8fs2m6IPU+4BEdFJR5THZRGvKg
	a7+7IZS0MOMMy6HlRfLOvFs/cryMxit6Ta8FuyTzLXIERzQ9hNdXSkHQifw3OmQ==
X-Gm-Gg: AYBFou2aaT5GJRLup6Lwu/3ab/AiN3uvVPFATS/I8cH0GFyP2lw1YN6DquNIx2w5Kvc
	+DE31cUN4MnBh0CzSpzbJJerVzZhpB0otlnIMe8Bf8Dk7MidusJc416IEqo4GnOSVnk+2+R2Mth
	N6wm8tIKntKrRqIdJ8kkWCnCz2LfziEGz51PzpQc+vwOQl6LnzHZyoR6XDP8lkdlwXCa1zAVRvv
	CFZMVRCd9nBKJ0TpW5xGXlRNvUkoexPGa94LdBWVE/U2flHXChKWYpkVk+/HYtxjOTqufhibQwR
	olUjUxsTcMfu1vXGBRWWgCYp7Q1/hl5qTAItzKbpcXpDYbsf1zyI24aXGTt3m5sp/0gGIRPLT9S
	hJziy49bG6cZjWdHe+LFYJFk8Zb+HjTrB1rsBjwL/NeVp6uM9SPHCKZ1WWvVxsRNYHdWCutw=
X-Received: by 2002:a17:90b:3f50:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-396d0df72e2mr39730116a91.7.1788178409281;
        Mon, 31 Aug 2026 05:13:29 -0700 (PDT)
X-Received: by 2002:a17:90b:3f50:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-396d0df72e2mr39729954a91.7.1788178408024;
        Mon, 31 Aug 2026 05:13:28 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d29b342dsm5638265a91.1.2026.08.31.05.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:13:27 -0700 (PDT)
Message-ID: <83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 20:13:23 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: initialize policy rwsem before sysfs publication
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, rafael@kernel.org
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
        stable@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260830155301.2713780-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260830155301.2713780-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwNSBTYWx0ZWRfXwOPitvk8DYXL
 9QJvUbxHazOhA5G/CHQOjGfr8uygHCFg/ue+E0aB0uKAbWywcg3B2AHmO5n6RZZoufsHMeRfxHZ
 6OQgTVkPLhF6kmvCCYBJQzFa9bPxI9Q=
X-Authority-Analysis: v=2.4 cv=O7sJeh9W c=1 sm=1 tr=0 ts=6a956fea cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=N2ojTfqJbajg-YQ71DoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: c6yCJZyCcy8QOiRF2tfkzE3M5l44gl5F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwNSBTYWx0ZWRfX5Okd/HfJNUz/
 MqWnywc3C6hFAKe7NGiPtPkJRoX82UrLHpyYVseKHmT0OB5LGPPnfOEnE0NjAxLh4Of0ox5Mtv1
 0alLHUp7QwHQ/OfSBCjZmBXDsoR3bKZdUnyS48A3p47SSpgjLLCXmiQRQZ73HP+aF25t4Ex3wW3
 KG6nljCJGm/oKbCDmweak0t+nZgd2ey14DOEFZ3IoR+HgYpEhsxPHJFWH9TNv4NcTDhFgVEI4y5
 KNPxThVETwPLHYPAfAtgdmSfIjMvfmPrwHSet6YQhQM/WhEeAafwqGBHP+c6EYwj83DK2u2dJCS
 OU9uPVda8wcKLx/Oi35ponqIwaQp50WgUPYk0kSGCr02nat20N0WJnw+2U6EvNj7XPkvr0AsW/I
 p72Jk1qIWTGsY/yQjsI8EuGyXsYcxm5J6xZu2rHlPDqgT/GVd4VN8jWgx8DZJbc7SILDmXmmp73
 oeiC3zeMzS38Uh8NPpQ==
X-Proofpoint-GUID: c6yCJZyCcy8QOiRF2tfkzE3M5l44gl5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310105

On 8/30/2026 11:53 PM, Runyu Xiao wrote:
> cpufreq_policy_alloc() initializes policy->rwsem after
> kobject_init_and_add() has created the policy sysfs directory and its
> default attributes. A sysfs access can therefore reach a policy callback
> before the semaphore has been initialized.
> 
> Initialize policy->rwsem before publishing the policy kobject so sysfs
> callbacks always see an initialized semaphore.
> 
> Fixes: ad7722dab729 ("cpufreq: create per policy rwsem instead of per CPU cpu_policy_rwsem")

The tag should be 2fc3384dc75b ("cpufreq: Initialize policy->kobj while
allocating policy").

> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   drivers/cpufreq/cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0d0df986f..9efbf5b17 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1258,6 +1258,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>   	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
>   		goto err_free_rcpumask;
>   
> +	init_rwsem(&policy->rwsem);
> +
>   	init_completion(&policy->kobj_unregister);
>   	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
>   				   cpufreq_global_kobject, "policy%u", cpu);
> @@ -1272,8 +1274,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>   		goto err_free_real_cpus;
>   	}
>   
> -	init_rwsem(&policy->rwsem);
> -
>   	freq_constraints_init(&policy->constraints);
>   
>   	policy->nb_min.notifier_call = cpufreq_notifier_min;


A separate issue: policy->cpus is allocated with alloc_cpumask_var() (no
__GFP_ZERO), so once the kobject is published policy_is_inactive() can
read a garbage mask and let show()/store() reach the attribute callbacks
on a half-initialized policy. I'll send a separate fix for this.


-- 
Thx and BRs,
Zhongqiu Han
