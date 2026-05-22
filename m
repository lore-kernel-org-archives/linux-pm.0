Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F239DBF8
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428374; cv=none; b=UwaET0irTkRI7x9H7qVxanoW2u/5rtJo5PNQsdMZxHt/Wi3kkeqdJk7I36nA3MxWtSJssjsEt03t9mIxIoszDYi9uYoSNkqCHTSUeDA5vxvTgUxOjZydQZyzHiiR6oTx4aRTl+pfUmOK6T3ZqEugxQq6DQ6HlUgeWPrqQ/xq+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428374; c=relaxed/simple;
	bh=tBnu8iI/zsuJXD6vOC4LjzXuqbvLReGGQViNOhXjPsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpuB21CMOoHEkunPFRa6y8TU7wZN6F1YFA4wu+7IJ3lzIs+MccTOUv+Ib1t0sZ4q/EgWKT3PnEUMVHWN8xsmN2g7NnHpwSMg9ulrNrwJF6CZdgR6DZXTZ/j+5w2anTAARHUtb0nirrEUEYvUjyw/mPyU7vGMHzeH/XCw1K4tYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SPsvyD6h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dq7G8RtU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SPsvyD6h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dq7G8RtU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M30btn399205
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 05:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1tneTc/JBnTMxLNd3afN0kg883hXEVFta1eEX5f3b0c=; b=SPsvyD6hYcuqbrvv
	avbLLd5uQ/WWlStFN3gE8zqtU7n9KlbAvacgclC9MiEM6Di1U+ip6HUvGHypfOaU
	WUeu1DQcKAe89T/yiKQunCsRCWuyEBK3x/+nNRyiejlATMOfzvRrMq/gXxzPFnig
	/h3eC02TDd+j+36Muf53E2Fg1+XPggwwIfovIVDN1MWrVHP+EfDzMKC8Z7yozMMC
	fP8jQg/lMgvfsyBnfnAhnwimz+xyUAwDjMs8owBwD39nRaeDXblnmma41Jk8SZrw
	3UIy1M0JxtWB825Dsxv9yoacIOYKfjD7jlvZoBSJ1pyP2OgjHBrG14bUrWZhU8pt
	aciigQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea5p9tjqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 05:39:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-835423c69ffso3653041b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 22:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779428371; x=1780033171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1tneTc/JBnTMxLNd3afN0kg883hXEVFta1eEX5f3b0c=;
        b=dq7G8RtUuHzTPi18RSbmo0GY9nzHZHLyYOoYFq3lMO/tDG8sq+1eT7dRYX4xVA7eln
         FcpDU26T3y6CtZMKVZZTe0gd4d/J+U4/NBonCyQ4BBguTjRU+7+yrC7ssnrMkm/9JF0L
         XTyzfznCFcTS0Br3JnCzKsCyhtMq29yO4ztYBJreBHEzuLCuUvHPozBN7yH0XB7QOu+p
         OBZGEO9JQ2/uqFr9yyZHOIJ2miSM5Hgua5kAfSxd4jf9KiELSxBDO8rZPU5AOaZKEsiK
         imC6PZZE1gv6QWlv8sDpkTMx30wHwawgbzBhRR7+J8/lJgTO+80YaSQ9PP80jwsXMaew
         9rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779428371; x=1780033171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tneTc/JBnTMxLNd3afN0kg883hXEVFta1eEX5f3b0c=;
        b=bY7/+9IYai0sd46Gx9veLHf8RyfP4WSBT25vnjmO/pUtjJLsqvrLDvsWkqsbE9AhTe
         A7sDpJYuN0m3zOT/LKvJF7ePTWv/Pk9aoolPyOwfPgRVBD7dmjlkqEBvqsIMu4rXLHl1
         7NYUwwqq2/OPeiytGztRXY9Xps69hNazCHPSARMD53zqrpobxZTB6Q4ieX8xdPq/AdIU
         UYUiQVrFvCanOITCRiUIwA9j05CrhIMQRwYkK/4G30W+dNxVtEhUW63xWTQAE0b/5jiu
         lCxCo3nEDpsYGWsXxpq4we94MDd8nMmtupvxip+1CXQgMAI8h/uNLh+77U3N/YIxptMc
         H3NA==
X-Gm-Message-State: AOJu0Yz/iTLhxJwZsBzhORlpwx9pw3zMLw03O7gViqDz1QD6+x0WPg+v
	qtoj/AMEemhjzAKLJxlJAX64zFoEL7rqbpC6xa/VCiV2w8Rvd84p0zskuxuWx3WLWAX5JdUIhPO
	gBLCiMEfjs63yR8zDkMnmUthH75Q84N47Tev+Tm71XLhGOvaYwnFUUza5Cwey0wtIhbsSZHqV
X-Gm-Gg: Acq92OGVltG9uZODJ5Y7h9MJfq66SKe2HXYnnlkED51cdPvfA4DAR5zvdeeA1wx4utz
	yfqKs+g28iGaieGWEMl9ywD66T3tm+nGQ3mhDztDP4DhstqUp69gYeCMnUPdE7FEdflA5zesXq+
	Cn3ayIeO+3T4x5QSYOg91Cmwv27C8eooFyQIq9QE0lmpfow8NIddbpI79Fkcj+DuoRChoofnigG
	CY8yJ7DcDXNB5tpwBoHQ5zcGy9GkDBhvF0jbacXTeq+DM5QF/RheQrjWvFIRwzEpWo9ABmOZYU3
	9pWRyDUtwa7Ulzjx/1kFKTacH0UsJXdOLXIMPihBjGuBmP+gkiWyO9pwail1Ytb+KB/WNJvMsII
	/mdr5kML83InOFQwnKsTOhhAM6TuYGsmg+pNhu02pooSwvSFxQLXbyHlWBi7AxUe41Q6i2iN/wK
	LwUW6eY4QJpbj/qV6rcQ==
X-Received: by 2002:a05:6a00:4396:b0:82c:e1a3:986f with SMTP id d2e1a72fcca58-8415f58b7d9mr2117440b3a.43.1779428371189;
        Thu, 21 May 2026 22:39:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:4396:b0:82c:e1a3:986f with SMTP id d2e1a72fcca58-8415f58b7d9mr2117408b3a.43.1779428370626;
        Thu, 21 May 2026 22:39:30 -0700 (PDT)
Received: from [10.133.33.151] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aca86asm686012b3a.7.2026.05.21.22.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 22:39:30 -0700 (PDT)
Message-ID: <bf2fbd26-d428-414d-8ee4-f1640aa8ff5a@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:39:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/3] cpufreq: Avoid redundant target() calls for
 unchanged limits
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <cover.1779423281.git.viresh.kumar@linaro.org>
 <d0107c364b709abca21acf88072220bc05478594.1779423281.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <d0107c364b709abca21acf88072220bc05478594.1779423281.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DKm/JSNb c=1 sm=1 tr=0 ts=6a0fec13 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=r_7_iPtBSj_To4JTbMoA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ONrsDWmYcnojfd818uPPOrPlEdj_-575
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1MyBTYWx0ZWRfX1KqDrv1fpJuf
 6jrH9J4sA/Z7GdQJChBRiypWo5B/o/Z5J37YiQLvweuH5hEptEklgLsVhsNOiqCy24o9cPnSUdS
 mreH3XafJeW9E/Jx3P7ntkvW1W9t3KOSnddcaudzsL+xBUezAmm1mqW+LvTlnDDWJ3tqb+0DsGU
 HaYYE1RoPSHMtYcXmkttFNTgFlXW4CwvnTVluDTSSVpBze78nCXxVoEOeP4rkKXwzFg/X8NS9ZI
 sUfijbdNsWkLPHjtKJN6Tb2Vr9x4Mc2wMVIFmQ1YqUmYp7TObGm4LrldJ21djf47z3Fiy1UTxUo
 +lDKM/sctCIBqlxzTr/1+IY/PC9Z+6bMUns+zJQw2T9WffszKEtKKTXsXZcHwWlKXdaRCPkg1Gd
 NnSA7aVye30Ka3Sdqtxkum5hp+4kvus/GNC0jdC1x7ydCJKRZt2xYzIYi4NBuOjOK/nnEa7C6Xl
 FYlO0NFnOIIPsIfJi/w==
X-Proofpoint-ORIG-GUID: ONrsDWmYcnojfd818uPPOrPlEdj_-575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220053

On 5/22/2026 12:19 PM, Viresh Kumar wrote:
> Drivers setting CPUFREQ_NEED_UPDATE_LIMITS expect target() to be
> invoked even if the target frequency remains unchanged, so they can
> update their internal policy limits state.
> 
> Currently the core invokes target() unconditionally whenever the
> requested frequency matches policy->cur for such drivers, even if
> policy->min and policy->max haven't changed since the previous update.
> 
> Track pending policy limit updates explicitly and skip redundant
> target() invocations when neither the target frequency nor the
> effective limits changed.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>


Looks good to me, thanks.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/cpufreq.c | 31 ++++++++++++++++++++++---------
>   include/linux/cpufreq.h   |  3 +++
>   2 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44eb1b7e7fc1..225228e9f4ed 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2366,9 +2366,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>   	 * exactly same freq is called again and so we can save on few function
>   	 * calls.
>   	 */
> -	if (target_freq == policy->cur &&
> -	    !(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS))
> -		return 0;
> +	if (target_freq == policy->cur) {
> +		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
> +		    !policy->update_limits)
> +			return 0;
> +
> +		policy->update_limits = false;
> +	}
>   
>   	if (cpufreq_driver->target) {
>   		/*
> @@ -2620,6 +2624,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>   {
>   	struct cpufreq_policy_data new_data;
>   	struct cpufreq_governor *old_gov;
> +	unsigned int freq;
>   	int ret;
>   
>   	memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
> @@ -2652,12 +2657,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>   	 * compiler optimizations around them because they may be accessed
>   	 * concurrently by cpufreq_driver_resolve_freq() during the update.
>   	 */
> -	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
> -					       new_data.min, new_data.max,
> -					       CPUFREQ_RELATION_H));
> -	new_data.min = __resolve_freq(policy, new_data.min, new_data.min,
> -				      new_data.max, CPUFREQ_RELATION_L);
> -	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
> +	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
> +			      CPUFREQ_RELATION_H);
> +	if (freq != policy->max) {
> +		WRITE_ONCE(policy->max, freq);
> +		policy->update_limits = true;
> +	}
> +
> +	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
> +			      CPUFREQ_RELATION_L);
> +	freq = min(freq, policy->max);
> +	if (freq != policy->min) {
> +		WRITE_ONCE(policy->min, freq);
> +		policy->update_limits = true;
> +	}
>   
>   	trace_cpu_frequency_limits(policy);
>   
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 4d4b4ed24b30..ae9d1ce4f49c 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -146,6 +146,9 @@ struct cpufreq_policy {
>   	/* Per policy boost supported flag. */
>   	bool			boost_supported;
>   
> +	/* Pending policy->min/max update for the driver */
> +	bool			update_limits;
> +
>   	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
>   	unsigned int cached_target_freq;
>   	unsigned int cached_resolved_idx;


-- 
Thx and BRs,
Zhongqiu Han
