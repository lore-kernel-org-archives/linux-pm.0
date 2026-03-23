Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73520296BBC
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244103; cv=none; b=LhKv2fp93UOr1Qsb9c3k+EhVufb/bb+Lco71K6dm3Wk0+t+c6/WBlk57LLsC9AUYZoZAZSepEOKSWsC3E8F4tznwSQS/F87nDnz1vVaFQ+Te5IjjcYK82G7/LGNjk2mTgypnWqJF3HhOf07P46OnE3R942WmLgmOJfeAXxr5ZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244103; c=relaxed/simple;
	bh=Wu9Cp4XNRcM1e4jt7z7MicwNDrWBEIMEsVbEGaNjFBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ1k9ZkcABne37cP+iEZLaf87BaNe0mnMfJFSV+HxNNBM75aQbWUprheXw3MnKrOYQaXL0A15lYaUZkROsxy2chcoF10CbfjbBd8TUv6XhMAWQrBYLN75hia9Pr8KKNDijYZUFgS+lsSOK00oeZiulVQNamOgppf82tNIOypHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s8OwEwSW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8OwEwSW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad4d639db3so10063705ad.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774244102; x=1774848902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqjeV6DPG0/uprV9ScvTHSovuEnQoCCvGTx8apC/MHQ=;
        b=s8OwEwSWKnD9BVYto7TF2Djyf4L8CgjBiU3AICGhw9JF3Z5yNzJO6oCoy3TyEuHaUH
         dqDyrj0VLuWsH9sCsZ5OykbSNiRumBvnoq3N72MQ1ylKMbbdfEaSDDzFr92RyJaYsLmK
         FfVtcEEZGchjp2PjQ3M7fINdAbLFIYJely+2NN6uvVh6apdumIkqMlA1Zrj2PlsepHrd
         pRNRUitqthh2oZ6yafy8Cw4EJh5aDl9QB7LcDF8As4EALTsAjeZXeDQx8xvIYnJSffWU
         rHLnId8k6gMLzCieF2qtDI0TnNHjm0GwY38IhHLT8fcq/981GabA+DyDh/3hJtJ9W56q
         fUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774244102; x=1774848902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqjeV6DPG0/uprV9ScvTHSovuEnQoCCvGTx8apC/MHQ=;
        b=Muh+aTDzlf5mx2kSTXljlsw6ikzJcjI3keGdKXeARm7Lz3L3uoQsaiLFtvsibytyzD
         gl0pyBkzTimHXw4D+BoJZj36IbWJjQd0oTV9YdR+KGlRsXAAJXAV9RQiW3DVqmtd87Wa
         zOdzysRFG64MmYmT8hnVRuYOgv6OPbvc7HlxywpdKNJMeWj0Rvoww9Wl6vQ9lhFeaIk6
         Tn1KNDI2UDteSoqfdovb3u1n+UasskXsXpWvc91sDS+elS1OVBtb9GEguE5+f99fi5nc
         kwnWROpqYUum36B9EF6YkM0Ysn3u4We1KN7M2UwbFf6jcsJIkxLvhOMEvoDou6SbJbXg
         tP9w==
X-Forwarded-Encrypted: i=1; AJvYcCVe/l5/PbpCDUfS/+r0C8qELUoyCxNeAIL6ntyFFNhPf7I745TEDWD9dzPg8zjV5mncTlO4tRzNQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNMODzkOa+ny1Ofvu0k4xT3rlBUcsJ3qOt/Y5uotw8Ll4V+gc
	b9ubX1hh3sD6apj+/pkqOMK+0JykrZ6gW2PamsPsjBad1Wg83Nbk+LSBqrV17xMBwj8=
X-Gm-Gg: ATEYQzxZTHENpxdOfK3inLGvyB4MNnjlPbV/O8Cb7znyyGtdNjvbUcuS3J08f2+6Vu5
	MUF6GqGC1O6cRfbQmjt1C/N82M1Ctd/hyxOu6GM/acqfJfIfg9Mc1obpJ8oX+yabMou4+o1nn0J
	6YLhg+NuwipOhEILCy0pUoUsTvAEDYBgLEsqE+adn8pRGxqwg1S3iBdv/RCv/XuzBESV0kI4baG
	xFL9/gbOKiiEwnozyr43kDOaZZTkZ0ZWvhIXWHHMrD0aAnt8a1MSnUaT4WQnTvF9XK7ZzaXbaqW
	h/T6dbsP0ifwOuliJ3nBO/Jlz+LkgpH+yjKKzR+3mAdS+dhveoLCTMMXdiEQdQeXHUPVVk4TPii
	GbuzhcEIkxun9eNJ3lHY54/gP2bqvLqM6YT5JHWVkIfHDkGuNWS20BpBXpsL0Ocj1nI7n8E82s6
	BaVI8kXPWGo7P/UjH4+OeTQmVY
X-Received: by 2002:a17:902:e882:b0:2b0:9a6f:cbb with SMTP id d9443c01a7336-2b09a6f0dfamr22386295ad.26.1774244101602;
        Sun, 22 Mar 2026 22:35:01 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516877sm117987615ad.12.2026.03.22.22.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 22:35:00 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:04:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, rui.zhang@intel.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, amit.kachhap@gmail.com, 
	daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	di.shen@unisoc.com, jeson.gao@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx
 in get_load()
Message-ID: <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
References: <20260320113148.7308-1-xuewen.yan@unisoc.com>
 <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>

On 20-03-26, 12:32, Lukasz Luba wrote:
> Hi Xuewen,
> 
> On 3/20/26 11:31, Xuewen Yan wrote:
> > From: Di Shen <di.shen@unisoc.com>
> > 
> > The cpu_idx variable in the get_load function is now
> > unused and can be safely removed.
> > 
> > No code logic is affected.
> > 
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> > ---
> >   drivers/thermal/cpufreq_cooling.c | 13 +++++--------
> >   1 file changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> > index 32bf5ab44f4a..d030dbeb2973 100644
> > --- a/drivers/thermal/cpufreq_cooling.c
> > +++ b/drivers/thermal/cpufreq_cooling.c
> > @@ -151,26 +151,23 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
> >    * get_load() - get load for a cpu
> >    * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
> >    * @cpu: cpu number
> > - * @cpu_idx: index of the cpu in time_in_idle array
> >    *
> >    * Return: The average load of cpu @cpu in percentage since this
> >    * function was last called.
> >    */
> >   #ifdef CONFIG_SMP
> > -static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> > -		    int cpu_idx)
> > +static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
> >   {
> >   	unsigned long util = sched_cpu_util(cpu);
> >   	return (util * 100) / arch_scale_cpu_capacity(cpu);
> >   }
> >   #else /* !CONFIG_SMP */
> > -static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> > -		    int cpu_idx)
> > +static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
> >   {
> >   	u32 load;
> >   	u64 now, now_idle, delta_time, delta_idle;
> > -	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
> > +	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu];
> 
> This is a bug. We allocate 'num_cpus' size of array based on
> number of CPU in the cpumask for a given cpufreq policy.
> If there are 4 cpus in the CPU cluster but CPUs have ids:
> CPU4-7 then accessing it with this change would explode.

I think following commit introduced a bug by removing `i++`.

commit 3f7ced7ac9af ("drivers/thermal/cpufreq_cooling : Refactor thermal_power_cpu_get_power tracing")

-- 
viresh
