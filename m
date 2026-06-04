Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E633EF
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567713; cv=pass; b=jzIFLxijaV6VT9/pZ1EhyqMYFulVwEvwuSWS4rNLxKWbxN6Qsf927dj15LAut8NrrcKNuTEaAQLfw4bm9/EdfXGZhVirGzhBXmxcQlH83jyEd+oJceN1PULvKUQLllg0s0gVBDK0hXuPPM5qCn4RIguvyU6c4Xr/o5twBoEwHOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567713; c=relaxed/simple;
	bh=HhLuT634S1bGovGmEL58Hy4xmsxqY6iHFcACo8SPT6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oL5+Dnfq6SAWK8eu8Lfq09PKTJpNRBldf1p40rqxPKGYDy32A1zg2ZQ9HDv81YZvpAg0QAyeeOeY0o2gDLxnizbdL3f13CGVUPAc/MpTPGscTDksJemb5E13rNWe+XVrU+9X0nmlZ1Kq80/NhosRUub+VQaXaWHzG2eYNFBNX24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ndN5//xf; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndN5//xf"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so1005020a12.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 03:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780567710; cv=none;
        d=google.com; s=arc-20240605;
        b=haqTMjyIoPwCE+aCDPQ8FRHX/0Rj0huKfDTY8CjITbAXj3MUy/CDB1BZERHwV7W3rc
         0W9UZaVBAvV3tzWCWcygA1uSm84/dGrvuVOWSvWUq3tXxB3mmJkgG4sC7Du318XanevZ
         h2xhBVoYdSkly7DQCdW6cDnccHs+pJR28HlCJr25IQea8dwPpUP9lpMW9kS+X2hjTsQ1
         9Y0clqc9ZGclsimTFnZGQcrvQZJRw+fE+2bB6QqtpyqY4Td9f92oYE01XA9QkOxaJYNE
         dOYi/kGg7UA/kkzPpbMkttNK/+k74BtieSTC3JUtplsChtELDb23/FoE1Xry14r3iU5f
         +N2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fH6LccfX1e1gs0wpfFU/BGTTT70TciQb7KsL8WGA1xY=;
        fh=3Qj7f0hkY4UFW2abCBEX/uy0gzGLdfOaTObuNpfkTeQ=;
        b=lN8jQow14F/o6SIXd9ScCRSdwvAc5S9JSO/ZjFhN2T6eoNNSe8iyBkz7+fEcQUD/3S
         PclZpSfTPTAPjYPZ4ujgfbfqelSXXEyku1JAmu2IfKK0dkvKPZ8TkV5SDAIxaY+RZS7J
         XB3LOOAOhRmTyfoGdvd0NjwncL3eYPhsy0aWUVoNvYH0ZHPMeNjRnHr0qVX+/Y/H/qa4
         My6otFGezsxTss2U3nZmV1vdKRQyr/+LbYl2phdSIiAs5w7ki/Xw0tWxkeJBo/IYZ+di
         dLt9cp1dJnWcTpZ2tZv1q5PDyCGGlHytk6OREy0uoBYv3ZMto1ikMf2y7aD060AHJ9Iw
         MmaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780567710; x=1781172510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fH6LccfX1e1gs0wpfFU/BGTTT70TciQb7KsL8WGA1xY=;
        b=ndN5//xfr1DM2DAFeUiJJjhva1Bsm5pJSDF55ywWXRYKDXn5J5PFLaTK9f1HP5Kni0
         LQ0/tX+Qty11+ZM3Dfqguh+aBm4dnhtZorc69dQ95Y95Qhuu70fnPDXPnSW88yjIXZny
         1kIaEKRhvo4yTBnpBkBtbaKC6A5dMiCHK6W/bSb0n+Hot7ix8NRhSlT0M2X6bFrkonxR
         mvqR/1fXJ7Vp/ur8RjmuD4pUbI0+qLA7vom0TCjyne0ZuPO+c1Z0joLkGVqc7Y4sRB9O
         RztRBdWfuUjLCa2PdkjodFwEszgOzyVMRu6ig028lHSsg+Q9VxiQrRINz+IvsOSnfeFt
         ysJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567710; x=1781172510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH6LccfX1e1gs0wpfFU/BGTTT70TciQb7KsL8WGA1xY=;
        b=k2L1tdhnVrwnzqRu+n6bLeuPnGE5tCEB/AobPzUZM/x9heucoYTVZlpZFz3rgFdZm9
         79AavGCJEmkITkSmADIEU3y/VcCB+LRkFOKXoizpdhlj688+7B8KVYE3UTX3o1E7joQv
         Xnczkmd852j99tF/ND+KZNVhK0hSwDF0cjJWfRUDlickzvMKSmqv7v4jrpq4atiul2I1
         gw+iI1VVMeIJlXG7ybzLOtj0U8J2O4DgLgfhcjNebZqxoyCY5muT8T9XrR45UjBvY212
         KxMH9YrOJw6fyKI/pZErrQDALRHrWpeh+N4uZnEGoaqAHxJxdM7R1SBGAGmKHZ6qyvrB
         lsOw==
X-Forwarded-Encrypted: i=1; AFNElJ+0O1SUSgny8NIv4hemFqfczD3qVhK/aHGI1QnaPxullSnVZzw4123FNO+g47QQsN9gU6KB4ZSRhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza07PzV4wPPFGfLz4TUdTdXcSy9Jb6vabTeVb3pQOCDwFTyY6R
	Egffzr7khGX+C7LakUCTupv39+nj9IKzGzdavaHuwTZtTVdu/K5P8BtXXWDDIea+pqQxqxf6Z1O
	Ly7e7NeZvAoas6kaY34DRDhpR4bpDIQ7pNQdyqVx+xQ==
X-Gm-Gg: Acq92OHJfrVpLMzhi8w5R3ACDR0rpa0jydTtJErI+OCEN5cpArx/NxRxCogmyGvdorV
	ILn+dr8KQMSqPnpIUOkN0lMiAH4NKmQKVGm4yqzN6qrrVKPjBoXzSDVHMvQ5fXWlhWndmYCa1Bx
	Dpa32kBtP0nOOUt2vZJ20dQDH6S/N1UzHk2uOcJMYSC7//j7cVFA0so7llOgvZ888Qhns9Tw+Og
	z9PGdGr+D2tKYpQyWlREiauIoTuwzgWyGa/EZ/nSdmh77MEN54E7LnSK8nn5mMIB/8a9MOk46uw
	lzjKVrNqs8SIJjce0ci7iQc3OMenHCLqs/DpkyX8cDAXUzE=
X-Received: by 2002:a05:6402:5111:b0:68d:651f:ccf8 with SMTP id
 4fb4d7f45d1cf-68e6e446730mr3687652a12.3.1780567710402; Thu, 04 Jun 2026
 03:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504020003.71306-1-qyousef@layalina.io> <20260504020003.71306-5-qyousef@layalina.io>
In-Reply-To: <20260504020003.71306-5-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 4 Jun 2026 12:08:18 +0200
X-Gm-Features: AVHnY4JFEsVnu0GqIITqslXdsdJ6wV6bf5Vg5qpu_CwD0h_rhH33NtOvdMmuKBA
Message-ID: <CAKfTPtBKpFPS4AfsF_ihjW-m-FqcSXgg1fO_ZBV_Qjvr++iTHw@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] sched/fair: Remove magic hardcoded margin in fits_capacity()
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Stultz <jstultz@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 04:00, Qais Yousef <qyousef@layalina.io> wrote:
>
> Replace hardcoded margin value in fits_capacity() with better dynamic
> logic.
>
> 80% margin is a magic value that has served its purpose for now, but it
> no longer fits the variety of systems that exist today. If a system is
> over powered specifically, this 80% will mean we leave a lot of capacity
> unused before we decide to upmigrate on HMP system.
>
> On many systems the little cores are under powered and ability to
> migrate faster away from them is desired.
>
> Redefine misfit migration to mean the utilization threshold at which the
> task would become misfit at the next load balance event assuming it

Do you mean at the next tick?

> becomes an always running task.
>
> To calculate this threshold, we use the new approximate_util_avg()
> function to find out the threshold, based on arch_scale_cpu_capacity()
> the task will be misfit if it continues to run for a TICK_USEC which is
> our worst case scenario for when misfit migration will kick in.
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  kernel/sched/core.c  |  1 +
>  kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++--------
>  kernel/sched/sched.h |  1 +
>  3 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 49cd5d217161..47ec8ea7c52e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8921,6 +8921,7 @@ void __init sched_init(void)
>                 rq->sd = NULL;
>                 rq->rd = NULL;
>                 rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> +               rq->fits_capacity_threshold = SCHED_CAPACITY_SCALE;
>                 rq->balance_callback = &balance_push_callback;
>                 rq->active_balance = 0;
>                 rq->next_balance = jiffies;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f179faf7a6a1..4e1ed3c7f96e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -97,11 +97,15 @@ int __weak arch_asym_cpu_priority(int cpu)
>  }
>
>  /*
> - * The margin used when comparing utilization with CPU capacity.
> - *
> - * (default: ~20%)
> + * fits_capacity() must ensure that a task will not be 'stuck' on a CPU with
> + * lower capacity for too long. This the threshold is the util value at which
> + * if a task becomes always busy it could miss misfit migration load balance
> + * event. So we consider a task is misfit before it reaches this point.
>   */
> -#define fits_capacity(cap, max)        ((cap) * 1280 < (max) * 1024)
> +static inline bool fits_capacity(unsigned long util, int cpu)
> +{
> +       return util < cpu_rq(cpu)->fits_capacity_threshold;
> +}
>
>  /*
>   * The margin used when comparing CPU capacities.
> @@ -5180,14 +5184,13 @@ static inline int util_fits_cpu(unsigned long util,
>                                 unsigned long uclamp_max,
>                                 int cpu)
>  {
> -       unsigned long capacity = capacity_of(cpu);
>         unsigned long capacity_orig;
>         bool fits, uclamp_max_fits;
>
>         /*
>          * Check if the real util fits without any uclamp boost/cap applied.
>          */
> -       fits = fits_capacity(util, capacity);
> +       fits = fits_capacity(util, cpu);
>
>         if (!uclamp_is_used())
>                 return fits;
> @@ -10299,12 +10302,33 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>  {
>         unsigned long capacity = scale_rt_capacity(cpu);
>         struct sched_group *sdg = sd->groups;
> +       struct rq *rq = cpu_rq(cpu);
> +       u64 limit;
>
>         if (!capacity)
>                 capacity = 1;
>
> -       cpu_rq(cpu)->cpu_capacity = capacity;
> -       trace_sched_cpu_capacity_tp(cpu_rq(cpu));
> +       rq->cpu_capacity = capacity;
> +       trace_sched_cpu_capacity_tp(rq);
> +
> +       /*
> +        * Calculate the util at which the task must be considered a misfit.
> +        *
> +        * We must ensure that a task experiences the same ramp-up time to
> +        * reach max performance point of the system regardless of the CPU it
> +        * is running on (due to invariance, time will stretch and task will
> +        * take longer to achieve the same util value compared to a task
> +        * running on a big CPU) and a delay in misfit migration which depends
> +        * on TICK doesn't end up hurting it as it can happen after we would
> +        * have crossed this threshold.
> +        *
> +        * To ensure that invaraince is taken into account, we don't scale time
> +        * and use it as-is, approximate_util_avg() will then let us know the
> +        * our threshold.
> +        */
> +       limit = approximate_runtime(arch_scale_cpu_capacity(cpu)) * USEC_PER_MSEC;
> +       limit -= TICK_USEC; /* sd->balance_interval is more accurate */
> +       rq->fits_capacity_threshold = approximate_util_avg(0, limit);

update_cpu_capacity() is called in build_sched_domain() and also
during periodic load balancing, but fits_capacity_threshold is fixed
and should be set once

I'm not sure to get what you want to do here. Do you want to get a
tick margin at max compute capacity compared to
arch_scale_cpu_capacity() ?

On the big core (1024), this means a threshold of 1023 which sounds reasonable.
On the little core (280), this means a threshold of 268 (1ms tick).
However, reaching 268 at max freq on the little core requires 41ms,
whereas the task will be at 602 after 41ms running on the big core




>
>         sdg->sgc->capacity = capacity;
>         sdg->sgc->min_capacity = capacity;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a445add5cc3a..24008f1ec812 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1236,6 +1236,7 @@ struct rq {
>         unsigned char           nohz_idle_balance;
>         unsigned char           idle_balance;
>
> +       unsigned long           fits_capacity_threshold;
>         unsigned long           misfit_task_load;
>
>         /* For active balancing */
> --
> 2.34.1
>
