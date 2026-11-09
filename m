Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235442;
	b=vFQm/LqABn7DZg+rN75sDXYbuyAHEvvxZdjSt9xpvCLB1pO0nO3rqfraALPi1LiO/+F6
	 NGcQEqXm/GZDWd04ubmJ4dKeAS5MqaDrktLkQFQlF3X540DVnGqkiAjrWz7QzKCx6aQph
	 HMSvRLi+AWiQuogZ7Zh1kN8Z3CyXP3BOEvPUWfuHfBVbXR9KmN9lU6mOnNUijyCvogOYC
	 yl80rDK2zYNXzP1mDsbmqEpsfuugz6+WqgvoF8wzZMOQhXUPq0Vvz6Dx+/D34WpPjk1Oj
	 YeM8q4ZMcXxNpZb5jg2GU4+EN1G36AYd0xrpJZ0o0NRrjw8aBo17g2Sf/u6aqIcIBGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235442;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=mDNWue9FIgVDE1X2GCvFbr+hhY2JH4nVUA0rACmRVSs=;
	b=0T/wcIZhxgQzTZ6XVkr7+8GuppSGLOaVslEYECwqXrJ+rkITFNHfB4yUtM3+d+kasd1e
	 5ttEPv4Jn+KfLq/0AGPgXKPg3xBxlhXzruz0Hiar7RKCSJ0CWexUj1fBHpbF1HvuOl2SG
	 enZ8HRMeAenLcCj4F+UHzusJUGipT1QxVETiMa2FgbMLZIC0+7LrTSQt4M0zDH0bfwD7u
	 1kCoNg2xMnkwWP4npbd5v0seMe6CPighZeZMCcx01OSIgLs0Ay1lTylo4bOf2R8gql/S4
	 7vVCsTrgWFgQGNvtTzVs/D68oXWJ4154cmujwd/MllVCl0woIxHcYyw8/dbjsBF0Fsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bMmLia1z;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB5606A333;
	Mon,  9 Nov 2026 14:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82EB5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bMmLia1z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mDNWue9FIgVDE1X2GCvFbr+hhY2JH4nVUA0rACmRVSs=; b=bMmLia1z+0PuSzXtLr7FBPN6h2
	K9wfL+h8SXCUo4LbaH41WB/K4Z/FtrlEd7n24SCOnXnyzF1M8croamhwDvJ1/InVRVcpw9IIbJ2Pv
	fqhkAvRuRrX2Y0Y0eFJ7ycMQJ0w2/TjjXNe9YBEN4hFat+NnDn4FrH17c2QsBH0n3KtN2dzEWu5a9
	NyvJX7PTn6mHoPV1Y+hm/U4TRNkIcBbTs1gVCcd7S2ve/3ePjwFvmh4n/BSdTFZTEhbt5vo8dKAxq
	uzwvGo3JZnWmDT9NspnO6JJnGnGCAPWBRpHGcAJdbHjw9uhk9g6cfAe+PNrD6SYzddrImeDpXLMMF
	zyhjyPvQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQQb9-0000000FSnz-0U6h;
	Mon, 09 Nov 2026 14:43:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A4DA6300910; Mon, 09 Nov 2026 15:43:50 +0100 (CET)
Date: Mon, 9 Nov 2026 15:43:50 +0100
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
Message-ID: <20261109144350.GD2668564@noisy.programming.kicks-ass.net>
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
> +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +	if (!has_pushable_tasks(rq))
> +		return NULL;
> +
> +	p = plist_first_entry(&rq->cfs.pushable_tasks,
> +			      struct task_struct, pushable_tasks);
> +
> +	WARN_ON_ONCE(rq->cpu != task_cpu(p));
> +	WARN_ON_ONCE(task_current(rq, p));
> +	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> +	WARN_ON_ONCE(!task_on_rq_queued(p));
> +
> +	/*
> +	 * Remove task from the pushable list as we try only once after that
> +	 * the task has been put back in enqueued list.
> +	 */
> +	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +
> +	return p;
> +}

This means a task will only be pushed once? After which it needs to be
re-enqueued on the runqueue?

So if it was found during migrate_disable(), its thereafter stuck? --
this seems a little weird.
