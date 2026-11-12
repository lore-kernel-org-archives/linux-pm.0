Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794466916;
	b=yGjknO6GMO74ndLDPb4uJ9N9OgQ2nqydfXuNC62T5PMmyoq6le6k1ZqzhHZRoPOyIKRk
	 Xr1rnZp7P7ww1ZIluYHJ8NXiiR/TU3NB5eof0nN7NvM3fwfdM/s1hmB7Yfqft40aW1X3f
	 4/AtFYHu7o2en/9MVWCQxMTN7PWl7NBo7p6s+Xb2Ru3iIYyOvA1AWdejOT5rnIbTNt3u1
	 PLeqbJfsv9RrChPuNweY2iUULkiAo9oHfFhYRjdDqF4W/mtmHjvTcP+mx42G20EP+738s
	 KoSTKDXoVmTvslQLG0her315GsWrR4FHO5FEK3UFI/n1ytkZEAh4j3sXkVBczGOpmnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UE2S/v9lUpY69MJ7L+FzJG1ltivTSX3+KzjoTbLuPuc=;
	b=jcTRCzbWuwnqPWcSHPQCKJZRQogXoAE+yyS0brI0oBZF4UJC6e/e1/03+f2a4eEy94Lc
	 sVcjyMmHZTQ0GhjJC26hLXvjOHL3ZXleBqlhjC7Cz5gmCqBcUIaCaOaM481lZ6x4G6CrE
	 WAEutlssRlVriEApDa6IMtfIx//DnTh8RHZXCmoEctaVzKKA+65/uGDtpoFoCFMLT61op
	 FkL3HUFt/rfgCOlaO9gVbarzlRiWBbpKt625XhRCN4O7aJXogDXHRvVeM61sh5qwx5olz
	 oF09wRnqLJtObnO1dVaP00XdP8hg6j39lw4X+p9gcXybRm8v+UqV37F8T7qtJX+YGMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UiAixHN1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CCA606A327
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48CCA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UiAixHN1
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so4547341a12.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 23:01:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794466915; cv=none;
        d=google.com; s=arc-20260327;
        b=fZsKP0lMiKCXF9jvw3DeeUCCHCGAA0nrwpHFT9i9XLzD2lkX0vP79cpEg2uScAfvCl
         xB2Cdc6gurjK5cJmcsVZ26bSGRd3AbioDi3Ph3m7asE6QxVu7oTiYzGtSUaj4OxjvcmT
         FaZyZbTIkVNuWmILQrcoOPJI5rKN7ywHFJlFUoprmnfMtZiBs4d6IOqCW72xxMv3mv+m
         2Q9Y7QvzURA/fHjr5V9pFltpYzuO3ZNNlIAeFZ1pA9yeYofLXFj7Qe07kwtN80Fs0JWP
         NzgMJX1E++EdK7Y0iJFAIm1zTko8+Jl01DkumIp4ByxMfe6jQej9wJMpjtj2hKXx8YdY
         BwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UE2S/v9lUpY69MJ7L+FzJG1ltivTSX3+KzjoTbLuPuc=;
        fh=IcvVe96Na6G4rblzPi1qvAbXOap97j4n9fYZig1xU+g=;
        b=ElRcqdGeCmCLiO/zcd6jyculF1nQ7QaMeoYL6qyYkk2IDinAmk8wIET2RobynOBorB
         WnIrQy40wCrGy8jxtZNwNrLPhL1VjCUBCasRhql0lbkyurkQqu7MCzyENoh/e+SgRt6l
         jX6bzJJDRUdtkXG1bTE1n9H4ruy3l3enIL15W7tSaBXzBStwHU0X3NLuGoOeV+9/uvLu
         oKz2CKRTLXjMbA/0ir5zR0cbgWq3rmSHZ5/vrT5rQjRXoNyTNJh4Sd6CjUQfHTRn+WvJ
         tuUvCjtrmHMjcAx6J1XFKAtTZJJICk1xQ4NVd9NkT3tZCg7ntdMyCC6C8ByYj0Hp7fXy
         4bbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794466915; x=1795071715; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UE2S/v9lUpY69MJ7L+FzJG1ltivTSX3+KzjoTbLuPuc=;
        b=UiAixHN1FUbfDe7klDgIiMH62rnQAf9KRkO3u1AfWrm5CI0uh82tN0eXc3T9wbA1Vk
         Z8e2YZ2ub0b4ecefSp1MlLEP9YoKN9hs3yBnqsQ79R6LmoTehDvWMcwTehXLsJ0k85ZT
         aPlsOaL6jxHi8jiee/UUZhJlaJ3V25Tw2gI4OROVD5eqcmSqr79oxLXkhIMmwqd3Qoo8
         aRpxd5FzCw1PnCPlkVLYqjlR1eqckLU6ezpDBr1aIrEQNs3/CuzwLXhXWvW3ZzGUKW4N
         /Wne4+lV9YUhnr8P2O4p4+yZRSNJ2yOF6S5fMPm1PGN79bYpHqjnD7jZCNaySrLT6Beg
         A8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466915; x=1795071715;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UE2S/v9lUpY69MJ7L+FzJG1ltivTSX3+KzjoTbLuPuc=;
        b=LBUcn95o539Q+EmbAi0Oy+BNbGfB3ySmup7VTFUjdXmkTJHrGdNrzgnHn2bjcZ5Qrs
         0d6K41jRdiG2cg8zCHh2cqZXyXGZgWKznMZ5a9K/ULO0iMD6gvpTil3aw6S0JajG8GQ+
         xI0orjWGw/VJ3U63Fup4tlaIPuzGaw13G/RWLtuS+JfNVnAjzPXIzeakqBFCaF9BOGxB
         z3AS/t1GB8eCgD58MxsBjVfnX64NGWtKYs6ZvVnGgyMvzwTUbin6yb6OZaX4B7ynH2Gk
         WVCSncosGR+A+z5Po4V8dnybVwQKMtRwXViAZLS+gdsWLOd4PqGOQnE+E0l+9EZjSqgX
         KNRA==
X-Forwarded-Encrypted: i=1; AL+hErFTmJAkBnmVw1/9w9S9JO1uSpnCSEia9t78sQuB3y+Cb22NmXFRdQimE/E5pi3eb8mAM9W9deH6Rg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+vYkH965ko7vycoKqQz6XMKAdqyH2YoK0MFvMye0KLN86tTFXY
	43vhFdAb8gDX39YKfAC0sMdhx/2cMEh3gCeWbWFqBG3hubXUmDb3Q5fcp4mWMRgQyy4PqOOkkeB
	eU+waPAD15zfZq+pQ7ffBDxbzDJ+SfsGqW+xnnvGdIw==
X-Gm-Gg: AYBFou2A7ukN6dBukTbTSIgGpZoxnS5QoLC92rbnX+SvdWow6RNS1BHU9Q/D7spKJLK
	mdtlUNEoQlESbKT37u4DKfVuX+2rjKx5eew3AdZ38zj/Uuecz+d1ZqTA8EHG0KJ6A7TMYCbc6Yx
	fqunK4W9Ovx0woK3N0DU82pZ23P5vJ7gqUQJ9NAv3w89T1iNvLQrOJT7GIw/OJxiVELXQhQJmcE
	FrmBZOb5ImLVojp0Yn09C+sbTX3TkJZcYkg21Tt+S5tFWZmRgROil0TaUmVeRHp1DqO9/UBa+ps
	8Xk6DHnWXp9u782XM28ERc8Xi29s08EdKAi4QK4k8oV6Cz4d6u2jQFPveqgHplBTYqidSlxxhoC
	HLWCf3ZcKxTeKmPJvSKWi/qxPY9puVIrRJj7fG+5Qhid7UWmsIMMukOmwEnPeieSpcnjzDg==
X-Received: by 2002:a05:6402:1f03:b0:6b5:767e:f030 with SMTP id
 4fb4d7f45d1cf-6b77733a4b5mr3291059a12.2.1794466914501; Wed, 11 Nov 2026
 23:01:54 -0800 (PST)
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
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <20261109144350.GD2668564@noisy.programming.kicks-ass.net>
 <CAKfTPtDcu6HS-G75bG7xp10t-n-XceneFtqxa_cAd+B96zCJiw@mail.gmail.com> <20261111085928.GE2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261111085928.GE2668564@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 08:01:42 +0100
X-Gm-Features: AclHuK-gkc4M-jSyE1nXnvG2bMRR6frusiPuC8UsfPnuglBYeu9svvaRxrdoStY
Message-ID: <CAKfTPtD054JHb38LdY-Dgdo4LTOVU1f80tL9hf9i629kEc6wkA@mail.gmail.com>
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, kayracizmeci@gmail.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 09:59, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 09, 2026 at 05:07:31PM +0100, Vincent Guittot wrote:
> > On Mon, 9 Nov 2026 at 15:43, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Nov 06, 2026 at 04:19:35PM +0100, Vincent Guittot wrote:
> > > > +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> > > > +{
> > > > +     struct task_struct *p;
> > > > +
> > > > +     if (!has_pushable_tasks(rq))
> > > > +             return NULL;
> > > > +
> > > > +     p = plist_first_entry(&rq->cfs.pushable_tasks,
> > > > +                           struct task_struct, pushable_tasks);
> > > > +
> > > > +     WARN_ON_ONCE(rq->cpu != task_cpu(p));
> > > > +     WARN_ON_ONCE(task_current(rq, p));
> > > > +     WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> > > > +     WARN_ON_ONCE(!task_on_rq_queued(p));
> > > > +
> > > > +     /*
> > > > +      * Remove task from the pushable list as we try only once after that
> > > > +      * the task has been put back in enqueued list.
> > > > +      */
> > > > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > > > +
> > > > +     return p;
> > > > +}
> > >
> > > This means a task will only be pushed once? After which it needs to be
> > > re-enqueued on the runqueue?
> >
> > Yes, my goal is to keep the list small to avoid ending up with many
> > tasks to push. So I only check if prev could be pushed somewhere else
> >
> > >
> > > So if it was found during migrate_disable(), its thereafter stuck? --
> > > this seems a little weird.
> >
> > If a task is migrate disabled while we are about to look for a
> > possibly better CPU, it will have to wait until after the next time it
> > becomes current. This is a simple way to pace the number of tasks to
> > push in one callback
>
> There is still a worst case where a lot of tasks get woken, they all get
> enqueued and then they all get on this list and you need to iterate them
> all.

Yes but this case still limits the number of tasks added to the list
because of the case which involves short slice preemption and
simultaneous enqueue on an idle CPU

>
> If you want to bound this thing, you might as well do like
> detach_one_task(). Only ever consider the first task from the end that
> is suitable.
>
