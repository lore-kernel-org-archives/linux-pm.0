Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8C3CFF75;
	Mon, 11 May 2026 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497042; cv=none; b=bb9Q7jcWYPs39d8YMxfM+lrGG6uaWmO5iMudEQ4r6dwa6FqMq7U7REX3S80LBWamyK0XVutPNzrqiIMIthsz6dlRkXzJi8xxMEQVCtPEsQhkajSeeL7lZ4aQm1xub3M7xhU6w/NjrMNMBxtjKs9iQ6tle1gFCVLsv1SuoIhcI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497042; c=relaxed/simple;
	bh=6zEehJmO+u+XeZHvcRnP6csCBs95AfqTTJ8Id2bBkwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCyupHVn776mW/mzSFD8gspC5mouCt0qyaCxh+k9ehL6KyT4xuKHufGSpU/CFHOKY4pxBcTseR95nHuPNxLdvSz6GczVl7EH5z+J3BuytoWW5SE3lCqpJ/XochW6Gec5vv6MHN4RGIbKEo5UuApIsTZkvYmwjtmBmfoTfCoclrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AikIAf4d; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AikIAf4d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BZR6FnDkxsDFjO9m9tWBb6hvfkpxru2h3surKNLegn8=; b=AikIAf4ddmJs/zdIFt+irmBvgC
	nQlVlCJINEyx1XbfRbbJT+hUsRellmCa4hnYq04H2B4cLP9AzzOpE8Bx4wl6Da7j5u0ldZRRTV7xl
	nyarZ+UWX8cbdRpOD+H/ckNNCJzJzJhDt1Rk4DsUpqMIvx+N+VfgvRMuC2iRSRPseQ135iGbiHm9N
	BVRhLNNTN86KIkW4T0UQraecXiBNVyMoqbCTCvMwuPEBYOnFBe0h0M+mwv5hn69Vc/o+Y4Ld/JJ+Y
	fYrEs/mkMy4X/EeaJ3h7xoQbJIdlaBuBEFK5ydVCwJCRmybY25LXmlSxPzZLhJJxOynITnDE7M4bl
	uwZVeUDQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOJu-000000081uO-1jiR;
	Mon, 11 May 2026 10:57:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1B75530063F; Mon, 11 May 2026 12:57:04 +0200 (CEST)
Date: Mon, 11 May 2026 12:57:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 RFC 08/13] sched/qos: Add a new sched-qos interface
Message-ID: <20260511105704.GR3126523@noisy.programming.kicks-ass.net>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-9-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504020003.71306-9-qyousef@layalina.io>

On Mon, May 04, 2026 at 02:59:58AM +0100, Qais Yousef wrote:
> Provide a generic and extensible interface to describe arbitrary QoS
> tags to tell the kernel about specific behavior that is doesn't fall
> into the existing sched_attr.
> 
> The interface is broken into three parts:
> 
> * Type
> * Value
> * Cookie
> 
> Type is an enum that should be give us enough space to extend (and
> deprecate) comfortably.
> 
> Value is a signed 64bit number to allow for arbitrary high values.
> 
> Cookie is to help group tasks selectively so that some QoS might want to
> operate on tasks per groups. A value of 0 indicates system wide.
> 
> There are two anticipated users being discussed on the list.
> 
> 1. Per task rampup multiplier to allow controlling how fast util rises,
>    and by implication it can migrate between cores on HMP systems and
>    cause freqs to rise with schedutil.
> 
> 2. Tag a group of task that are memory dependent for Cache Aware
>    Scheduling.
> 
> The interface is anticipated to be provisioned to apps via utilities and
> libraries. schedqos [1] is an example how such interface can be used to
> provide higher level QoS abstraction to describe workloads without
> baking it into the binaries, and by implication without worrying about
> potential abuse. The interface requires privileged access since QoS is
> considered scarce resource and requires admin control to ensure it is
> set properly. Again that admin control is anticipated to be the schedqos
> utility service.
> 
> QoS is treated as a scarce resource and the intention is for the
> a syscall to be done for each individual QoS tag. QoS tags are not
> inherited on fork by default too for the same reason.
> 
> A reasonable point of debate is whether to make the sched_qos an array
> of 3 or 5 value to avoid potential bottleneck if this grows large and
> users do end up hitting a bottleneck of having to issue too many
> syscalls to set all QoS. Being limited as it is now helps enforce
> intentionality and scarcity of tagging.

> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +Scheduler QoS
> +=============
> +
> +1. Introduction
> +===============
> +
> +Different workloads have different scheduling requirements to operate
> +optimally. The same applies to tasks within the same workload.
> +
> +To enable smarter usage of system resources and to cater for the conflicting
> +demands of various tasks, Scheduler QoS provides a mechanism to provide more
> +information about those demands so that scheduler can do best-effort to
> +honour them.
> +
> +  @sched_qos_type	what QoS hint to apply
> +  @sched_qos_value	value of the QoS hint
> +  @sched_qos_cookie	magic cookie to tag a group of tasks for which the QoS
> +			applies. If 0, the hint will apply globally system
> +			wide. If not 0, the hint will be relative to tasks that
> +			has the same cookie value only.
> +
> +QoS hints are set once and not inherited by children by design. The
> +rationale is that each task has its individual characteristics and it is
> +encouraged to describe each of these separately. Also since system resources
> +are finite, there's a limit to what can be done to honour these requests
> +before reaching a tipping point where there are too many requests for
> +a particular QoS that is impossible to service for all of them at once and
> +some will start to lose out. For example if 10 tasks require better wake
> +up latencies on a 4 CPUs SMP system, then if they all wake up at once, only
> +4 can perceive the hint honoured and the rest will have to wait. Inheritance
> +can lead these 10 to become a 100 or a 1000 more easily, and then the QoS
> +hint will lose its meaning and effectiveness rapidly. The chances of 10
> +tasks waking up at the same time is lower than a 100 and lower than a 1000.
> +
> +To set multiple QoS hints, a syscall is required for each. This is a
> +trade-off to reduce the churn on extending the interface as the hope for
> +this to evolve as workloads and hardware get more sophisticated and the
> +need for extension will arise; and when this happen the task should be
> +simpler to add the kernel extension and allow userspace to use readily by
> +setting the newly added flag without having to update the whole of
> +sched_attr.

So 'type' is effectively meant to be an ephemeral space of hints. A
kernel can, or can not, support this arbitrary set of hints.

If a particular type is supported across two kernels, it is assumed to
be the same -- although its implementation might be different.

Your next patch implements type-0 to be this pelt multiplier thing.

I wonder about discoverability, suppose we create and discard a fair
number of these types, just because. Then how is someone (this
muddle-ware component for example) to discover which set of hints is
supported by the kernel of the day?

I suppose it can go and scan the space, by trying to set hints on itself
or something, but that seems sub-optimal.
