Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32039F172
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428627; cv=none; b=MDQsc92QBNqOF/jjYsyn3k47PXd6YLBvPMrDD4SMeMTc1oAudIX1/7dEbllSk3JLS+ZMo56Lpzd/BhBQdaeVbdULH9MARye53JlbTUCirTUG1OHWzIGqXWZCJupkhxyQ82vJoLvO5iSflS6dS6P0sK3LTu5tNWj4VN3Byhki7cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428627; c=relaxed/simple;
	bh=Q7K1F3np4WJv4oG/sTNlQkMLHtgmoG8J9W9dCcnSGYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuajDG3aivhvFhgMCLr/8aASq+P4CuJC/ADX/xOt2eSG5fWtRSQIk6k6/itDtf8pVdt9igdfCpqxZ/ceJURlmIWI0kKmHxnjn/0uneZLAxL0jm9MCgS+iF0oPgIJ7ba8uAAJPUlIucve2HF6ysPmRjIuj+cX1zRBCnN2qsdNo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NwbFH4Lz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwbFH4Lz"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-83f674f978fso2427905b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 22:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779428623; x=1780033423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dA9bLoOSaD6AuZlc4efO47Bjrc+kVVqleEY+CSgNcvY=;
        b=NwbFH4LzXN4K6y2i9I+adSodvqtHCJv/u7tVQeQoouliz85gfsjpaZOTyjdF2JZhxF
         EeaBFWdqNgoW3CTRmmfm/88HQVIxw+hWXcLCdTeRhRmnLYXgpCOSGVH0WvSRUW7ZnNGX
         fZFFnsAiouUCzhJAbYZD0nedPx/M8prb5NNhd85btVJHn3VQ4jb+kzzexYHU+qQas8+E
         2mEKqEtnH1G3X0ywyWs24FLSw/HD6e1JdtoRYVXzTx954NP3AYPTD9mfNuCyN0AEGBhR
         cuiXSIL98zrnWucMBEBouFOUC18jaWGzj4TrrjmalyCnR5pp2E/SpwWWLjFaz+BHelko
         8SBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779428623; x=1780033423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA9bLoOSaD6AuZlc4efO47Bjrc+kVVqleEY+CSgNcvY=;
        b=gXudER/BF/MSGf2V7k1L+jf2x+9PN2lwIy1oybk9WSnm0wQ+3DWGl+MFxh3IQ1S0Vt
         ffww51ksNtAG+9TJjOCIPTIBN1+rJLh808NknuiR911p125VIfztdL/9HvFgRjKHfpDd
         OZZc1LPR3djGYC7aj7TJePNI5B2+JBwfeJnUR9+4B3ksZ9AYbbj1empNX/CmGv+oRq+2
         m9Vwfe6GQtRNFRXJ083c5zzAukfcVVMhcLpIbcGk1gwTSgo+bHK7Nfy/zBoFYQsvy8Lc
         zzW+YkN104L9r5rOg4pPq9Ju8cB2MaKje99fxJJaN7gRXy404UNiTyKvlJJeTtcuyx1l
         QESg==
X-Forwarded-Encrypted: i=1; AFNElJ82popthMDjDPVthrFDiYDRUBrs8Ia2KK6o8/iMg6Vxsdx6qhaYmAImRWVZXTS64+bQXqphPJNZKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjrn1zXrmnxhkBi+Q9rh1Gka8WVh0PP9N8qBE8Bd3VNVq1sBt+
	ut8fwRFTINVPPU8WWCdIgwYus8sZRm/gFf37Q5UCD4eM+DYEDts/sZuYkZaAYOBQWN8=
X-Gm-Gg: Acq92OGSt1CvIy06852gNq77MKDz5HLsCGZh2Ecqtc6/zHVLRCftYA71W7jU086n5q+
	hmMEs1FgwCMJQX7a8DYOvpk3te6rCTtqW/Xvab1fjexRq8KQU7W8ulghq0wGi6X2NH26o6CWi3+
	ly8ZKVMb37mH0J9P+lPaXslWxp8c+mlwOxsCukzLsLeB3GGBqcR0nGa+R8+duFey8mB9X3DPWY+
	W9e320Ds+A6xpyLWzgkVgmwQpOgVkrfYB4WzIxPPaQ6RiJwK39RfaCUMvLPE9FcuMVG5L/MwiMp
	d/B0A68OtlhjWykWYbn9qHPjyCfjfBdMbSl2+bPVtNlXRig64ZvikI+FmS1UE/aCijaaZYLzduB
	8TuymyAslP4P+2lpvDHzrbBCugQKzPMw7wv+Y1d4U3jbPU4QU0QUYmyvZVNz52aDwmJ9EbtkWIa
	YnmBIbb5kyn+DDqFa40AwaZPQ=
X-Received: by 2002:a05:6a00:1412:b0:81e:ef16:b288 with SMTP id d2e1a72fcca58-8415f37d836mr2434622b3a.22.1779428623390;
        Thu, 21 May 2026 22:43:43 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164afe343sm659817b3a.20.2026.05.21.22.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 22:43:42 -0700 (PDT)
Date: Fri, 22 May 2026 11:13:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/4] cpufreq: Set default policy->min/max values for
 all drivers
Message-ID: <5jmfuo7wi4zqz3cv3voeheq6jm4xaxkwrnsprpjwewtk6v6qjs@vea3o4u7cyl4>
References: <20260511135538.522653-1-pierre.gondois@arm.com>
 <20260511135538.522653-3-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511135538.522653-3-pierre.gondois@arm.com>

On 11-05-26, 15:55, Pierre Gondois wrote:
> Some drivers set policy->min/max in their .init() callback.
> cpufreq_set_policy() will ultimately override them through:
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>   \-cpufreq_set_policy()
>     \-/* Set policy->min/max */
> Thus the policy min/max values provided are only temporary.
> 
> There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
> cpufreq_policy_online()
> \-__cpufreq_driver_target()
>   \-cpufreq_driver->target()
> 
> To prepare for a following patch that will remove all
> policy->min/max initialization in the driver .init() callback
> if the min/max value is equal to the cpuinfo.min/max_freq,
> set a default policy->min/max value for all drivers.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 034603c2af325..9e2d9d3fc5351 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1401,6 +1401,13 @@ static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>  {
>  	int ret;
>  
> +	/*
> +	 * If the driver didn't set policy->min/max, set them as
> +	 * they are used to clamp frequency requests.
> +	 */
> +	policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
> +	policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;
> +

This has nothing to do with qos-init, we should do it along with:

        cpumask_copy(policy->related_cpus, policy->cpus);

in cpufreq_policy_online().

-- 
viresh
