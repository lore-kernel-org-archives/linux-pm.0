Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005152;
	b=uyYByOQx/+yPGbSH3NiFuoPkTdzV041ZRaw8jdQcg611NfaVZ1ClyqZ3CMh6S/KvrvIA
	 oFCwOtIKNABR+5qAXMZZT3G0cAXE8aNdaX6dxmVy+QHFByz4bZN2wPEpltS4Alj8LAquu
	 8baWwoPJ/tbBffKcwO+Lmh/hbr1q/7MK2SLE/gpDpT8lWhDCOZjMsf7E73trsopHVJyaL
	 IDIwpsTgdnHa0RukYRfkVW4T1kNu1NvR3eXstUj80+1kZ/jqK7k+rncXouJlrQctZcoP7
	 Ax+dffuJ6mxrt7A279je4JqQ1PFWLi4H3xKH022mr5w+/LXPvk6kqXPr7i72XP+I98Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MegKunIxbKJmWXfHvvLlyDz6eGlSNoNkyHutakVtL/4=;
	b=4riDMj120MMEidYLyGX3dX6qnRFoGj8g1BBUmbH0pWAsu381p+WyjYtult8on4WkbbyI
	 mfrTAVfX6H2ju+Dq7KPbznRhgTRXwjh9rRpSbpR1ZMBVmwbf3p2/2gK+0eIU5cA96apGJ
	 cT/HpZix2gWx8DW1cBRgl7X+76mI7MSHvtMG50ijD7NFS8RhFt8Wr6dDs0pPJu0O9uGXH
	 w2Q0glwktCG5gLrSzvVxEKc2KPcO7K+0Cszp3VRapV/A6IQjvgjhntWGg37Jv/VHVY7sW
	 GRfb5yNKhC6/y8elo6mDscp840s7iZXArSlDR4BXbt8/wJurOQTKc/hItdtEmmeMJHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyfbf2Us;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51543606A320
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 12:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51543606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyfbf2Us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48ff6bd58b8so106058f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 04:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795005150; x=1795609950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MegKunIxbKJmWXfHvvLlyDz6eGlSNoNkyHutakVtL/4=;
        b=tyfbf2UsPBVYYD26GeNTW+Qgmm0LMvV7VG/ikGF5XJoStTiPOglV/6gXZjSr/oWyJv
         2vByeShRxa04SwSUmUyB70qEaHEczqGgZPt6BDVPNq2V9MLNzoakciG3XnaHY1anl2EK
         7Pa/ECRBuBaoI5KxULPfvFt6Cm8cMVbO2/AWxWwW5RlGm2LtaECQtGUx3q36S+Anp96W
         w7n24TllVuuVHCDcQUic1nxFl+vcm8A3e1DzpmsKngxhJbirihpjIVtsfYQKn8kTmJnU
         GN0j/o9h8DEqlK4VCKNJgk+9ZOZx6bhHtdgf+9lG2RWJtgy3WV4DG2KRZSv+BTkln/aj
         dcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795005150; x=1795609950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MegKunIxbKJmWXfHvvLlyDz6eGlSNoNkyHutakVtL/4=;
        b=d2gw+67bcbOW0pgxMa05bstGS3bxDqAdUidcylQVO/yYdCIWP+zV2nFi3v5lvDcqph
         +H1DHJ6YP5j3YKH1T5lFX0qFBMGOn67bs69/k3R8zc5xtfF8UlWptDAu1a2eN3U9l1UU
         dxnjxdBvqqSWZNzvLIp6iTxKxvFAnc8Zb3e1NvCgjB1gIHge/axanN/RsNaprIM+sZGd
         xRgC1LIFzydjQrrwt8RxxHidAHLAfD4iQ3ZWPJitJf9DKpTwVXjtaAE3YIqWpaywR6e1
         wYhl4HwhQv1192fF0EAyre3Qw2Bw6EAe+OF5J4VfFWWemfX/Dv1DcWg6HjcZ8r6sa2NI
         Zpkw==
X-Forwarded-Encrypted: i=1; AL+hErGzMBV5NFa8nVHcoW3Bqu7ekayCsXlTEFnUeDFvpeSRQfFKiXGxw7NmImVUNtZPhchqSlcyH5VnHg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+W/lPTFUgpzaBphw8BEdDdatVoM2B7r1l54x50cEnPujr3eO39
	R4AnCh09zMqDAH2GiiVdwF9a01rjjLkiHK1Vc0fhd//RuJokauXViGXM
X-Gm-Gg: AZFdTZdkk+5m/WEnQpE/W9Wf10cAL7ZzW5IJqvo8OArPdZTPY1+af8E67UCH1aH9wIM
	xQdEhBdfuET4EE2antMg21MYf5N+/wGYnvtoD2uOZwmtLpMeknPzY3IsGy69SlYjO1q1GTeD8rG
	XoNaSOq2NJuBrTzcN6t+fn7dJqviT4pR42S1Ir9SXHxXUOBWcVK4xL2Bax7jwXnLlJ2sENV+dfr
	Hrj/IfPuU3axDvy+u3lwwk6xsYRWyy2aAs866XxOLbhrqfxiI5NFKk1jogiCPhp8bnd1FWVS916
	InxQAMp+9ShEnVC8qmcFEUsL3R+kk/3iyaGNKTe4TdCjZbkgo0wanWWHX7CEkdFDNcq0HHFRPLS
	rUvz/K1SQal7mY6LhEg7LPzYKD+LETX/58Iig8bL7BCJ65z5gFTOe2NNWSY1IdAtjRphFo2Wm5b
	YxDA1EWHjn2JOuZQkt797GDSJl7ksCqGThLhjSenpodkxGMaAgd4SKQHDVCzvoyTh244lpbD5yP
	honyVSnS/DyWwyAA5UhpytSw1Q5e58JP9FyBNVCaXf7iCkpAKbWNb6ohyTO5m1j4gzonKcr/Kgl
	UhYZkEwtbDyTqBFezapo5yI02a8eMBRQ+1HaDJMHiDsTMy4yIxNHOSs=
X-Received: by 2002:a5d:5f54:0:b0:4a6:bc53:246a with SMTP id ffacd0b85a97d-4a6bc626b7dmr4052393f8f.5.1795005149445;
        Wed, 18 Nov 2026 04:32:29 -0800 (PST)
Received: from scheduler.schedules ([85.100.69.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c11f4bsm4645746f8f.51.2026.11.18.04.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:32:28 -0800 (PST)
Date: Wed, 18 Nov 2026 15:32:25 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 01/20 v3] sched/eevdf: Decay positive lag of sleeping
 entities
Message-ID: <av2KuYNx1A-rCz0R@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-2-vincent.guittot@linaro.org>
 <avr4MsRsjGfGHKKk@scheduler.schedules>
 <CAKfTPtBZ=Dc_X48EQ0yXMym0JrS=pWvbviyVyFri0tv5VdR3Eg@mail.gmail.com>
 <av1uqTFI46wRb0ok@scheduler.schedules>
 <CAKfTPtC7AmoSE4iev5qf0MMYDBHPpLMduYhz5XMDsMGiMNpy0A@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtC7AmoSE4iev5qf0MMYDBHPpLMduYhz5XMDsMGiMNpy0A@mail.gmail.com>

On Wed, Nov 18, 2026 at 12:21:10PM +0100, Vincent Guittot wrote:
> On Wed, 18 Nov 2026 at 11:58, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> >
> > On Wed, Nov 18, 2026 at 10:20:14AM +0100, Vincent Guittot wrote:
> > > On Mon, 16 Nov 2026 at 14:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > > >
> > > >
> > > > Hi Vincent!
> > > >
> > > > On Fri, Nov 06, 2026 at 04:19:28PM +0100, Vincent Guittot wrote:
> > > > > Similarly to delayed dequeue, which enables an entity to decay its negative
> > > > > lag while sleeping, a task should not keep a positive lag forever.
> > > > >
> > > > > The sleep duration and the weight are used to decay the positive lag at
> > > > > wakeup.
> > > > >
> > > > > Apply the decay when enqueueing on prev rq for which we hold the lock to
> > > > > get rq_clock_task().
> > > > >
> > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > ---
> > > > >  kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
> > > > >  1 file changed, 90 insertions(+), 34 deletions(-)
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index 0feec172fd37..5cd171f830d8 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > > >       return avruntime - vlag != se->vruntime;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * Signed add and clamp on underflow.
> > > > > + *
> > > > > + * Explicitly do a load-store to ensure the intermediate value never hits
> > > > > + * memory. This allows lockless observations without ever seeing the negative
> > > > > + * values.
> > > > > + */
> > > > > +#define add_positive(_ptr, _val) do {                           \
> > > > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > > > +     __signed_scalar_typeof(*ptr) val = (_val);              \
> > > > > +     typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> > > > > +                                                             \
> > > > > +     res = var + val;                                        \
> > > > > +                                                             \
> > > > > +     if (val < 0 && res > var)                               \
> > > > > +             res = 0;                                        \
> > > > > +                                                             \
> > > > > +     WRITE_ONCE(*ptr, res);                                  \
> > > > > +} while (0)
> > > > > +
> > > > > +/*
> > > > > + * Remove and clamp on negative, from a local variable.
> > > > > + *
> > > > > + * A variant of sub_positive(), which does not use explicit load-store
> > > > > + * and is thus optimized for local variable updates.
> > > > > + */
> > > > > +#define lsub_positive(_ptr, _val) do {                               \
> > > > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > > > +     *ptr -= min_t(typeof(*ptr), *ptr, _val);                \
> > > > > +} while (0)
> > > > > +
> > > > > +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
> > > > > +static unsigned long task_h_load(struct task_struct *p);
> > > > > +
> > > > > +static __always_inline
> > > > > +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
> > > > > +{
> > > > > +     struct sched_entity *se = &p->se;
> > > > > +     s64 delta_exec, vlag = se->vlag;
> > > > > +     unsigned long cfs_load;
> > > > > +     struct rq *rq;
> > > > > +
> > > > > +     WARN_ON_ONCE(se->on_rq);
> > > > > +
> > > > > +     /* Negative lag is managed by delayed dequeue path */
> > > > > +     if (vlag <= 0)
> > > > > +             return;
> > > > > +
> > > > > +     rq = rq_of(cfs_rq);
> > > > > +
> > > > > +     /* No fast access to prev rq task clock */
> > > > > +     if (flags & ENQUEUE_MIGRATED)
> > > > > +             return;
> > > > > +
> > > > > +     /* Compute sleep time */
> > > > > +     delta_exec = rq_clock_task(rq) - se->exec_start;
> > > > > +     if (unlikely(delta_exec <= 0))
> > > > > +             return;
> > > > > +
> > > > > +     /* For anything above ~4 seconds, save computation and clear the lag */
> > > > > +     if (unlikely(delta_exec >> 32)) {
> > > > > +             se->vlag = 0;
> > > > > +             return;
> > > > > +     }
> > > > > +
> > > > > +     /*
> > > > > +      * Use cfs' load and p's weight to estimate what would have been the
> > > > > +      * share for p. task's load contribution to cfs' load is replaced by
> > > > > +      * its weight.
> > > > > +      */
> > > > > +     cfs_load = cfs_rq_load_avg(cfs_rq);
> > > > > +     lsub_positive(&cfs_load, task_h_load(p));
> > > > > +     if (cfs_load) {
> > > > > +             unsigned long weight = scale_load_down(se->h_load.weight);
> > > > > +
> > > > > +             delta_exec *= weight;
> > > > > +             delta_exec = div64_long(delta_exec, cfs_load + weight);
> > > > > +     }
> > > > > +
> > > > > +     vlag -= calc_delta_fair(delta_exec, se);
> > > > > +
> > > > > +     /* vlag can't become neg while sleeping */
> > > > > +     se->vlag = max(0, vlag);
> > > > > +}
> > > >
> > > > Look:
> > > >
> > > > Let's say we have 3 tasks named TA, TB and TC. They all have the same
> > > > weight and the same slices. So TA gets picked, works for a while and then
> > > > sleeps for less than the rest of its slice.
> > > >
> > > > So the part that I hate and love, math. For your diff, we do:
> > > >
> > > > (sleep_time * weight) / (3 * weight)
> > > >
> > > > 3 * weight here is TA + TB + TC, it equals to 3 * weight since they all
> > > > have the same weight.
> > > >
> > > > So if sleep_time equals 2, weight equals 1, and slice equals 3 this equals
> > > > 2/3. If the lag is 2, we do 2 - 2/3 resulting with 4/3.
> > >
> > > yes, we assume that TA would have run 1/3 of its sleep time
> >
> > But if sleep_time + working_time < slice for TA is true, there is no
> > guarantee that it will run 1/3 of its sleep_time.
> 
> Even if sleep_time + working_time > slice.
> 
> >
> > >
> > > >
> > > >
> > > > Later, place_entity() uses this formula to do V - ((Sum(weight) + weight) * lag) / Sum(weight)
> > > > So ((2 + 1) * 4/3) / 2 equals to 2. But this is wrong, no?
> > >
> > > why is this wrong ?
> > >
> > > Assuming TB and TC have the same vruntime before placing TA, the
> > > average vruntime is avg == V(TB) == V(TC).
> > > place_entity will do V(TA) = avg - 2
> > > After placing TA, avg' = (V(TA) + V(TB) + V(TC)) / 3
> > > avg' = (3*avg - 2) / 3 = avg - 2/3
> > > TA's lag is : (avg - 2/3)  - (avg - 2) = 4/3 which is what we assumed above
> > > TB's lag equals TC's lag : (avg - 2/3)  - avg = -2/3
> > >
> > > >
> > > > If we didn't decayed lag: ((2 + 1) * 2) / 2 equals 3.
> > > > So we would do V - 3.
> > >
> > > Which would end up once placed to
> > > avg' = (3*avg - 3) / 3 = avg - 1
> > > TA's lag is : (avg - 1)  - (avg - 3) = 2
> > > TB's lag equals TC's lag : (avg - 1)  - avg = -1
> > >
> > > >
> > > > Now our objective is to add the sleep_time of the task to -3.
> > > > Because if the task didn't slept, in that time it would be working
> > > > instead of sleeping.
> > > >
> > > > So, we should do V - 1. But we do V - 2.
> > >
> > > Why ?
> > > You assume that the whole sleeping time would have been spent by TA
> > > running on the CPU but we don't really know. We can assume that a task
> > > with positive lag should run first, but this also depends on other
> > > tasks enqueued.
> >
> > If TA didn't got preempted, and its sleeping_time + working_time is
> > smaller than its slice, the whole sleeping time would have been spent by
> 
> You can't assume this to be always true, and we don't know how long it
> was running. A positive lag of 2 as in your example doesn't mean that

Can't we do deadline - vruntime? That would give us slice - work_time.
We already know the sleep_time.

> TA runs 1 ms in its slice and would have run 2 ms more if not sleeping
> 
> > TA. Even if it did get preempted, there is no guarantee that it would
> > work 1/3 of its sleeping time.
> >
> > > My first version assumed the whole sleep time would have been used to
> > > run which is optimistic. Peter suggested using the ratio of weight and
> > > cfs loads instead which accounts more fairly for the running time.
> > >
> >
> > IMO, for a task like TA assuming it will work in its sleeping time
> > is better than assuming it will work as 1/3 of its sleeping time.
> > Or atleast less-bad, no? :-).
> 
> That depends on the PoV you take. The reality is that TA could have
> run from 0 up to its full sleeping time (even if the sleeping time is
> longer than a slice). Assuming it will run for the entire sleeping
> time is one extreme, while assuming it won't run at all is the other
> extreme. The reality is probably in between. The longer the sleeping
> time, the closer the expected run time would be close to 1/3.
> 

Yeah :-(.

1. If we assume that TA will get preempted, we can't know how much it would
have run if it hadn't slept. And in that case 1/3 could be right or wrong.
We can't know.

2. If we assume that TA won't get preempted, we can know that it will run
in its whole sleep time.


In any case, we are doing a assumption in both of these.
TBH, I don't think there is a big difference.

I would still argue that assuming the 2nd one is better.
Although, if there is not a big difference I can't see
any reason to add a case for it.

I'm gonna play around with the whole series. Testing and other stuff.
Maybe I'll find something unexpected. While testing, I'll try to test
the difference between 1st and 2nd too. I don't think there will be a
big difference, but I'll still test it :-).

> >
> > > >
> > > >
> > > > AFAICT, we can't already know for sure how much will a task run even
> > > > when the sleep_time is smaller than the slice. Because of preemption
> > > > :-(.
> > > >
> > > > The cleanest, the simplest and maybe the worst or the best solution I can think of
> > > > is just setting lag to 0 on every wakeup with positive lag TBH.
> > >
> > > Keeping eternal positive lag for a long sleeping task is unfair but on
> > > the other end, clearing all positive lag for a micro sleeping or
> > > because of waiting on a shared lock is also unfair
> > >
> > > >
> > > > Or maybe, try to calculate when sleep_time is smaller than the slice,
> > > > but just set the lag to 0 when sleep_time is bigger or equal to slice.
> > >
> > > There is a difference between sleep time and lag. Even with a sleep
> > > time longer than the slice, the task can still have positive lag after
> > > sleeping (this is also true for runtime). All this depends on how many
> > > other tasks are running simultaneously and their weight
> > >
> >
> > > >
> > > > What you think?
> > > >
> > > > Sreehc,
> > > >
> > > > Kayra
> >
> > Ah, you didn't understand my joke, sad. :-(.
> >
> > Sknaht,
> >
> > Kayra

hint: try to read it backwards :-(.

Sreehc and Sknaht alot!

Kayra
