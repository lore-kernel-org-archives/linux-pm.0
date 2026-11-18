Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795000886;
	b=SyDHugGVtYwJB2oesV8QGYkiYJoLDGOyavNgoOWMKFjuWxG6EKei8PWM+08c6HfKBhur
	 TIcvQJo1/ZYz6sXjpnsD29FlnSW5UQqZk9127hVg59RRfZt35kqbm/DwXXuT4TTX7r4Qm
	 yS90zZ4r/iFM5vjRpp5aXLb3qYFGQpMw6gxNRML/JbHeR5vFKsGZKd2jd5rajp15qMuLz
	 fKWkiUvJr5O04tf2OrTePqGLxzLB/5AMW8om/v/hbAoyjaxKkrRPtVCPafF99fR2Jm2BT
	 MgInJyT6+PpPPtfJiL9y4VVPQSfGN3XFHO1Rbj3ycdSMxJq3xub/ikzHpQiWSoYYFww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ftWeT9v9vnvRt2kmLZwEf0dDqTmHNYp8z9nzUAEucvg=;
	b=XbunKi8LV/zIGXuuKkYlVGFJXljOzB9OtWaedFsIHdtCgA5ZJuWryVMqldj55uCdhZnM
	 GGALpPHLxL+SvkanuU1upb5zzzh3WzKc1V3OMmzoXLHsbJDtbjuLKKX6f/oQJR3IBdEX4
	 85cT9oXFKkTsdymmBVETWsnH5dyvoOq4bP45GSLAFVOfj/JEg+ys3ygJ2IiddTt5wvd7l
	 JsDI6VhqUErkPNwmzVppx/XjI91NL8oP+S0dd0dRnIQnkoS5a2UK4P3ZSXw+y0OmWGtYy
	 lNxqcuIsAcooj+Ack0vQYl0j8D7MaI3KivWAgGhN3KTtYVz8kjr8+Fn5kHI2SjR3W7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kdxJdYtE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CA606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 11:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 405CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kdxJdYtE
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1727567c88.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:21:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795000885; cv=none;
        d=google.com; s=arc-20260327;
        b=kwBIo2cJtib2xhskC+ZVMjqC5KPw5FNnSgQIdESErfQZMZk7KYPuzrfVRCOiq4LtHF
         ry2uqNJVDMwGkhv/vUrqo5qkyW/nSditrPf59m7VV3A1JSezlcmkWT5LvA+KWtlkuaWi
         5jlT7gcDWYoF89yT80gnZwOi8UqobL67daKmWt4Ufiii7jFWTqzFvc1I6JBpTspHeD1U
         HJtM5kIC07n65+wEVDWH0ADSLCkFZlj6SzrynarVevytvYcuvs1vEqfL4FpqIrq+NOa9
         YzvTxK+ZeImGqP6efudbRTXMZkV0o6fQ1iRCmu7RhMOfDx5aqb9IipjfPSmmtol/GvTK
         eifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ftWeT9v9vnvRt2kmLZwEf0dDqTmHNYp8z9nzUAEucvg=;
        fh=BkHo9rEzQDbeuLNp689PzmnKegMq/L6tkEzPlsF4TVs=;
        b=DQQ6lzrkIbpc1MgfJ6XpgWnUhi/mBiahQFPfWoNwDdkKY+0eo+M/IehmuOjvNEuqUF
         I/V0+pM89LbYkbXLslvmayV6oOueoiotXDFRWMMRDR33CAel9q/7eWiMnw37LegXh2fb
         bMS7caO05mUZlt0KBhRO3Qdl+7qQb385Y62U/k02EwlMdq4eHWzj25bS64kGBAemj5e7
         nNxcLkJqf4GiHkmqMCisq1jNH9mfjQ0ycEQyfQDrsv/gwo43gm7JASUEsU5unrS6Z7Zo
         66a9kWO1sl4gOKDW5s8xPV9qhY61q7FvtA2RgAlylJRT0Dx1Y3ruHWOTmkXoCT7vETA1
         ispQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795000885; x=1795605685; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftWeT9v9vnvRt2kmLZwEf0dDqTmHNYp8z9nzUAEucvg=;
        b=kdxJdYtEqtGfFyfTLZiP4XcTUfVHMakOHfx8T5r4nKVBOhCp3xPZh2NVripO4+cILF
         W4O/aFi3HiOX7oNun1zbTeJIVE7wPEp33dycrYJ+hOOHzD667BQr+zmGEbC+q5jQmTDv
         YKDypMi0IyF+h1fw6rTrCAwArsI1N7HkX2rKRnUIdKgJE3YQdyNU294QJXFa4aNHKk0w
         OzmG3KSj0VBW4Dyxh9uI735nTNIxBhtRq090IKXBeQlGKHWUtRpQdEeQfGNWe+WF1dqy
         lqMxL59c/FIgXkKDSDK69VSpIEn7w9JyFF6HuNxvsHLVw7eV2pFUnAFpDWIr4PKl1M/l
         KuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000885; x=1795605685;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ftWeT9v9vnvRt2kmLZwEf0dDqTmHNYp8z9nzUAEucvg=;
        b=mW7sfZTqtLWjQXNmT1yI/ipx+55XGfIjT2TQ2AY0oUWftxoHhfJllRS3FsaJTgxvTf
         oipEgzUpSeA1nCsEmJijTCazDfJ31mRKvzTSi2xDSxJfYB8dpHuemSeGTiS4Kbd+Auxc
         jHhhlJcgm6RaYoWZo0NLkw8ZdbsxAB8hRgOcJsWlVJDLgJEIxnpBwKwjRpNI7qlJMrOS
         J3f2ffH95ovNLouSisRMnyiaXhFqmUXXJqV3xDxrN4SMm8JMEfZmYwjdsgjxPaf/fx5H
         iJUoJ9STlH4VYfPd4DkXU7apUiFcQhUbj+aK2TdH0V9lHrb/5YjqR8fjCUQztdBAWc2H
         wsUg==
X-Forwarded-Encrypted: i=1; AL+hErESslS0FktiI7cOJWzcptHSdmB6Umbf/ZgK7fFvdLO2jNVGTzR7nCaLmSVsaz4QotvZB6jBkM7LMw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+LQvGdnVQtuNJRO8+mydxdQLaYoy39VGbLLRRKl2//0yPU+9eK
	703qPmkZeVMgMqt7iGuu5xnD0dZRBI6Dc2ShyDxwLayYggTU2V7+Zd/HtDl3kBrOTLgfIa4lUVk
	t9RnmgepmdB+t5l/lWU0CmuQ6vSgeSBVR5NyY1IClCw==
X-Gm-Gg: AYBFou1INOeuYCO2QNB8efDOcEI2r4eV18llhXiVqFz/3goOl0GbfhIkDh+vm8VuPze
	/U5XWJZTWiJIe8u8d5DaE3zYDDo/L/AaHjFhBzO2JtXX5v/ZZmo8oJRWQ4DxvTjf6/I71iwGFG5
	R+86XRfFzKoz2hZIjXKpGvOIiG+aU0LmhKcmIYhCTUurARHIo9ENijka5QjCsreho6/AvnTOlyx
	AIMPLOp982IKR7Iwss06elqClI9lI9+DN6V0AXEAt4gX4cjpIe0mJr0Ra9czI3xLHXCpL7AX4AN
	/3eTF4Emg2Y3Sr8JJ7W1HCikwPM2Zk30UiPiNEW4+TfB0Um6HjgB2/DO0uDRG5RK7osxCnNBJqI
	+AAqFQm1k6RGXEAMwEqm5h3T08HRqvnbBfnqSM8pNiTrlbjs5FDoNOt7ImgcW8mOcAl9X
X-Received: by 2002:a05:701b:4588:20b0:1b2:610b:878 with SMTP id
 a92af1059eb24-1b543c3693bmr2080228c88.6.1795000885174; Wed, 18 Nov 2026
 03:21:25 -0800 (PST)
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
 <20261106151947.3991524-2-vincent.guittot@linaro.org> <avr4MsRsjGfGHKKk@scheduler.schedules>
 <CAKfTPtBZ=Dc_X48EQ0yXMym0JrS=pWvbviyVyFri0tv5VdR3Eg@mail.gmail.com> <av1uqTFI46wRb0ok@scheduler.schedules>
In-Reply-To: <av1uqTFI46wRb0ok@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 18 Nov 2026 12:21:10 +0100
X-Gm-Features: AclHuK9YhWIoWx_QC_rN-ICEQIlD18KQ9aWWGzZ60ZJoewobyLYX02l8R4wpJP0
Message-ID: <CAKfTPtC7AmoSE4iev5qf0MMYDBHPpLMduYhz5XMDsMGiMNpy0A@mail.gmail.com>
Subject: Re: [PATCH 01/20 v3] sched/eevdf: Decay positive lag of sleeping entities
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

On Wed, 18 Nov 2026 at 11:58, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> On Wed, Nov 18, 2026 at 10:20:14AM +0100, Vincent Guittot wrote:
> > On Mon, 16 Nov 2026 at 14:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > >
> > >
> > > Hi Vincent!
> > >
> > > On Fri, Nov 06, 2026 at 04:19:28PM +0100, Vincent Guittot wrote:
> > > > Similarly to delayed dequeue, which enables an entity to decay its negative
> > > > lag while sleeping, a task should not keep a positive lag forever.
> > > >
> > > > The sleep duration and the weight are used to decay the positive lag at
> > > > wakeup.
> > > >
> > > > Apply the decay when enqueueing on prev rq for which we hold the lock to
> > > > get rq_clock_task().
> > > >
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >  kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
> > > >  1 file changed, 90 insertions(+), 34 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 0feec172fd37..5cd171f830d8 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > >       return avruntime - vlag != se->vruntime;
> > > >  }
> > > >
> > > > +/*
> > > > + * Signed add and clamp on underflow.
> > > > + *
> > > > + * Explicitly do a load-store to ensure the intermediate value never hits
> > > > + * memory. This allows lockless observations without ever seeing the negative
> > > > + * values.
> > > > + */
> > > > +#define add_positive(_ptr, _val) do {                           \
> > > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > > +     __signed_scalar_typeof(*ptr) val = (_val);              \
> > > > +     typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> > > > +                                                             \
> > > > +     res = var + val;                                        \
> > > > +                                                             \
> > > > +     if (val < 0 && res > var)                               \
> > > > +             res = 0;                                        \
> > > > +                                                             \
> > > > +     WRITE_ONCE(*ptr, res);                                  \
> > > > +} while (0)
> > > > +
> > > > +/*
> > > > + * Remove and clamp on negative, from a local variable.
> > > > + *
> > > > + * A variant of sub_positive(), which does not use explicit load-store
> > > > + * and is thus optimized for local variable updates.
> > > > + */
> > > > +#define lsub_positive(_ptr, _val) do {                               \
> > > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > > +     *ptr -= min_t(typeof(*ptr), *ptr, _val);                \
> > > > +} while (0)
> > > > +
> > > > +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
> > > > +static unsigned long task_h_load(struct task_struct *p);
> > > > +
> > > > +static __always_inline
> > > > +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
> > > > +{
> > > > +     struct sched_entity *se = &p->se;
> > > > +     s64 delta_exec, vlag = se->vlag;
> > > > +     unsigned long cfs_load;
> > > > +     struct rq *rq;
> > > > +
> > > > +     WARN_ON_ONCE(se->on_rq);
> > > > +
> > > > +     /* Negative lag is managed by delayed dequeue path */
> > > > +     if (vlag <= 0)
> > > > +             return;
> > > > +
> > > > +     rq = rq_of(cfs_rq);
> > > > +
> > > > +     /* No fast access to prev rq task clock */
> > > > +     if (flags & ENQUEUE_MIGRATED)
> > > > +             return;
> > > > +
> > > > +     /* Compute sleep time */
> > > > +     delta_exec = rq_clock_task(rq) - se->exec_start;
> > > > +     if (unlikely(delta_exec <= 0))
> > > > +             return;
> > > > +
> > > > +     /* For anything above ~4 seconds, save computation and clear the lag */
> > > > +     if (unlikely(delta_exec >> 32)) {
> > > > +             se->vlag = 0;
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * Use cfs' load and p's weight to estimate what would have been the
> > > > +      * share for p. task's load contribution to cfs' load is replaced by
> > > > +      * its weight.
> > > > +      */
> > > > +     cfs_load = cfs_rq_load_avg(cfs_rq);
> > > > +     lsub_positive(&cfs_load, task_h_load(p));
> > > > +     if (cfs_load) {
> > > > +             unsigned long weight = scale_load_down(se->h_load.weight);
> > > > +
> > > > +             delta_exec *= weight;
> > > > +             delta_exec = div64_long(delta_exec, cfs_load + weight);
> > > > +     }
> > > > +
> > > > +     vlag -= calc_delta_fair(delta_exec, se);
> > > > +
> > > > +     /* vlag can't become neg while sleeping */
> > > > +     se->vlag = max(0, vlag);
> > > > +}
> > >
> > > Look:
> > >
> > > Let's say we have 3 tasks named TA, TB and TC. They all have the same
> > > weight and the same slices. So TA gets picked, works for a while and then
> > > sleeps for less than the rest of its slice.
> > >
> > > So the part that I hate and love, math. For your diff, we do:
> > >
> > > (sleep_time * weight) / (3 * weight)
> > >
> > > 3 * weight here is TA + TB + TC, it equals to 3 * weight since they all
> > > have the same weight.
> > >
> > > So if sleep_time equals 2, weight equals 1, and slice equals 3 this equals
> > > 2/3. If the lag is 2, we do 2 - 2/3 resulting with 4/3.
> >
> > yes, we assume that TA would have run 1/3 of its sleep time
>
> But if sleep_time + working_time < slice for TA is true, there is no
> guarantee that it will run 1/3 of its sleep_time.

Even if sleep_time + working_time > slice.

>
> >
> > >
> > >
> > > Later, place_entity() uses this formula to do V - ((Sum(weight) + weight) * lag) / Sum(weight)
> > > So ((2 + 1) * 4/3) / 2 equals to 2. But this is wrong, no?
> >
> > why is this wrong ?
> >
> > Assuming TB and TC have the same vruntime before placing TA, the
> > average vruntime is avg == V(TB) == V(TC).
> > place_entity will do V(TA) = avg - 2
> > After placing TA, avg' = (V(TA) + V(TB) + V(TC)) / 3
> > avg' = (3*avg - 2) / 3 = avg - 2/3
> > TA's lag is : (avg - 2/3)  - (avg - 2) = 4/3 which is what we assumed above
> > TB's lag equals TC's lag : (avg - 2/3)  - avg = -2/3
> >
> > >
> > > If we didn't decayed lag: ((2 + 1) * 2) / 2 equals 3.
> > > So we would do V - 3.
> >
> > Which would end up once placed to
> > avg' = (3*avg - 3) / 3 = avg - 1
> > TA's lag is : (avg - 1)  - (avg - 3) = 2
> > TB's lag equals TC's lag : (avg - 1)  - avg = -1
> >
> > >
> > > Now our objective is to add the sleep_time of the task to -3.
> > > Because if the task didn't slept, in that time it would be working
> > > instead of sleeping.
> > >
> > > So, we should do V - 1. But we do V - 2.
> >
> > Why ?
> > You assume that the whole sleeping time would have been spent by TA
> > running on the CPU but we don't really know. We can assume that a task
> > with positive lag should run first, but this also depends on other
> > tasks enqueued.
>
> If TA didn't got preempted, and its sleeping_time + working_time is
> smaller than its slice, the whole sleeping time would have been spent by

You can't assume this to be always true, and we don't know how long it
was running. A positive lag of 2 as in your example doesn't mean that
TA runs 1 ms in its slice and would have run 2 ms more if not sleeping

> TA. Even if it did get preempted, there is no guarantee that it would
> work 1/3 of its sleeping time.
>
> > My first version assumed the whole sleep time would have been used to
> > run which is optimistic. Peter suggested using the ratio of weight and
> > cfs loads instead which accounts more fairly for the running time.
> >
>
> IMO, for a task like TA assuming it will work in its sleeping time
> is better than assuming it will work as 1/3 of its sleeping time.
> Or atleast less-bad, no? :-).

That depends on the PoV you take. The reality is that TA could have
run from 0 up to its full sleeping time (even if the sleeping time is
longer than a slice). Assuming it will run for the entire sleeping
time is one extreme, while assuming it won't run at all is the other
extreme. The reality is probably in between. The longer the sleeping
time, the closer the expected run time would be close to 1/3.

>
> > >
> > >
> > > AFAICT, we can't already know for sure how much will a task run even
> > > when the sleep_time is smaller than the slice. Because of preemption
> > > :-(.
> > >
> > > The cleanest, the simplest and maybe the worst or the best solution I can think of
> > > is just setting lag to 0 on every wakeup with positive lag TBH.
> >
> > Keeping eternal positive lag for a long sleeping task is unfair but on
> > the other end, clearing all positive lag for a micro sleeping or
> > because of waiting on a shared lock is also unfair
> >
> > >
> > > Or maybe, try to calculate when sleep_time is smaller than the slice,
> > > but just set the lag to 0 when sleep_time is bigger or equal to slice.
> >
> > There is a difference between sleep time and lag. Even with a sleep
> > time longer than the slice, the task can still have positive lag after
> > sleeping (this is also true for runtime). All this depends on how many
> > other tasks are running simultaneously and their weight
> >
>
> > >
> > > What you think?
> > >
> > > Sreehc,
> > >
> > > Kayra
>
> Ah, you didn't understand my joke, sad. :-(.
>
> Sknaht,
>
> Kayra
