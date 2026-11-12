Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794466947;
	b=wk9nLRjnLnd3mmX+iZ9P83ghGp9kpStVxdAkSzL1gcn8w4WwMTx2iUBlyhrJ/4NyLye3
	 UN6oLXmrhc6/GyHGum8fXle4rfIS1cRKHlDuWedEo4FsRaMS3U7rbqgISIb1QHasKagLO
	 qtIZppfrdff91HxwgPhmUS4OWu6Xp1Z8zMuF83wzTzKZdDP1jGBoiMw7cDcGmFUj8AfXk
	 S38ErGCY2a1Wttrkt2M1mzqLWHiJcbqy7MR5dXta4451CfbG5zGwkuDK+MouJ44bsXotQ
	 9etPgcEIC0WneoVlIoeQjmz0jyreYQ9GLA8Sy//KnUpctOCFzyMHax0FvPfBUkvazGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zj4daZqcOfrk9MLreCDoKv45VzLcW0kMVsw4yuRmjFc=;
	b=lo1bOEa1+37fJYoaH/vtgxO4Chubo+PYUImuPsFFlUWmunA48XeDtSi9Tb1oOifvXjEt
	 EGgKD1FMke1qUXprz2eEy5tnqkfuy/IiFZjPPOE8a6v9Eb5uZRfae38n0/283aKIGQw7A
	 Kl3YkvMjceEobZlPA00UO/XDPTVN1WR12SyCFZDC2I9tf+dMef9+JfT3tkQbFcolKqTJ+
	 IKLCyqziDcz4W+ZMutbyflfE+ybDIERQ6bemwl0zicOzcTZeB4s520BnZzrq9Uxo0qUWv
	 iQnslVJod+aRxmeC2b34U8c34T5DRu4jeYTpXfa6d0JDE4EYH/JZAihLPBuyZhPbC0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PXWOUoJA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A6606A327
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 896A6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PXWOUoJA
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b79f5115c0so624880a12.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 23:02:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794466946; cv=none;
        d=google.com; s=arc-20260327;
        b=dmGtEmODs6BW2UEL+QIEEjGWqBX7ASo3bIT3lQJayhnwOg+ezgXorDLI7oDKc4Ne9G
         v/9xnEtrDWvFW+S4/QJ+Ogbrxn/btprnf00+dswIg8m/2C9wTTbYG4B/v6kJcSFvyEna
         TvWUm7vNcWf7Yjyc+OvZQQaaGP0JI2hzjfqi0kqFgcdlEUAgImXLesC0E33ueJOOp0hn
         BhHn77OS0F5PIqBLePsW10EzZokPmBJwYSEG1n1GZE+YYwKCk7T6K4x2K8amPGL88CIA
         7HEMRDD2iykvKMks4wOQrxjMz9DeW/74xyQjDFS3dvs/WJo2znweLuF24gFiqSQFW1FV
         1OPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zj4daZqcOfrk9MLreCDoKv45VzLcW0kMVsw4yuRmjFc=;
        fh=CjuvKe7EdSdC90pBSakaCNqy+0Vur9Fk8LizITrP2hI=;
        b=Z0n1w30Q7RIBmqDTcutABaV1HgHXRdQQ/VF30z/1E9x9Yj6kyP0XcK2GhS9j6ndr1/
         4NIcgF3EHUx6m6Pkgenh7z9J1tMwRNd9y/xvEsY2S9foDMlnZH6KniBMBpcqQX0UPfPd
         k01/v1jMhSG9UC89+JN5Lhjw2nA91V105ZViUNEHnF8ikEdgCesumlefqEBRa6cQ8xGb
         scRAD8BUNLeONwPn8lqW0eI5ZcDMjyD7LDZamq4r/Q2B+AyjiLfGG7wh4Ml7PT0lmLt9
         adAtHlSvVO7xVfduDp6rGXBngmsLr57rPk5J8ay1HXbf74W7KJ5Y5d1yCsG/NEVtQs+o
         TahQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794466946; x=1795071746; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zj4daZqcOfrk9MLreCDoKv45VzLcW0kMVsw4yuRmjFc=;
        b=PXWOUoJAKZe4F84y9dSv19nTvPgCLE7t3wF/6OK2ig1rLWBe5ND5kYjIbJVvKGGp0q
         3ZSPR2Rs/JDxKAPgG6q2nLooeqGi5oap0ZDMf5HCaL4dV8JjodKNl3ACgCKeNj/dm3bJ
         4845Q0ZgOcvEms9ueC9IhkEZMRRTZMy8yf2MN4zLR8l+o220MoW5YqaF2w1ym0hzm+V9
         Typlt88pojHaKYcDnXIDukueDzqIYuhWX923qSm/IuM746jbl2MWtxkP/WKwPTJXvbcU
         vAg7BaHx9f5TITUGVYdeM1RiLuZTJskUL8VtnEw0pM376PeA7Qw/dbkFu/FLO+KTuve5
         AUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466946; x=1795071746;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zj4daZqcOfrk9MLreCDoKv45VzLcW0kMVsw4yuRmjFc=;
        b=LHbGRebJPpvLQ/MwCYdYwnrR20bs3cpVmsqgONUk+KkgRljKa5BrzeI1TlGqaKtXQC
         3eSlPfVm5qVF7Ot0zHllPSFT4zOuczqji/f6tDnpOqM0AB0gdMFpGyllC79A9LJNW60T
         nY/HNXkJVJ3sAmAIUbLwBeLatN6MMAT1UY5fDIEWlTA0Pb5g5WiXGM/GRq3/fhlNx2pm
         NnBu90M1QKe9LK2j+PgqbGZMyHrUesbe9C6gJAwZ3c80PstT5q9GtiI6+LAeT1EE4UrH
         rNvBJzSs8GMUtfh2wQgZ9YOqdLR7UJ3x7jMFTMH6HjvxdjrgeQIt3W8AsINyA8uSOLRi
         OhZQ==
X-Forwarded-Encrypted: i=1; AL+hErGcXuTbrIiKQsmJ7EE6FSp1sxMg8dJaT0s+ZD5bRa/mMd6/8R2Sf9lzCfFPaN1yNxdw3asPuTmOaQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/cIWPRyZccL7HK1jT7NuWOnQzzie26iUfGjzUmT6ALi+C0WJxK
	qt5CFatuUhUxAFXtHE0NAN8ULftXjpgfSgSeRzhql1/TjvlgE+b7JrhWlQu1XT5NJEn0Up3tOg2
	2fJQhKi/W+DWdTKPojiHq1HS/y4cvlndkvbFVo2z6xA==
X-Gm-Gg: AYBFou3vDVNHJOujfztdSTHu2ez8HQ51XROmwh4x4h/dimE+mHaPGkQR34nsJ6XoJvg
	OrOB6/22JIaMMcVke4lWohu/6zYoS/sSBQ3eeD8gm2hIfCJ52cDHKK0kPRQtIv47uovxT2Zd5s8
	Eg8nHlrsVwekatDKIDvhl4ivudYJXhajDWirL+J1VHOiZO3BQ3un/Vjks5eW2Kgnq4WllP1A4yp
	9Au85leA/QkwWa/0r8BGNgnLFU5uC3/EzD9NI5J2CTeHfXk8BPGpF2LtFxuBWYw4YeTHfu7+DGC
	bEgljrE78Jqmeu66dXXfy/zf3UOOlnaGf5efs1hAmOE3qUBrqr17+7Z6vAD06cI+67u48mznQ5+
	hwFgQ9sxRkDBdDkhwQinzmczFRWxTQuvfcWmdjvUWiV0oM99C1MviK65pZ8P+JxL5eU3mgg==
X-Received: by 2002:a05:6402:28c4:b0:6b4:602d:f1f7 with SMTP id
 4fb4d7f45d1cf-6b7773f4731mr3380483a12.20.1794466945804; Wed, 11 Nov 2026
 23:02:25 -0800 (PST)
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
 <20261106151947.3991524-3-vincent.guittot@linaro.org> <au38gSTzmvPKmqWT@scheduler.schedules>
 <CAKfTPtDXo8_3tfXt=UH+BKyO1rJCWjRAVXjO5nFVHO1NBd8LyA@mail.gmail.com>
 <20261109154536.GK1779021@noisy.programming.kicks-ass.net>
 <CAKfTPtAL9T0bGZdhkodC49DtNUFKJgEn9f5wLNBe_rGxzJEN0w@mail.gmail.com> <20261111090354.GG2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261111090354.GG2668564@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 08:02:13 +0100
X-Gm-Features: AclHuK9sTnZDoWNK1z60y7C5PPNcVNuqCH5Q2WF5qMfYgWqlwEG8DadJrWu2JO4
Message-ID: <CAKfTPtBeEQU-7R0wPZeQXF6RdC_kDkbmbCcRBj_WZUCksU5gqg@mail.gmail.com>
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kayra Cizmeci <kayracizmeci@gmail.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 10:03, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 09, 2026 at 05:27:57PM +0100, Vincent Guittot wrote:
> > On Mon, 9 Nov 2026 at 16:45, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Nov 09, 2026 at 04:27:14PM +0100, Vincent Guittot wrote:
> > > > On Fri, 6 Nov 2026 at 17:22, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > > > >
> > > > > On Fri, Nov 06, 2026 at 04:19:29PM +0100, Vincent Guittot wrote:
> > > > > > @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> > > > > >
> > > > > >       dequeue_hierarchy(p, flags);
> > > > > >
> > > > > > +     if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
> > > > > > +             cfs_rq->idle_seq++;
> > > > >
> > > > > This needs WRITE_ONCE, no?  3/20 uses READ_ONCE().
> > > >
> > > > I hesistated to make it WRITE_ONCE but i concluded that it was not
> > > > strictly necessary because the READ_ONCE is only used to compare the
> > > > value but not use it for any computation or sync so if the compiler
> > > > wants to do any kind of optimization what we really care is : is it
> > > > equal or not ? so any intermediate value that we would read would be
> > > > ok
> > >
> > > Right, so without WRITE_ONCE() the compiler is allowed to write the word
> > > in random order byte writes. When comparing only cares about equality,
> > > any intermediate messed up state is not equal. And since we were
> > > incrementing, we're not supposed to be equal to any previous snapshot.
> > >
> > > Therefore all is well.
> > >
> > > That said; we should either document the above reasoning, or just do
> > > WRITE_ONCE() and get all the sanitizers off our back, because I'm
> > > certain that KCSAN is going to complain about this.
> >
> > I agree that it needs at least a comment. I can use WRITE_ONCE but I
> > remember seeing somethign about its cost. But does it worth having
> > sanitizers complaining ... I will run some tests and use WRITE_ONCE if
> > I don't see difference
>
> Mostly it doesn't actually cost anything. The thing with WRITE_ONCE() is
> that the compiler cannot elide or merge the stores, it is forced to
> actually emit the store. But here we need a store anyway.
>
> So the worst WRITE_ONCE() does it get in the way of compiler
> optimizations, but I don't think any of them are relevant here.

Ack
