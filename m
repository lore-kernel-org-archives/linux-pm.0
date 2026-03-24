Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006236DA16
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316513; cv=none; b=CT96+EuP5l7yIsV38EWFuPY9abYgQHqyKPqlYE6nuawhhpBSFOO3C7DjL/aLd90cQOlHoeZCjRhJRbfBGIA/JrNwRCj8goTyW7h+P0aqMOwMrWaRTO3h7X5OiEBmuq92Q0LXuDLl65Lhcj6b/6IAca23z9Tk+/2+0qTjv/uOkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316513; c=relaxed/simple;
	bh=9GCpuOhlhywup5UjYUryHHnSOF6QJWTZwxUDm9hGkBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/Om/NtN3jOXn1CJJHtAdhobHghJ6FDq0NeZ/NcjgEy+00hCrz7UGdUNcV2o3oZcTEdoj52H6+FZWW1sDjbro9vzwjj68isX6r3nXvmQDIuNq9xAYZJjODt5Hr7JTryYnRXU+Aedj24EPrVk5+dJrk/p2nnaRRst0lemB1ONR3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=z/JlESKr; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="z/JlESKr"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so4959715e9.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 18:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1774316510; x=1774921310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yqAyV4uroGqQlZ4QfVT1TrVG+gnKcCJGc9bJfbkq9D0=;
        b=z/JlESKr1adVX+qIP7w8HLoM6XLDG+XUr5EyLTx9sCzKhgfmxP/TVKgKQsFQ9y1nk2
         vTSFEzZAOgg7AeGTv5a7v2V5CmegSbJ25IupkAPUwEy1gbD4I7lEjxSzxpvI1zbRQBO+
         D/REBEIT4iW1QROD1+muTc/wEQQ+vh8qEE8fUAOMxkdsEDoAvSpj49cxQp+sbXCqPsch
         kkIoFPXC/uwOcIab//mm+lw90ErTJCS0LibVmVC/v8UB0pKs0dMc9uTMvUNHiUHtlAj/
         SU4pkRvgaEAm6Jol8G3wYAiIQ9pTmcUJhWB+WaxYPgAGHglU7mSIbTtIsQS1euXHMjgy
         1Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316510; x=1774921310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqAyV4uroGqQlZ4QfVT1TrVG+gnKcCJGc9bJfbkq9D0=;
        b=QGwz+JPhMebotk1Jm6+6SW7HCh/sImztlX9CQR8qpb+NpHOXHzaftG9ydBC8Vn09BK
         gePYSaDzhT2thLPvU/g1ZQzYIQ6UPtwymNcxE1bAgDJZ6aUH3s4Ey2UFdm8d57chqiCH
         9HjhmcErTMXWtDunTK8muRBvg28XYSw9Isg//Xu2b/OSbIPdl7Ysws6FPy8ZUYgGQeB4
         Gt9O78V7B5pMZxUuxG5xwXsIwuFVN+tKrmzudSHINunssWEdVjvVx6JHX6SIsMG2U4l6
         UqNnxbsft2G1b0+J68ihrgfqBASUAoanpCyupWIiYpPJHxRrIjn8ocgg4js8QBJIczb3
         03Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUVwLh+icLotXHSs4BzEOUo+jPcMLsQbtJGZZZaYJMCNzAKuD4Dt9ygBzUIiwzhXGSpwUrQ1348Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9jn8lRPyBwdELsUP1pGnn5//K1uPXWBfTkSGLk8pMeDDcKxnD
	2c54xuS0sC9FbfO2gx19ghqyq7zGVmF3I/IhWrUrWRQgBHtJWIhw5Vwy7GrJwmiJWEA=
X-Gm-Gg: ATEYQzy6ATKeRhlRh/WNQJZZ91d6mWG5GwWkjpGxolyZ4BsSBGh9W6/lE2no5FwKP5e
	O8zDX+JPEv778ZHVQc/VkJh5yj90Mtau5MLYnO5WwGY9D9wAxAZDCoI930d9/ZMl6NPwy5MSwbx
	iI4wDyc79PveC8uS24GmJcaCKqT1HA/H0+bajDrcf5/2Tf8HUVim03FTlU8z417eVQvI+wm8VNo
	pVau+zp/bF0WsnZxjujRTWYMlLl255PzXaubSzBLZuIJVriG80jRhNI51QzggpXcfN4qU3kpNxW
	2ClFf6CzTlJAP3mWGR/naOLGoJqvmmmrzXqiqqyF1CEpaw9dUSLSRQktEy/rE2qpxMeaJl/5b/o
	XFVmj4bRKQ77yuVsiNFfob/wDDasBdZy8MpaFr5mSm4V/EmiWBYLEq3CvRIkg9jmV0k7q6goTJ0
	/pmkTU49bTcj5ults4
X-Received: by 2002:a05:600c:348a:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-486fedd7fe6mr202896925e9.13.1774316509993;
        Mon, 23 Mar 2026 18:41:49 -0700 (PDT)
Received: from airbuntu ([146.70.179.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711764625sm12602545e9.14.2026.03.23.18.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 18:41:49 -0700 (PDT)
Date: Tue, 24 Mar 2026 01:41:47 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: daniel.lezcano@kernel.org, amit.kachhap@gmail.com,
	viresh.kumar@linaro.org, lukasz.luba@arm.com, rafael@kernel.org,
	rui.zhang@intel.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
	di.shen@unisoc.com, jeson.gao@unisoc.com, xuewen.yan94@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 2/2] thermal/cpufreq_cooling: Use idle_time to get
 cpu_load when scx_enabled
Message-ID: <20260324014147.4rnhi3h37kffyrim@airbuntu>
References: <20260320113148.7308-1-xuewen.yan@unisoc.com>
 <20260320113148.7308-2-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320113148.7308-2-xuewen.yan@unisoc.com>

On 03/20/26 19:31, Xuewen Yan wrote:
> From: Di Shen <di.shen@unisoc.com>
> 
> Recently, while enabling sched-ext debugging, we observed abnormal behavior
> in our thermal power_allocator’s temperature control.
> Through debugging, we found that the CPU util was too low, causing
> the CPU frequency to remain unrestricted.
> 
> This issue stems from the fact that in the sched_cpu_util() function,
> when scx is enabled, cpu_util_cfs becomes zero. As a result,
> the thermal subsystem perceives an extremely low CPU utilization,
> which degrades the effectiveness of the power_allocator’s control.
> 
> However, the scx_cpuperf_target() reflects the targeted performance,
> not the utilisation. We couldn't use it.
> 
> Until a perfect solution is found, using idle_time to get the cpu load
> might be a better approach.
> 
> Co-developed-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
> Previous discussion:
> https://lore.kernel.org/all/5a5d565b-33ac-4d5c-b0dd-1353324a6117@arm.com/
> 
> ---
>  drivers/thermal/cpufreq_cooling.c | 54 ++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index d030dbeb2973..e8fa70a95d00 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -24,6 +24,9 @@
>  #include <linux/units.h>
>  
>  #include "thermal_trace.h"
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +#include "../../kernel/sched/sched.h"
> +#endif

This is a terrible include

>  
>  /*
>   * Cooling state <-> CPUFreq frequency
> @@ -72,7 +75,7 @@ struct cpufreq_cooling_device {
>  	struct em_perf_domain *em;
>  	struct cpufreq_policy *policy;
>  	struct thermal_cooling_device_ops cooling_ops;
> -#ifndef CONFIG_SMP
> +#if !defined(CONFIG_SMP) || defined(CONFIG_SCHED_CLASS_EXT)
>  	struct time_in_idle *idle_time;
>  #endif
>  	struct freq_qos_request qos_req;
> @@ -147,23 +150,9 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>  	return freq;
>  }
>  
> -/**
> - * get_load() - get load for a cpu
> - * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
> - * @cpu: cpu number
> - *
> - * Return: The average load of cpu @cpu in percentage since this
> - * function was last called.
> - */
> -#ifdef CONFIG_SMP
> -static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
> -{
> -	unsigned long util = sched_cpu_util(cpu);
> -
> -	return (util * 100) / arch_scale_cpu_capacity(cpu);
> -}
> -#else /* !CONFIG_SMP */
> -static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
> +#if !defined(CONFIG_SMP) || defined(CONFIG_SCHED_CLASS_EXT)
> +static u32 get_load_from_idle_time(struct cpufreq_cooling_device *cpufreq_cdev,
> +				   int cpu)
>  {
>  	u32 load;
>  	u64 now, now_idle, delta_time, delta_idle;
> @@ -183,8 +172,35 @@ static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
>  
>  	return load;
>  }
> -#endif /* CONFIG_SMP */
> +#endif /* !defined(CONFIG_SMP) || defined(CONFIG_SCHED_CLASS_EXT) */

More ugly ifdefs

>  
> +/**
> + * get_load() - get load for a cpu
> + * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
> + * @cpu: cpu number
> + *
> + * Return: The average load of cpu @cpu in percentage since this
> + * function was last called.
> + */
> +#ifndef CONFIG_SMP
> +static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> +		    int cpu_idx)
> +{
> +	return get_load_from_idle_time(cpufreq_cdev, cpu, cpu_idx);
> +}
> +#else /* CONFIG_SMP */
> +static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
> +{
> +	unsigned long util;
> +
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	if (scx_enabled())
> +		return get_load_from_idle_time(cpufreq_cdev, cpu);
> +#endif

Instead of this scx special hack, wouldn't it be better to implement this as
a special operation mode? But then this will beg the question do we actually
need sched_cpu_util() if it can all be done based on idle time and just remove
the deps on sched_cpu_util()?

ifdefing based on scx is nasty hack, this can be done better; most likely by
decoupling the deps on util if truly the idle time is enough. If it is not
enough, then I am not sure this will solve any problem.

> +	util = sched_cpu_util(cpu);
> +	return (util * 100) / arch_scale_cpu_capacity(cpu);
> +}
> +#endif /* !CONFIG_SMP */
>  /**
>   * get_dynamic_power() - calculate the dynamic power
>   * @cpufreq_cdev:	&cpufreq_cooling_device for this cdev
> -- 
> 2.25.1
> 
