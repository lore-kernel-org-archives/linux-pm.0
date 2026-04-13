Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D013939C6
	for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115249; cv=none; b=Q9Yi4rR06UZFEXsjJygBDfEI/GIKfbS1yYVIEwp3PuH5R0kaCNE4q1SBbxJZEPX+ZkRn+tW/4HijZQucD4t1HhnrSsC9lcAq5cWIjmkhJNA14kyxb+P5is+dT8N7vb9qsJfqA9ZjLNyE9Jskv2TKaPQuFTZVa9+1/9f2tmnov4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115249; c=relaxed/simple;
	bh=+KNjJIKSmLSTNCxVPcEZ/mpl/fmbcdg+ekJWpmUzLyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpFvY+k6++vntMJT0eh/UwJfNZislZ6RpGc/3WuS7oNMdf0Wj4fZeG/tIUmjR2K0lfpmY/uca82i9P4iV8y0NYZi6ty4GZq3FENrD5EasSQrY2jHs8LRr3zHRGlQH8Xl6Nl1gHwjuPrVm8Paoyb89FcumfxxVUcsz0r7gDRvMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUFPFDfB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUFPFDfB"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9382e59c0eso879166066b.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776115246; x=1776720046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HTRp+l7/0tc5qrHVhM0cLgoMYRaB+2fMs37hHfn3p50=;
        b=FUFPFDfBlUqsQjlzjVeiHztRcorXcwfjGERgPESGe9/psCC6l+I/Mp+rH2vC/6jV7P
         euGgVRQVt3VPARFXtNrHxHTQ1MLmvlMxvqsS8QXeGPfbKWlfa9rOQyzHScVo6WZdZ1Pg
         fs3cdVdYFn/YDnyZNz6+zDjIr6aQEGtSx9lyFo0QNbktsBMWMJN/EXnc+cYJPqucFrEl
         AuqODk1fNIe0kfTvh7kvoA28b+AWr4b22pj/cItAs99VoU59OCLYv7cZvFABG3LTp/LQ
         broC9QkCWF60Tbpy4tUrLOX0cDIjIdIfqA80mgFMSQLwhvZmV3M20lZVl69DUQzJ5KiF
         vUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776115246; x=1776720046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTRp+l7/0tc5qrHVhM0cLgoMYRaB+2fMs37hHfn3p50=;
        b=K1zfqSELUsVVA05DsBrA4XbyhkwgeUYEZ+VXPSx8WpkFsOgMmXuA+ATAENsq+T4jzx
         6TzJR9IIEZv6Nztlh737Xk5hIS0HRwQB/kogM9qey932PR6bGRuJGP0tFuoY9aRO5VhS
         0VPtKzqxEUja/aqRWXZ8TgaHtd5XIZ4Zq/jDaeX9mj7lvwgXc7z3Dmhr7ubPdVNVUUdv
         gOYX3uAvBXy3yoKhPq0dyL5mtjtP0ijziA+sxUSPXI4Ho5Eef1Lj+nZmILZq1RmC+bd7
         wOww60WyMYLz0oKpNc5Zceo6ZQ9njWHXJlo86sgDa4u1B4CP14T3HMpAnWKfexKDojbl
         /3XQ==
X-Forwarded-Encrypted: i=1; AFNElJ/I2Ic68de86uiHWziSHJQZMs+DbgPAinnOKIux+NH8BFSAXFkH+3qkB2LJ+Y9mGG6wUHpXtHXieQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4UbrGgqvms7btRutBkaumqZ4prD1lTtY9gyTafBetnXh0fEyh
	nmW7Bkk+Q1yILowKChWR4EvwjRi8ONFBxt/c1mSZ8YDzDnhm7ZZxoaFA
X-Gm-Gg: AeBDietjThXpQoAZQ7B9VOpCWmvuVQSvcLEtN3nhWKHHyl3e1bTKYezmWthScHgYCtk
	g34445aIjF55nHX9fPQqvZ/M2hp1g3US06or0JNUmkE+7pJXaq0BiXoFVTrAxrwQOBDBDqC03id
	3YKZT0UAtAOpXfCee0l4idvV+YAUBQkz+t2YvlwIl/pKBE9jauvgk0uTFQNyvDnyXl0eXXNG2rY
	OuUYXDzAXg+xnCvHyRr9xDk6jpk7lEazouo4FOwC//sxo3/l+0j2If+AMkhlFXPfE0kRwVfsFvf
	mH7HeMXZ7Kg9+1DbuGZEuznqGhz1ExzMLf1W1IE4Rgtj1m+D81n8UrXU6gBWChSnri/5wDDdnGl
	Z0jdYg9ssv/Tr51OWKovTO/ajq8S0o+t3AfsoHfg03KptHMPgWipIkjGaKGv1hzo2S15xWT9Sk2
	6veObwd0qHAeh6T1lOpX1Zc1w83jp6Yx1qK+WxuMXomYc=
X-Received: by 2002:a17:906:6a0f:b0:b9b:3a1b:e2ec with SMTP id a640c23a62f3a-b9d7248abc2mr747543566b.14.1776115245800;
        Mon, 13 Apr 2026 14:20:45 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6de9b65fsm341457466b.7.2026.04.13.14.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 14:20:45 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <68d1e9ac-2780-4be3-8ee3-0788062dd3a4@gmail.com>
Date: Mon, 13 Apr 2026 21:20:43 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: The "clockevents: Prevent timer interrupt starvation" patch causes
 lockups
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Calvin Owens <calvin@wbinvd.org>, Peter Zijlstra <peterz@infradead.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20260407083219.478203185@kernel.org>
 <20260407083247.562657657@kernel.org>
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <20260407083247.562657657@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/04/2026 08:54, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@kernel.org>
> 
> Calvin reported an odd NMI watchdog lockup which claims that the CPU locked
> up in user space. He provided a reproducer, which sets up a timerfd based
> timer and then rearms it in a loop with an absolute expiry time of 1ns.
> 
> As the expiry time is in the past, the timer ends up as the first expiring
> timer in the per CPU hrtimer base and the clockevent device is programmed
> with the minimum delta value. If the machine is fast enough, this ends up
> in a endless loop of programming the delta value to the minimum value
> defined by the clock event device, before the timer interrupt can fire,
> which starves the interrupt and consequently triggers the lockup detector
> because the hrtimer callback of the lockup mechanism is never invoked.
> 
> As a first step to prevent this, avoid reprogramming the clock event device
> when:
>       - a forced minimum delta event is pending
>       - the new expiry delta is less then or equal to the minimum delta
> 
> Thanks to Calvin for providing the reproducer and to Borislav for testing
> and providing data from his Zen5 machine.
> 
> The problem is not limited to Zen5, but depending on the underlying
> clock event device (e.g. TSC deadline timer on Intel) and the CPU speed
> not necessarily observable.
> 
> This change serves only as the last resort and further changes will be made
> to prevent this scenario earlier in the call chain as far as possible.
> 
> Fixes: d316c57ff6bf ("[PATCH] clockevents: add core functionality")
> Reported-by: Calvin Owens <calvin@wbinvd.org>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/lkml/acMe-QZUel-bBYUh@mozart.vkv.me/
> ---
> V2: Simplified the clockevents code - Peter
> ---
>   include/linux/clockchips.h |    2 ++
>   kernel/time/clockevents.c  |   23 +++++++++++++++--------
>   kernel/time/hrtimer.c      |    1 +
>   kernel/time/tick-common.c  |    1 +
>   kernel/time/tick-sched.c   |    1 +
>   5 files changed, 20 insertions(+), 8 deletions(-)
> --- a/include/linux/clockchips.h
> +++ b/include/linux/clockchips.h
> @@ -80,6 +80,7 @@ enum clock_event_state {
>    * @shift:		nanoseconds to cycles divisor (power of two)
>    * @state_use_accessors:current state of the device, assigned by the core code
>    * @features:		features
> + * @next_event_forced:	True if the last programming was a forced event
>    * @retries:		number of forced programming retries
>    * @set_state_periodic:	switch state to periodic
>    * @set_state_oneshot:	switch state to oneshot
> @@ -108,6 +109,7 @@ struct clock_event_device {
>   	u32			shift;
>   	enum clock_event_state	state_use_accessors;
>   	unsigned int		features;
> +	unsigned int		next_event_forced;
>   	unsigned long		retries;
>   
>   	int			(*set_state_periodic)(struct clock_event_device *);
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -172,6 +172,7 @@ void clockevents_shutdown(struct clock_e
>   {
>   	clockevents_switch_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
>   	dev->next_event = KTIME_MAX;
> +	dev->next_event_forced = 0;
>   }
>   
>   /**
> @@ -305,7 +306,6 @@ int clockevents_program_event(struct clo
>   {
>   	unsigned long long clc;
>   	int64_t delta;
> -	int rc;
>   
>   	if (WARN_ON_ONCE(expires < 0))
>   		return -ETIME;
> @@ -324,16 +324,23 @@ int clockevents_program_event(struct clo
>   		return dev->set_next_ktime(expires, dev);
>   
>   	delta = ktime_to_ns(ktime_sub(expires, ktime_get()));
> -	if (delta <= 0)
> -		return force ? clockevents_program_min_delta(dev) : -ETIME;
>   
> -	delta = min(delta, (int64_t) dev->max_delta_ns);
> -	delta = max(delta, (int64_t) dev->min_delta_ns);
> +	if (delta > (int64_t)dev->min_delta_ns) {
> +		delta = min(delta, (int64_t) dev->max_delta_ns);
> +		clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
> +		if (!dev->set_next_event((unsigned long) clc, dev))
> +			return 0;
> +	}
>   
> -	clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
> -	rc = dev->set_next_event((unsigned long) clc, dev);
> +	if (dev->next_event_forced)
> +		return 0;
>   
> -	return (rc && force) ? clockevents_program_min_delta(dev) : rc;
> +	if (dev->set_next_event(dev->min_delta_ticks, dev)) {
> +		if (!force || clockevents_program_min_delta(dev))
> +			return -ETIME;
> +	}
> +	dev->next_event_forced = 1;
> +	return 0;
>   }
>   
>   /*
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1888,6 +1888,7 @@ void hrtimer_interrupt(struct clock_even
>   	BUG_ON(!cpu_base->hres_active);
>   	cpu_base->nr_events++;
>   	dev->next_event = KTIME_MAX;
> +	dev->next_event_forced = 0;
>   
>   	raw_spin_lock_irqsave(&cpu_base->lock, flags);
>   	entry_time = now = hrtimer_update_base(cpu_base);
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -110,6 +110,7 @@ void tick_handle_periodic(struct clock_e
>   	int cpu = smp_processor_id();
>   	ktime_t next = dev->next_event;
>   
> +	dev->next_event_forced = 0;
>   	tick_periodic(cpu);
>   
>   	/*
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1513,6 +1513,7 @@ static void tick_nohz_lowres_handler(str
>   	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
>   
>   	dev->next_event = KTIME_MAX;
> +	dev->next_event_forced = 0;
>   
>   	if (likely(tick_nohz_handler(&ts->sched_timer) == HRTIMER_RESTART))
>   		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
> 
> 

Hello.

Sorry, but this patch as of 7.0 introduced *severe* periodic lockups on my Ryzen 7700X machine.
I see such messages in the log:

clocksource: Long readout interval, skipping watchdog check: cs_nsec: 2897344852 wd_nsec: 2897356996

Reverting d6e152d905bdb1f32f9d99775e2f453350399a6a for mainline fixes the issue for me.

