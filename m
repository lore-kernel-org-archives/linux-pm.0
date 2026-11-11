Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387587;
	b=EbwqEzSDIjKnMcoZWTITvWqOCHz92IQymPQUdEtAkLPtj4+MCGEizCd7oEB/1GxzFS6U
	 hVfDX/6Kgi/c/Q52ZSw5i7T4WGENeDUlWQzJo/KczAVfkwrxYN6lEsaJvg/IBI0oCy2HN
	 rnXOzpRyYzvApx8ltV9OqupgJk7+T5WiE20i0nVpX4U8+WgMeJh/YC3g4hbMAtx98Vpi+
	 MAbxXvt6I6Uu0P1vdC3gpS6ai7xiQZ93nM5aiV5i6T5jhLBvMBtSajhmSZVscXvF2b/Uo
	 R+rebHlpa2UYlpxi0ntPBd3kV5DD762WCGSqya+zOCW/moqTwoldnvlucJVuHhOZNkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387587;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KJyTT988MFMyZ0ejmmm26IdmxQxtobwAxRtchBNx95Y=;
	b=HZDuK0X2xSdVr1P/tlXnLISXpTO2TY7AMrV5QjmFMbvO0oJU1ZPsFwzTsOBLncHKiFBR
	 xYW6D0g9E4ilI9BZGSoSXWW3s8xzHDyT3PQXeRanyjFJlfVVONOLgjrXp2G5JgPagVfwp
	 lqre/aVO1NQAFvNAr7HNeLFwKw6uY2iidbIgFhuPut545Wh7CilmrcnIbMNaxK70ecMJs
	 5pdMpnZPYjyxC/7j+iUgjQmRY7A1dXDE5Cw2sVwBqpOL3OfLS/CKsaTVXiMLNhgkf+atq
	 eWd/pakBf8OA99xJq33VTrX9gPmeQH4McLDyjgipXSUBo6QgySYzK7Yqu0vxbdV53jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ZWqqYCwb;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (unknown [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB060A2608;
	Wed, 11 Nov 2026 08:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2CB060A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ZWqqYCwb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KJyTT988MFMyZ0ejmmm26IdmxQxtobwAxRtchBNx95Y=; b=ZWqqYCwbRhSJXmgymwqnYUdnbT
	lEzA4p2E6yAgkx9W2+48mK2s5sullbAj/PKsSdqhl3R2Bj7wekraomE6oDjGay1srN3Iopv4YQNMw
	8flZCxH2vqt8poaJXswn0coovlZnCMQqeG7Z50VP6MWrd2FPCTBMH7zR8FtxhCPRUWmwZTqupNwKI
	4BXVD9UaAQ0fqfYx9cx0udLEdbqPXHkBo73FxZPH/brKgsroH/V61XP1qAEV2aASQ1CUoIh5ZUcwj
	FyV21ltdLHru9dqqvbwnsmGaSUjNCf2Yb8LllprP+MiFin3WgCCMRFFq07py0T9mEdL77yhe4Fbiw
	puN+qGpQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR4B0-00000008wgi-2AB6;
	Wed, 11 Nov 2026 08:59:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4FB6C303011; Wed, 11 Nov 2026 09:59:28 +0100 (CET)
Date: Wed, 11 Nov 2026 09:59:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com,
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, qyousef@layalina.io,
	christian.loehle@arm.com, pierre.gondois@arm.com,
	sshegde@linux.ibm.com, kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
Message-ID: <20261111085928.GE2668564@noisy.programming.kicks-ass.net>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org>
 <20261109144350.GD2668564@noisy.programming.kicks-ass.net>
 <CAKfTPtDcu6HS-G75bG7xp10t-n-XceneFtqxa_cAd+B96zCJiw@mail.gmail.com>
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
In-Reply-To: <CAKfTPtDcu6HS-G75bG7xp10t-n-XceneFtqxa_cAd+B96zCJiw@mail.gmail.com>

On Mon, Nov 09, 2026 at 05:07:31PM +0100, Vincent Guittot wrote:
> On Mon, 9 Nov 2026 at 15:43, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Nov 06, 2026 at 04:19:35PM +0100, Vincent Guittot wrote:
> > > +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> > > +{
> > > +     struct task_struct *p;
> > > +
> > > +     if (!has_pushable_tasks(rq))
> > > +             return NULL;
> > > +
> > > +     p = plist_first_entry(&rq->cfs.pushable_tasks,
> > > +                           struct task_struct, pushable_tasks);
> > > +
> > > +     WARN_ON_ONCE(rq->cpu != task_cpu(p));
> > > +     WARN_ON_ONCE(task_current(rq, p));
> > > +     WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> > > +     WARN_ON_ONCE(!task_on_rq_queued(p));
> > > +
> > > +     /*
> > > +      * Remove task from the pushable list as we try only once after that
> > > +      * the task has been put back in enqueued list.
> > > +      */
> > > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > > +
> > > +     return p;
> > > +}
> >
> > This means a task will only be pushed once? After which it needs to be
> > re-enqueued on the runqueue?
> 
> Yes, my goal is to keep the list small to avoid ending up with many
> tasks to push. So I only check if prev could be pushed somewhere else
> 
> >
> > So if it was found during migrate_disable(), its thereafter stuck? --
> > this seems a little weird.
> 
> If a task is migrate disabled while we are about to look for a
> possibly better CPU, it will have to wait until after the next time it
> becomes current. This is a simple way to pace the number of tasks to
> push in one callback

There is still a worst case where a lot of tasks get woken, they all get
enqueued and then they all get on this list and you need to iterate them
all.

If you want to bound this thing, you might as well do like
detach_one_task(). Only ever consider the first task from the end that
is suitable.

