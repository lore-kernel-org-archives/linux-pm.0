Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16EC3537E3
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421390; cv=none; b=OsJ2e2BOCYVFRUlQK6c/IW5b1fA5u+2mzVDV2RWDtjvgCL+Oqfl2XCxUnPbzDSVutCSGul1iQEE8KgG8+f9vXEiAnYsXtsBpTVVMOdje1WWzDrJdeJKUksz3k7G5kkR00gkbuebvSwiyPBuhmhgrhPjJ6+3axEkATybOZmgoE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421390; c=relaxed/simple;
	bh=gQyPpNJvbRk9I0968vGaQE2UpCdhfKRtGmcpP33d44o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSbkhUsKna7VfcZnp605INqeVG0MC9SJHDfmXGlLAe6sDrdmmHXU7eTTNJX9mtcYl7ysIUoA5aq/ytZ5VdfSBo7sFJvZIWhSamWI6Ppq865Y5O7ApUD8YDRA2Udx5Q6cCmqVCzdcjrWQjlhNsDAMz8sX0cc147sWMwchby20jiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jrR/BBEc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrR/BBEc"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82a893d289bso2353275b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774421389; x=1775026189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D1hOe4XO2tT8UrUusWV4Xm4SXbFrr/TdpZg49EfB2oE=;
        b=jrR/BBEcZQKTvJ1LmuLnIS+hEQqE1yB+MHryISX067CL0UMEA76Gkv2349tjcgqYFZ
         2OZfXLMSfbQ6tjsA501hq3J4SLZeMoPXxRC1ADR+VmmNaXXzEn9Y0hRFJqi0RKk3wmUy
         EJix6FuwBLLGiYWrf1vN7pMEclAynD/v0fLEO4fwsnUWI3ZkGjZo99sEdp6n04sRVLCl
         8TY5sigw3Av5UQfpE5io20wh0YB9Mg+LwZl9m9kG9nMCRqkrSOXqrPiSJoaJg5vBg4sm
         zALerw5sYhxhaEAVI2/robqdO/z7cTBJdN9AHkPYaReqe/gow1pO9DBlX2O7Jtlo5x0d
         9bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774421389; x=1775026189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1hOe4XO2tT8UrUusWV4Xm4SXbFrr/TdpZg49EfB2oE=;
        b=d4zTdpl7gAb1qfyWGDjOaeZpClrykJ7a92k9OSRItc1FlFlrUX7fM+pz1MwvKi1Fl4
         S1MmDwjzeJDOsPGenZZ7ONDd8t4+OR/O1zXwrilQHrI8TgqmbZFZXUFojzCh4fmcV//s
         9ziUUuwmWeSUhy+4E8c0ZilbvrfHsVQccQBAlc00Rb4GS5DO+OndRmdhK0VYCdl0oc+R
         1lf3Ev1HeLf42d5cygWNDfu2W/WmRsHh530sGxsMfv1n3Q63/Ov7P1QPrm6OIomlVWAr
         A/OrfZglqgFsdqAwvaCnduDXGRmF+OCyTLsDC1uVl8tULCA66oQA8y4Zf1ycinSbe2tq
         T69g==
X-Forwarded-Encrypted: i=1; AJvYcCUF0klN/8BNB0b0YQnzbvPbRhI6ubqnak7y8NDwue50pgOX8+w8qq1hfktGDm9lvfc0+r561OmGtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZEdiIbiRL2ckvrc1e56Y4CkBH4Iy3Ihj7oT6RpIrLxEnOfFXg
	XyZU9aL8BQDqxCjHfF2gMHG/EjmZOaNOnV0iQixhYTR6vnSZ/JhDrUIyses2iQOQGLU=
X-Gm-Gg: ATEYQzzazxBCzgfAt8+O9AiuLfCwLvlRmVn0IqwTmtDANJ1ZEiT5U9uF63Gf7qCsvsL
	+EHPhD/g4QQa2qS6sr6/m9oV9K5sbLYyNmMoG3efvJDKT0V5jcseex1wTm96GrQytCFP2vy+6Nz
	hjg0etbPmREo0ssoYGd8OVn8fXWMg5kotJ8nCV9Mpmcq2no96OtdGr7jpCCdU4ZqJnKgPQ5Ld6e
	5QSNDVwKh2JqScxe/3dHYbKCE5d/pt8GfogmF9wgrYTq3o2yRvp4+umPygdh6O57FITm/0epLAm
	s/8o6otfD7OA2zjsadtWg62Y9UyusHve1Y4eMv1y83WmFVRh8CIjjpaUXp42G9xXUpPe/SOugHH
	6kE1Jw8yqLFrfEuaWU9XU8E09W7vPXbSW68a5yZ0OxuJ6VcHJwaj8Lf6pqHW0yb+F7htSNn/b35
	S0vhGzC5QJ9INTGwDFnVteaNiC
X-Received: by 2002:a05:6a00:27a8:b0:82a:7893:e14b with SMTP id d2e1a72fcca58-82c6dfa60a0mr2414936b3a.38.1774421388819;
        Tue, 24 Mar 2026 23:49:48 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa960csm18031245b3a.12.2026.03.24.23.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 23:49:48 -0700 (PDT)
Date: Wed, 25 Mar 2026 12:19:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 3/4] cpufreq: Set policy->min and max as real QoS
 constraints
Message-ID: <ir3mvkz7bbzwtsydrfdhnkkkseaj6fclzgiw3soxb673xvhczk@fukk5ad7jrtq>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-4-pierre.gondois@arm.com>
 <ukxdxr3xv7x6pqnwwafxgvhvfh5n7w67y3zwunhnk7b45tz3t6@d6ehl4vqac6t>
 <ab06e8d6-d430-483b-a2a4-9e7d197aa6b6@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab06e8d6-d430-483b-a2a4-9e7d197aa6b6@arm.com>

On 24-03-26, 12:40, Pierre Gondois wrote:
> Being able to set the min/max_freq_req from the driver might be
> something that is needed, cf:
> https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/
> 
> It would also allow to have a common way to set policy->min/max values
> as they are set to the the cpuinfo.min/max_freq.
> 
> On the other hand I agree that I didn't test all the possible paths
> for this change, so this is a bit audacious.
> 
> 
> What about adding the following to have the values set for all drivers:
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> 
> index 70814c567243b..3a1e5f58a301f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1530,6 +1530,9 @@ static int cpufreq_policy_online(struct cpufreq_policy
> *policy,
>                                 CPUFREQ_CREATE_POLICY, policy);
>         }
> 
> +       policy->max = policy->cpuinfo.max_freq;
> +       policy->min = policy->cpuinfo.min_freq;
> +
>         if (cpufreq_driver->get && has_target()) {
>                 policy->cur = cpufreq_driver->get(policy->cpu);
>                 if (!policy->cur) {

I am okay with a separate series doing all these cleanups. We can set some sort
of rule on what is expected from the driver here and what is left from the core.
For example driver only sets cpuinfo.max/min and core takes care of rest. This
series would cleanup all the drivers, etc.

-- 
viresh
