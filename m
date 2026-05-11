Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB1D54652
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778472235; cv=none; b=cZ+GFPRdzOJZJShU7f2WlhAN/RGPXfygI87GqqSYJA8h9v11dKYIiAOmJcTlt1jiNvWN+UQb/NxAQora0a5zfxMfnDX2F4LOM+lJ0/+Z788rFigfrzpafl3DhCgMjJ0Vg3MteasUl9fO+Fp6HO5OBpkoHPuBsmTQ0iVX8npBqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778472235; c=relaxed/simple;
	bh=uAX43zJY9VCL5sRVk4Ac7LnG2HwQMuKTSjfY7y46+zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxEOed5fa22cZZEmEzmihQ9FN2K4G3xE4WkICfFF94UFVDnNtd2Ggi4Tltp87A2ceVxzSBJen1K8+Z9Y2s4FnhEaoxQ6IRA21hxWMAVlm4hRGy2iZanFAhdhZc9g7bUYroItyUNjcUk9B7ZJk0khINbKfXD76X9zhr9g4ZNhVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XFjl8Bt+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z8+GP5se; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XFjl8Bt+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z8+GP5se"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AMFSeS3876211
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 04:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yzhbiFvZW3aBsGS+wWeIcjYiFitpSQhYtRKQkrKsr+A=; b=XFjl8Bt+WFU5otkR
	g2l8OvBYI60ndnLYJqsZyO0JWyUBTYqRnh7gHL7jguHZ2nwZ5lg/k9SSjFx1rMTq
	9TH42bckdIAFxZslCCT0PNl/ySYUeOZNzN3cTPV2gSy15p9E2Zr+oVgDSFDepq1K
	q3bZcFNusGa0yNZ3oo3iOSMKk20ps9WWsI8FX8jv8TCNqO02CiJHcKGv2ZKwq4S2
	r/C5rqLZR7ONytpbLu3D3ISqOXrSyCB4AXKsy/iRZP0OfX4/zKq47+iy/1N43QVQ
	WMcSpQtk3ycTqRWRhsDP8iSc/zxClBjCylCH9ocAnQElREwZbtJfnSMz+HTtuF93
	G1ELKA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1x3k48ch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 04:03:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba603a7d2cso41137145ad.1
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 21:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778472233; x=1779077033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzhbiFvZW3aBsGS+wWeIcjYiFitpSQhYtRKQkrKsr+A=;
        b=Z8+GP5seEIKMgfozD0OtYQgV4zMJ7TIv2f/GanueKkup5sx0rXHF9vXEzE/JMM2Cut
         k0Y25O5+EnfQuOkqMb1g8HAl5m9tLeMPlJrrPT6NHikCuDpii1ZZs0Li6t/fRd5/rozt
         CLbt0PbaKqomKZiggSl2n08X5BaQejjrxmIx6Nne8fcs9k5YPSs1P7KkzgORl+XpxG0/
         BZdNrBJ5VMskBAwot2cfvN1nupxuIDb1us3ADIE9lh7hbQed+0eyAGaNwpa8NjtgSrmV
         /YAndQgtVHbHS9+uf8XalkPiv0kSv4FOt4fqNzpom82ncS7Ly7h3hDGwfE136d83ukPt
         b2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778472233; x=1779077033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzhbiFvZW3aBsGS+wWeIcjYiFitpSQhYtRKQkrKsr+A=;
        b=tKVamfALBTUtIHsqjLdjN/ge5XewBGd/knLLiTBM9nB5L4MESOsQDPCtiGo9keyk+h
         Wa4bFgkJXVO1Ei+eBF+m4rz3fCiYvdOKj7xt8pTi32D11X9ji+6ptD7vMF7eK0yBczMG
         ShL/+HwZ+sTnVqbjGdJKsc3Y+/5Qz3PkUowfETaLa1Z/Yg4KUaNxvOYpJGjg0cNHw8rh
         7dJzN+jMhop5egONR/ZywoP3i3ZHQEOgmOw401aj6c3DOVs6P98/z09p/VLZZ1cuQNvI
         V/kSN6siwxcyYTQmLHTtpNh9eFk6NlAY5N23WBs4bkhAxJRzwPwtawZ8Dj7exJ2+Ks/l
         dYgg==
X-Forwarded-Encrypted: i=1; AFNElJ9KcWm8D7Xv9pfrnzFViBEQsnkXhwXXkm7zT+s+BICA/Rx2FZUVUliohzIlPDBXgdoEmBMFnKC97w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBU1TwY880YUlzFzx1uvUaNLx18nLrkrnGnQU808GvSzDa7+yq
	dMORjVISZQHWOUmIIqhihu3PcUfeOLvuB8Dh0oQ8ETO88hjl1o5FFRCwtejr9xTqDN9U3LfmP/8
	yEmrRmUm4JYCftKlI8CWBH2+gDg5acsPsGKANyZGM+vFxUkSMkqKeeDh7Qki9tw==
X-Gm-Gg: Acq92OF9EuxKQ9ftASMplb7QjWXTyGHG/1rcjGfmxrF1/ATHAru2Sej8EQokNmcQIYs
	vAkrtcfa2n8MsYGmRg7aFT94tDY/o/GFrDas2M617wOK7zVuKDOWSrNQERJYoi1BBPnIOK3IO6d
	/lZj8AqW9cI/NoBYFbY6A507+2IeW+MJFS/m1rBagRxSNys14cfUREhLkGxwhh7sNqk1/MVAbA0
	PtwK8FWj7W/8Vf/u2UUmFmJ76XSHt2Fxz2cJsVdvSJlMpkN2r5nSM0QleD5Cx1sgPoCGl7oJwqT
	Co9T3QigcWvRn3oZ4oNc63Ki+ypgg1eNF71TNok/B4mxiyy0pGDPIqYVq5y9EVuQ3F56w3WlE0f
	vaxwSGpWX07iUYjyCYt6t3Dcr0fYfXZjr1xFOHNc2l5PjivMitA6umUlSUX/8X/CZK3k7iGXADx
	ALAVWSQm1BynlYPzJsAA==
X-Received: by 2002:a17:903:946:b0:2b0:be79:e521 with SMTP id d9443c01a7336-2babd60bbddmr133614005ad.26.1778472232800;
        Sun, 10 May 2026 21:03:52 -0700 (PDT)
X-Received: by 2002:a17:903:946:b0:2b0:be79:e521 with SMTP id d9443c01a7336-2babd60bbddmr133613765ad.26.1778472232260;
        Sun, 10 May 2026 21:03:52 -0700 (PDT)
Received: from [10.133.33.247] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm83935845ad.44.2026.05.10.21.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 21:03:51 -0700 (PDT)
Message-ID: <a028421a-de24-43cd-ac80-17de9b2fc523@oss.qualcomm.com>
Date: Mon, 11 May 2026 12:03:46 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
        stratosk@semaphore.gr, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com,
        zhangpengjie2@huawei.com, wangzhi12@huawei.com,
        linhongye@h-partners.com, zhongqiu.han@oss.qualcomm.com
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
 <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com>
 <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA0MSBTYWx0ZWRfX0X5AfI8bA1q3
 LVBYGqW6YDxC/8El/n5FOpvySf9GyLRcNHwXBECCtlz5m7AcLMMbM0My2lCxp7knlcf7GhoARdf
 OubF5F/Kc9q3Y0e801t6AAY+Nfl/s+SuoYzu0xJU4z+anRndvg4xqhHqg80zYK47rW+3FWKjXsV
 S3o6UV94r8ylA63whOIELhvpY2/aDYxL9EMezK6y6VGUAEYWXgdpLB4PplqjePDZ6tt7cp4mJjT
 +7ff59bEeDNwaWVJMm4+yQjY5OO/BBUQhj99LAkjS1hoUDCnRQTniA2kwD/CezZuIhMiBD/d8W2
 9ulGBEAPiKy4Prne9dJQjwcSQXtRHP6Pl9WSaFh9V4AV2eIsyZsPRm2s+GYxBSNoJ4LyiOTvjwT
 6YWiwXnMwnrgbwyL/BSZv7o/KvdJ0XO9k0g+O+EzeaC7R4mp/Ib9n94Mk6t+tHmaQFhSq6FsGmN
 mdugXyoQSQhsYT7UIag==
X-Proofpoint-ORIG-GUID: wk1MZrc2fCMpERDCzJFUrkJRKyC54zIj
X-Authority-Analysis: v=2.4 cv=UNvt2ify c=1 sm=1 tr=0 ts=6a015529 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=RqrBSwbPjokQlsvh5zYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: wk1MZrc2fCMpERDCzJFUrkJRKyC54zIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110041

On 5/8/2026 6:14 PM, Viresh Kumar wrote:
> On 08-05-26, 14:46, Zhongqiu Han wrote:
>> Nice suggestion! — I think it aligns well with the general direction of
>> addressing this issue and relying more on the cpufreq core.
>>
>> That said, I have a concern if we drop the decrease-path early-exit
>> check while keeping the existing condition:
>>
>>          if (requested_freq > freq_step)
>>
>> unchanged. In that case, when the system is already at policy->min, this
>> appears to introduce a governor-level oscillation, even though the
>> effective hardware frequency remains unchanged:
>>
>> Consider the following scenario
>> (policy->min = 200, freq_step = 100, hardware already at min, low load):
>>
>>    Iteration N:
>>      requested_freq = 200
>>      decrease path: 200 > 100 -> requested_freq = 100
>>      __cpufreq_driver_target(100, LE):
>>          clamp -> 200, target == cur
>>          -> without CPUFREQ_NEED_UPDATE_LIMITS: driver not invoked
>>          -> with CPUFREQ_NEED_UPDATE_LIMITS: driver is still invoked
>>      dbs_info->requested_freq = 100 <- below min
>>
>>    Iteration N+1:
>>      requested_freq = 100
>>      out-of-range check: reset to policy->cur = 200
>>      decrease path: 200 > 100 -> requested_freq = 100
>>      dbs_info->requested_freq = 100   <- below min again
>>
>> This results in a repeated oscillation pattern. For drivers with
>> CPUFREQ_NEED_UPDATE_LIMITS (amd-pstate, intel_cpufreq, cppc_cpufreq),
>> the driver may be invoked every sampling period even though the
>> effective frequency does not change. I'm happy to defer to your judgment
>> on whether this is significant enough to warrant further changes.
>>
>> Given this, may i know would it make sense to adjust only the decrease
>> path early-exit condition to use dbs_info->requested_freq (i.e. the last
>> target actually requested from hardware), rather than the idle-adjusted
>> local requested_freq?
>>
>>    -     if (requested_freq == policy->min)
>>    +     if (dbs_info->requested_freq == policy->min)
>>              goto out;
>>
>> With this change, the scenario raised by Lifeng
>> (dbs_info->requested_freq = 400, idle_periods = 2, low load) behaves as
>> follows:
>>
>>    Iteration 1:
>>      requested_freq = 400
>>      idle decay: requested_freq = 200
>>      if (dbs_info->requested_freq(400) == min(200)) ? NO -> continue
>>      200 > 100 -> requested_freq = 100
>>      __cpufreq_driver_target(100, LE):
>>          clamp -> 200, target(200) != cur(400)
>>          -> driver invoked, hardware: 400 -> 200 MHz   [bug fixed]
>>      dbs_info->requested_freq = 100   <- one-time transient value
>>
>>    Iteration 2:
>>      requested_freq = 100
>>      out-of-range check: reset to policy->cur = 200
>>      if (dbs_info->requested_freq(200) == min(200)) ? YES -> goto out
>>
>>    -> Stable from iteration 2 onward, with no extra driver calls.
>>
>> There is a one-time transient where dbs_info->requested_freq briefly
>> drops below policy->min, but this is harmless: the existing out-of-range
>> check corrects it in the next iteration. A similar situation was
>> discussed before [1], where the conclusion at the time was that
>> __cpufreq_driver_target() already performs the necessary clamping. If it
>> would be clearer or more robust to add an explicit guard
>> here, this can be revisited as well at your discretion.😊
>>
>> [1]https://lore.kernel.org/linux-pm/20231005105746.ikezg2buza2qwvig@vireshk-i7/
>>
>> The increase-path early-exit is intentionally left unchanged, to avoid
>> altering the behavior in the scenario where conservative idle decay
>> would otherwise be ignored when the previous requested frequency was
>> already at policy->max.
> 
> What about this ?
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index df01d33993d8..c7ec11de9a43 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -103,10 +103,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>          if (load > dbs_data->up_threshold) {
>                  dbs_info->down_skip = 0;
> 
> -               /* if we are already at full speed then break out early */
> -               if (requested_freq == policy->max)
> -                       goto out;
> -
>                  requested_freq += freq_step;
>                  if (requested_freq > policy->max)
>                          requested_freq = policy->max;
> @@ -124,15 +120,8 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
> 
>          /* Check for frequency decrease */
>          if (load < cs_tuners->down_threshold) {
> -               /*
> -                * if we cannot reduce the frequency anymore, break out early
> -                */
> -               if (requested_freq == policy->min)
> -                       goto out;
> -
> -               if (requested_freq > freq_step)
> -                       requested_freq -= freq_step;
> -               else
> +               requested_freq -= freq_step;
> +               if (requested_freq < policy->min)
>                          requested_freq = policy->min;
> 
>                  __cpufreq_driver_target(policy, requested_freq,
> 

Just one small concern is that requested_freq may underflow as an
unsigned value; perhaps this could be improved by:

-		if (requested_freq > freq_step)
+		if (requested_freq > policy->min + freq_step)
  			requested_freq -= freq_step;
  		else
  			requested_freq = policy->min;

or use min() func?

Additionally, it seems that dropping the early‑exit checks also appears
to be a nice side effect fix for CPUFREQ_NEED_UPDATE_LIMITS drivers when
updating internal upper and lower frequency boundaries.

As designed in commit 1c534352f47f ("cpufreq: Introduce
CPUFREQ_NEED_UPDATE_LIMITS driver flag"), a cpufreq driver may need to
update its internal frequency limits when policy min or max changes for
drivers setting CPUFREQ_NEED_UPDATE_LIMITS.

However, the early‑exit in cs_dbs_update() can prevent
__cpufreq_driver_target() from ever being called.

For example, when policy->min rises from 200 to 400 kHz while policy
->cur is already at 400 kHz, under low load:

   cpufreq_policy_apply_limits():
     policy->min(400) > policy->cur(400) ?  NO -> driver not called

   cs_limits():
     dbs_info->requested_freq = policy->cur = 400

   [next sampling period, low load]
   cs_dbs_update():
     requested_freq = 400
     if (requested_freq == policy->min)  /* 400 == 400 -> true */
         goto out;  /* __cpufreq_driver_target() never called */

With the early‑exit removed, __cpufreq_driver_target() is called with
target == policy->cur, and CPUFREQ_NEED_UPDATE_LIMITS ensures the driver
is invoked to update its internal performance boundaries.


-- 
Thx and BRs,
Zhongqiu Han
