Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485984;
	b=kiXzo0HCSXur4w/4T3T3RT9CgVVCNj4Tn+9ESk4vEnoHMbH2CCRql8Qyis/5OMhWbn79
	 DuMXxlkns32+vYgNMq9hd0amAKFG6dW/qMt+7wpP0WRhnP3UJpKcF74TPfJ0Seoy1P9Jo
	 ml1DAraAtYpAsV9XxB6oEhwOZPg0yOPSj1d79QLc8CwMLet+OMnBM5iIT/hNxxJEGF1+k
	 ctyW+m6qWAtm09Hate963FK3Mcn1NOxquxdAI9bU0BDm+LHzqRmnFLlHjWP8b9Uuzg4QZ
	 v+2O1to6RI5I3Lh/ZQtAMUlHCqJwkn8Pt3UNF8uzQg/8nQP2mnfgO+BR0quyXEtqV4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485984;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6lBfSop40ANpomb/oJdRrK/QOYFNcTX2jfeonW12esM=;
	b=3044Ux06vW/Sn6COWAXt9jvqlcW8ktzMQjwTj+Bxq7ad2lXuCufzaL4GkESDaaiu4an7
	 XgNKiFSQMeVoDlwOcQtTCPzSPdFoIxXQvvU0wTTm6XXmQe4FvAYeBT/ijI03AOXEn5bEp
	 TXuA7pGSK5WPNi+YrJkpLoBmax3FA4mQrt6A5Fw3hLuJzRfib47SuLW7kZ5DBkqV+CGZa
	 fg2Ed+kfolMlNt3Oa7L8l4vovR8mMI8CaZO/xyz0revokLds5gSmSn/T0Wau4eLvkEvRm
	 FR+t/hhOMua/2ilUEwBv+UiUeYz6AwWIxTD9i7M5sJID+f0MFf7DQVQYX433XVF3FIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=R80vod0w;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB916606A31C;
	Thu, 12 Nov 2026 12:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB916606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=R80vod0w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6lBfSop40ANpomb/oJdRrK/QOYFNcTX2jfeonW12esM=; b=R80vod0w55bkVZUag495J9bzuS
	SPEiBMIv+2WoAIFNxquYkU5bx2O/LYfO0wXypaBYnA9nm9plSzDhGDayaCyLxL1I50n1r2GBUKfV0
	OceCfGRPOE1Bu3rVkf0iBr7eqd5egCd2Nrbta7j5qD1O0kw14/TipfzA3X23C0nVXNm95sG/fO1D2
	H2+77rsuQGDFdbWvRqDnU6UFZuTdWBkHOAUQDZw1uqhDy2eos2++cbrzZVYIIQDuj6XBuyr3gwH+e
	r5nIIuV5REeA/o9VOW/PWSR8kyPNUT6b5RaqMVnjZE0V5AxhW4AL4SgzRLU/aehMoTZaVH71lgrge
	whwwRCsQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRTmB-0000000AJ4o-0yz4;
	Thu, 12 Nov 2026 12:19:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6CF5C300882; Thu, 12 Nov 2026 13:19:33 +0100 (CET)
Date: Thu, 12 Nov 2026 13:19:33 +0100
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
Message-ID: <20261112121933.GW1813469@noisy.programming.kicks-ass.net>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org>
 <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
 <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com>
 <20261111090155.GF2668564@noisy.programming.kicks-ass.net>
 <CAKfTPtBfQd5nD9jNdayGbEW_P2bDMvOm=GZ3Q-gu+O6KkQmKbA@mail.gmail.com>
 <20261112094910.GK2668804@noisy.programming.kicks-ass.net>
 <CAKfTPtBNx9Dpe4zBAzJU1iabp6riGAN8v-GP9bc5fh8NZq57hQ@mail.gmail.com>
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
In-Reply-To: <CAKfTPtBNx9Dpe4zBAzJU1iabp6riGAN8v-GP9bc5fh8NZq57hQ@mail.gmail.com>

On Thu, Nov 12, 2026 at 12:29:14PM +0100, Vincent Guittot wrote:
> On Thu, 12 Nov 2026 at 10:49, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Nov 12, 2026 at 08:01:17AM +0100, Vincent Guittot wrote:
> >
> > > I don't want to take any random task from the rq but only one that is
> > > meaningful. Why do you think having a dedicated pushable list like rt
> > > and deadline isn't worthwhile?
> >
> > Well, effectively cfs_tasks *is* the pushable list. The below patch
> > makes no effective difference, and can be argued to be an optimization.
> > Currently every consumer of cfs_tasks goes through can_migrate_task()
> > and every task that has nr_cpus_allowed == 1, will fail that function.
> >
> > The thing seems to be that you want additional constraints on your list;
> > like dropping tasks after one push attempt. The other classes don't do
> > that, they do the same thing cfs_tasks does and keep all runnable tasks
> > that can migrate on the list.
> >
> > I'm not against adding another list per-se, I'm just struggling to
> > understand your extra semantics, because its not _just_ another pushable
> > list, it has some extra flavour.
> 
> The main case is to periodically look for another CPU when a task is
> put back in the runnable list. I also have other cases like patch 20
> where several short tasks end up selecting the same CPU or when the
> short task finally can run 1st and should look for another CPU.
> Because anything can happen between wakeup preempt and pick_task_fair
> I don't know if the 1st item is the one that might to be pushed or how
> much requested it

I've yet to go read 20; but can we cure all this by making cfs_tasks a
RB-tree and imposing some convenient order on it?

Perhaps sort on {se->slice,se->exec_start}, that way the shortest slice
that hasn't ran for the longest is first. So when all slices are equal
length, it is similar to what we have now, but when there are multiple
slice lengths, the shorter ones are preferred.

That is; instead of trimming the length of the 'list', make sure the
right task ends up at the right place.

Another option is to so an augmented list, normally sorted on
se->exec_start, but augmented on se->slice, such that normally you pick
in longest-not-ran order, but can also pick in shortest slice order.


