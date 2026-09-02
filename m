Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2005361974
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 04:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323407; cv=none; b=KUmuW9M6IH4Jz3uDhVtR0+RULaNdKRKoAy+zTZ9sDsOuGsGXyVfkCHFif/vnEq2tUYpuU2DQ7W/H9dDSR+S6YttB9z0FNACgDmt4DHnW2FI4uOER7e6SQWerpSzrDiKb+SDxns4tyEnMe2m6VPaRWslYP5HUeVo4gVb43kEEoWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323407; c=relaxed/simple;
	bh=mdgPcZlJL3HWscq7fjKdXipWCBSy4NPqNPPDd1WmTxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH6k1luP93l7/NmaQIY3XBm0olx9aSWlh9Jdgtl0e9Usl6gUgv74Kmv0VzFhFncoQZ9lxhBLr9o24ib+dQ6PhQLMtlgV5f/IV7u4jGLTpsvBcaJFIuWPBXWEPR39U5zlgxIqjuMhwAMexzHrNHOZPO7x6ExxS2zkrGmG+XghTyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kylzrvcP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kylzrvcP"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d9201076b3so6959605ad.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 21:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788323405; x=1788928205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=loEECbV+1/PD6+b04t7A4hFCdkNgi7Lwbp3peMcWJ+A=;
        b=kylzrvcPW8My5uGhAq8czS7VAOEfT8rkcQe94tAojm3tHSRNYNryv6HN4D3qIN+WWK
         w6Dnb8dUN35NtcaUQy350VObn+ygPV8wP5ug6Qawvk8SLLDrQovJdAvr6mslghmzitoP
         rt8iSVzjiWBakSYlLVSA+P0jMLGSzHYFquAvs60MR8LNb3Xspa8orIjnD4eNNrVwXz65
         Ze5oqM4LPHNL5iAWhb6kMSBrRWCsYr3qtiwnF1//7nX2ovn4rD6pWgJjatQC+kIMeCfb
         T7Oz2JeUucqB85AuTM2OVMJzRqWRT0IDnvoWgd+9wDQTyO8k6OAL1Kp557nikhFGJSEj
         NlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788323405; x=1788928205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=loEECbV+1/PD6+b04t7A4hFCdkNgi7Lwbp3peMcWJ+A=;
        b=j4IA8vwyUjLVEJ/htZXc5UECQMF7C8uQg9r5rWZ9RdI/vAnn2Z2UwUToKEKZuxNgZj
         BVGN94LBYK5jtZ85Llb9IwESZ8m/wRqP877lhGl5Rk9xKc3fURJh+c+Eq81jYCBF+VnC
         2HeaBhjqQL0wyuBFM+11yNQezfBjFEnNRU6xYX/iPeHFs+RL2v6P6ho0sQnQ8RSetM0y
         ohep3UrkqINJJy+RJJy2676zlAMIh9dGqvr2lwdnY79LeBWOoXBTjwNBd8GHGTodv18Y
         C413x6FT/yFTTUZ30wPcwxdzw/og70tU07gA9VW3hAmbq4irYTG4QE4I1I4YiTMqnGnk
         qvhg==
X-Forwarded-Encrypted: i=1; AKwUvByA0sXgprTm6yi/6kDOe3YmnCs1+Tg1XHPzSjpZcsZm2xWWjXpCVhpvgbcQ2sZVxG0nEwuo5YWdng==@vger.kernel.org
X-Gm-Message-State: AFuF++l0lK1BoSuBTCoCD/Wy8A+fnI+F8+frlCLSDmqJk24f1RHerk5q
	A4BKuZhb73VGvdu0UysESOmEo8pio1Lcj/TMt/YL/EuNkYnIdypvtFAOxIqgzCsOjSM=
X-Gm-Gg: AYBFou1k9lEGBKFJ8ucB6dADi5tPtiZh4Dejzwi9l1mzFk3lE9g8/LJ77c0AD6jEE5e
	UQUxeJwsMkY3TxOT3euE7xW+xCzdeqNK8B+ugElut9YQd9ZRMxwyzoKzQGV2ci5ZWG7SL/Bk+l8
	MlbmfLf+HQoF/+5foaWFFjzxpjOZTanisdPLmQ9ZFTbYj8xhbkvIn6xHn8r2qiTVpzYPnIub7X/
	WfLYsxiY52xNruGx+fVgqWhlZWhWN2KqBe5rwA296BzbW3YkXJt5pLpyvABIhKnGiZ6Wrcd5hfi
	KRNNFTRZ68q91nFxSgqbLpu41rbyIrHXb3Ap/qQaKvA2FaHNddSg+qQi0hanwtXk071C9QzD6W7
	6OfqV452cm1Kl/95DrHd2jNHjWMjl9luK97ufqewFEd5qA/P0w21hwWMHccB/pZWKaaC4YjIubv
	jgVfZHYIdKojw7i9hpVCwOX9BzvUwZbhUV8yjNTRM7YLiEDTNDdNtVT5iEmMkNngY=
X-Received: by 2002:a17:903:1aab:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2daf1b16445mr2465215ad.3.1788323404935;
        Tue, 01 Sep 2026 21:30:04 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079c6aa4sm2617066eec.5.2026.09.01.21.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:30:03 -0700 (PDT)
Date: Wed, 2 Sep 2026 10:00:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: zero-initialize policy cpumask before sysfs
 publication
Message-ID: <apemScUaVXUn8sR6@vireshk-B250M-D3H>
References: <20260901143635.4106960-1-zhongqiu.han@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901143635.4106960-1-zhongqiu.han@oss.qualcomm.com>

On 01-09-26, 22:36, Zhongqiu Han wrote:
> cpufreq_policy_alloc() allocates policy->cpus with alloc_cpumask_var(),
> i.e. without __GFP_ZERO, unlike the sibling related_cpus and real_cpus
> masks. With CONFIG_CPUMASK_OFFSTACK=y the mask is a separate
> kmalloc_node() allocation, so its bitmap holds whatever the slab allocator
> left behind:
> 
>   cpufreq_online()
>     cpufreq_policy_alloc()
>       alloc_cpumask_var(&policy->cpus)    /* bitmap is uninitialized */
>       kobject_init_and_add()              /* policy%u/ appears in sysfs */
>     cpufreq_policy_online()
>       cpumask_copy(policy->cpus, cpumask_of(cpu))  /* first valid value */
> 
> This leaves a window in which the sysfs attributes are already reachable
> while policy->cpus is still garbage. show()/store() gate on
> policy_is_inactive(), i.e. cpumask_empty(policy->cpus), so a non-zero
> bitmap makes them run the attribute callbacks on a policy that is not
> initialized yet.
> 
> Fix this by using zalloc_cpumask_var() for policy->cpus.
> 
> Fixes: 2fc3384dc75b ("cpufreq: Initialize policy->kobj while allocating policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
> This patch is based on https://lore.kernel.org/all/83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com/
> 
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0d0df986fa3d..3b1b2ed86cc3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1249,7 +1249,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  	if (!policy)
>  		return NULL;
>  
> -	if (!alloc_cpumask_var(&policy->cpus, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&policy->cpus, GFP_KERNEL))
>  		goto err_free_policy;
>  
>  	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
