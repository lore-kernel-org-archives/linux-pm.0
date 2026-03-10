Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B15E3B961F
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773114854; cv=none; b=hY1aogOMxDZY6HAaDiqraMPjCaOD6qcbKKIGcgF9thrC1i01CXQK/r+RXhSu/VdT7xvcKtnB5mIj2dBs74U9KZl0v8sToNUxuCE9po74JiMXqhXiVuPusEyrAm1bAHpDHvYje2Hi/8kgOt11gOIULkoChuCddagtdCXNeCHG5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773114854; c=relaxed/simple;
	bh=j6EEc7Huoy8lDiZfXeS0/DSqi0EhkXLYJ5QFOI9v+xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI1k4ndOrhmSCn254lpL1tXS86AwWprXypActzUUL1gOHuqZ+UG4dYHdyQMHBNyrWj/4vBnuRf9DlNhvb0GijysNflVnqM3NRAK08yEZsrIvtI/qRRzCCYz/qsX/nn4tZ6GVX2qWOEeeRZp+OpjB2Hto1Ehu8Mg59aWUBk4T1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=dxFmjxgP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="dxFmjxgP"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439c9eb5d36so5371617f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 20:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1773114851; x=1773719651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccBTEmZS8i6Xgj54Ar7HD/l3oM1VdOlMe8+Txyqrh6o=;
        b=dxFmjxgPeZ4PI/EXrmiEvizkct57+FbtqB+rVbaf2vQId/3EhYxS4ulvF8gHDlFEeb
         BtR3O5ibo54ufVtTHnKckm3jiZ7Mg6QN/SXwTbWBsGiLgqjuZ0AxE1myYhVrBsG9PNt2
         BCe88omwAdhHwjUpQB9W6jCXdoszMBUbOlqBQFFw7JxEnuwsIJ1w0UzUe/jeNDHijT8r
         qKzZEViacdZxg6FqIppsOIZ3I5EPsrhvxFBeCtVi0pdV+Boj9kFLRzPj6Zq5kF/rQ8AT
         Ht3q+SPXSQVCgsygSPF/9DNvyXnMyUwdH26x96PVTT1PR+RLi21RbSqqQtNZa5lieyDv
         kdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773114851; x=1773719651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccBTEmZS8i6Xgj54Ar7HD/l3oM1VdOlMe8+Txyqrh6o=;
        b=GzmyxKcdOSOF1p2HZShw3PoFVoJcmqeBgPzZxSpWzpi4GbDjn5+1avmHU4Ojwzr6x8
         CeLj+L3SowdwmveUVkQ0dSgJlQ49p77h2knQRDk5GOSAI75wBS/bqfBxomb/tnulbdek
         8DxIxaM9Cu3evHIGlbhHei8bvELLpz3YAE2SMomuYMgt3a9103l1WqXYE9EBgxt8Ue8g
         gsA7TNbrJ8N9viqRFYAjNq6oaa+yHEqWXpLpEs/+2bJyou1xMS+hlklNnd8P4KyO15rh
         p0Q0541Bjbt6CKOjVjNFQvLMbT2BarbzZ8wcZ/hV+XzZ259BnPM5rCOnluuZUfuKOTzh
         RnHg==
X-Forwarded-Encrypted: i=1; AJvYcCUDUIaxBTI+YH1vkAbkhDbCi0jDJpei39uMHRITMZs17FVjBNBTJlzUD/jPPwWZOmD/7cFevOIsUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgK+UPv+bZ5IZREIM2zJeisWLJarMWJzrQYRAcW+8bN+2SU9G
	bX893vWR5cW7iU1RnFd3E4Hy5Fn8hQz/f5VIOnpoSEZnHYnI3dHeqiIB1tpbc23G/44=
X-Gm-Gg: ATEYQzz77QYA6l6r/mV4PGvAnDahqC4DDF4KknfOTEho57Zam93SXMf2E6UhFCahyya
	NKaRkBVvgVrVsfP52/he6eiNWWAe39a/0rNn38qwlC85Ta1RdYeZVFm+HQTAi1+HIDkf5pYLVLK
	3garKw21Xp52G+79lq7iZD97XviExGsezhOiSdRtD7L4hfd5z4jXax33QPHsmRtvp3qZEQ5kA/x
	0K8o/k94RAVRMd5VH8Kwhk70+PnhHXOKboVMejBQBRYQyhrUAK4J5Hz5nztl7ZwjjbpfjqI7+N3
	HJLy5VZbYnoUV2MooHMCuMzzSqsltlIh4J06K02zCEC3e0W1unr7NSb4NJP9DeFEFpOJ+WwDKua
	0joXtarDtxvXG8AbmWn+lTwmbjDk2K47o237HTrYoC4uOr8Ihnrbng3l4bQjKxI2uqgbrY01W1J
	rsuF0WS24gmsdGX2V59Q==
X-Received: by 2002:a5d:5d06:0:b0:439:c628:2228 with SMTP id ffacd0b85a97d-439da35e481mr23565311f8f.31.1773114850785;
        Mon, 09 Mar 2026 20:54:10 -0700 (PDT)
Received: from airbuntu ([194.36.110.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad97da3sm35183733f8f.12.2026.03.09.20.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 20:54:10 -0700 (PDT)
Date: Tue, 10 Mar 2026 03:54:06 +0000
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [patch 2/2] sched/idle: Make default_idle_call() NOHZ aware
Message-ID: <20260310035406.xnu3nlqp4ldshxww@airbuntu>
References: <20260301191959.406218221@kernel.org>
 <6250711.lOV4Wx5bFT@rafael.j.wysocki>
 <CAJZ5v0jb7wJFQEfP_-JRv4mwh3qveq+VPoy8k9dmtmigoSyKhg@mail.gmail.com>
 <2409653.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2409653.ElGaqSPkdT@rafael.j.wysocki>

On 03/07/26 17:25, Rafael J. Wysocki wrote:

> In the meantime I realized that if the .select() governor
> callback is skipped, its .reflect() callback should be skipped
> either, so I've posted this:
> 
> https://lkml.org/lkml/2026/3/7/569
> 
> and here's a fixed version of the last patch on top of the above (for
> completeness):
> 
> ---
>  kernel/sched/idle.c |   25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
>  	return cpuidle_enter(drv, dev, next_state);
>  }
>  
> +static void idle_call_stop_or_retain_tick(bool stop_tick)
> +{
> +	if (stop_tick || tick_nohz_tick_stopped())
> +		tick_nohz_idle_stop_tick();
> +	else
> +		tick_nohz_idle_retain_tick();
> +}
> +
>  /**
>   * cpuidle_idle_call - the main idle function
>   *
> @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
>   * set, and it returns with polling set.  If it ever stops polling, it
>   * must clear the polling bit.
>   */
> -static void cpuidle_idle_call(void)
> +static void cpuidle_idle_call(bool stop_tick)
>  {
>  	struct cpuidle_device *dev = cpuidle_get_device();
>  	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
>  	}
>  
>  	if (cpuidle_not_available(drv, dev)) {
> -		tick_nohz_idle_stop_tick();
> +		idle_call_stop_or_retain_tick(stop_tick);
>  
>  		default_idle_call();
>  		goto exit_idle;
> @@ -222,17 +230,14 @@ static void cpuidle_idle_call(void)
>  		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
>  		call_cpuidle(drv, dev, next_state);
>  	} else if (drv->state_count > 1) {
> -		bool stop_tick = true;
> +		stop_tick = true;

Silly question, but wouldn't this benefit the normal path too to delay for one
tick? This will only matter for the cases where the governor doesn't explicitly
set stop_tick to either true or false - which I am not sure what they are :)

>  
>  		/*
>  		 * Ask the cpuidle framework to choose a convenient idle state.
>  		 */
>  		next_state = cpuidle_select(drv, dev, &stop_tick);
>  
> -		if (stop_tick || tick_nohz_tick_stopped())
> -			tick_nohz_idle_stop_tick();
> -		else
> -			tick_nohz_idle_retain_tick();
> +		idle_call_stop_or_retain_tick(stop_tick);
>  
>  		entered_state = call_cpuidle(drv, dev, next_state);
>  		/*
> @@ -240,7 +245,7 @@ static void cpuidle_idle_call(void)
>  		 */
>  		cpuidle_reflect(dev, entered_state);
>  	} else {
> -		tick_nohz_idle_retain_tick();
> +		idle_call_stop_or_retain_tick(stop_tick);
>  
>  		/*
>  		 * If there is only a single idle state (or none), there is
> @@ -268,6 +273,7 @@ exit_idle:
>  static void do_idle(void)
>  {
>  	int cpu = smp_processor_id();
> +	bool got_tick = false;
>  
>  	/*
>  	 * Check if we need to update blocked load
> @@ -338,8 +344,9 @@ static void do_idle(void)
>  			tick_nohz_idle_restart_tick();
>  			cpu_idle_poll();
>  		} else {
> -			cpuidle_idle_call();
> +			cpuidle_idle_call(got_tick);
>  		}
> +		got_tick = tick_nohz_idle_got_tick();
>  		arch_cpu_idle_exit();
>  	}
>  
> 
> 
> 
