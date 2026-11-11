Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387841;
	b=HAZYPGpzhebX107M/gKmnAungIR6vjpRVmKsneSDsr5ssgsChcggJqoWojsTdG5p5wKI
	 VoGfT49RmeQByPisVbKPPg8iFkLrCxBojyFYlVo+5aoYclilvRyjZ2cyWu6yA/3qto1r4
	 AaCpGzmYzthPoYk07Z5TpPgYkmIwD5j32pdd0R9K0M7i1xpv8FP18ks8ABYAJUmJF1Tqb
	 VZiTxF3Ah6Dd2hAUvPxwDsZizH68XrNAuOFSKojzWAgcFSiT7GjEBU81VFbtoEjYMpQQt
	 JUCBPsYELVu5YlVJT5KYZoMo4Y7hQggT/b6tfS1HZRyswxGIBHAB44pKOjsOjoz+oUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387841;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=CY9z4QEeIEDwH6apgb1ycoV4HKxdCekmhlR9jszG3Zo=;
	b=gajs5J1KNP689MssEOPhIYHgUPfKu4BsY33jb6znBUbhxqbgMrI0jU9RemR5/7r+LBt/
	 k2otKwoe+By0U59SzTxw1smp6vBLOqjehoDpWMohGegbkNBVtlKFdFsdXQXgJwKXIGtmr
	 K4jdZ9SmkYTyVSrAMYjHcCUJKqkOhFWL9BdEQ13WGkS3ZNgy6QsjFuExDq83TMP7m0/Ja
	 OvOyaKJqn0dl7TrCsFnGNtOvjd8eErRT7NMHK/kMIZGHNVHixPPmgkWQqFlJAWEHwoGOw
	 7ff8c9fiCrSdyjqbxBmUw854BHUce7dUQJDyxfCOk/y0owNFOUuXNt37KieV1x1+LiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=B63AjCSX;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011C606A323;
	Wed, 11 Nov 2026 09:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9011C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=B63AjCSX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CY9z4QEeIEDwH6apgb1ycoV4HKxdCekmhlR9jszG3Zo=; b=B63AjCSXNuw0/1ct1QbA/4iUUY
	qDF2y3IEzjqidt2mz4G6V1aog3vqIsT8PMx6pj7A5TNcZt1aR+jBN2s4rSKWU3qB2AK8cLYPtTXfa
	zWD03O4XUWR/L3O2Hsi//9FYFPL6WWGsmSDFlDPxXRZY46WGlfOyAiIGfYcjq6OfMoO1+TPneYqGs
	DhWmzGgjPjOICzK5Kndw3gjQOcraQxMsOMKn7ZWC0JzZfTH3UOtRppasLqbWugYhAPOE3vBlvNq4/
	Y4dm7WkcBmdvXPd7OP0eBH08xiTbDfITTB53vScAFMy4ZM82zHl4ZedO0rHIgLQzPMg9o6r/cakl+
	QLVNsgKg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR4FH-00000008wy2-41vh;
	Wed, 11 Nov 2026 09:03:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E1CE30025D; Wed, 11 Nov 2026 10:03:54 +0100 (CET)
Date: Wed, 11 Nov 2026 10:03:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Kayra Cizmeci <kayracizmeci@gmail.com>, mingo@redhat.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com,
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, qyousef@layalina.io,
	christian.loehle@arm.com, pierre.gondois@arm.com,
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
Message-ID: <20261111090354.GG2668564@noisy.programming.kicks-ass.net>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-3-vincent.guittot@linaro.org>
 <au38gSTzmvPKmqWT@scheduler.schedules>
 <CAKfTPtDXo8_3tfXt=UH+BKyO1rJCWjRAVXjO5nFVHO1NBd8LyA@mail.gmail.com>
 <20261109154536.GK1779021@noisy.programming.kicks-ass.net>
 <CAKfTPtAL9T0bGZdhkodC49DtNUFKJgEn9f5wLNBe_rGxzJEN0w@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAL9T0bGZdhkodC49DtNUFKJgEn9f5wLNBe_rGxzJEN0w@mail.gmail.com>

On Mon, Nov 09, 2026 at 05:27:57PM +0100, Vincent Guittot wrote:
> On Mon, 9 Nov 2026 at 16:45, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 09, 2026 at 04:27:14PM +0100, Vincent Guittot wrote:
> > > On Fri, 6 Nov 2026 at 17:22, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 06, 2026 at 04:19:29PM +0100, Vincent Guittot wrote:
> > > > > @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> > > > >
> > > > >       dequeue_hierarchy(p, flags);
> > > > >
> > > > > +     if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
> > > > > +             cfs_rq->idle_seq++;
> > > >
> > > > This needs WRITE_ONCE, no?  3/20 uses READ_ONCE().
> > >
> > > I hesistated to make it WRITE_ONCE but i concluded that it was not
> > > strictly necessary because the READ_ONCE is only used to compare the
> > > value but not use it for any computation or sync so if the compiler
> > > wants to do any kind of optimization what we really care is : is it
> > > equal or not ? so any intermediate value that we would read would be
> > > ok
> >
> > Right, so without WRITE_ONCE() the compiler is allowed to write the word
> > in random order byte writes. When comparing only cares about equality,
> > any intermediate messed up state is not equal. And since we were
> > incrementing, we're not supposed to be equal to any previous snapshot.
> >
> > Therefore all is well.
> >
> > That said; we should either document the above reasoning, or just do
> > WRITE_ONCE() and get all the sanitizers off our back, because I'm
> > certain that KCSAN is going to complain about this.
> 
> I agree that it needs at least a comment. I can use WRITE_ONCE but I
> remember seeing somethign about its cost. But does it worth having
> sanitizers complaining ... I will run some tests and use WRITE_ONCE if
> I don't see difference

Mostly it doesn't actually cost anything. The thing with WRITE_ONCE() is
that the compiler cannot elide or merge the stores, it is forced to
actually emit the store. But here we need a store anyway.

So the worst WRITE_ONCE() does it get in the way of compiler
optimizations, but I don't think any of them are relevant here.
