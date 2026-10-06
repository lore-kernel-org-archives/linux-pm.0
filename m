Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036FF3BADBC
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274980; cv=none; b=ATb4Hh26IEcHeM2GNqXLdQwsrLQC5iLl3tN//t6IouK8wqr9Ywvtp4zjrBERyUj+7Om1eeGzYreZtmaQWMacoSG9XgjuKQFYYSb2R7jArfkRbstY9zSSgB3tr/3aA2BEhHrXH2WmSJGUgmpzsYedH4Ur3EV+hGdmT4iDzfCWqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274980; c=relaxed/simple;
	bh=ZIjNAmXtHmu4yN5iNA/Dw9g2gQ4eUYJ4OJCKIskmRoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J16wIQnTwLf2umiO4WJSi85mXEOD9I4cHUZ0K3Q9m39CpUvCzjteBfe9j5pTKk/7kXhUR223PwYOiTpS7sOAxBXYZqKoiSemGSF0X3drhhmkqnfbDLdWS+yF9XKFktndPQaFF3h6tH4hTfGCkTYuLeuxQpOe/ZPw2TwADt/emHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xo7E3WU4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eauhiq8Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xo7E3WU4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eauhiq8Q"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966eC5n2834124
	for <linux-pm@vger.kernel.org>; Tue, 6 Oct 2026 08:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V4CxaEk1X/vxfIRRtAsFl33lTcdSoULtVCTw5xYmesg=; b=Xo7E3WU4WuuuakRK
	TICHn4V55wQUPUsbBQdIGvKeHmy5h7FTEB5Dt2PdD0rck0qgcRNXDEvfoZIFJC9h
	eZ/H+1HuDlqquGC0lSQ3CFCW1N/NFrQYf83vFlJ8sSUTxenpLST76/oxbgJV0r6d
	ijsejg1BYyYppDRbjTNNUa0NWGmMxe+iR9mP4/JSSlLoPgU95NkIM6sOZJYOEaN+
	QSX3zePSgGzRfSBCMomIG0zx8Z+9zeICybuLoB658dB/f69dllA3qjFLRFwKl5RE
	9lG4cmFaxHvKi2RHsGUPJwDep5TwM+tGyqZ7THR45N/xVHZlPi4+8kkgLEB1hrzq
	HR2a7Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4dnckkvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 08:22:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a813204f87so1491160a91.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791274977; x=1791879777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4CxaEk1X/vxfIRRtAsFl33lTcdSoULtVCTw5xYmesg=;
        b=eauhiq8QnQlmzl5zW4cdGzUvckz4AFS7WAPIrEe64Zsa0vKmsOxTuIS6D/q3+Y+eiu
         yRnbKjqv9NVj+cCr0Blw2vF/VdcqP3M9yK+AVfmkG5e2NX1w6ACD23xvZAzOp5ENtgfm
         TBAxSmUc7Vl9i5uXs7YsJ/2PMj25AcEpFneAIa06uIqZIYWYsTf2fjwaKCnRtQpJdOwa
         rbZq3R0zprfbE/wthKGlZuYGflv3zReZLNy4sK8AlmsXG0H9CTe2GkE0Ffki34sM/8ct
         0f0hj1C32dWikrm79dVC+C2l8e2doLFk2G3uhRgzI9yBaiKsG5gkgDjStrcYaI368kRM
         VKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791274977; x=1791879777;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V4CxaEk1X/vxfIRRtAsFl33lTcdSoULtVCTw5xYmesg=;
        b=sruMzelX8lYe9koz+DafCOe/y1r5L8clVh1GkgMZ+wLZq29f0OpsSj2sx0H12BqkWz
         u+sah+oxhabv3szJO5eNn7PUEbVr0vcuzoh8jUGBX8/ATWRE5HxcQNT+CoA4Cu86U2T0
         nujARybVDFs9BsNeteqYWOCbeOJQ4D/eZI0YRg01JGO+sZV/Aq6bSZ/yNZ3cTrfYkDFl
         H/GqX1NFMTYLZKi8G5tqzuYwPSVi7+bcBDwWslMs3tDoxvCrfsmFVAvD9F+2SyV7Yb5W
         Eyxh4jACPDcdzM1aKCCVq8LiDHtCHKgWZixv0Rq51KJPZzK3XvV7Ze7fkmoCjrpyLYOt
         /j8A==
X-Forwarded-Encrypted: i=1; AKwUvBzB+pP4VvwrxM+8oBVn36TbLhO1iAB7p0hLN2PRKyMgXON2nDpgjYdtqHwBLLwQmSTjwwUfiLR8Tw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJvJOmP0O9fVWmmJC/p+uau2TB2oDZTWakf4y7JOQDRmUXHyzwy
	mIi6CAtrIG+kK12LaVL+c8/gSiionvqsXeE8c6BlkGroPPJCKpqjNFGUyjVKd2eZ8Sy4JpfW/7M
	/1ubmOJusxifkEa3hJ4UBA+tcX93l/esIYd48/DTLgOGOVtydU2aSFd3gbChQTA==
X-Gm-Gg: AYBFou0+FaCpf9xdR7YF3iF91QXipCit95k1C2MmrtoBNl8/T9c/pIghg1YoBaa9t/6
	k8Huzp9ygDIIrQEYeVQwMGcKB3FdA7aMSUDkrELl7eijo1YVP8JNbKe/phuot026JwP96JAbf57
	FRvSbTV3TomGBveel/uLqujt6KEmRkXpe98LD3W4dmo/jcoAS/J7BIyyD91Lia3iu7ZZKlcQ3A0
	KEWiOKtV2SHHELjeO8iWVStWWg1bNbu72xiN77MvPaheghDEd5q/TpVMdGICY6gcD8tU+30OuSk
	DaM5JeEuP4RWP25rsbfwtpd0m1e5tf+SAQ9PRIr1mNEnItQ5xIDMGp62rOzwm5naTuiAS+6gmeO
	1qoCIDBtaUXAtNZ2sEOYTUlGW2qmKXEbF7qVVO+c7YvNatnG9hBrue6MllKLKtPF6iX8Jtmmv
X-Received: by 2002:a17:90b:3810:b0:3a5:25e:85fc with SMTP id 98e67ed59e1d1-3a873750b3cmr493699a91.63.1791274977370;
        Tue, 06 Oct 2026 01:22:57 -0700 (PDT)
X-Received: by 2002:a17:90b:3810:b0:3a5:25e:85fc with SMTP id 98e67ed59e1d1-3a873750b3cmr493674a91.63.1791274976695;
        Tue, 06 Oct 2026 01:22:56 -0700 (PDT)
Received: from [10.133.33.116] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853c88aa7sm3667676a91.5.2026.10.06.01.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 01:22:56 -0700 (PDT)
Message-ID: <c2d93d95-e623-4910-8d92-b3e16738703c@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 16:22:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: schedutil: Serialize start against rate limit
 updates
To: Hui Su <sh_def@163.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260929103635.3780346-1-sh_def@163.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260929103635.3780346-1-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzMyBTYWx0ZWRfX0tFNv6vkJ2Qs
 qMsnGcVHef+xZRxeAsl8nljG/k+VWxZlLBBYBpKA44eUzjP3BWKBqfqUvSwcmdIvUbhtraz7uPR
 y+l1xCaufyw8VsvimRouBkTmEMTxbqs=
X-Authority-Analysis: v=2.4 cv=Vdxir1p9 c=1 sm=1 tr=0 ts=6ac4afe2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=WbzL4V9Atknj4SyEsUoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: kt2ODCGEKH_1tjryLxQi0q3RaO-TJO1e
X-Proofpoint-ORIG-GUID: kt2ODCGEKH_1tjryLxQi0q3RaO-TJO1e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzMyBTYWx0ZWRfX8m8EMAqyvJ+j
 DFQCM+XdPtIiaj6oYukdDPb8CsHjgjA1UIDxXbLsFveRGkpDo8GVMl/iEEcSJ/1oRv9L6ARQzSQ
 JIAkOSDB5jb59J+bhSruXc2xjcN8Ago5TRLcqNxEK4cUDztkQC6MLTrzTmQlXU7xissvmKC4Y5d
 7JyGzgFzvyS3k229GGE17M9t+rzZqOCpToy4fKnPPmkSNratYRaPZP9+7vrG4S8PYx9K3MK1ix5
 AnQ/nzyhLR8UvSbtPhSFhZSpKiAXps620b1zfuAYjfCq12qnbZho8MtqQEmj3DPwOX6y2rBC2tU
 uWOlzwPb/izEpU03B1d1ENCa+dMLngEOtnHglBU2+YEPgmtDNaMS2VHenyQaAPdgq8kqYoM1zDt
 zNl7fpXmvObEw6vftDwgSLiOKRhG2WBscRT8FPT2edmHaFCRLHrnOQVQO0Ke8mCBdkGtX1GPexq
 dBY2DoF978Qws/6O2hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060033

On 9/29/2026 6:36 PM, Hui Su wrote:
> rate_limit_us_store() is called with the governor attribute set
> update_lock held, but sugov_start() updates freq_update_delay_ns from
> the same tunable without taking that lock.
> 
> This allows the two paths to interleave as follows:
> 
>          sugov_start()             rate_limit_us_store()
> 
>          read old rate_limit_us
>                                    write new rate_limit_us
>                                    publish the new delay
>          publish the old delay
> 
> The sysfs tunable then contains the new value while
> freq_update_delay_ns contains the old one. Unlike a transient torn
> read, the stale delay remains in effect until another rate limit update
> or governor restart.
> 
> Serialize sugov_start() against sysfs stores by taking the existing
> governor attribute set update_lock around sugov_update_rate_limit_us().
> This keeps the fix off the scheduler hot path.
> 
> Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler utilization data")

The Fixes tag is accurate, but the patch cannot be cleanly backported
because the code has since been refactored.

> Signed-off-by: Hui Su <sh_def@163.com>

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> ---
> kernel/sched/cpufreq_schedutil.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 49ccd6f1c185..e759f09be638 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -861,7 +861,11 @@ static int sugov_start(struct cpufreq_policy *policy)
>   	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
>   	unsigned int cpu;
>   
> +	/* Serialize against rate_limit_us_store(), which holds this lock. */
> +	mutex_lock(&sg_policy->tunables->attr_set.update_lock);

Nit: Better to wrap this in a helper, e.g.gov_attr_set_lock().

Besides, When I started reviewing this patch, I initially considered
removing the freq_update_delay_ns cache for a lockless design. However,
since it is on a hot path, doing the multiplication every time could
hurt performance.

>   	sugov_update_rate_limit_us(sg_policy);
> +	mutex_unlock(&sg_policy->tunables->attr_set.update_lock);
> +
>   	sg_policy->last_freq_update_time	= 0;
>   	sg_policy->next_freq			= 0;
>   	sg_policy->work_in_progress		= false;
> 
> base-commit: 63de2367f6d280904a9c5e5bbc7c75bb91c5b3d8
> 


-- 
Thx and BRs,
Zhongqiu Han
