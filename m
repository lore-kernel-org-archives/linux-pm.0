Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795594691;
	b=CH5gFslFJBJjmMJ1MBcoPrKv+c1s+vBMsX82AzN5eDfC67aOw7CY+fGaLBnwYzCNQp+W
	 YOg7dVxdVz/iETnNym3hPD2ugrojMPE3BMtVJMRVFbVUqyTLI//LQePnY9ZCp3edzZpU+
	 dD1x15mvCbGB9klPooNHpoJAsH18mz4OW2YmPDfgypQs4z9knwuwituDzGYlJz+0qRpp9
	 AURhCKw3qBfrmiZzwPOlqP65s+q7X8lka22jZDUQXK1/SPknrhDrEoIotWxXMi59o0Nz0
	 XLIYeSD+wovDD9ArbnQcIfhW9FREfcPdyz3JozDHP+/dzD5fsqGIwhgsiHcUD+Ej/2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+TlxyhCe0EFo142JqOfaOYVkjOKNeFKPV+TihlUjknw=;
	b=1YQ1WgUjFzeb9HTcim8pk5iNGhR2LuYSWozfZJ0ug7w/z9INcGQMgev+TBouFYWdJvOL
	 faSEIa2L8MghH+bz81Lxi9FcCOJjl2DNyd+SjWKUiYo0tzTuFek16p9K65EX1tO6PpvJA
	 CPGLyIgiWFOzZKFKUwQTBLWClaQULk7PgZBO6H9QK0Z8Kn5UlzLn3vTW0+/l5gqd4iAwW
	 I/cSB4imfDVLu8fGEgq8xqMpF/OmRtfgr69tNFjBclK9Acpy1hnqqlsBXe/y3RNzEWzRq
	 AoWQW8UdnAarqPGwQX9pCg+vVynQBA/GKNGvVbF8brZ2iJPgkFrQLyaaaQH+eyMi9KA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R7ZaEPx5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED988606A329
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 08:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED988606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R7ZaEPx5
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6baa6f27904so4441245a12.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:18:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795594688; cv=none;
        d=google.com; s=arc-20260327;
        b=I+q2EMb5edQJog3Gl+t4U32kXQS0Abl4ATKuZEku45xaesQlI1E+Bj1WRiKRSVKsBD
         fOI0aXGYXkQOiE1vCrfMiS3Vhx87iK/5jDDOMM+JRSA61++ginxYB6RGxGP1oiq0/mQG
         dZrpZbQh5gCduF62r3t7WHq7gc8ojpw4/orLVuVChPYz7hNKf+eTankF/YHVEVfY5O5u
         nM6DdjTl+ruXDomHD+pM0BExw06VqrE2CE+dV/ruRFPOHha9uAICXgtJYHsdcg29m/W4
         gDR9xsIYWtPnPQMb2zmUVCEv5SdDIU+l+tJ2SIDcBKtSp4iwzbtQjFev/YphBSylZiiR
         QOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+TlxyhCe0EFo142JqOfaOYVkjOKNeFKPV+TihlUjknw=;
        fh=mPKH52XtEArKIHKv1+7SiFoZom0cc7ZyPSBJS1s0zBQ=;
        b=gjDPRpnyBqFuVFtiFUeX8Z+gJnLH38XDPVWeFZH43HmqRgDcfl8s1a3AJqI3cI4bCh
         LJiDdQ/7aUyPLGrS4JhOFivCDvbxoq2FGhUA17dwXapmB5UbwE1vFLKGzCcG+3O/p3vf
         d8GhYHhBbtGA/SgZ5UnH/i30gVStKxQgWyHM5Y3gZRxnZgM/ZuXbxwDU59/XJmrqtmfr
         psM99fX1F56e4viT4od8a2+eEz5lHGqHA+Cqm/qBsSQox9VFx0wvI4wtK0DooMiTHW+i
         63y2aA9BF8KfQg7HWxxuPzxubiraXtyxRB8I1sR0Hzjst0fBmrxmuxnBP0wT2Hy2wYTQ
         iXtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795594688; x=1796199488; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+TlxyhCe0EFo142JqOfaOYVkjOKNeFKPV+TihlUjknw=;
        b=R7ZaEPx52mr6ZgEbtuQSyWvD+2bUGb9pNRXver4QpuoWSosaeMmkystGuH94UH1dXY
         NNhc48EB4i2n6sNqZfxdOPjFr06a1ImkfceNQ1EELzmMlbp5rb3o4IHFn1Ywo7PcDpa2
         zC4IH/5dwtzAPnJCz9viFmQJFR6VZKx7jm1JsIfFIHPTHVgqTpKut7dVp+uKld73gcR0
         /sOGc7AmdH5yG/HFUzheDCG2e5Oq8J5zvRVbTRWa4LKDEEuoNMh4LpBVxe8aZRmTzEWl
         bUJopYjrPSIoJBDY16kyi9Kx86E4ZGCjopg9Nb2lkcUGlPDeLKOU7ArEhRH/s94KHqPE
         uzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795594688; x=1796199488;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+TlxyhCe0EFo142JqOfaOYVkjOKNeFKPV+TihlUjknw=;
        b=V1v4kArHYHwN5shyoeQZX6OqpDcRsFAwvf0Uj4i4m3eGaWzweRN+sb+KrmJENj62fu
         Jo8JKapvYo1Fw7tM/XED4k1KBp7nk6tjuwc6e/jAxbOJ7KUVX22zsF1Gl7UDEsoz+YtH
         kSW/KlBEvb3wCBOLJKw3v3rHj1OcFFjUZQ09qlCepvJhQFxGwlovVjeShbtwpxgZGSkC
         7Vm30Ho6ckPmRpEtaBvIHr+yr2vkhRsYISuCzTUTUYCAiZeWln4h/ngm8h/3Cvn2HOBl
         zte5JwwAwwGL/TPRHfZl3eDsm8KJ4z2nTyMIsmP1DMxuTWdtMtQ8mR0nz4ruo3Wvhd3D
         IqKg==
X-Forwarded-Encrypted: i=1; AL+hErFPx2Qkux1OlidEAaNAmu/j3KbXTXiDNOG/MXlZbfS8i8nBbtmHR9dV3mg2ENYuvUAYMY2N8suQLQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8vrGcKkvRv7nDfdeETIOz4h8MjyKce8O4GM4RnFXWfuRfUclef
	lC7YOp3++yJU/iwmeNeTA+P8m882Ep0QgUn2EkjWRgYATZScAENSRzyAa7XfXE7A69hJWINLXG9
	0jlPI5RXykIaDU7Oqg48rhnTrCmQjYGBzSHsJvFyD6g==
X-Gm-Gg: AZFdTZc6QD3lITPdB2ApiKX5vgdQGU6BQcKOT3jDkue6XebdtqDhNXGB+hmPECMosA2
	xZIKg6cxWOIgJXpWAVROkqttxzB7NiRdCnPR+RiRhC4CdOCanQJtr+ZJSX/IARGouwm0igvWcY8
	+72LvSXSfV/C3orqBOeW7GwWLgCo5ITKtqZuhtfikriOWdoKUIxudakYF6Gn2x0ZyLnOUDhDCRJ
	qZ+hRw6BLdT98s1RV+UOuXikP7464miKHJElkNSh+J8MPF/i8Ndld4iJb2TeJjxChhwJYjetnow
	C/im8E/XpzY3HQKOT73Xqk9wjIY01PKd3KG4I8KvUklGF5BnZamGIdPz30G2lzwgckFh8+nsMum
	uaz3jziDc1n9CS8oNvha5aEe75qVZ1t9nq47CJjDfJM3A+AiaPN5/RmB1iNsiMLPRlTA=
X-Received: by 2002:a05:6402:510:b0:6b4:201f:17d6 with SMTP id
 4fb4d7f45d1cf-6ba37e69ce8mr9553464a12.16.1795594688009; Wed, 25 Nov 2026
 00:18:08 -0800 (PST)
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
 <20261106151947.3991524-2-vincent.guittot@linaro.org> <50f73e24-bf40-4fcf-a232-8747087ddbeb@arm.com>
In-Reply-To: <50f73e24-bf40-4fcf-a232-8747087ddbeb@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Nov 2026 09:17:56 +0100
X-Gm-Features: Aa3M54pfpxEOr1H_7jVIj59aJvakodQU1grHxa6VKKndnKMJH8hAKrAlbFJTmpM
Message-ID: <CAKfTPtDJFkSJm67CzoB=p5PCc60eVToEcy-=bxaThLXr5KGd7A@mail.gmail.com>
Subject: Re: [PATCH 01/20 v3] sched/eevdf: Decay positive lag of sleeping entities
To: Elif Topuz <elif.topuz@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Elif,

On Tue, 24 Nov 2026 at 16:13, Elif Topuz <elif.topuz@arm.com> wrote:
>
> Hi Vincent,
>
> On 06/11/2026 15:19, Vincent Guittot wrote:
> > Similarly to delayed dequeue, which enables an entity to decay its negative
> > lag while sleeping, a task should not keep a positive lag forever.
> >
> > The sleep duration and the weight are used to decay the positive lag at
> > wakeup.
> >
> > Apply the decay when enqueueing on prev rq for which we hold the lock to
> > get rq_clock_task().
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
> >  1 file changed, 90 insertions(+), 34 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0feec172fd37..5cd171f830d8 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >       return avruntime - vlag != se->vruntime;
> >  }
> >
> > +/*
> > + * Signed add and clamp on underflow.
> > + *
> > + * Explicitly do a load-store to ensure the intermediate value never hits
> > + * memory. This allows lockless observations without ever seeing the negative
> > + * values.
> > + */
> > +#define add_positive(_ptr, _val) do {                           \
> > +     typeof(_ptr) ptr = (_ptr);                              \
> > +     __signed_scalar_typeof(*ptr) val = (_val);              \
> > +     typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> > +                                                             \
> > +     res = var + val;                                        \
> > +                                                             \
> > +     if (val < 0 && res > var)                               \
> > +             res = 0;                                        \
> > +                                                             \
> > +     WRITE_ONCE(*ptr, res);                                  \
> > +} while (0)
> > +
> > +/*
> > + * Remove and clamp on negative, from a local variable.
> > + *
> > + * A variant of sub_positive(), which does not use explicit load-store
> > + * and is thus optimized for local variable updates.
> > + */
> > +#define lsub_positive(_ptr, _val) do {                               \
> > +     typeof(_ptr) ptr = (_ptr);                              \
> > +     *ptr -= min_t(typeof(*ptr), *ptr, _val);                \
> > +} while (0)
> > +
> > +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
> > +static unsigned long task_h_load(struct task_struct *p);
> > +
> > +static __always_inline
> > +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
> > +{
> > +     struct sched_entity *se = &p->se;
> > +     s64 delta_exec, vlag = se->vlag;
> > +     unsigned long cfs_load;
> > +     struct rq *rq;
> > +
> > +     WARN_ON_ONCE(se->on_rq);
> > +
> > +     /* Negative lag is managed by delayed dequeue path */
> > +     if (vlag <= 0)
> > +             return;
> > +
> > +     rq = rq_of(cfs_rq);
> > +
> > +     /* No fast access to prev rq task clock */
> > +     if (flags & ENQUEUE_MIGRATED)
> > +             return;
> > +
> > +     /* Compute sleep time */
> > +     delta_exec = rq_clock_task(rq) - se->exec_start;
> > +     if (unlikely(delta_exec <= 0))
> > +             return;
> > +
> > +     /* For anything above ~4 seconds, save computation and clear the lag */
> > +     if (unlikely(delta_exec >> 32)) {
> > +             se->vlag = 0;
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * Use cfs' load and p's weight to estimate what would have been the
> > +      * share for p. task's load contribution to cfs' load is replaced by
> > +      * its weight.
> > +      */
> > +     cfs_load = cfs_rq_load_avg(cfs_rq);
> > +     lsub_positive(&cfs_load, task_h_load(p));
> > +     if (cfs_load) {
> > +             unsigned long weight = scale_load_down(se->h_load.weight);
> > +
> > +             delta_exec *= weight;
> > +             delta_exec = div64_long(delta_exec, cfs_load + weight);
> > +     }
> > +
> > +     vlag -= calc_delta_fair(delta_exec, se);
> > +
> > +     /* vlag can't become neg while sleeping */
> > +     se->vlag = max(0, vlag);
> > +}
> > +
> >  /*
> >   * Entity is eligible once it received less service than it ought to have,
> >   * eg. lag >= 0.
> > @@ -4693,38 +4778,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >       cfs_rq->nr_queued--;
> >  }
> >
> > -/*
> > - * Signed add and clamp on underflow.
> > - *
> > - * Explicitly do a load-store to ensure the intermediate value never hits
> > - * memory. This allows lockless observations without ever seeing the negative
> > - * values.
> > - */
> > -#define add_positive(_ptr, _val) do {                           \
> > -     typeof(_ptr) ptr = (_ptr);                              \
> > -     __signed_scalar_typeof(*ptr) val = (_val);              \
> > -     typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> > -                                                             \
> > -     res = var + val;                                        \
> > -                                                             \
> > -     if (val < 0 && res > var)                               \
> > -             res = 0;                                        \
> > -                                                             \
> > -     WRITE_ONCE(*ptr, res);                                  \
> > -} while (0)
> > -
> > -/*
> > - * Remove and clamp on negative, from a local variable.
> > - *
> > - * A variant of sub_positive(), which does not use explicit load-store
> > - * and is thus optimized for local variable updates.
> > - */
> > -#define lsub_positive(_ptr, _val) do {                               \
> > -     typeof(_ptr) ptr = (_ptr);                              \
> > -     *ptr -= min_t(typeof(*ptr), *ptr, _val);                \
> > -} while (0)
> > -
> > -
> >  /*
> >   * Because of rounding, se->util_sum might ends up being +1 more than
> >   * cfs->util_sum. Although this is not a problem by itself, detaching
> > @@ -8152,7 +8205,7 @@ static void
> >  enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >       int rq_h_nr_queued = rq->cfs.h_nr_queued;
> > -     int task_new = !(flags & ENQUEUE_WAKEUP);
> > +     int task_wake = flags & ENQUEUE_WAKEUP;
> >       struct sched_entity *se = &p->se;
> >       struct cfs_rq *cfs_rq = &rq->cfs;
> >       unsigned long weight;
> > @@ -8185,6 +8238,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >       if (p->in_iowait)
> >               cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> >
> > +     if (task_wake)
> > +             decay_entity_lag(cfs_rq, p, flags);
> > +
> >       curr = (cfs_rq->curr == se);
> >       /*
> >        * This can actually happen with CFS_BANDWIDTH, a task can be throttled
> > @@ -8225,7 +8281,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >        * into account, but that is not straightforward to implement,
> >        * and the following generally works well enough in practice.
> >        */
> > -     if (!task_new)
> > +     if (task_wake)
> >               check_update_overutilized_status(rq);
> >
> >       assert_list_leaf_cfs_rq(rq);
>
> I have tested the patchset with cyclictest and rtapp like you mentioned in your
> cover letter. I have used Ampere Altra with 160 cpus.
>
> I run these sets:
> - cyclictest with a 3777 us period and default slice with 2xNR_CPUS rt-app tasks
> that run continuously with default slice.
> - cyclictest with a 3777 us period and 8ms slice with 2xNR_CPUS rt-app tasks
> that run continuously with a 16ms slice.
> - cyclictest with a 3777 us period and default slice with 2xNR_CPUS rt-app tasks
> run periodically with default slice.
> - cyclictest with a 3777 us period and 8ms slice with 2xNR_CPUS rt-app tasks run
> periodically with a 16ms slice.
> I have also run them 130 seconds.
>
> Cases with continuous rt-app:
>
> | Kernel   | Slice   |   Samples |   P50 |   P90 |   P99 |   P99.9 |   Max |
> |:---------|:--------|----------:|------:|------:|------:|--------:|------:|
> | base     | Default |     34403 |    53 |    54 |    56 |     287 |  3996 |
> | patch    | Default |     26748 |  1979 |  5637 |  7119 |    9264 | 10895 |

the p99.9 increase is somewhat expected and related to patches 1-4
because we soften the capacity of short task to preempt current when
they have the same slice

> | base     | 8/16 ms |     34406 |    53 |    54 |    56 |     269 | 11880 |
> | patch    | 8/16 ms |     34256 |    53 |    54 |    62 |    9126 | 15429 |

The p99.9 value is not expected. Is it something that you can
repeatedly reproduce? Also, what was the slice of other tasks on your
system? if they stay to default 2.8ms they can disturb your test by
preventing cyclictest to preempt rt-app. I noticed that when rt or
deadline threads (like sugov) woke up simultaneously it could disturb
cyclictest preemption. I'm working on fixing this for the next version
I will look more deeply at this case while preparing the next version

>
> Percentage differences:
>                                         base |                  patch
> slice                                default |                default
> 99th Percentile                           56 |         7119 (-12612%)
> 99.9th Percentile                        287 |          9264 (-3128%)
> Maximum                                 3996 |          10895 (-173%)
>
>                                         base |                  patch
> slice                               8ms/16ms |               8ms/16ms
> 99th Percentile                           56 |              62 (-11%)
> 99.9th Percentile                        269 |          9126 (-3293%)
> Maximum                                11880 |           15429 (-30%)
>
>
> Cases with periodic rt-app:
>
> | Kernel   | Slice   |   Samples |   P50 |   P90 |   P99 |   P99.9 |   Max |
> |:---------|:--------|----------:|------:|------:|------:|--------:|------:|
> | base     | Default |     33795 |    56 |   901 |  4366 |    6156 |  9039 |
> | patch    | Default |     33081 |    60 |  2734 |  5055 |    6395 |  9165 |
> | base     | 8/16 ms |     34419 |    56 |    61 |    86 |     291 |   554 |
> | patch    | 8/16 ms |     34419 |    56 |    59 |    77 |     161 |   540 |

Thise results are more aligned with my expectations

>
> Percentage differences:
>                                         base |                  patch
> slice                                default |                default
> 99th Percentile                         4366 |            5055 (-16%)
> 99.9th Percentile                       6156 |             6395 (-4%)
> Maximum                                 9039 |             9165 (-1%)
>
>                                         base |                  patch
> slice                               8ms/16ms |               8ms/16ms
> 99th Percentile                           86 |              77 (+10%)
> 99.9th Percentile                        291 |             161 (+45%)
> Maximum                                  554 |              540 (+3%)
>
> With the periodic rt-app the difference between base and patches are lower, and
> using custom slices I can see the improvement. However, when using continuous
> rt-app, especially with the default slice case, I see the worst latency. I have
> noticed that this difference is coming from "decay_entity_lag()". If I
> understand correctly, most of the time cyclictest's lag reduced to zero after
> decay_entity_lag(), and it cannot preempt the rt-app tasks.

yes, patches 1-4 have the benefit to reduce preemption between tasks
using the same slice but at the cost of scheduling latency for short
sleeping tasks.

>
> I have also run hackbench with continuous NR_CPUS rt-app tasks with default
> slices and custom slices (hackbench with a 8ms slice and rt-app with a 16ms
> slice). Both threads-pipe and process-pipe for g=1 and f=160 gave around 50%
> worst execution time with default slice. When using custom slice, this
> difference is much lower.

I haven't run those tests but will look into them. Have you tried
hackbench alone and did you see some differences?

>
> Default slice:
> MODE    IPC      G  FD |    Base(s)/CV |   Patch(s)/CV |   diff%
> ----------------------------------------------------------------
> process pipe     1  10 |   0.172/10.9% |   0.077/25.6% |  +55.4%
> process pipe     1  20 |    0.409/6.7% |   0.558/18.9% |  -36.6%
> process pipe     1  40 |   1.145/23.1% |   2.176/15.1% |  -90.1%
> process pipe     1  80 |    5.326/7.5% |    7.248/8.6% |  -36.1%
> process pipe     1 160 |   14.105/4.5% |   21.404/6.1% |  -51.7%
> process socket   1  10 |  0.055/113.9% |   0.176/35.8% | -221.8%
> process socket   1  20 |    0.467/3.5% |   0.454/21.0% |   +2.9%
> process socket   1  40 |    1.014/5.6% |    1.062/5.4% |   -4.6%
> process socket   1  80 |   2.584/10.8% |   2.820/16.9% |   -9.1%
> process socket   1 160 |    6.786/7.7% |   7.525/13.1% |  -10.9%
> threads pipe     1  10 |   0.050/10.9% |   0.148/14.5% | -198.0%
> threads pipe     1  20 |   0.283/65.4% |   0.650/10.1% | -129.2%
> threads pipe     1  40 |   1.285/53.5% |    2.269/7.9% |  -76.5%
> threads pipe     1  80 |    5.702/5.7% |    7.727/8.2% |  -35.5%
> threads pipe     1 160 |   14.412/5.7% |   22.659/8.4% |  -57.2%
> threads socket   1  10 |   0.218/13.2% |   0.237/23.6% |   -9.1%
> threads socket   1  20 |    0.528/3.3% |    0.533/6.3% |   -1.0%
> threads socket   1  40 |    1.085/2.7% |   1.269/20.3% |  -17.0%
> threads socket   1  80 |    2.549/8.0% |   3.258/22.7% |  -27.8%
> threads socket   1 160 |    7.241/7.0% |   7.909/12.3% |   -9.2%
>
> Custom slice:
> MODE    IPC      G  FD |    Base(s)/CV |   Patch(s)/CV |   diff%
> ----------------------------------------------------------------
> process pipe     1  10 |   0.053/54.7% |   0.040/40.9% |  +25.6%
> process pipe     1  20 |   0.373/48.3% |   0.318/13.1% |  +14.7%
> process pipe     1  40 |   1.130/40.4% |   1.704/23.1% |  -50.8%
> process pipe     1  80 |   4.570/14.0% |   3.558/15.2% |  +22.2%
> process pipe     1 160 |  11.877/10.9% |  13.374/17.3% |  -12.6%
> process socket   1  10 |   0.068/15.1% |   0.095/34.8% |  -39.5%
> process socket   1  20 |    0.222/8.1% |    0.278/2.1% |  -25.2%
> process socket   1  40 |    0.716/2.7% |    0.660/4.6% |   +7.8%
> process socket   1  80 |    3.261/9.6% |    1.768/5.7% |  +45.8%
> process socket   1 160 |    8.099/3.9% |    6.134/9.7% |  +24.3%
> threads pipe     1  10 |   0.048/31.6% |   0.060/29.8% |  -26.1%
> threads pipe     1  20 |   0.264/15.0% |   0.232/17.2% |  +12.0%
> threads pipe     1  40 |   0.838/20.9% |   1.558/25.6% |  -86.0%
> threads pipe     1  80 |   5.794/15.9% |   3.933/23.3% |  +32.1%
> threads pipe     1 160 |   14.666/7.7% |  12.614/16.4% |  +14.0%
> threads socket   1  10 |   0.068/14.2% |   0.111/27.1% |  -62.7%
> threads socket   1  20 |    0.232/8.2% |   0.334/12.1% |  -43.9%
> threads socket   1  40 |    0.753/5.9% |   0.983/14.5% |  -30.5%
> threads socket   1  80 |    3.655/6.3% |   2.585/21.5% |  +29.3%
> threads socket   1 160 |    8.959/4.6% |    8.628/3.8% |   +3.7%
>
> I have also used g=[1, 4, 8, 16] and f=20, but didn't see much difference
> between the base and the patchset.
>
> Thanks,
> Elif
>
