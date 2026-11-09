Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794239738;
	b=c9cJK5UKTp6CFbEZBT7XxFXDKUxA1h5N8ein8kjdkmjod2/6RoDLQaUuRi8qRWxsOEk1
	 xZWAUCKrKKuoGRzMIQXg25FTGomAEY5t9lsIsUNXSHDsyiKdIgF6ZDO68TFkp5xw5DiQd
	 IB2dZUsW5dkQDhFy3shknAdC9PYpWcfiQTTW40bRYAB9Z+naNAw25QcQJfpALnFoOk/xm
	 R+X8UMkK1dGCW2vLgyM622b+6A17V9SNBulGa/FO5CA0Ud21/TkjiNKg/r741RsM7f+8s
	 Q8KwjVxaI0XcToUvIOaU+R4TZWx3UdrjCcnzAK6fQCDRi7hPfRs7Qw8uvhbGGyakBxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=U0Jsq4W3eeFxH08Ha1MiRKApbxlSGjDxuaxUFi4tWRw=;
	b=DYTv0qcYcOyCA7E3IoReYX4bRiOpoQWI1pJOcGDy/cZL/qPmcxb+0spyLrL1G8ZXExOo
	 vzZtE6AGF+a+Pmj6fYtZqLCv8WBJqYUPwtkrsM7WxMvKicarZlq8UbdY5WYwWb2e0lztn
	 CRT9UxCVoUbLyzCgCw+jxC/y+uIjV8x00AntVhw3bTQJiqZRLPaQMWtpxxOCaImrEWEne
	 Q8MlotGf7X+b5TeKk/J1N+cwjSJue94r6jV3L/zWm1LFo3n71PYC8JqJ7McKIH6BGumtq
	 5tfkhrr3ApoNj8OJqcGpTbRUAT8ZwQm6FqTlweIZoLFtC2+yAK6VGWtsSAqjuJN+izw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HW1wRTVA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ACD606A325
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5ACD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HW1wRTVA
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so1714463a12.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 07:55:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794239736; cv=none;
        d=google.com; s=arc-20260327;
        b=ORAHeRIY/j1ObA01rIUKr4cgUtBIVwJlYeI1IZniP3FaROco3+LSV2dsSUodKyBXT7
         YnTSWa9to1KPK3nDvtapPAPODd/C5plIYMYvBCJxvb2L6OnmjSjlouA5SSZ5ZTiIzOW9
         0tbAEut/gOMDVepSJft5ZGp5WaYL37pls3BGxAj79x1VRzX5XHbIBuDYcErGy70kbfKd
         DP01LMPvr/tBrE494LxcmEB8z4pM6NIilgr9SPk9I++949+XBM7iUd1CWixH8WCQyxAU
         yEHIydPgudq1nT/Jnt4aMKRqiZUnQucFNY1hQNKVTg0Wbi7XRJaXp0ooIrjoODhys7Ia
         4rUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U0Jsq4W3eeFxH08Ha1MiRKApbxlSGjDxuaxUFi4tWRw=;
        fh=31ceDwyUHqs1B2L0lC5brTsbSz/M1V5r5Ag7irCX/3k=;
        b=i1ABCNr1yk9pek4NlyooncTYq4Z5pNsNNy0uM1GrLkk4nkTLgAdVGXVaOjq4hsXR81
         O+LYXFz69k7JwoxSZ2DVYTP23ofEXb6lEOhDYQfnL9YtK+2P5h8VEP36yOd3G7F283Xc
         uDeaHGIty77VN+szSLVFIuKpsve8kF7LxHD2Oz4InSDHxOIYxM7BSz0UaISPB4MKZpXt
         AzeUHeFHPikp+1JEAkggOv8u2Q5cnVXj1KoFuvYxGvOQ6UnJ1dMYdBqrj+FWeBP1c2nI
         P3SkOZK6WWCZlyEu+DeFtXk+4CZWsXmFoWxkiB1UHxvV+0OMoGx2RGJT3nErZC8EzCcR
         cuVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794239736; x=1794844536; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0Jsq4W3eeFxH08Ha1MiRKApbxlSGjDxuaxUFi4tWRw=;
        b=HW1wRTVAhKtUfRmelOIEsw4AclL5bmEWoRQz0cHDEZ1imHxc3EYOZWOk3pO9cNaNyS
         US/qgf8pAyvyGA60AugAkd/aMcQf9vxOIZAnM1zfwFJfqfftroT6qgDKfBglkBuSch9o
         /2HLdgkOTsuckeJYr8CbaQ9WfQLm7H2sejii56gGsNRhH2irilTzFlY/Vhbgx6nST6za
         PggdINlnXx4Ym4q1dSE+PQCQ/neZbuTC31wGPny9rQk/GZngdul2tQXFE55fXFREYswO
         T6XyVtTk/UE/L6HYufZGdErT8DgWxKbjhIkBm63k8sOjRQSOVTcG6DK+QwDEorxgibvd
         cjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239736; x=1794844536;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U0Jsq4W3eeFxH08Ha1MiRKApbxlSGjDxuaxUFi4tWRw=;
        b=Luk9yBmTbCzwO16Nkwbh/IlXSRNJPcfaW+1OycHo+0dIFUR7/vaqZi0SSMFxQY8WVE
         amdjQw3sKujfYMVgzlBSwur6PLOWm4R2PYfaTg1TzJzs5gv2H9/bGY5pwebRnIJMh0H5
         QJB131/FE36GNblo2Hy8ReB5qzLSWHQ9sUcLSxjPzaoewxZDbTPmK4D2TUgv4SWKG3M7
         cK9DEvmZcxgeou3fXmEv62qESZopDNNRsSnSCexHlbufNw9srxvtux2OAvk3wP5NHZfD
         WjYJncRHFqpU1yrq4dAa2s+3qYYXRUf2imszcBU5HHgXrjOgYpG5vjNmLobZLFjZV/iW
         Qfsg==
X-Forwarded-Encrypted: i=1; AL+hErHLEQgn6IXgIiq8S06PXp00tv57VFRbikrtHwOW60DcCmswtb8w441Om44S+oz+V/XNEFlX3gV7cQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8FCDmkKzZ9ELW/NTCyLmSDDSaGfXwZ6KTpKZMbghnZGeIG7JKJ
	KqHCkH6IvjEPxg9XBWOjdYwp574npwUovBBr1nTN2QT/U7ro43JX0S3PqfYw8veuc1IjKJ7VqUW
	8QKcBB1wZ6epmXaLP/9Mno3Nl4UUA0XLgyYx+1dZKRA==
X-Gm-Gg: AYBFou3wNvHxCtBxIQzhFuvIs1XTGQq0adsdXGOn/yqe8De7Zd7RvBv1iLwElFwxC3X
	GVRO9/luYpp5TAGLEdWZ0q9anNOx+U+0PvGs6tPqu0fEEdnnLv3iYn6asRmyDusTMqQ3T17pkMK
	AG2OunxIFhYuz1SSwOsfcWhhyNLYkFX1gyFvyana9rr7yeosQVzi6W1AsJdR4LTONl7O/Gfjq8P
	igzInLvximtPWuSWa8yjzflc1OiozwWtJpVNDE0LDSDn8C01mwusRk2wn3xOa1nC/UCKjwurxez
	je8zC8UgkGq6CpuSgn6LmI+GScVMLkj16Jy8ciOMf2eCXgzE3lFQNK9lnWXjJ3OvBThNoqkJTdv
	YPsrZAA0qOYjQD1a/jwz61U1UKgMBbgdYk6puQ4xi/3xdfx1toZeG9AADB354JqBEMGKAxw==
X-Received: by 2002:a05:6402:561f:b0:6b3:d0e9:2e87 with SMTP id
 4fb4d7f45d1cf-6b755e86651mr30882a12.5.1794239735838; Mon, 09 Nov 2026
 07:55:35 -0800 (PST)
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
Date: Mon, 9 Nov 2026 16:55:23 +0100
X-Gm-Features: AclHuK9poa26sv5bNbXpCPCpPoDt4sJTZSu0qBPd_Ku0HfRlx1XeQt-Jp_S2E7s
Message-ID: <CAKfTPtBfXOcAd=5RkYepRn15Hg=id9FQ3jh1tQoewOtUSrsjHw@mail.gmail.com>
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

Regarding sashiko's feedback about cpu state ranking, I chose this
ranking on purpose.
For !SMT :
- 7 CPU is idle and fully fits (i.e. return immediately)
- 6 CPU fully fits and is not idle but we can preempt current because
of slice so the task will run on the best CPU immediately
- 5 CPU is idle but doesn't fit uclamp min. On such a CPU, the task
can easily miss its deadline
- 4 CPU is idle but doesn't fit at all. This is even worse

For SMT
- 7:CPU is idle and fully fits (i.e. return immediately)
- 6: CPU is busy and fully fits. Although CPU is not idle, task can
preempt current because of its slice and run immediately on a CPU.
This is similar to an idle CPU (and maybe even better). While writing
this, I realize that I should probably check the lag too
- 5: CPU is idle but doesn't fit uclamp min. On such a CPU, the task
can easily miss its deadline
- 4: CPU is idle but doesn't fit at all. This is even worse than -5
- 3: CPU is idle and fits for task but sibling is busy
- 2: CPU and sibling are busy and fits for task and like-6 task will
run immediately
- 1: CPU is idle and doesn't fit uclamp and sibling is busy
  0: CPU is idle but doesn't fit at all, and sibling is busy.

Note that with the push mecanism we could look for another CPU for the
task that will be preempted

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
