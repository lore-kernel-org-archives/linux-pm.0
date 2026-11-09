Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232567;
	b=qKqfZpBPvF8FRwKeVEFre0xzmip0vDyjiHmTlbRH4zBzkwzJ7LeMugXUcidbQazoJtYl
	 O7qHW+dPjjzpJKrHjSEeGja1Hy1+mVuARDq9OFvRCyt9vXDqW9IXqmm+zWIFUvp0YbJ6H
	 VSaNyGWso8ies91YHtkTjtabYKpPv54Ly5mHw9j8eh8cY06tfuxYzsscMcoTEtpwDQoIS
	 sE4PZzkScpnktwXSaKmSW8qbIbuUEtjrbsOGH2JbOJe/IX0akcu2sC6LafVsrzybSt2zV
	 RQ/oeY2LN/CDiSGtpDIDzH7d7d0aQXI57sSeo0JMmID87ozjetMebddjl1FoDNCak+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232567;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=B6WcZ6IMkcLgiSPsNKkvOLd/yuLh+SF0+P0jadmaCpk=;
	b=Iz2vokCHDAlonwXVsDZ4sqwHSbctGl33jtY0A1l9RrYUrWUpjfWhDTs842nZaMJ/G9D8
	 KVIv9q4e+v8m2pZx8q6tjeF+v2f7om4kzA2p9GM1yG2nHkKOpPwmQv4lEwF3kt0hg+pfI
	 MGbwCk7YxunogkXeFvpmx5+Fp2FDfaDqiLW7vYipMLVuFJpLDEetWgcGnhjLYQjtjwVsQ
	 iNMnADW3AhH8cGkRWhZjXC29/NSoEfmWDYeTTm/QqlfFd+L0UhHiB+pAMYNKq87K2oCpj
	 oRKDk8ug4JunkL1wf60fdG5lHIXjtUyKSn4koRgMIDID3QIvIQ2hZapv34HumKMRWOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=e3QgGhPW;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996A606A31C;
	Mon,  9 Nov 2026 13:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3996A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=e3QgGhPW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B6WcZ6IMkcLgiSPsNKkvOLd/yuLh+SF0+P0jadmaCpk=; b=e3QgGhPW8XV8DfJb8YQ/4HEgoJ
	U4IFQYEzqPjouU8aHCMblUV2i+NnRybd8VYi95AKn0ZAqQZy116TWV+YcYLFymNYOYrbi4kdmC5t9
	NWde+S9aG3YsniqLmJ8M48KmW/GKAvyns5AubTUA7pQ7SYM26svNc0+wn5sRmkER3n+8GgUNubK4j
	8OnJ+He0SZ5QZot4NKpBpXKKqv9hAq4s/sJTCflv/l9p14krxiIK02vRYPTGHpRBrnh+Bwu/ePDUc
	hM5Nu7F4r7XyKJILxOU4n47tgmQ9kxtvsuzteQYSX96TrKixzJFIBCOXS1bdrEncV7csV2hIWOa0A
	oRDLGHNw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQPqk-00000006niR-3sTy;
	Mon, 09 Nov 2026 13:55:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2394E30057E; Mon, 09 Nov 2026 14:55:53 +0100 (CET)
Date: Mon, 9 Nov 2026 14:55:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com,
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, qyousef@layalina.io,
	christian.loehle@arm.com, pierre.gondois@arm.com,
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting
 CPU
Message-ID: <20261109135553.GC2668564@noisy.programming.kicks-ass.net>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-7-vincent.guittot@linaro.org>
 <au7SabL5pfbsApyB@scheduler.schedules>
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
In-Reply-To: <au7SabL5pfbsApyB@scheduler.schedules>

On Sat, Nov 07, 2026 at 11:57:12AM +0300, Kayra Cizmeci wrote:

> (My editor got crazy, so I had to copy this diff :<)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 262626455497..8b0dd858f332 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8876,10 +8876,8 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
>  
>  static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
>  {
> -	if (p->se.slice < get_rq_min_slice(rq))
> -		return true;
> -
> -	return false;
> +	return p->se.slice < get_rq_min_slice(rq) &&
> +		READ_ONCE(rq->curr)->sched_class == &fair_sched_class;
>  }

that wants to be rcu_dereference_all() or somesuch, rather than
READ_ONCE().

The think I noticed is that it will only select one slice_cpu; it will
not consider another once its has found one.

This means it picks the oldest option, rather than the most recent one.
And given this is all racy as heck, the most recent one might in fact be
the better choice. It will have had less time to go stale.


