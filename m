Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999535;
	b=m097BWvCBSTQ95hlDYY0U97u8nkDbLQKEt5rN/Y2flZuBvWIDqSDDon+LM6bY1A7lYW9
	 xNqv9VkPAyOEE3ggGGrzEKW4t9UZjCcl/SApAKuuAnIEtyd3jS6ncuOaY7Q8ZNhc46HOe
	 +CqgrkJDbem2Fe1Uv+DHUTbvK1h/xD70bdo4qX34iZd3Q8aqXoBs+RPs5jV1nbeSvZMYO
	 o/IaY7YSBesw1Gv+Ln9BR0jnhn02ZDAju1iUw8f/u0RR83m6jQYcYy5xveaDzeP9bCVAe
	 vlNyC69iH7CxDOwwMTOC2dBFSN7Z7zTd8Oe2XUJS/PvglynF07ZebRMwnC12RqoWpFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gOokTz1G9UcB/naYSeBX2ofw41eva17L+gF1HVq9r8Q=;
	b=AaqiVTIc786T2Df0+eSPQIAJ1YGMbrXuNcECDmmkW+G1zsuHXgPmtOQbQTwuoKDySgQ+
	 4i+tNz20Zux7oc4MNJIMIxtcSin7Ci8TbQE90ApohikCnPumPX49R64DSdamiPD4Ivvxl
	 7YiKn+tH/7Fu0QHtm0CuXTLvBQ7S5VGehjuJ+HFnFeRMQGeiWbao/+xpaAFlnLcMfQHS+
	 APsnldyd0WofnSgel+jDokCjcJrlBkyqGDfrTVWkmvOzrQcYsWx3qcr0rFuExVZ2EmZqH
	 rcFKTOqoZ+EJl9W1V2xsl+A2aGXxNjDNqEKAVX8QMtpxEGFtGTYhszaF13zFx9nTB/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sW5DeqEB;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9438606A325
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 10:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9438606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sW5DeqEB
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-490b7266f7bso15348f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 02:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794999533; x=1795604333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gOokTz1G9UcB/naYSeBX2ofw41eva17L+gF1HVq9r8Q=;
        b=sW5DeqEB/3hSKu5h9oLyiMSprBGkZ6MoiN3BmfCwgiB4/H09E1h6T6jLI6nxLCN/VO
         2ZnEanEOyImEsfuIHqDC0/0xeAUzxN+3NW3AuRVcFBydnIfkmA0XCz/SgL8FNEY5OHEz
         yTLnNYLIO/yhYoWHnYJ8fsu/RKbMFPGyLlcr0Q7MKniCRkI5DDzBDo+0hNldT7K8ahC2
         R/zWEhpaavqOXPD+xZgF0/Gj1KPOBDHLUfhxj65weBK2zUbEepURGmg65J0f902AF3N+
         RgkeYWA4mQ6SCY0RPuBIeEYEZJnQDfHmITTndvAiKYuC2Tlm9DW22bUEUHCvT8QVJ9E+
         B1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794999533; x=1795604333;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOokTz1G9UcB/naYSeBX2ofw41eva17L+gF1HVq9r8Q=;
        b=kt4FgGBj7JOEoiMU9nx42O5mzwrA3rgWou3pr/nLHEXAwJJ5kXAIxl0ux8rmt/SAe3
         HP7u5bNDjnNvkUYbZqwVO7mzAnxBAg7TMVv7M/Vx9ZbrhbMpRuviDA7E1y8o+tlTuOgr
         3tpLeycLLlMd/AeIUPN791t2mcW0HB13SpBxoBhwX4V46112pTH7rohOB8ZuFwFkfapH
         6PJmh3zGt4S/vSyb3H9KHkPlHrgKsKUEIUsKbqLBlopR1D9XtRh7EOwIkSBGXisEny1T
         KI5h6l4LrrDfZySEiebPSTYCC36yE+Fnknq8X7JqzVIRFbX9sWdNs2Y+jNdNZp/+mmEg
         Ud9g==
X-Forwarded-Encrypted: i=1; AL+hErGByim6jS/ofGddMAdcLzPLR58SxrQu7VbBl43gNRkXGWhfowgBXup1VYb8tprir6YOweuolfKD8g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/PT3EA6epdq6pbqlkzOa/FYsgP4xElj9SkUY4b3tvz6Caio+ZZ
	92kaarQWYVFWDPfRShyRHTAZ1ELVIA5wIpG3BJLrcQKLISAbvqzjsRHH
X-Gm-Gg: AZFdTZfc0keynLrcvIYnfi1I60vHhuCDaIh3BWOzXz63iiVcLMpSZ8JRmJrxN0sciKI
	vQqhx6IDn961PuZMItOdtJYfSd+e2OlX3vBL7KqXgWhGFHvtzmoDEP/PlOQjSKCSqfR+31celgD
	JrOaOYkWOJoG8OUlsJ7aMHmmOR262VecaDuTUx/jCoAovzjskbV4bkjYbiyZ1Oa//0YPEq8+iL4
	MUhG0fR05uZeuELJHZIw9S6kC/uI4Z/SahMbmzCMxmuMEPlakZnDmXh5uh2ILBn8RJSXHsvCEkD
	ThsOMr1hrJ2f3GQfyr1V0jKLVVd0sQ7DaxJtJ8nG7cgLQvlk0TGJNjC4f4tXyYjEdKrUaycvNaL
	kle/2Bhbeds9aR9B3MHQ4TRrhVeFW+acjmo/NGU6iY04xUAc5C0zsfyUyKSS1gmRMhBQwf7r0wr
	R5eqsyL+5wjuPJTpd0za+Y8EE2g5VlYW0AVU0FEcFUQGXLfr+XV7K+HJgD0k2dDcc02tVwzySR6
	0KYCY1w2GrHIrR0HqiTV8uvoYCnlf0AxH+ZbwdaMoj7Q/66yAX0XlDz3/8drBy+I8OSNtPA4sYG
	lzmE01tDhHAW/5pArpUCic9Cm2EJZBhhm2NhDQvpMZ5GlnzectOjeeU=
X-Received: by 2002:a05:6000:18a5:b0:4a6:bc53:2472 with SMTP id ffacd0b85a97d-4a6bc626a3dmr3453644f8f.5.1794999532857;
        Wed, 18 Nov 2026 02:58:52 -0800 (PST)
Received: from scheduler.schedules ([85.100.69.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65560ab59sm3871525f8f.29.2026.11.18.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:58:52 -0800 (PST)
Date: Wed, 18 Nov 2026 13:58:48 +0300
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
Message-ID: <av1uqTFI46wRb0ok@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-2-vincent.guittot@linaro.org>
 <avr4MsRsjGfGHKKk@scheduler.schedules>
 <CAKfTPtBZ=Dc_X48EQ0yXMym0JrS=pWvbviyVyFri0tv5VdR3Eg@mail.gmail.com>
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
In-Reply-To: <CAKfTPtBZ=Dc_X48EQ0yXMym0JrS=pWvbviyVyFri0tv5VdR3Eg@mail.gmail.com>

On Wed, Nov 18, 2026 at 10:20:14AM +0100, Vincent Guittot wrote:
> On Mon, 16 Nov 2026 at 14:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> >
> >
> > Hi Vincent!
> >
> > On Fri, Nov 06, 2026 at 04:19:28PM +0100, Vincent Guittot wrote:
> > > Similarly to delayed dequeue, which enables an entity to decay its negative
> > > lag while sleeping, a task should not keep a positive lag forever.
> > >
> > > The sleep duration and the weight are used to decay the positive lag at
> > > wakeup.
> > >
> > > Apply the decay when enqueueing on prev rq for which we hold the lock to
> > > get rq_clock_task().
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 90 insertions(+), 34 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 0feec172fd37..5cd171f830d8 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >       return avruntime - vlag != se->vruntime;
> > >  }
> > >
> > > +/*
> > > + * Signed add and clamp on underflow.
> > > + *
> > > + * Explicitly do a load-store to ensure the intermediate value never hits
> > > + * memory. This allows lockless observations without ever seeing the negative
> > > + * values.
> > > + */
> > > +#define add_positive(_ptr, _val) do {                           \
> > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > +     __signed_scalar_typeof(*ptr) val = (_val);              \
> > > +     typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> > > +                                                             \
> > > +     res = var + val;                                        \
> > > +                                                             \
> > > +     if (val < 0 && res > var)                               \
> > > +             res = 0;                                        \
> > > +                                                             \
> > > +     WRITE_ONCE(*ptr, res);                                  \
> > > +} while (0)
> > > +
> > > +/*
> > > + * Remove and clamp on negative, from a local variable.
> > > + *
> > > + * A variant of sub_positive(), which does not use explicit load-store
> > > + * and is thus optimized for local variable updates.
> > > + */
> > > +#define lsub_positive(_ptr, _val) do {                               \
> > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > +     *ptr -= min_t(typeof(*ptr), *ptr, _val);                \
> > > +} while (0)
> > > +
> > > +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
> > > +static unsigned long task_h_load(struct task_struct *p);
> > > +
> > > +static __always_inline
> > > +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
> > > +{
> > > +     struct sched_entity *se = &p->se;
> > > +     s64 delta_exec, vlag = se->vlag;
> > > +     unsigned long cfs_load;
> > > +     struct rq *rq;
> > > +
> > > +     WARN_ON_ONCE(se->on_rq);
> > > +
> > > +     /* Negative lag is managed by delayed dequeue path */
> > > +     if (vlag <= 0)
> > > +             return;
> > > +
> > > +     rq = rq_of(cfs_rq);
> > > +
> > > +     /* No fast access to prev rq task clock */
> > > +     if (flags & ENQUEUE_MIGRATED)
> > > +             return;
> > > +
> > > +     /* Compute sleep time */
> > > +     delta_exec = rq_clock_task(rq) - se->exec_start;
> > > +     if (unlikely(delta_exec <= 0))
> > > +             return;
> > > +
> > > +     /* For anything above ~4 seconds, save computation and clear the lag */
> > > +     if (unlikely(delta_exec >> 32)) {
> > > +             se->vlag = 0;
> > > +             return;
> > > +     }
> > > +
> > > +     /*
> > > +      * Use cfs' load and p's weight to estimate what would have been the
> > > +      * share for p. task's load contribution to cfs' load is replaced by
> > > +      * its weight.
> > > +      */
> > > +     cfs_load = cfs_rq_load_avg(cfs_rq);
> > > +     lsub_positive(&cfs_load, task_h_load(p));
> > > +     if (cfs_load) {
> > > +             unsigned long weight = scale_load_down(se->h_load.weight);
> > > +
> > > +             delta_exec *= weight;
> > > +             delta_exec = div64_long(delta_exec, cfs_load + weight);
> > > +     }
> > > +
> > > +     vlag -= calc_delta_fair(delta_exec, se);
> > > +
> > > +     /* vlag can't become neg while sleeping */
> > > +     se->vlag = max(0, vlag);
> > > +}
> >
> > Look:
> >
> > Let's say we have 3 tasks named TA, TB and TC. They all have the same
> > weight and the same slices. So TA gets picked, works for a while and then
> > sleeps for less than the rest of its slice.
> >
> > So the part that I hate and love, math. For your diff, we do:
> >
> > (sleep_time * weight) / (3 * weight)
> >
> > 3 * weight here is TA + TB + TC, it equals to 3 * weight since they all
> > have the same weight.
> >
> > So if sleep_time equals 2, weight equals 1, and slice equals 3 this equals
> > 2/3. If the lag is 2, we do 2 - 2/3 resulting with 4/3.
> 
> yes, we assume that TA would have run 1/3 of its sleep time

But if sleep_time + working_time < slice for TA is true, there is no
guarantee that it will run 1/3 of its sleep_time.

> 
> >
> >
> > Later, place_entity() uses this formula to do V - ((Sum(weight) + weight) * lag) / Sum(weight)
> > So ((2 + 1) * 4/3) / 2 equals to 2. But this is wrong, no?
> 
> why is this wrong ?
> 
> Assuming TB and TC have the same vruntime before placing TA, the
> average vruntime is avg == V(TB) == V(TC).
> place_entity will do V(TA) = avg - 2
> After placing TA, avg' = (V(TA) + V(TB) + V(TC)) / 3
> avg' = (3*avg - 2) / 3 = avg - 2/3
> TA's lag is : (avg - 2/3)  - (avg - 2) = 4/3 which is what we assumed above
> TB's lag equals TC's lag : (avg - 2/3)  - avg = -2/3
> 
> >
> > If we didn't decayed lag: ((2 + 1) * 2) / 2 equals 3.
> > So we would do V - 3.
> 
> Which would end up once placed to
> avg' = (3*avg - 3) / 3 = avg - 1
> TA's lag is : (avg - 1)  - (avg - 3) = 2
> TB's lag equals TC's lag : (avg - 1)  - avg = -1
> 
> >
> > Now our objective is to add the sleep_time of the task to -3.
> > Because if the task didn't slept, in that time it would be working
> > instead of sleeping.
> >
> > So, we should do V - 1. But we do V - 2.
> 
> Why ?
> You assume that the whole sleeping time would have been spent by TA
> running on the CPU but we don't really know. We can assume that a task
> with positive lag should run first, but this also depends on other
> tasks enqueued.

If TA didn't got preempted, and its sleeping_time + working_time is
smaller than its slice, the whole sleeping time would have been spent by
TA. Even if it did get preempted, there is no guarantee that it would
work 1/3 of its sleeping time.

> My first version assumed the whole sleep time would have been used to
> run which is optimistic. Peter suggested using the ratio of weight and
> cfs loads instead which accounts more fairly for the running time.
> 

IMO, for a task like TA assuming it will work in its sleeping time
is better than assuming it will work as 1/3 of its sleeping time. 
Or atleast less-bad, no? :-).

> >
> >
> > AFAICT, we can't already know for sure how much will a task run even
> > when the sleep_time is smaller than the slice. Because of preemption
> > :-(.
> >
> > The cleanest, the simplest and maybe the worst or the best solution I can think of
> > is just setting lag to 0 on every wakeup with positive lag TBH.
> 
> Keeping eternal positive lag for a long sleeping task is unfair but on
> the other end, clearing all positive lag for a micro sleeping or
> because of waiting on a shared lock is also unfair
> 
> >
> > Or maybe, try to calculate when sleep_time is smaller than the slice,
> > but just set the lag to 0 when sleep_time is bigger or equal to slice.
> 
> There is a difference between sleep time and lag. Even with a sleep
> time longer than the slice, the task can still have positive lag after
> sleeping (this is also true for runtime). All this depends on how many
> other tasks are running simultaneously and their weight
> 

> >
> > What you think?
> >
> > Sreehc,
> >
> > Kayra

Ah, you didn't understand my joke, sad. :-(.

Sknaht,

Kayra
