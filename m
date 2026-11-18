Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794993629;
	b=x0pWL/Kik8fUfRWRVcC79YSl7FreuWb5TkRt2ZlOtpg4zf2cqgjAItx9zmt+CrxUOxe0
	 B5cXCUm2N7gu8MUKCvNnKW8V2uftpp4VkpTPIlD8ql1I70kPda47aqm8+byuXxn0JBB/+
	 sjG4l5SGQ7pSncK3ZriRkailTFeLRU1vPA3MhxB1qW1lOuX/zaVQRiM3woJkz//ruT2iF
	 s7GMZFBZS1VCagHIVSI6rmyT7UdJxhJWhykM9RBV6vLPNd6KZ2ASgwVqOPAmk9ELyoxGh
	 ciHNhWAuZ5c3nVsYPnDK3WX1Yshi2Td/rfHzWW0T7b+T9B7gxyoDfhAryihhp9baGrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Aeo8Kc6gDZPXZvE0DmabfYTz/zNuvasGH9KV0/D9kjE=;
	b=LCyAINHWfHbOCdcPHdvjag70vjxB+CDGRPO9KsDCiIm4ipHpgpponp7Jzz4kO1uwqXUa
	 ABymSQaTJmtyab0VsM+uiLCIDwfOo9BwO97qw65DDSZ191mqImwrUKu5wxuvnvYBzySRE
	 Z6Dfhf9Skt0h/RJDYJRAo92eUi+i7DcMxbperGFGRMBOxCo96HPLBqvMnoq9JQfg61IUu
	 wnYZLyUtwTUbwi/R/9PAI9TscmhXHSDDhEWOLUejeoTl59Uh7oH8ECk+6XrtyP00H04Ok
	 LsjngYy8iFmm+Y9WMO0Lxma38vPoX5XoOMWp+gx6qsxOcTANsQsbSsju+a3MP8c1pqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EqhEF+sn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5E1606A33A
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 09:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D5E1606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EqhEF+sn
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so1411246a12.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 01:20:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794993627; cv=none;
        d=google.com; s=arc-20260327;
        b=kVBBmmBMLTFbR15mCI2BY3keS3CzEjfUDA+hRAUctVWQcBKIqug/Tf2VN9RVYyN6Y5
         GxE8KsWyiZwnqXCyRjDfdy1pCOoNdAOiJVZkxwoYNcu201pOHEvZfuYPNoKp9xY9nb5/
         T0gCs9LebUCNfqpn/7SlHjryRJJjPTsufFw3WDIs29aJVGDcl8qcQot9ftewm/Qmn2/B
         SC9bFU72QHO2+g0QyNMqh9D8U3Di09oEhhWLjroofdWa1UCT00WQXVSW2oiGJvYhRzUE
         cX9mL/rB7E0QoDP3JhmfY4elgIUui7A3oh2pYR/rUTIHSHHZTbRI9E8VWAzPs6eQqX7k
         /M0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Aeo8Kc6gDZPXZvE0DmabfYTz/zNuvasGH9KV0/D9kjE=;
        fh=DJ2a8wuON9bgHP+htvakYGyLB5LXKvqHnB1s6Z7JKm0=;
        b=H4xr2WtLGjiw01guto28rYVksl721cG2NkvoBGCY1YjPWeLQKIlu8ytw67RfYREQic
         Bjul4CIH424BaBNX8XL+gSn9VbIjylqAT937jgUEOaB60bbde/toqjSLmaR2V0DNen1H
         AN4lpIM7UkTL97s3ibnbo/CdkLBjnAjtq1hziKzcDkwDcQFtceG0sDFFEMH2axmC9U2c
         eKA3JWJMY1tqOy2F4ilsTsVVVYkH9EaVqV+d9HzM2HAH1dmlxcGkiHxgUIn9buuDsIVz
         SAnbri23LHu+LimkTDOvAL7T6sz6ikT97XhFMK+jish0YTXE1w8wIEY8Plj9bAtAv6m0
         ZFLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794993627; x=1795598427; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aeo8Kc6gDZPXZvE0DmabfYTz/zNuvasGH9KV0/D9kjE=;
        b=EqhEF+sngw4Lkj+05dDnNwVYWzJpfM+l1hEFuTS1wOgrLS3SUX5bNRM+1gMoKitbxf
         +YeArXkF7mi8yhWGgjOpYRw3n0v896pyFTRXccsh97JwY7FELf2re3mb+SBj8p7OHsJL
         GonoUgq4o2TN+fnqT1jRTVp5AC/rYglQLdjDML1VO5VF2gchY4NsOYZNhsKie4nUXZ7A
         arpp9e4q2cKEerxccMZ4oi9A+ozHDHwhLgv+/oVRePq4zTASA7z/H0Y+i8rZpqp94u0a
         X+NeSW7/stIExb3slNkRTDM6kMlGr4NBba/KhtpTS9CeGrMLGqWmCW+CsN/XqCF3MXO9
         nY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794993627; x=1795598427;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Aeo8Kc6gDZPXZvE0DmabfYTz/zNuvasGH9KV0/D9kjE=;
        b=1NdiJM3VcrQTujvbTJ6cUW/g2HRt5axFPbk4g9vtcjdJ/Be7bZtmUVn2TzAe7HZLcP
         qd5+NOwiZu1cYSAUotVhkPRU50Sn1A+PvP4abt1GQcpOlQ7gWZ6NwFe0uXhf/zFGRHrM
         xsSzm1VOnU8THM3qQiRASVGWVwmg6e5r+eCDRzKvTMEo5rzwDv3jbmgfmurpEeAJ6w57
         /ilBIzN40ZZlVZl1dYf0jAl+nX/q0X5ae0CWlHLcVBUmxN6cX7c0G+rWUhnxix7AHRRD
         7H8nkoQfFAlXcmSFhcpA/xhhHJiGdJwqdvFZl7nUkjKuMiRwWX1cpl79LPMgiePteRhZ
         eT8Q==
X-Forwarded-Encrypted: i=1; AL+hErEtPEw7JnJFwKtKIiYS3Mljbs7LX2Tuwv47sbFM4ZOKcG26P/hDIt9O6zNg/aJA8Bshhdkji36btg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+xTWeHurMDaSljWiDdj4pbkmd9s0xcVs53VLFThxpREt6M8THn
	IMaLr4q2hPVTuKrBFr52tyCOvmQz5GsKN+AjoJBuM7eFN2kHoaAk0Oq/A+wjOnuncXYN1vm4THo
	Z0IA7il0ayNrA2M0HsrhArSqfEDw/IFAVpjKv8+pwmg==
X-Gm-Gg: AYBFou0Ywatg4ty1ManlRwahK4c75yGLaS1Wi5FYjvSoYHQpReU+NYGoMyKbDLYlwUk
	slNq7RAWGZ6jFS9EHVDU0mfmbO78lge0Y6UnYomDCnTGjNcrJIkFsj1zsBwNIPJAl+Ud69qhZG3
	lrb/x4aXfYvXDTdNk4yZzCpMwOHBoSVoaViBR+xxibpcHgYtknxeQoByN/JYoAKpEKjiGvR31qn
	zN978ixJsIbcFUMgUkaE3fMRnHYXxIeVKvZyV/Sx/sSVqOXFiPTczUhIC/Nvi2zA6ewOhad1f6V
	7+Dno9skOlCxwUGdaG9CM2gj9UyJ9QQpsg/kN7ah7IEroTWUa5Mjv24A9MZ2TR0/VQOtFQX2N7p
	g6O+IsJDjX7HrfEMaN8Z58msVit0/PSZ4IZfwsHE75Asok02z0tszOiJON79nN1rb3iw0861Azo
	zPBa8DuHWAN6jf
X-Received: by 2002:a05:6402:5025:b0:6b7:dda4:f72c with SMTP id
 4fb4d7f45d1cf-6b88814ddbemr1418382a12.44.1794993627427; Wed, 18 Nov 2026
 01:20:27 -0800 (PST)
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
In-Reply-To: <avr4MsRsjGfGHKKk@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 18 Nov 2026 10:20:14 +0100
X-Gm-Features: AclHuK_oniCwAqlI2oAZeu8xsFu1h8iipcGgGgvvNigzDOS5HzX_db5ZNqKqLFA
Message-ID: <CAKfTPtBZ=Dc_X48EQ0yXMym0JrS=pWvbviyVyFri0tv5VdR3Eg@mail.gmail.com>
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

On Mon, 16 Nov 2026 at 14:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
>
> Hi Vincent!
>
> On Fri, Nov 06, 2026 at 04:19:28PM +0100, Vincent Guittot wrote:
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
>
> Look:
>
> Let's say we have 3 tasks named TA, TB and TC. They all have the same
> weight and the same slices. So TA gets picked, works for a while and then
> sleeps for less than the rest of its slice.
>
> So the part that I hate and love, math. For your diff, we do:
>
> (sleep_time * weight) / (3 * weight)
>
> 3 * weight here is TA + TB + TC, it equals to 3 * weight since they all
> have the same weight.
>
> So if sleep_time equals 2, weight equals 1, and slice equals 3 this equals
> 2/3. If the lag is 2, we do 2 - 2/3 resulting with 4/3.

yes, we assume that TA would have run 1/3 of its sleep time

>
>
> Later, place_entity() uses this formula to do V - ((Sum(weight) + weight) * lag) / Sum(weight)
> So ((2 + 1) * 4/3) / 2 equals to 2. But this is wrong, no?

why is this wrong ?

Assuming TB and TC have the same vruntime before placing TA, the
average vruntime is avg == V(TB) == V(TC).
place_entity will do V(TA) = avg - 2
After placing TA, avg' = (V(TA) + V(TB) + V(TC)) / 3
avg' = (3*avg - 2) / 3 = avg - 2/3
TA's lag is : (avg - 2/3)  - (avg - 2) = 4/3 which is what we assumed above
TB's lag equals TC's lag : (avg - 2/3)  - avg = -2/3

>
> If we didn't decayed lag: ((2 + 1) * 2) / 2 equals 3.
> So we would do V - 3.

Which would end up once placed to
avg' = (3*avg - 3) / 3 = avg - 1
TA's lag is : (avg - 1)  - (avg - 3) = 2
TB's lag equals TC's lag : (avg - 1)  - avg = -1

>
> Now our objective is to add the sleep_time of the task to -3.
> Because if the task didn't slept, in that time it would be working
> instead of sleeping.
>
> So, we should do V - 1. But we do V - 2.

Why ?
You assume that the whole sleeping time would have been spent by TA
running on the CPU but we don't really know. We can assume that a task
with positive lag should run first, but this also depends on other
tasks enqueued.
My first version assumed the whole sleep time would have been used to
run which is optimistic. Peter suggested using the ratio of weight and
cfs loads instead which accounts more fairly for the running time.

>
>
> AFAICT, we can't already know for sure how much will a task run even
> when the sleep_time is smaller than the slice. Because of preemption
> :-(.
>
> The cleanest, the simplest and maybe the worst or the best solution I can think of
> is just setting lag to 0 on every wakeup with positive lag TBH.

Keeping eternal positive lag for a long sleeping task is unfair but on
the other end, clearing all positive lag for a micro sleeping or
because of waiting on a shared lock is also unfair

>
> Or maybe, try to calculate when sleep_time is smaller than the slice,
> but just set the lag to 0 when sleep_time is bigger or equal to slice.

There is a difference between sleep time and lag. Even with a sleep
time longer than the slice, the task can still have positive lag after
sleeping (this is also true for runtime). All this depends on how many
other tasks are running simultaneously and their weight

>
> What you think?
>
> Sreehc,
>
> Kayra
