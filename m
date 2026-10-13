Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED53B42FC
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890799; cv=none; b=NnCJyQomVATpla1v3IurH5kE7CRyHDF3qg84QIARTH3L36YXn6IkjOeGr+j10xOZZ8p8dUj5M4fNBfyPkB9Ix/O6ITANRQZfe5nRJNrCPUtXIjgYs03tTjJh5js6OwSrdMcCpl6s+n6lyvc251mE53MGvEGiZ0OLKlHL+lbVFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890799; c=relaxed/simple;
	bh=f30R+NPZIgKRdOpL7rg6rJZt4SiA4r4YoLdU7gMcN0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Umb/kzwjvq/B7yBgzAeWy8Q1Tfr9PKd9wKGw+dNy1yv7SAgol07zoHOLWFWOr2bl9cl3yWPSp+Yxjw3Rsi30Dw9mwQ5lWyeYcBjSPgR3jzOKndnSdBe4ohyBck46chbuEC8eYnoxkb+Yr1WF7zqatZKE0Ku2UECMjBmZaPCeLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MOWoDuG+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=erPfkcZi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MOWoDuG+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="erPfkcZi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D6ZUXF3210078
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 11:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+sRwej529jiGXn/urVBwYwVr
	RTLegOaro2P5M15s5TE=; b=MOWoDuG+5//WdChuKmGiNL+kgHFLG4q3Z0aOY8Ui
	ADY0AEYhZSZ2MqVUcwomzp0lMsifM7iHJk3nQ7wucOla77nThGbQMIZmfKBt4IN7
	chIpo3VS+FhDYXGd7v41j18HlPSJZeAVrlczs9RKJjk5rEw6yZpziFhKK8vZuOU3
	dsKIm8oIHXWWMA4cg8Ge1pfcg/Fjg4AnQqoW6JlCsGYDyIn++BenkElm6wp+M80P
	P34rwOcr2UvQdbqGPLZ4eYYvVmBd30iQ6hPc2weK6fF2QKuZ0Ir9HbxFVmNdLJk9
	oSpdJtT7p51RgZzj8s/cZc5o/fvRqTjwl/c4TVraKgL7TA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9fgjh6pe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 11:26:37 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-143826c4a13so1774532c88.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791890797; x=1792495597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+sRwej529jiGXn/urVBwYwVrRTLegOaro2P5M15s5TE=;
        b=erPfkcZi8yg5Aj5KHUvu6sPz2/n+hS4SXwqB3xACEw+VSTe9IkK/I83ZJQLR3ueeGC
         dMJpBKs6qkkiSEM0X+ePKq7WMAhAxLES7e9CmD3O6LDoSHOpGbvRFpZIIRNk4oSd3pH/
         oNEJpk4x5R9a3yg1n9O7ISSoU1bfDM/s4HyPT8yAui31DtNSdLP72IucAmdt72Obtzt3
         tQSD3ouF1SxFo5QnSUOAGQhy8jwicNrzIXXmEVY2k9r0rDFfnV4L+GeaoE4530HzzcAC
         TJGVG/Q5R2FFxHYGm4Nq7S/VvBlU0VbOPsBDggCC+CK/0q8e4t56GWos1hR+6M2C6Id5
         LAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890797; x=1792495597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+sRwej529jiGXn/urVBwYwVrRTLegOaro2P5M15s5TE=;
        b=s0pZgrglH6E4x1bjY2ZwMgv/6Cfaask6d3Uy4de54m3dbGSzBer8La0RZ0+7Qy8FGO
         1h5DQBfa6oYeGBNvly8oQTTvY2PxYNY+3UNrHBVbfQK0lFbr80T+KdeqL7v49FzE7Z0n
         qlZIg8L+Q6k7p5Ao2dP2ZH8ZHGx9bwc84aA3wHN8rHVtfszTiSgioFPlFD1gODigZFwn
         ESeXsJcnbee1BtU1fbm8IcubuVarKXd79+GjaE4zEJsAuxGYHC3yGnltHF3udHh8qzCv
         UdCwTlkw/OxqJgwnCPLDpQUQsRlm4PA6CW4IaUKhvgjKCiFX5nVcTT6mzNicuEtKHoEN
         bJkA==
X-Forwarded-Encrypted: i=1; AKwUvBztb+7qzB6xYjlZHJlCX6ZZ1acOZMWV+MyvGzHMYt2uFuiAmmkPuCkcFA+6IgZNfIQBSLQs/dhHDg==@vger.kernel.org
X-Gm-Message-State: AFq9FYILXyHb4SKZDnzf9AbRHuphZ/GQ2fWW1vMnuMcLinmr3nqujJbk
	HrrAkJ4O+Oo0Pu6MuR1lUKzdwQkO+hRpuFvdlfUpnJ1si1sSbFxmNmXoeFKhGh1FgEJjUmCmEcd
	mUr6T2A3iWwHd/mulIMu7DhC+HgyLcopXb9lOj32Fv8TWfj3zxfXDfVsDZs3Tvg==
X-Gm-Gg: AYBFou1I6R++kZKYHnw2sod9MJVALTwmi9+Rah+5sYPdmXwOat1OTQt2cCDp6jL1fGQ
	VQuo8j2+6GMSaztPmQYXByzWcf8FOrwJ1Jal6FZKKcWA0Z9RZBZnEEB8YoXjBL0yT+Ws2oU6/La
	8T6Y6D7QHq/zSxaDTpZFgcXdIHuFt1eXDVpNCodugGSzA43k3lywD22N9YiJahN/8PxIQuKXUtu
	qG3xZDAFVE1pkeAIkTmsjSDRCaX1BMTR4HHG4liKP+KaxBpWrbZxKVEdEFScDeAp+zVE7IB2veU
	MulPr0Y551AqrfiHyclSeDChqLw6P778VhJLPyWrksZCO74heT8aulOVWLgPuxcK4dUUwBZH+eh
	JszUbTuS5cUfuw7r0n2vtwoGN+G3PCzcSPNT5HahFAHo3LYrB4F2o65Znu1WDwtRxL7HvyT7wjn
	k9QKviyovs3samWm88Mw==
X-Received: by 2002:a05:7022:e884:b0:14f:b80a:33a5 with SMTP id a92af1059eb24-16a5d35f1cdmr24644762c88.28.1791890796512;
        Tue, 13 Oct 2026 04:26:36 -0700 (PDT)
X-Received: by 2002:a05:7022:e884:b0:14f:b80a:33a5 with SMTP id a92af1059eb24-16a5d35f1cdmr24644718c88.28.1791890795729;
        Tue, 13 Oct 2026 04:26:35 -0700 (PDT)
Received: from hu-nirjroy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1698de65af7sm41863099c88.0.2026.10.13.04.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:26:35 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:56:27 +0530
From: Nirjhar Roy <nirjhar.roy@oss.qualcomm.com>
To: Hui Su <sh_def@163.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: schedutil: Serialize start against rate
 limit updates
Message-ID: <as4VY4F4VuAQmr1c@hu-nirjroy-blr.qualcomm.com>
References: <20261007155820.3194105-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007155820.3194105-1-sh_def@163.com>
X-Proofpoint-GUID: qPInwX9DrpLmCoDO7v8NYa8XFcZX54o4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NSBTYWx0ZWRfX6QLPkjlDg0TX
 T252VJsvkTRU1c0SYitlZhjGH09Wj3HpcJzjfZajYWzIOq3x2t+mrLxd0kd2+MrmnZuKe80OT93
 sziq9hhYwV7Wyhm0fiTTcNqXRUpNMNbfKCY+unj7e5Bg1vjewdoKZc9L07gCAGhNLQcOUXac1A3
 wV2hQenefwGyL2TgR8pES6pSMNoZa1Wqw8Ww2DeAUHhwY9PXHC6/pDDGbqQKgI8F4DWKkweAjuY
 zn59Tl73mrD84lS/XbdYeOfO/FEegOES98EU9yimNwpacDtnTtiPwC2sUiOlFmAyI808K6lkx0I
 foy0zi0jv0PoM8ZfSnv7tbBYNKZ4Gb3ohpcccU+ecnVQsIP6huu8Yi5i2hqkDzNZsvItB8s38A1
 WRY8gETR0D+lpTscOGMjf0Sbk9uEyAKa6D3qPdvC5OVRNMl9yGutHs1m4DNBCssF+todPtInxVX
 O01EWblQTIzeaYe+piw==
X-Proofpoint-ORIG-GUID: qPInwX9DrpLmCoDO7v8NYa8XFcZX54o4
X-Authority-Analysis: v=2.4 cv=PedqFShd c=1 sm=1 tr=0 ts=6ace156d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=Gmc05hTQ9VndzER7qmEA:9
 a=CjuIK1q_8ugA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NSBTYWx0ZWRfX8oRgWQGdlb0Y
 M93QF8lkM7YnJmfH45/SVHeHEULxFiL+WeSFZVcvM+wSAnlvfof4FWhw1AwXTpDS/gKVJbsgmRK
 QIOBRpVpkgkIj/Z7xnJaZRDx1kq5BQw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130045

On Thu, Oct 08, 2026 at 12:58:20AM +0900, Hui Su wrote:
> rate_limit_us_store() is called with the governor attribute set
> update_lock held, but sugov_start() updates freq_update_delay_ns from
> the same tunable without taking that lock.
> 
> This allows the two paths to interleave as follows:
> 
>         sugov_start()             rate_limit_us_store()
> 
>         read old rate_limit_us
>                                   write new rate_limit_us
>                                   publish the new delay
>         publish the old delay
> 
> The sysfs tunable then contains the new value while
> freq_update_delay_ns contains the old one. Unlike a transient torn
> read, the stale delay remains in effect until another rate limit update
> or governor restart.
> 
> Serialize sugov_start() against sysfs stores by taking the existing
> governor attribute set lock around sugov_update_rate_limit_us(). Use
> gov_attr_set_lock() and gov_attr_set_unlock() to keep locking details
> within the attribute set interface. This keeps the fix off the scheduler
> hot path.
> 
> Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler utilization data")
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
> Changes in v2:
> - Wrap governor attribute set locking in helpers as suggested by
>   Zhongqiu Han.
> 
> v1: https://lore.kernel.org/lkml/20260929103635.3780346-1-sh_def@163.com/
> 
>  include/linux/cpufreq.h          | 10 ++++++++++
>  kernel/sched/cpufreq_schedutil.c |  4 ++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 35ce665edfd8..5448eb0a0885 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -694,6 +694,16 @@ static inline struct gov_attr_set *to_gov_attr_set(struct kobject *kobj)
>  	return container_of(kobj, struct gov_attr_set, kobj);
>  }
>  
> +static inline void gov_attr_set_lock(struct gov_attr_set *attr_set)
> +{
> +	mutex_lock(&attr_set->update_lock);
> +}
> +
> +static inline void gov_attr_set_unlock(struct gov_attr_set *attr_set)
> +{
> +	mutex_unlock(&attr_set->update_lock);
> +}
> +

Can use the above wrappers in governor_store()? Right now it directly calls mutex_{lock, unlock}(&attr_set->update_lock) ?
--NR
 

>  void gov_attr_set_init(struct gov_attr_set *attr_set, struct list_head *list_node);
>  void gov_attr_set_get(struct gov_attr_set *attr_set, struct list_head *list_node);
>  unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list_head *list_node);
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 49ccd6f1c185..b847311c307d 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -861,7 +861,11 @@ static int sugov_start(struct cpufreq_policy *policy)
>  	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
>  	unsigned int cpu;
>  
> +	/* Serialize against rate_limit_us_store(). */
> +	gov_attr_set_lock(&sg_policy->tunables->attr_set);
>  	sugov_update_rate_limit_us(sg_policy);
> +	gov_attr_set_unlock(&sg_policy->tunables->attr_set);
> +
>  	sg_policy->last_freq_update_time	= 0;
>  	sg_policy->next_freq			= 0;
>  	sg_policy->work_in_progress		= false;
> 
> base-commit: 63de2367f6d280904a9c5e5bbc7c75bb91c5b3d8
> 
