Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387737;
	b=dWACyYMtIvXlQKFHyaS2/8+6SH2Cv7pnphVSj9DA6XFhhmGa+ZNJxf9vZKJ8d/AtN4gW
	 6l/euMKN1BagYluWJOUad8NIDFE9rR83+16TnbRHR4Xf47brnNtzz9SmARJJRsSeSCFgK
	 Me5gocqS3lr8wz9JyEx+0WofJ+m0pUiVnhj7fnXxTB+SnPkFYte5XKPDmrm3AspIcNki7
	 qh3lERzG673bpkd959lYmi4rxifdH1FBiT8bse0F89yjeQ7KHOAGyEfm4iOTnjZRqbdhd
	 LU9PnyB3HhFXfqmVNJ8dosq9eKgF/mhVmdhFirxZnCDmoMSKbsII9RYFRDri6xNQ5XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387737;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KD+midAiex6FN7cbjzLrt8rXUDeZcRp9uHeF9WBYzgs=;
	b=hAE30UgYiwRDrfQehjmVIZbD6tNZfw9vsC/4fQp8zx5IqsZmKYvAg69wdXzbINHpw0y0
	 KjqZFb+riN315L0gghL5gd9eNr7cayoOKbSN/MACaW0RfttzQTj11bTWNO0oclnMYVhsk
	 kmGL1ueZ9Jr4bxllcWIr6wRavrk29ziyV29GtPNJRrL3ffRvT34Kd7dOh44cFMpeaSglF
	 4IicIdbvSof4cNuIfR1NkCV1dp1ApScLW8oRD+UJWX2BZRX/5klIhsgQtkcZd6h8JSdLm
	 r0xGdjm5CFvkjG+jdmP2cajJ8qeU+Tq9ZaH5TRksyBP41ETPivoWGeaTMmpBKpEQoKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="c/bGLBC4";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BDD606A326;
	Wed, 11 Nov 2026 09:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BDD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=c/bGLBC4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KD+midAiex6FN7cbjzLrt8rXUDeZcRp9uHeF9WBYzgs=; b=c/bGLBC458ggf7hNHqBNDG2RaR
	f1GL0aZJxkgURl47epFng8HPvxwjO3/EcMyBQCrM0s39eVaSq8WNvma2X3rhU2XkTdazBcsf49JOa
	+WmunSdDOCoH3cwAZ9CUWTux2O1Nij9KBBbGXB0wlaasv3snZ3v0BRV4qtBiwVSQV/UsvgvZJ05Ax
	XH8y/d8rURPw0hnZGfjVohhNkdI7rCFtOi1Fs6u+Sto0jvFumT5jXz/KyZdfjoxw6rqRghVWRJ5rE
	Ps0ie+MplwYHFrwgs27w5dlWYkVtXq0FlzHzh6zSu+6hYVRIj+E+5Txip2oOV2aAusr/ZJwTW5wdT
	BSnJEEyQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR4DM-000000088k2-1iYn;
	Wed, 11 Nov 2026 09:01:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 19EBA30025D; Wed, 11 Nov 2026 10:01:55 +0100 (CET)
Date: Wed, 11 Nov 2026 10:01:55 +0100
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
Message-ID: <20261111090155.GF2668564@noisy.programming.kicks-ass.net>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org>
 <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
 <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com>
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
In-Reply-To: <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com>

On Mon, Nov 09, 2026 at 05:14:39PM +0100, Vincent Guittot wrote:
> On Mon, 9 Nov 2026 at 16:54, Peter Zijlstra <peterz@infradead.org> wrote:

> > Can't we add the 'p->nr_cpus_allowed > 1' condition to rq->cfs_tasks and
> > use that, rather than adding yet another list? I mean, its used for
> > migration, so excluding all pinned tasks actually makes sense.
> 
> rq->cfs_tasks can be quite large (we even take a breath during LB)
> whereas this list should be 1 task most of the time (except during
> wakeup)

Like in the other email; detach_one_task() is also just one task :-)

> > Also, I'm still not sure why we need a plist. The rq->cfs_tasks list is
> > MRU per set_next_task_fair() moving the current task to the front.
> 
> The plist was only to reuse struct plist_node pushable_tasks; in
> struct task that is already there for RT

So while plist makes sense for RT, it doesn't make sense for fair or DL.
Notably for DL we keep pushable tasks in a RB tree.

> > So reserve iterating rq->cfs_tasks, skipping blocked and current and
> > such, should get you much the same over-all.
> 
> Yes but I was afraid by the overhead of iterating this list which can
> be very long; We have already seen email about bug with thousands of
> tasks queued on the rq

Right, so just take one of the tail and stop there.
