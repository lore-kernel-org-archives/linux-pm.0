Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED9324B33
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552929; cv=pass; b=RjGENNwV7JjMZFYLoLuEZTUIo2KNj8/9W+9e/8kj1V3ieuqrjEWRPYKAJ2j/b0pk21DTgfYzNr+LBWqjD4ppiP43hOBRdStcF1RDPEMb81fxiVHRHFYIjo8FTQxz5AW1Q1AwSBqKFitz2FxuceopgNI76zoDITwuweC7W7nlE5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552929; c=relaxed/simple;
	bh=NSL1230ZzJQ74Jx1KNkVBnc3qpUs25gQVJx30zAtXRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIFTqGC0Cr4JDoEogWoMYlVZ2vWJ3wNi3TJRpQuRF/i05pcMqxgdzVk4/hOUi84lCOFhwLyo9GyTY0B8+DwzcdpdyMcfxnhR9zg4FXz0EUKn8ep/QXaQiXb4slzInr8gyOdgrMZiaZm14FfwyFoVmVpmWTq1Ox5UZSQXuN1ZiAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YRMQEu9n; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRMQEu9n"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c3156e7705cso785411866b.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 06:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791552926; cv=none;
        d=google.com; s=arc-20260327;
        b=Y2obaaC4NRblsiIqhgj5wN7WZP2xhv3kBdL0wv4is44bY9q1kN23tik+6zzMCJSG6A
         h/PnBYoN6lKh9z7TVhDWPyTuUqmZeNkpwMXK5t9KCLwFvX24pYYPSB+Kzvc33PpWqZs3
         QRtttimlftf5cM5zL88k5SK4Q7Nhw74N3oRi2DzV2epYXx1eJdpYF87b1iWxnEGpUU+K
         lxLtZ9TQ8SmfFaMHdhnC5LdcX2BiDh80Nfv/tjSOmETzkWE04m6ft4W4XcTzPPxJQjX7
         DZaXYJCpf1/bBnStrFMd4TO54wjrHEbvlc958U5RmYP/Xpc9I2pHji3z+tdoohjqXcEi
         INaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5gh61X4RiGipDxIUahocXKIUNnUE9ZBer048Hrx3Sr0=;
        fh=NVTaepM4IMsoznPgER+DwVstZeWa5jH4gVXsPkfGkCY=;
        b=n1Q0GWyiMnrJKRcOreRUv5qKQMHBVss08b0ZCNwkoY8iaIf/1wx5E9jjdORsq0DXJA
         Elo/JSUKfML21nG5hd/Bp1gr+4V+MkGJWq2QwThfUzwF42X5cPoz0WiZbDYZC9mtQ1rE
         pq1Cs4We6RUhTV69QrevuBGN7Ct+wkErmnC3gnWM7RKR6O9Ery/v2Vozk6UcgqzBmFLv
         n5RKrPJNDgJKALkfrKuR2EjJnfufPkhydg9AhMmPGGFUt0kkL/+vQOAaFjADVX1vb9r/
         /SPliAqPBVOHRvyw/LXycCzxyWjtnKDI6TES+UuTkJQn7FVCDd0lraJC6CtpZlEGpzs4
         019w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791552926; x=1792157726; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5gh61X4RiGipDxIUahocXKIUNnUE9ZBer048Hrx3Sr0=;
        b=YRMQEu9ny5/5G/UNn7sztXR/8BdFDsJrhXK8+BmuOueoCjt7IQo7wMSYlGBqHyUMgI
         f5d1YhjlI2uHIVvq6s8SM8DKviwFnHQs0tNlHkiufdojvq9GG29Bwt4MCYliwVt4Nxu+
         XpLB/Y+DQOH2hiQJFsGy90HUjMPs0WVlZiilPWqqeI1RSLlcjRkpykBS61U2Eo+GHfM9
         Gy3w6GnXJ08+peLP6VXXo1of/3M0BbS+o0z8nV5tq0x8RF8HeRIsBPLdrl5Dymh8wliI
         zJJFTaYJe9TpDxArStjnQLfwCYnvZogivAsfvVB7+GaToXocxCi8FKD+ZgBZlLOxeMXz
         hdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552926; x=1792157726;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5gh61X4RiGipDxIUahocXKIUNnUE9ZBer048Hrx3Sr0=;
        b=k5twUvLfylGkOl0nnkP0Y7pA8QgksdKvgGS1XtGkPZhbuOLMsahARWYo1ml/qC1Mia
         J/VGGx3uvsDiFLMgSblTYdNpp5eHKLVV+drjzWU46COo5U1wVREJVFtilfnlejF9JKre
         UMsGTs7SFbzd7F+qWfmTBrxpQM+iMLkGgS/+oM+1A0VclelV0v0rCNkz970KHb7///Iv
         Z8XbNlnvE30xhVjaHZVYQffCYwSLJK/iiXKdqNOsosWXc59MUcYZ/pwAQIZQ7mueHLG4
         443+kagbYPQ3x1Gmasrs2ACsd0xmWMIIg+Q/y64ueXfahKV3SXpHbN6wjpCpUSdmphU6
         5eJA==
X-Forwarded-Encrypted: i=1; AKwUvByZl9woV936noi1qzFjh+c0cK8rLxySebhUreawMlHec5vgi5kLhrILBVceWXwuIsUafDorifSRZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLMcsuWY1sY1G5h3enPCLpsTdhsgyqwtHzbpxC8t1GZySIWOZ3u
	t4nQ0bz7mRQbcuuyjp8nsPmlDuy8KQJ4ntWS9DcZn4A8oNPq8lWOYLJe+N3C0ubtYwLWkv0LIxk
	lO5e/WTM91K9UniCKq6qHT0W8JG7c5qzhwaE+0xuNmQ==
X-Gm-Gg: AYBFou2s/DKB/8BLIvGKlLQXOCf+d6xPTc2ztpSJ6xveS3feXgYJuUGheN7e36mBYfj
	EsKhbKsAiAZRNNpHgY0jj6YxGplxGhIvcb5LPYihgF7kwxPRRvQJnbBL/A5BRrFEDYji2iXPvLO
	vKmhe616q6QUo+t55KATvu/awiiN6qgP7ean0XJ3OSF1pplHrLTF+XeTUK+haUT7sDdomK52kGq
	QjKn5LE7taDX3Q4LuME9MdDz54SgnO1zKdpTCd6mslE9GdfJ/8ux8YVFTfOcDBlP0hcOxDF2ark
	IOOx6NOWEgkEnZ8jwivNWIhEaYZIOIk8QRS4x/EDg4auYY+JrLdW9s6gnE1RSwlu6wswQHPCjbe
	brZ3+1CdxXII=
X-Received: by 2002:a17:906:f592:b0:c26:19de:912c with SMTP id
 a640c23a62f3a-c31aa07ba07mr238720566b.31.1791552921162; Fri, 09 Oct 2026
 06:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002154415.2270586-3-vincent.guittot@linaro.org> <20261004173032.18867-1-kayracizmeci@gmail.com>
In-Reply-To: <20261004173032.18867-1-kayracizmeci@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 15:35:08 +0200
X-Gm-Features: AclHuK8U9thImNFByGGzg7OkoOg8Hahf03eIGKYMWN7wt2qam3WUMqyVYhsj5oM
Message-ID: <CAKfTPtCWNmVcQ_R+dN0MdZoFnXAGkJL3XmnqSN64vuz_doQzSg@mail.gmail.com>
Subject: Re: [PATCH 02/18] sched/eevdf: Reset lag when waking up on idle cpu
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: arighi@nvidia.com, bsegall@google.com, changwoo@igalia.com, 
	christian.loehle@arm.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, pierre.gondois@arm.com, 
	qyousef@layalina.io, rafael@kernel.org, rostedt@goodmis.org, 
	sched-ext@lists.linux.dev, sshegde@linux.ibm.com, tj@kernel.org, 
	void@manifault.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Oct 2026 at 19:30, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> > When several tasks wake up simultaneously on an idle CPU, their final vlag
> > will depend of the ordering as the first one will lose its lag but not
> > the next ones.
> > Reset the lag when the enqueue happens while no fair task has already been
> > picked et set as the running task.
>
> There is a typo. ('et', also 'depend' and 'loose' Not sure that's all :>)

will fix the typo

>
> > As a typical example:
> > CPU0 is idle
> > TA with vlag 0ms and TB with vlag 5ms wake up on CPU0 simultaneously.
> > Depending which grab the lock 1st the behavior will be different:
> > If TA is enqueued 1st, TB will be enqueued with a positive lag and will
> > be picked 1st.
> > But if TB is enqueued 1st, it will loose its positive vlag and both TA and
> > TB will have 0 vlag when fair will pick a task.
>
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index d7cc77181ef9..32d7077ef148 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -592,6 +592,7 @@ struct sched_entity {
> >       u64                             vruntime;
> >       /* Approximated virtual lag: */
> >       s64                             vlag;
> > +     u32                             vlag_seq;
> >       /* 'Protected' deadline, to give out minimum quantums: */
> >       u64                             vprot;
> >       u64                             slice;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8cda1d39b037..4c8f12fc8869 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -893,6 +893,7 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >                       vlag = min(vlag, 0);
> >       }
> >       se->vlag = vlag;
> > +     se->vlag_seq = cfs_rq->idle_seq;
> >
> >       return avruntime - vlag != se->vruntime;
> >  }
> > @@ -914,9 +915,22 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >
> >       rq = rq_of(cfs_rq);
> >
> > +     /* You can't claim any lag when waking on idle CPU */
> > +     if (rq->curr == rq->idle) {
> > +             se->vlag = 0;
> > +             return;
> > +     }
> > +
> > +     /* Accessing remote rq task clock is a cost */
> >       if (flags & ENQUEUE_MIGRATED)
> >               return;
> >
> > +     /* CPU has been idle in between so the lag has been removed */
> > +     if (se->vlag_seq != cfs_rq->idle_seq) {
> > +             se->vlag = 0;
> > +             return;
> > +     }
> > +
> >       /* Compute sleep time */
> >       delta_exec = rq_clock_task(rq) - se->exec_start;
> >       if (unlikely(delta_exec <= 0))
> > @@ -8190,6 +8204,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >
> >       dequeue_hierarchy(p, flags);
> >
> > +     if (!cfs_rq->h_nr_queued)
> > +             cfs_rq->idle_seq++;
>
> Shouldn't this skip DEQUEUE_SAVE?

Yes


>
> > +
> >       if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
> >               se->deadline -= se->vruntime;
> >               se->rel_deadline = 1;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index b98084e1f5b0..69a2a749e188 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -689,6 +689,7 @@ struct cfs_rq {
> >       u64                     sum_weight;
> >       u64                     zero_vruntime;
> >       unsigned int            sum_shift;
> > +     u32                     idle_seq;
> >
> >  #ifdef CONFIG_SCHED_CORE
> >       unsigned int            forceidle_seq;
>
> Yeah, well AFAICT other things seems OK.
>
> Also, while trying to get this patch series on my tip
> branch I had a hard time. I was at the caves
> of git and b4 figthing with... Everything.
> Like there were no v2 tags on some of the patches
> so b4 didn't tracked them. I had to do some
> things by hand and finally it worked. (Not too greatly tho.)
>
> But who cares? :>.
>
>
> Thanks,
> Kayra
