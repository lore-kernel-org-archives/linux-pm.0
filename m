Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239669;
	b=tmzQxnOJT+5LKeRk2pw6ERlvFDDcMwPuK1uhhSgvMyeeiAS52R3JsVtNlOMWL10XHPsJ
	 lNV+DJiaWJvErG4WebJ5BLqD6EYx3lUdPDjjjp+MaOGJyY9rJxapZ73cvvQTA4/gPhELz
	 cwAGtW/5PgWfV5qp4seJGlNoYW0+RX0s3RDdrU5lmtx0OVoL4/4rO/qpSFDVWPoh2/6T7
	 Dm3tdD6AwgBUe7C06bQ8bfbNrzQGexvRUhIKRv+DtqjnJabccAqRs/Qqh6xA94Cv7K/5E
	 /JVFUvEuo4d2U0/B4G5Z8g5VbE45B2Qy4nb6YUmtnjZoZyzL8ZPKXWuCMt2aMsl+ZyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239669;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ujVbWQubLASE++avGWW5U3iuvslvg2L/fGbHxKmiOFA=;
	b=e0n+1pujoakoCOg2R0qekvaU6nm0q1tTCaUjEmBPzwWYm4prrPytZiwbDpTHZzbw1MC+
	 OWQBw6J0yoSAcrkWEh7GlZY/QmD2u28e+RB4KlhE6MunHMaGs5xODyUoHicE07kJOLgyd
	 jHfQHnCQm5sqymqDLt1Or4URxTlWDnB2WceknXp/T7vN7co9y1sYR7uu85Np52OMt3y0K
	 0bargkasTon5W0RKbD4g1Cv90W1Xbi5Rn9ARIqq7VhatWGrea/c5v0ayMRivdJuCQe9LT
	 EI/j92BF/uQadmzwmuZGl1KoCmx8g5Hh7ESCUeDh7iRgxp46oa7eozbwzHxW+M6oYfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=lf7omZ+E;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854D606A331;
	Mon,  9 Nov 2026 15:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C854D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=lf7omZ+E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ujVbWQubLASE++avGWW5U3iuvslvg2L/fGbHxKmiOFA=; b=lf7omZ+EGsTICAxB5HN+fQ1hYr
	ujKdcGAg4j5qg5iymRJQisgrz/9rbOUJxNzNPcG72PEONaTEIf4smP1Al28UCu4j+V+2g8quOUSjO
	3Qhw2ny8d2EqKzAGuAIPOH1pbvUzT8KCH75pF7S2beBnqMcMVwaP6DmwCWo/YHypA7OV5x88dSIsQ
	2by+LhlZcVjBxj+bn/OE2mqVjGNk7jyi/rPvF630PR2xipETxlT+uimeXOjTVmYS+Lh0dEa1qWIKd
	jHuurlSOiX+7nGhrptDvbI9IE91ghDef6oyLv+By+1WwnjZ9VH1Nxyv1JurYh3o+Z7bHI7rb+2CIi
	/lFetYcQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQRhM-00000006u8H-01cp;
	Mon, 09 Nov 2026 15:54:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AD05D301142; Mon, 09 Nov 2026 16:54:18 +0100 (CET)
Date: Mon, 9 Nov 2026 16:54:18 +0100
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
Message-ID: <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org>
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
In-Reply-To: <20261106151947.3991524-9-vincent.guittot@linaro.org>

On Fri, Nov 06, 2026 at 04:19:35PM +0100, Vincent Guittot wrote:

> +static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
> +{
> +	if (!task_on_rq_queued(p))
> +		return false;
> +
> +	if (p->se.sched_delayed)
> +		return false;
> +
> +	if (p->nr_cpus_allowed <= 1)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
> +{
> +	if (!__check_pushable_fair_task(rq, p))
> +		return false;
> +
> +	if (next == p)
> +		return false;
> +
> +	return false;
> +}

> +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p)
> +{
> +	if (sched_push_task_enabled())
> +		plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +}
> +
> +static void __fair_add_pushable_task(struct rq *rq, struct task_struct *p)
> +{
> +	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +	plist_node_init(&p->pushable_tasks, p->prio);
> +	plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +}
> +
> +static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev,
> +				   struct task_struct *next)
> +{
> +	if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
> +		__fair_add_pushable_task(rq, prev);
> +}


Can't we add the 'p->nr_cpus_allowed > 1' condition to rq->cfs_tasks and
use that, rather than adding yet another list? I mean, its used for
migration, so excluding all pinned tasks actually makes sense.

Also, I'm still not sure why we need a plist. The rq->cfs_tasks list is
MRU per set_next_task_fair() moving the current task to the front.

So reserve iterating rq->cfs_tasks, skipping blocked and current and
such, should get you much the same over-all.

That is, why can't push_task_fair() be something like:

	list_for_each_entry_reserve(p, rq->cfs_tasks, se.group_node) {

		if (!can_push_task(p,..))
			continue;

		...
	}

This would result in pushing the task that has not ran longest; which I
think makes most sense. Hmm?
