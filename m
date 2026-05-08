Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184BE379989
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222833; cv=none; b=oGUtUAQzEypuJSUkqIusm4mG6qg2GMubB7XsyK24p9t4rmxVxNd/G9VZGXCgxEe6hMKHvteox4IiESFSwJaVDvS8XXnNagvcWMyPBfTv5wflNIc5jaSzRLhZ/DuakTbIL9zlcZLC0stDv+Paoia+fHMO7Lzb4c4DFMnLiTdZdaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222833; c=relaxed/simple;
	bh=qw3oZQK5F3aNCaZjcgdboq0+FguF5W83K4D+0fgvxE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2dyta0LpOXl6fIL+a/3IPlUGLQfy95E3yfpqtWOy9tMcUvOBV/fAZbTJkcG/vw+htRu6Sy3onOvTufHSN+XoeMa6y99GccZ5ynHoPkJc9dgmsQTxOaGsMAJzATvtluMN/zVrjQwbMqC0e7NJMhm2AGafskuSOLpXi3z7zuRN3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c8FJqp80; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NCwssyGK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c8FJqp80";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NCwssyGK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64842AcR1971617
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 06:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hgYa7VVGLVSTLTDj6wGtEsacvpNZkrN6GG3DxUuSAl0=; b=c8FJqp807XIfXAuK
	RLX0OBEOCn+NI4VPJX3DinifOkJG5cWFajT3oAIArU4FN0N62Hyadbvvmi8R3uzd
	FFMtRF22HFI6wfPdtlBg09xwMNdvt+httVgHQb/Z/jnIGBOTiBlP1LJtCOaM0LOG
	wEOvgilHgfgNwQDi3S2N/x5MTOidnnS517nnDzhbRxtJl2o37svzw1nj4N3u2JCz
	f6tpC6KOtuUh2Wv5Kx4j5+vCrjRJvXZjOxHBxBp5D+oVgL4Y2xd0Vmun0X1sNBBW
	tQhj8V45eDCtNEj/oocr1HUV2q2EK/oaSR+BcwcyN9+ksOaWxI/iLzmkIhJF8ii/
	+S65BA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tejbtjy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 06:47:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba5f794825so14519855ad.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778222824; x=1778827624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgYa7VVGLVSTLTDj6wGtEsacvpNZkrN6GG3DxUuSAl0=;
        b=NCwssyGK+NDHAo4KMYiWvL4WMnd6ZcO6XL2LssfRtZ/gLcCqIH9Ni/M2rh535xY1kQ
         8RDlxHaRGmL91XftNHwwbZuO1yRTTSAd/bg0KuKQclt9ZaZ8bc6Ai3z/VeePB/n6ST1t
         wNICEFDlaH3PS+btEatOldNcB3vlxyUxBx8RTgG5zE7EUwvE877ucYpCHmCpOHW5T9dc
         ZqE+NwM3w4bgFS462OX3RrgBtnqkdNrFKtfm0ZrkT49byz8dfZuy1DB5qd2ylLuG1zjO
         dQzMtQd5Qq4PtRLDAG9qQkO6r2xb6Lwqymj8A8xrtLMO6BAwTSdj1z90z8yyVxdDbd5n
         Av/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778222824; x=1778827624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgYa7VVGLVSTLTDj6wGtEsacvpNZkrN6GG3DxUuSAl0=;
        b=Xu/sWmJRHzD2xBH4CkrPVd2bFwQ+m80fivAL/C34lYhUn2IIaRWlaIEUeuv0z9CM67
         QQMkR+ECeItNGOqmJnh9G7mgoMD9BkyoWHHLf0FOHf81GC3qq7sEJqGjCaF/NJ/RyEtX
         weK1fMZB7QDp+zYoPh9tW89RiTRfAj12H67WDChysJgzOpXVZM0WmjLXucmWmeMgj6TY
         bLB78WowOUzdG3ippn0P7sRxJI3C+0kgbmzSRa4azckWwhaCise3XGuaC+3e2l8nuHmn
         RyV2x2lGAMhoVjksB+od+j8kq0u+5hpzsX2psBnlPsTC1i7uw5QmMisZL99IC7lOjj1Y
         3Pig==
X-Forwarded-Encrypted: i=1; AFNElJ/j1PRr+M8X2PAuoa5JaEmtFVIJzdQSPG02HEjCKhL3GI8MIA0TDa6wj+BkuRUBqhQ9Ults5/j2wA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWEFtK8JpZAfNFYUiVhURD0/WwVUguhk6JML3MsEHrr44nuddv
	ISFSa3xerfkfJlE+m0a7JcVLi5gFmnoVmGYLuOZ+2cXqx46evBNs0r6LLmTfKRwUqvgRe3xZaqS
	0MdopgXOaGgllzBjJudicc4Xbe4pongWycqu8UIh8JpQ588AKATvsg9X20RWiVQ==
X-Gm-Gg: Acq92OHz9zdHHPRUy+HUUlZnEskcuOclcxjenEh6w7wwfeafGitJbHtbBhKJeup/7gt
	VH6qpOCqyzEdiJ5F48X0/OrqVIUVpLT7QGnbdLnxQsgTi1tyMGW9Z9UCHWGfPRj8rBYzTJcbFWD
	pF1CftTeofHmLwlzsBm1poDP31HCsU2AUx0Z2C2uDzGpO7kheN3xr/msS8LYcGv7sAf0BvbfrUU
	sVqk8zwJVJSdcDjRXFs771hpkIL722W5esSEBYzLnY0iVA9iFWDpmhvUO+yauk5dh2BTr2GsFMJ
	tFuDF+jbc2B+QJyfAsCAyCgXPApQtwyHsy4/kr4iMcjF0fgcLjyeLa0H/5SRUz6OrdTr0FvuCeR
	tty0lyXphv8oEZZaWs7QRzVrMGu9YkFbFZDVBbGpHVqpPFkGf5C2E61UdehK5i+LorUz2km6pkV
	f2QxDeyWbZ9GHMo2Ln
X-Received: by 2002:a17:903:3847:b0:2b9:ecb4:a3dd with SMTP id d9443c01a7336-2ba798c2a32mr103025805ad.34.1778222824331;
        Thu, 07 May 2026 23:47:04 -0700 (PDT)
X-Received: by 2002:a17:903:3847:b0:2b9:ecb4:a3dd with SMTP id d9443c01a7336-2ba798c2a32mr103025425ad.34.1778222823674;
        Thu, 07 May 2026 23:47:03 -0700 (PDT)
Received: from [10.133.33.84] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e374besm10119535ad.47.2026.05.07.23.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 23:47:03 -0700 (PDT)
Message-ID: <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com>
Date: Fri, 8 May 2026 14:46:58 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, stratosk@semaphore.gr, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com,
        zhangpengjie2@huawei.com, wangzhi12@huawei.com,
        linhongye@h-partners.com, zhongqiu.han@oss.qualcomm.com
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA2NSBTYWx0ZWRfXy9f5ehNblug5
 iAh++bH/7vlJnIbmRBH7cgJxhqmgEYCA16zS+yUu9vXykQZNmcq2cCqiFSxaAKqctEExKJmqbJq
 lNgkku51ntvAwGK+5mWGyt2KV1upz0YTLzNZ0ON7e0Z9f97zKfel/pZZsg/pHi4g/nLhOLFY+0R
 ZONL+a0R7Ad4X7xRlM+4pHcXFgY+N8xbYkpwySKB9pMHJPbqSaNT3KaGCwlVVzxR46Ow6vmHX+u
 3JGGTmY/FQdxDqPD5sDr4xF4KterpwI20UEyU1WiHNI/D+6cVWa/qWbmupeTfJIb6/hmKdGqxf1
 DAOX+Q2qFU44DN7DAHksTq8+cnrZy9TDKDBaIciuJjA+NX551yMAMFqonmivkb3nwh+hkOwQmms
 8p0l6sTLJhmmvqYu3JIlpRI02fmIcE4NNVO3eUM2JzXmXt4CJuqNj7L8pLZyy5vm5LtIrqqUs+A
 TVMGzn8aceliZruCefA==
X-Proofpoint-GUID: vcrp0sngDtBGpR7Jfm6FoVnA699eW9wA
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fd86e9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=ujytlxt2ZZPjNJFSC5gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: vcrp0sngDtBGpR7Jfm6FoVnA699eW9wA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080065

On 5/7/2026 5:33 PM, Viresh Kumar wrote:
> On 23-04-26, 15:12, zhenglifeng (A) wrote:
>> Yes, I think you are right. The behaviors are not the same. I modified this
>> just in order to keep it consistent with the case exceeding down_threshold.
>> I'm not sure if this change of behavior is reasonable. Perhaps Rafael or
>> Viresh could give us some advice.
> 
>>>> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
>>>> @@ -104,7 +104,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>>>>            dbs_info->down_skip = 0;
>>>>              /* if we are already at full speed then break out early */
>>>> -        if (requested_freq == policy->max)
>>>> +        if (dbs_info->requested_freq == policy->max)
>>>>                goto out;
> 
>>>> -        if (requested_freq == policy->min)
>>>> +        if (dbs_info->requested_freq == policy->min)
> 
> What about dropping these `if` blocks completely ? i.e. always call
> __cpufreq_driver_target().
> 
> __cpufreq_driver_target() already have similar checks in place to optimize
> unnecessary freq changes. We don't really need callers to do the same.
> 

Thanks Viresh a lot,

Nice suggestion! — I think it aligns well with the general direction of
addressing this issue and relying more on the cpufreq core.

That said, I have a concern if we drop the decrease-path early-exit
check while keeping the existing condition:

         if (requested_freq > freq_step)

unchanged. In that case, when the system is already at policy->min, this
appears to introduce a governor-level oscillation, even though the
effective hardware frequency remains unchanged:

Consider the following scenario
(policy->min = 200, freq_step = 100, hardware already at min, low load):

   Iteration N:
     requested_freq = 200
     decrease path: 200 > 100 -> requested_freq = 100
     __cpufreq_driver_target(100, LE):
         clamp -> 200, target == cur
         -> without CPUFREQ_NEED_UPDATE_LIMITS: driver not invoked
         -> with CPUFREQ_NEED_UPDATE_LIMITS: driver is still invoked
     dbs_info->requested_freq = 100 <- below min

   Iteration N+1:
     requested_freq = 100
     out-of-range check: reset to policy->cur = 200
     decrease path: 200 > 100 -> requested_freq = 100
     dbs_info->requested_freq = 100   <- below min again

This results in a repeated oscillation pattern. For drivers with
CPUFREQ_NEED_UPDATE_LIMITS (amd-pstate, intel_cpufreq, cppc_cpufreq),
the driver may be invoked every sampling period even though the
effective frequency does not change. I'm happy to defer to your judgment
on whether this is significant enough to warrant further changes.

Given this, may i know would it make sense to adjust only the decrease
path early-exit condition to use dbs_info->requested_freq (i.e. the last
target actually requested from hardware), rather than the idle-adjusted
local requested_freq?

   -     if (requested_freq == policy->min)
   +     if (dbs_info->requested_freq == policy->min)
             goto out;

With this change, the scenario raised by Lifeng
(dbs_info->requested_freq = 400, idle_periods = 2, low load) behaves as
follows:

   Iteration 1:
     requested_freq = 400
     idle decay: requested_freq = 200
     if (dbs_info->requested_freq(400) == min(200)) ? NO -> continue
     200 > 100 -> requested_freq = 100
     __cpufreq_driver_target(100, LE):
         clamp -> 200, target(200) != cur(400)
         -> driver invoked, hardware: 400 -> 200 MHz   [bug fixed]
     dbs_info->requested_freq = 100   <- one-time transient value

   Iteration 2:
     requested_freq = 100
     out-of-range check: reset to policy->cur = 200
     if (dbs_info->requested_freq(200) == min(200)) ? YES -> goto out

   -> Stable from iteration 2 onward, with no extra driver calls.

There is a one-time transient where dbs_info->requested_freq briefly
drops below policy->min, but this is harmless: the existing out-of-range
check corrects it in the next iteration. A similar situation was
discussed before [1], where the conclusion at the time was that
__cpufreq_driver_target() already performs the necessary clamping. If it
would be clearer or more robust to add an explicit guard
here, this can be revisited as well at your discretion.😊

[1]https://lore.kernel.org/linux-pm/20231005105746.ikezg2buza2qwvig@vireshk-i7/

The increase-path early-exit is intentionally left unchanged, to avoid
altering the behavior in the scenario where conservative idle decay
would otherwise be ignored when the previous requested frequency was
already at policy->max.


-- 
Thx and BRs,
Zhongqiu Han
