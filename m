Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43444973BF;
	Fri, 18 Sep 2026 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731809; cv=none; b=NnpfXHyFXQmC8c/uEuYw8QYagEhbhNBBLUkg8ZwRSdtfnND7pSOu8zHXzLA2UBvKY6r0pPd642O+CXSy7kPPL2YYDcQE+I02aabjBv6WzV2YRgaV7ApA/+WU0xGHMCwGUxZE3pescJvzgf9IiZJ/GmVg/shoHMB6wtuRTOC4C8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731809; c=relaxed/simple;
	bh=/W9itLwGfr1e1jnzyKgGlEkGZU5X81u/k+YHG6nf/fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glP4MWbxLF3yPd3gGnjgJz6e6voC/yIVNrUQXELm3kZQWAuiKcbisdq+ldvyT1PRLNccbyGH1WKMNn/nIdnVsPBKHmOcVVTleNfmOj/ut3BkE2UzNbuN/fDLHi4CUZDq4DrBDzLtIMxQxxgj9CVTGUG29t/3gLFryu/j3kvetvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OSkK20Fn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OSkK20Fn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1H8mMS7ZyLHqrQSJ/fwgAtYDIhNJ85L1vxMyUhJcXVQ=; b=OSkK20FnIj3q52wXGIKdYJJV/T
	EaOZvUarfDhLkY2ls/ihX82UcjThLeaI5D7neLwwvddiDBV496MDNiga1dl6/1kM+xAUW28f63boB
	GX9J+wqB2K6/pJPMJOt7wjsx4++iYtYXxuQlCG1BKB1o/D+JzxmxKXEAydTsHEd7O+iBxmIoVt7M7
	p770/BAvtH5TD2hQqnrupFDYhMBXNjqpOgHvj2Gs4pYtu8r6ju1BDSeJCs5ijlFlrq2XVQZzX226g
	7ii60jOY9gxmY+bt9Xh8Y+aYPvshrgDkFI5feUsb7wakGcxOdGlRBcmJFmlSctYyyu8E2PvP+GHTd
	hkJlfyGQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Wzu-0000000HAkq-0cDR;
	Fri, 18 Sep 2026 11:43:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B265630057F; Fri, 18 Sep 2026 13:43:17 +0200 (CEST)
Date: Fri, 18 Sep 2026 13:43:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Elif Topuz <elif.topuz@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Shubhang Kaushik <sh@gentwo.org>, Christoph Lameter <cl@gentwo.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/fair: Randomize equally shallow slow-path
 candidates
Message-ID: <20260918114317.GO776954@noisy.programming.kicks-ass.net>
References: <20260917153915.1563875-1-christian.loehle@arm.com>
 <20260917153915.1563875-3-christian.loehle@arm.com>
 <CAKfTPtBft2pVrsZQGJu0UBjuqaGJ2ViE9N6YExLvBnpgEXDvag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBft2pVrsZQGJu0UBjuqaGJ2ViE9N6YExLvBnpgEXDvag@mail.gmail.com>

On Thu, Sep 17, 2026 at 06:06:42PM +0200, Vincent Guittot wrote:
> On Thu, 17 Sept 2026 at 17:41, Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > Picking the first eligible idle CPU leaves a scan-order bias. Concurrent
> > slow-path selectors can choose the same CPU before either task is enqueued.
> >
> > Use reservoir sampling for equal exit latencies, resetting the candidate
> > count when a shallower candidate appears. Use the per-CPU scheduler PRNG
> > and reciprocal_scale() to avoid variable division or a second scan.
> >
> > Use a u64 latency key with U64_MAX for unpublished states. Published
> > states take precedence; when none are found, sample among the idle CPUs
> > without a published state.
> >
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks, let me go queue this.
