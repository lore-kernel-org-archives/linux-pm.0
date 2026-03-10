Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057591F418F
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148685; cv=none; b=fx1/DG7Gpu+h3172Pwx6ND39JK53QFWDCcJAZQd3vKT0DTPusXTXjgY2sPo9yD9zt8flbhq1ISsGb0QuG4Wg0sxNXRa20Dr+3iQaTxhiNBntK7r7/dDsgbNKupzaBYp0lCLzLq+Svovc5WEU0/B7z5iJ5CBC1GJeMqDjRvMrhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148685; c=relaxed/simple;
	bh=X0hmFSpchItCFK/n/iWAzjP04Cuv3qg7aIt6bH/Idt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYipV83WR3ugXxJbZUJo2lIVfTzJ2oz5nE1yl2JtZH0G+dRYjAoiA0Qaj6olRcS/+6riaSqelS6Qe/WYEyU3OAlHYcxSZFctlwehj9DmxSzA5zCwFqm/bmnkPRTWsgXr/6p0S8fPBdWdUmNXh+sxTxuNe9fWYrmtLKUBCnY6SHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=laU5/Dlg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RdL3k7PC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="laU5/Dlg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RdL3k7PC"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACav7B3418255
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 13:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QeRVERBetYXJ7uyxSrvFn8RqQTgPuZs/VzIemLuHUTc=; b=laU5/DlgxSxiBEhX
	uunTU3NLmI6IG2DsiVTp49DgW1mnd2RN0pZH299yv9GlMP4qx4EpI0c73IgD35kL
	RQ21cWdXEAaHcPYqh3j5y899leyDJyhRHIPwgq9Nj+osAdf9ZagpYyGABEzQ/h/7
	V+dT5AarTQW0jl1IfY+PgHm1JOUWyOHdCowvMO9++HAQuiumB4BP2RpN1TA/umu+
	F2tDZxi8aQkh7gdRwKNZ2QZ2AcpXEzhqIi1DHNpv7eDghsvDJhZPdPCJJ1D4i9Go
	qc1DphsmHgl7M1gPOLC3mjpfxxDnvRxRlTHqRWuAhG2fUthbRT+vpIK+ORjXcgi0
	IklEsQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja28daa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 13:18:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae4af66f40so101014105ad.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773148682; x=1773753482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeRVERBetYXJ7uyxSrvFn8RqQTgPuZs/VzIemLuHUTc=;
        b=RdL3k7PCwq0EeXqnmtsY18nQByWGzvenE9zizcPBMKJHBZ13cprnbc9tbG4PH3R3H5
         H18zxnqsGJ1xndgOpuBKHhvZ15hxRhYUgZ2vDiHPYgYFcn40EzAwJWO40DO8PNv4B7UC
         bJ0CYXAEbLjc0fAjExXsD+10ra4Mm2/sWf87vOUVTAP3FgMcNcRUS6S30jvZymFb96Q0
         12tHt3ZuPxfemLrjsFqBn+UtMMz1ZtVvK1zQFJPHGDrNxOR2ieiO2X36yV7KknLRzQ4N
         iz2M0a1wGIuppjOyf2JFfErfmnsPQ7JWo8vLl732Vu8iVjDgIpioB3+bBieDHqNWePAh
         y5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148682; x=1773753482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeRVERBetYXJ7uyxSrvFn8RqQTgPuZs/VzIemLuHUTc=;
        b=FtvWqwymVbaYnFP0gRIHsawpyUnvc58aD1bp2LHpNpI3skLLxAGgKThjnONWmQ8Yws
         DzeDyCvnqZtzKCzOfKQQPlccpAsAAL7TZ7UJqT+FGqd/BqfaUDUHzeJKf9QKj80FAUBY
         SW+ZJny2tq9uZDSkFJek2BeoceIXCKvr5ZL7RHOnCnm+ZnJHatHVd41U9OwEtd1YSAvc
         vM3y/mtY4HQnf8WPmaSKOo2DAqFMyGBtJqlOFsRTjpqFsq+SGfSGBNdF8ycBW5oLz59N
         xUgF1NSlpCHt/mnnJ4OgAy4zjJgGwNL/LjdGdJakonaOiybD7Xz2OCpIaztHQDB0N94Z
         0h3Q==
X-Gm-Message-State: AOJu0Yyb2LGbSEiHVfFs7P9cOcDcp9zOw91y4mMTAo/WKsW6uoJA8Oeu
	l3awtoywqv+Kq0sUC9w2vSd6BDrxaoFsLzXkzyhnOzguFmPrlrh+bkPTzokUoQHpdd6J4Y/yyeX
	Esh+EC9Y6vVG0b/J7x8xPJhjZx63aN4Dntk+qC25zkky3Ky9USH3oqvDb8OYOKg==
X-Gm-Gg: ATEYQzxHGke1jCSs/eGvCJoOIhAao+fUeCiGJlzmmo8i0A5npBVhObSHNNwOQ5N4lhW
	Imr4Sik+0whSLa4EZzbqoSsYBk0bnM765ZO6KEE4HA9Jp6UQMiQh7NyilDVlsNHeCI51p7oMd96
	oyxcII7rBFy4LElzOllxHor0IWHyDjN8H6S1zXEI2EYyAPQoPZQw+UshI6y0TB7oERsuDBLw2F9
	DdMMpMDWPzm9T/h33LTHzWbUqvDTpPzCoKf0b1zYbl928eL/mKm6FbRTUZSSHULuI3k+p/hIE5I
	GhO7lahSOJSlJZz+6s0Tr9PaRPghQBRJr2nhqdXaD/kCpo/QCkSyxvP3+KrscIq3efcVvnW/DES
	s8A1QJslFZtmNyxGxK2heYAudcv4+xSabmYMpIh9hqT2xcf/YjYWdtlfghfSAbaQKSjaN47VTQr
	9NTupyHu2tJGjm93uHQg==
X-Received: by 2002:a17:902:d2d0:b0:2ae:492c:f8e6 with SMTP id d9443c01a7336-2ae82367d1fmr145871505ad.1.1773148681862;
        Tue, 10 Mar 2026 06:18:01 -0700 (PDT)
X-Received: by 2002:a17:902:d2d0:b0:2ae:492c:f8e6 with SMTP id d9443c01a7336-2ae82367d1fmr145871135ad.1.1773148681321;
        Tue, 10 Mar 2026 06:18:01 -0700 (PDT)
Received: from [10.133.33.216] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fb4401sm150287805ad.74.2026.03.10.06.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 06:18:00 -0700 (PDT)
Message-ID: <05feb9ed-3257-452e-98e9-89637431a347@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 21:17:56 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b01a0a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=KKAkSRfTAAAA:8 a=4yIxzue803bsba6ReOAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: OUusuRNZjxzQIH-YJv2zyHrYz8SJI8uy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDExNiBTYWx0ZWRfXyYH8wPWM2tXB
 9SC/dontxyWwVfGr/2M1W6VV7JalMj+ClILtLjS25MJWjUEpkm0OzVOxxHviz4oqF/hKbBoaZ3O
 sDJ0IWJBnpDXc8Qg53kFMZQoTuFFjmkXysZeAIM3sA91LX6Xyz7c9vVXJRDmzl4m587ZuK4/rUQ
 FnMUBzgyH0OQfy9Eak2utzZ4rLQBkbZjbFcISBo6cfEeVvwtjcxsPGec8AMmznH7bsyLI7WbVg+
 VjRWy0hNjqVwR1ntLJQIe9OFRwAJaoECHhaOSdgp/VV0Kl8M5DRvLg5Ocu4iMjZqoNDxYfz5wEt
 68qhzM7O48G0KEJxB8cEBQD6XqV3J3/u7HPARYW0thnaFxyNhpglfkgF1vvAPcHFFIDIe2SBlxM
 +kygJLAMXiOcvTM1vlYBhGVa2j7+xfPLB6/ifYldLaU/7nauQu8/b/V7HNxkn7HYeme0WNwMYg9
 auRHD0qy4tdi3/31bIA==
X-Proofpoint-GUID: OUusuRNZjxzQIH-YJv2zyHrYz8SJI8uy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100116

On 3/10/2026 2:34 PM, Viresh Kumar wrote:
> A recently reported issue highlighted that the cached requested_freq
> is not guaranteed to stay in sync with policy->cur. If the platform
> changes the actual CPU frequency after the governor sets one (e.g.
> due to platform-specific frequency scaling) and a re-sync occurs
> later, policy->cur may diverge from requested_freq.
> 
> This can lead to incorrect behavior in the conservative governor.
> For example, the governor may assume the CPU is already running at
> the maximum frequency and skip further increases even though there
> is still headroom.
> 
> Avoid this by dropping the cached requested_freq and using
> policy->cur directly.

Hi Viresh,

Thanks for the patch. The fix looks correct to me for the reported
issue. I do have one question though - should we also consider the
interaction with commit abb6627910a1 ("cpufreq: conservative: Fix
next frequency selection")?

The cached requested_freq can diverge from policy->cur when the
platform may change the actual CPU frequency outside of cpufreq
interfaces, causing cs_dbs_update() to incorrectly assume the CPU is
already at policy->max and skip frequency increases. Using policy->cur
directly avoids this.

This direction was already argued for in commit d352cf47d93e
("cpufreq: conservative: Do not use transition notifications"), which
noted that "policy->cur can be used instead of [requested_freq] and
then the governor will not have to worry about updating the tracked
value when the current frequency changes independently."

However, that change was subsequently reverted by commit abb6627910a1
("cpufreq: conservative: Fix next frequency selection"), which noted
that using policy->cur directly broke the algorithm when freq_step is
small relative to the distances between available frequencies. In that
case, the governor may not be able to stay within a narrow range
between two consecutive available frequencies and instead jumps through
steps faster than intended.

May I know am I missing something here, or does this patch potentially
reintroduce the same issue? Thank you



> 
> Reported-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Link: https://lore.kernel.org/all/20260210115458.3493646-1-zhenglifeng1@huawei.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Lifeng Zheng, can you please give this a try and provide your Tested-by as well
> ?
> 
>   drivers/cpufreq/cpufreq_conservative.c | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index e0e847764511..c69577e4f941 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -14,7 +14,6 @@
>   struct cs_policy_dbs_info {
>   	struct policy_dbs_info policy_dbs;
>   	unsigned int down_skip;
> -	unsigned int requested_freq;
>   };
>   
>   static inline struct cs_policy_dbs_info *to_dbs_info(struct policy_dbs_info *policy_dbs)
> @@ -59,10 +58,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>   {
>   	struct policy_dbs_info *policy_dbs = policy->governor_data;
>   	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
> -	unsigned int requested_freq = dbs_info->requested_freq;
>   	struct dbs_data *dbs_data = policy_dbs->dbs_data;
>   	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>   	unsigned int load = dbs_update(policy);
> +	unsigned int requested_freq = policy->cur;
>   	unsigned int freq_step;
>   
>   	/*
> @@ -72,16 +71,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>   	if (cs_tuners->freq_step == 0)
>   		goto out;
>   
> -	/*
> -	 * If requested_freq is out of range, it is likely that the limits
> -	 * changed in the meantime, so fall back to current frequency in that
> -	 * case.
> -	 */
> -	if (requested_freq > policy->max || requested_freq < policy->min) {
> -		requested_freq = policy->cur;
> -		dbs_info->requested_freq = requested_freq;
> -	}
> -
>   	freq_step = get_freq_step(cs_tuners, policy);
>   
>   	/*
> @@ -113,7 +102,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>   
>   		__cpufreq_driver_target(policy, requested_freq,
>   					CPUFREQ_RELATION_HE);
> -		dbs_info->requested_freq = requested_freq;
>   		goto out;
>   	}
>   
> @@ -137,7 +125,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>   
>   		__cpufreq_driver_target(policy, requested_freq,
>   					CPUFREQ_RELATION_LE);
> -		dbs_info->requested_freq = requested_freq;
>   	}
>   
>    out:
> @@ -310,7 +297,6 @@ static void cs_start(struct cpufreq_policy *policy)
>   	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
>   
>   	dbs_info->down_skip = 0;
> -	dbs_info->requested_freq = policy->cur;
>   }
>   
>   static struct dbs_governor cs_governor = {


-- 
Thx and BRs,
Zhongqiu Han
