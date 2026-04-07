Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0F344DA2
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583494; cv=none; b=GrYyDni8bxTh7ujfOCT/U7ETSJC2ZDjzWMnnhTcSUXxFgdIJke04uIg76wz+CftuzKPLVzKZkzzAVTBH9ZEjAy+ax/YePnVSKjKxP42flgFyo9Mdsq4KpHewcikVaTV/B0WQt0QaaF4FAA1WEhIt5YIgc7eK1AWVn32ZH0zvF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583494; c=relaxed/simple;
	bh=tvdUOATrbfQbm/otRmotSEVug48Q7PpH/fmsCZHFm/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRCI6uUw9tcCI/hngaZnhaoYpQ89zoxRLYJ8SyYZOF6+GEjtIImEZeggSY6pLWclgRz+uOVNbnPd6HAFWnwUB64OBhJpyaLJwnqJzQVdI4TDsP5jHzcc4h+o0Yr3EpKkk17bRl4N3EB/KbSoij/qhKg4eX9C3EwUULLnFxRvPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=W0VTYY3f; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="W0VTYY3f"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so5942824eec.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1775583490; x=1776188290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hqUr7UMuRskj68PpjSrDblmslOlX4kFlkF++X6DCkjE=;
        b=W0VTYY3ft7bUlo7blCkv7uvh2n+fbI1geytaWAqleOxemFlBdqAOBh2yH73beInRyr
         p0fueHUxvNR4a3YdozjFgRWwPRgNPsMUAbuSKfCsSK9pG29BKZGAyiGOgLiPGijgs4BY
         Fa3s+Qodwcnci/Q8bNt4481CyvK18QpJciMvhWQmf7tDtyi/TxTW7kO7XsgaeVrkhkNi
         8R65EmNicM5ZjtPYsgwuRexusJGwlwQLEugTdKSNQHs6NSdkDcOV4zR4W8K5Ln+3SAIa
         yysFTD1Bmh09jwfz4RSqo11OVqw8mOsvdwU+QxFHnLmNVazJF/1XCs3WVb7AiFW8/PQu
         YIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583490; x=1776188290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqUr7UMuRskj68PpjSrDblmslOlX4kFlkF++X6DCkjE=;
        b=HZtt1qWSGJ0zTEUGPbO+rRKsnk5qu1MiuOo4SVdkD3mKnhJPTJD023bBstxWxHlsf5
         AZ4Bta+16PrBIOn1yhTpqeWg43QJ84vZ3bRQDh/Hm4Ujeqj51lDqRJw47Fg/wJhVWdFf
         ks7UkBF+EzXP+srcwbRRKG30URToU/FIQnJL05A9V6dqlr9FWflERUZAMdshcjidDcwz
         Z4CsJQ5boPe1LHOKKx5NWQV0NLG0kN55PFI5+fRXMRFc3hMN6rtU/uCbINozg1EmACE0
         tVss09uSQdSFhpu1d8x+f160eU4eQgIwRUvh7UWlkMWDUoSHR7jxfVvIa09jgs+309mm
         KVEw==
X-Forwarded-Encrypted: i=1; AJvYcCXT9CcQbYXBsU+ZkYVTzV6ahQ12RXw4AKh1aDreLOoqdf2X0ENNF7iCFtT2sdti6iiKifwtDcG2HA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlKZk043cU+bFpOJ5e7sRHaSESqvkaEpL7SryBXRo2m1XkUxfR
	/o2ulGPB1Uiu8xX1MkuT6NQZZAKUVpzSZ2PAFMmwx1QVR6z0eYl4xJ2hjqrhPZNg3jQ=
X-Gm-Gg: AeBDies54nMCtmEGE7Iyw9ab9khCVAqeJ2ZMJg5rfThur8LEzv2YAYs+/Jez/H8vy09
	6bnAJE23ZuSQiHt2ZQzsu26DAnymaOcfFhqUXQFXXVe8EDaNdFJ7HJgIaHUMvIkcYV8btY7M14W
	gFfulOmrV2M+7bq/WiSfXaE6QR3rFXiTo1JAFrg035I5Eojfq0HhC/jwczs4EgoClEUcflwist0
	FXKVXK7WYIrNIH6NTr73rD0KePxIEBLJQCEDW7oz8eDWcSq66lmDHCyVlFeqNM+8ZiEnOA/h9mU
	1Zv/14xwPRy9gVxkk5hhmvDpnKV1COHuAtwdGSNGs2tzVXHYe498HZjIaV/NVAnCUtoy/JWNTOp
	FHooACk7Ifas/a6IsoHItkL1Oekn1qbVYALdSw3jlIhZX1IkiIwo1tgLVjbzpBFkb58V2O+EvEa
	mX5bhcMTbpM6DARSidey6P9LabEQ==
X-Received: by 2002:a05:7301:1010:b0:2ba:a2fb:403f with SMTP id 5a478bee46e88-2cbfb995d49mr8269797eec.21.1775583490260;
        Tue, 07 Apr 2026 10:38:10 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:412a:9f09:7acb:b69f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cba5df5c24sm15761050eec.27.2026.04.07.10.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:38:09 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:38:06 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 00/12] hrtimers: Prevent hrtimer interrupt starvation
Message-ID: <adVA_uv1srA_bsKj@mozart.vkv.me>
References: <20260407083219.478203185@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407083219.478203185@kernel.org>

On Tuesday 04/07 at 10:54 +0200, Thomas Gleixner wrote:
> Calvin reported an odd NMI watchdog lockup which claims that the CPU locked
> up in user space:
> 
>   https://lore.kernel.org/lkml/acMe-QZUel-bBYUh@mozart.vkv.me/
> 
> He provided a reproducer, which sets up a timerfd based timer and then
> rearms it in a loop with an absolute expiry time of 1ns.

The original AMD machines survive the reproducer with this series.

Tested-by: Calvin Owens <calvin@wbinvd.org>

I'm happy to test subsets of it and stable backports too, if that's
helpful, just let me know.

Thanks,
Calvin

> As the expiry time is in the past, the timer ends up as the first expiring
> timer in the per CPU hrtimer base and the clockevent device is programmed
> with the minimum delta value. If the machine is fast enough, this ends up
> in a endless loop of programming the delta value to the minimum value
> defined by the clock event device, before the timer interrupt can fire,
> which starves the interrupt and consequently triggers the lockup detector
> because the hrtimer callback of the lockup mechanism is never invoked.
> 
> The first patch in the series changes the clockevent set next event
> mechanism to prevent reprogramming of the clockevent device when the
> minimum delta value was programmed unless the new delta is larger than
> that. It's a less convoluted variant of the patch which was posted in the
> above linked thread and was confirmed to prevent the starvation problem.
> 
> But that's only to be considered the last resort because it results in an
> insane amount of avoidable hrtimer interrupts.
> 
> The problem of user controlled timers is that the input value is only
> sanity checked vs. validity of the provided timespec and clamped to be in
> the maximum allowable range. But for performance reasons for in kernel
> usage there is no check whether a to be armed timer might have been expired
> already at enqueue time.
> 
> The rest of the series addresses this by providing a separate interface to
> arm user controlled timers. This works the same way as the existing
> hrtimer_start_range_ns(), but in case that the timer ends up as the first
> timer in the clock base after enqueue it provides additional checks:
> 
>       - Whether the timer becomes the first expiring timer in the CPU base.
> 
>       	If not the timer is considered to expire in the future as there is
> 	already an earlier event programmed.
> 
>       - Whether the timer has expired already by comparing the expiry value
>         against current time.
> 
> 	If it is expired, the timer is removed from the clock base and the
> 	function returns false, so that the caller can handle it. That's
> 	required because the function cannot invoke the callback as that
> 	might need to acquire a lock which is held by the caller.
> 
> This function is then used for the user controlled timer arming interfaces
> mainly by converting hrtimer sleeper over to it. That affects a few in
> kernel users too, but the overhead is minimal in that case and it spares a
> tedious whack the mole game all over the tree.
> 
> The other usage sites in posixtimers, alarmtimers and timerfd are converted
> as well, which should cover the vast majority of user space controllable
> timers as far as my investigation goes.
> 
> The series applies against Linux tree and is also available from git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git hrtimer-exp-v1
> 
> There needs to be some discussion about the scope of backporting. The first
> patch preventing the stall is obviously a backport candidate. The remaining
> series can be obviously argued about, but in my opinion it should be
> backported as well as it prevents stupid or malicious user space from
> generating tons of pointless timer interrupts.
> 
> Thanks,
> 
> 	tglx
> ---
>  drivers/power/supply/charger-manager.c |   12 +-
>  fs/timerfd.c                           |  115 +++++++++++++++-----------
>  include/linux/alarmtimer.h             |    9 +-
>  include/linux/clockchips.h             |    2 
>  include/linux/hrtimer.h                |   20 +++-
>  include/trace/events/timer.h           |   13 +++
>  kernel/time/alarmtimer.c               |   70 +++++++---------
>  kernel/time/clockevents.c              |   23 +++--
>  kernel/time/hrtimer.c                  |  142 +++++++++++++++++++++++++++++----
>  kernel/time/posix-cpu-timers.c         |   18 ++--
>  kernel/time/posix-timers.c             |   35 +++++---
>  kernel/time/posix-timers.h             |    4 
>  kernel/time/tick-common.c              |    1 
>  kernel/time/tick-sched.c               |    1 
>  net/netfilter/xt_IDLETIMER.c           |   24 ++++-
>  15 files changed, 341 insertions(+), 148 deletions(-)
> 
> 
