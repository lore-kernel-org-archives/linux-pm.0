Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794238485;
	b=Jx7nsQsTxdayQUKXjUfubfWW2k5kqnjXzAQa242Bbz6xrnkMJubN0UzV+QRZ0ScptSfW
	 NZ8FGCYlZVOB21mI72yYHInnd0rlR+tA12qQtsNheEV+cOPZ24X+97aXX0wHM0Didj2Rx
	 tJRYJa+qny1GLwos5H0EzCfMQnJXWhSSUakCI1VQQICZNmFrt/Ldx2X0fhTNvUCh/KszT
	 gOpyfA6/B10WjPjc4mIBmQ6IaHF6OpVejFA+klj1ozwY/1/Y3OvqFy0QW9xmUCE0Ixibm
	 iLiH01uI39UPAjZ6Ybsl6NxtFJmYkw9/i60C2ybIvz3qTmwFtBkWQTtfDU0SJBcxsjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=tZb/JlzaDfnhk48XsH57Tsc9HiRXe4mXenMyxxS+EE8=;
	b=J1IUGszR9WeVVIGrKgffZNxo4OAQI6ZxA9puiyhtUDadahz75ykxhF/q7P0lc8bkjkPI
	 BvFDNRU8z6sBDcyzmSF/ro09ickKq+hAD82NRxd6iyGKcHsRGR4k/OGWmA0i7heTALvNP
	 BoCRCmYfGgppyYRpPBxydj5YEBLOavzJ0IK43B81acW7v6L+owiZGIY7RhOxQF8m/0leu
	 lSRB8Kp8ZQlb8SMqpaxKiRS6ILJb784fGuzRFccYXye55dy/24gOPjM+EFuQVga6/HDAk
	 LC/vaQfY+o8drOqYEtrN5sf+V+tKCBLMvgSwu9SgdQmLcRYst0B5NOY875LgYkFi7+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xHEbewjz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8E606A321
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC8E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xHEbewjz
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso143660266b.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 07:34:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794238483; cv=none;
        d=google.com; s=arc-20260327;
        b=V2HfT6XqKDBzA/2o1wsjuIwb2Mmn9QuoP6SFlDGSHZP3ajS76PnNRJRAUlx1/NYus2
         KI0BnbYARCZ/ytqoe5LX2wiGhCfKO3hG3of6nWbZVZD42UF5L6kFakMmH9a3JrlRQ/Pw
         7weokr46tSejDnY0sKf1iMdgWoeX0BmcX5lQNni8TNRwVhm2S2NfoMP7kKNRnYxRhgrU
         tWcZhcjaC7r5MexB4sqopvNJKWDaNHrN1+YBXws8Exs3x10R7NqM02BBek+5iUEBEPsB
         1FOfNdpgG22FXDZ9E3sGedx2odokePjoGuBAKymlVXhPgsqLCt1hDPyrN4JL+puEAHiW
         jq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tZb/JlzaDfnhk48XsH57Tsc9HiRXe4mXenMyxxS+EE8=;
        fh=/wQ0pnPs+ssiETm0Rvt+Zu0jKFQb/gJLOIDDVPpIJxc=;
        b=qa+SyWBONyKqFN28QklUhguyvYsYj6P0a0Xj+DxnJ0ZFJfe+7WaRTFfjwEi+fHz/4O
         cn+7DTlPwaBxUSmJqWmMqZL+bul9YbwVkIH9j1og+iE0n1YVtXbwQkVAg+VObv/09UAa
         wuBV8YgcD1R07DRMIC69uMboH7F0Gqi2LU3latNCLP/AaJOD0u8B2wRCAx2xexRPZ/bk
         VIJ6O+CYE1Nf0Pfv/NfE1zfsIbRZCe7TvPvFlGFfecBzBtkJE65KSdDGfEq63gBN49Nh
         OIjGYaX7OMgdCcVTwCfh96hzZquOD3rkAVQkcedRPqPUI8VaLBHdwbLSb6qhx/6Zv5WC
         MZwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794238483; x=1794843283; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZb/JlzaDfnhk48XsH57Tsc9HiRXe4mXenMyxxS+EE8=;
        b=xHEbewjzycILTidDukHvtOhGBmVf//ioViiMKotptHw3BVJgUcoP+CMJrKmkHx6eA5
         HfP6EBDTe5FclHi4weXdaycv9kqwIbl69t/oSTC3/mMLJaOmShktiCAMZkeipisNawha
         bwR0OnPQs8bG3lTBu0JQvkE2PCttOPjif3z34x1tkUAubjBStq9+zd8uV6c3sXgqG66K
         iZYogm/dgSSmv8Z/zaWcLkLzONS9/v71tSx2y5IKoLGxmWjWjFsq4OckUs6QnnBHY5HN
         jpwybQLXMghbmTqeZ+/6mj25gu7GkCuKl2Tb58YZkwrTI8XtDWFBakiK2wexfqtRgFQw
         +3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238483; x=1794843283;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tZb/JlzaDfnhk48XsH57Tsc9HiRXe4mXenMyxxS+EE8=;
        b=N9PkiPS4wPUa08WRpuhObQbws8HQbiSbQoHbOnD6KXrGsbXgUvfdYNuRuABXlPbTsg
         uLp7tr6OcWgymN4PfxZBYUEF0H/UyyRS2hNtwvuUVJyJOzDIF3g0OL/7mJjI+cn00s+Z
         L6aL0GL+u59AvAnK+6f45uHhgX8FBaFmdHKHbP/8FAaUd3NAP+W+E9aP1qIKF0C0dYUY
         fhc8Tmd6CckmbWadz+VvE0D3q2CleQsaSYQus19ze4gzlzfj6RhXLQmsI9R7P/B1DhgR
         5raZTs5DOeltJQvA9tCWKmxfmGmjqz2U/l/rnOjNHVbsFu4YjBY85sX9NUqsfmfklwf5
         vDLQ==
X-Forwarded-Encrypted: i=1; AL+hErF/yvPQFoZaDvIsn8l4X9PwjlvXtqVkulknqOLUhPznYdx1BGAhOGSN89upcXaacNyqe9wvnhhUzw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9kvAce5gJNHqXdaa/Z9Bt74nK5UuqVOv2mRKJ+viHsBy+uoqaC
	51Uv8bzJYl6BZb0o2jWSEL57iJhLxGnIjAK2xuUdjUYISpWFjJ2v2fsIZfekQCXuyVLcNDq+0WN
	g1mWBPTVQ5/c4wyxdT7/8dAeAKbqj5Jg4h4WStZ63IQ==
X-Gm-Gg: AYBFou2kQ2jwAWmkhr1Y9hICKuLmlkkO7qsE5e/E5Q6Yo1wx1pPGXu3T57yEkNQKUXw
	2nerJI3omhhBavQ8zEbfbYxPFlO7Iz640/EiKKwOvyjUyTZxGcOYiX2AgcxzmWnTqCUcFflR/uf
	fIfxCkVYHOP3rX+PHkfhSnHoJYUe9jhiRHxgxFpNHWNfCyj+lknTBqfVkisGAQ8GRUka9avF43u
	HJaSPVTnkEqHTObhHPxyzGt1g7n98refYpGObChi7YRd1RLvWuWXoBDhlxX8rSnQv647aY7yegx
	HTIpdijqYrVyPz+QjvC+duIXrYgDuZgi1F33Fc7uX5CNANNP1bc5A+RshgbkPKG1S+ATppimnbu
	WMcpVn5o+0no4XTkSarYXdK0nISDtC4uTY/eYAp5p3Yea6LS1+1YmEoUrucGV/nYFhOSOSGDv3i
	fy6El3h23BtfJXWbg=
X-Received: by 2002:a17:907:c06:b0:c49:d1c5:431a with SMTP id
 a640c23a62f3a-c4d6dd7ce91mr380002966b.38.1794238482427; Mon, 09 Nov 2026
 07:34:42 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-7-vincent.guittot@linaro.org> <au7SabL5pfbsApyB@scheduler.schedules>
In-Reply-To: <au7SabL5pfbsApyB@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 16:34:30 +0100
X-Gm-Features: AclHuK9N2muwxBwXja5tSUoZCIluDqTOafx-CvDIw1G2kK_wi6hfcBvvANqgYW0
Message-ID: <CAKfTPtAen9jnDpaE_318hTys9ek5VzE2LUaXGz2LWdGYfOtaEg@mail.gmail.com>
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting CPU
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Nov 2026 at 09:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
>
> Hi Vincent,
>
>
> Sashiko reviewed this one so I'll just put here my own concerns instead
> of repeating.
>
>
> On Fri, Nov 06, 2026 at 04:19:33PM +0100, Vincent Guittot wrote:
>
> > Add a new level for selecting CPU when select_task_rq_fair() fails to find
> > an idle CPU. This last level compares the min slice to select a CPU where
> > the task could run 1st.
> > This helps a waking task to select a CPU where a longer slice runs
> > instead of one where a task with the same or shorter slice already runs.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/core.c |   2 +-
> >  kernel/sched/fair.c | 157 ++++++++++++++++++++++++++++----------------
> >  2 files changed, 102 insertions(+), 57 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 031efe7d49fb..d71da9069218 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9012,7 +9012,7 @@ void __init sched_init(void)
> >               rq->sd = NULL;
> >               rq->rd = NULL;
> >               rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> > -             rq->min_slice = ULONG_MAX;
> > +             rq->min_slice = 0;
> >               rq->balance_callback = &balance_push_callback;
> >               rq->active_balance = 0;
> >               rq->next_balance = jiffies;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index cfc99b94d9ce..039dce244aaa 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8842,11 +8842,25 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
> >       return new_cpu;
> >  }
> >
> > -static inline int __select_idle_cpu(int cpu, struct task_struct *p)
> > +static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
> >  {
> > -     if (choose_idle_cpu(cpu, p) && sched_cpu_cookie_match(cpu_rq(cpu), p))
> > +     if (p->se.slice < get_rq_min_slice(rq))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> > +static inline int __select_idle_cpu(int cpu, struct task_struct *p, int *slice_cpu)
> > +{
> > +     if (!sched_cpu_cookie_match(cpu_rq(cpu), p))
> > +             return -1;
> > +
> > +     if (choose_idle_cpu(cpu, p))
> >               return cpu;
> >
> > +     if (*slice_cpu == -1 && choose_sched_slice_rq(cpu_rq(cpu), p))
> > +             *slice_cpu = cpu;
> > +
> >       return -1;
> >  }
>
>
> Look here:
>
> CPU1: CPU2:
> FA    RA
>       FC
>
> CPU2 has 1 RT and 1 Fair tasks named RA and FC.
> Let's say RA is running on CPU2 and FC's slice is 10 ms.
>
> And let's say FA has 8 ms slice, and a fair task named TC is waking up
> with 9 ms slice:
>
> * We look to CPU1, 9 < 8 is false so we return false
>
> * We look to CPU2, 9 < 10 is true so we return it.
>
> But the problem is, CPU2 has a RT task running and we are going to
> compete with the RT task. In that case it can be worse than CPU1.

Yes, but we don't really know. The only thing we are sure of is that
TC will be the 1st fair task to run on CPU2 whereas it will wait
before running on CPU1. I tested more changes on top of patch 20 to
handle the case where the task is enqueued on a cpu chich run higher
sched class task, but I was not yet convinced by the result vs
complexity.

>
> So, I would suggest something like this or so:
>
>
> (My editor got crazy, so I had to copy this diff :<)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 262626455497..8b0dd858f332 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8876,10 +8876,8 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
>
>  static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
>  {
> -       if (p->se.slice < get_rq_min_slice(rq))
> -               return true;
> -
> -       return false;
> +       return p->se.slice < get_rq_min_slice(rq) &&
> +               READ_ONCE(rq->curr)->sched_class == &fair_sched_class;
>  }
>
>  static inline int __select_idle_cpu(int cpu, struct task_struct *p, int *slice_cpu)
> @@ -9193,7 +9191,6 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>         bool has_idle_core = sched_smt_active() && test_idle_cores(target);
>         unsigned long task_util, util_min, util_max, best_cap = 0;
>         int fits, best_fits = ASYM_IDLE_THREAD_MISFIT;
> -       unsigned long task_slice;
>         int cpu, best_cpu = -1;
>         struct cpumask *cpus;
>         int nr = INT_MAX;
> @@ -9204,7 +9201,6 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>         task_util = task_util_est(p);
>         util_min = uclamp_eff_value(p, UCLAMP_MIN);
>         util_max = uclamp_eff_value(p, UCLAMP_MAX);
> -       task_slice = p->se.slice;
>
>         if (sched_feat(SIS_UTIL) && sd->shared) {
>                 /*
> @@ -9260,7 +9256,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>                         else if (fits > 0)
>                                 fits = ASYM_IDLE_THREAD_FITS;
>
> -               } else if (fits > 0 && task_slice < get_rq_min_slice(cpu_rq(cpu))) {
> +               } else if (fits > 0 && choose_sched_slice_rq(cpu_rq(cpu), p)) {
>                         fits = ASYM_BUSY_THREAD_FITS;
>                         cpu_cap = get_actual_cpu_capacity(cpu);
>                 } else {
>
>
>
> Cheers,
>
> Kayra :-)
