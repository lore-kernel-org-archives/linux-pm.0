From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 10 Mar 2016 11:07:28 +0100
Message-ID: <20160310100728.GT6344@twins.programming.kicks-ass.net>
References: <CAJZ5v0h47h-xW6a4jzwRuOOOSG+qsD9hegM7QCzbD8Wb-yPVKQ@mail.gmail.com>
 <56D8AEB7.2050100@linaro.org>
 <36459679.vzZnOsAVeg@vostro.rjw.lan>
 <20160308112759.GF6356@twins.programming.kicks-ass.net>
 <CAJZ5v0i+KFmpggrGKqtL_SB1=Fv=b_AbVeL-9jPfo4rYt6-q5A@mail.gmail.com>
 <20160308192640.GD6344@twins.programming.kicks-ass.net>
 <CAJZ5v0g=dXmoPr0jR6AVuynVYbSwJvnS2dFhb7QnUKq9LRRnrQ@mail.gmail.com>
 <20160309163930.GP6356@twins.programming.kicks-ass.net>
 <CAJZ5v0iKn4dT4ta6WaEcPbdYmA7P08=bmKU+dwcMx+Msk7WRFg@mail.gmail.com>
 <CAKfTPtB1g6VgA8NBep553C4MZ19B-rD4Xdp6EpZNAu+mYmx+2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:58110 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934071AbcCJKHd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2016 05:07:33 -0500
Content-Disposition: inline
In-Reply-To: <CAKfTPtB1g6VgA8NBep553C4MZ19B-rD4Xdp6EpZNAu+mYmx+2w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>

On Thu, Mar 10, 2016 at 10:44:21AM +0700, Vincent Guittot wrote:
> We have the arch_scale_freq_capacity function that is arch dependent
> and can be used to merge the 2 formula that were described by peter
> above.
> By default, arch_scale_freq_capacity return SCHED_CAPACITY_SCALE which
> is max capacity
> but when arch_scale_freq_capacity is defined by an architecture,

> arch_scale_freq_capacity returns current_freq * max_capacity/max_freq

However, current_freq is a very fluid thing, it might (and will) change
very rapidly on some platforms.

This is the same point I made earlier, you cannot try and divide out
current_freq from the invariant measure.

> so can't we use arch_scale_freq in your formula ? Taking your formula
> above it becomes:
> next_freq = 1.25 * current_freq * util / arch_scale_freq_capacity()

No, that cannot work, nor makes any sense, per the above.

> With invariance feature, we have:
>
>   next_freq = 1.25 * current_freq * util / (current_freq*max_capacity/max_freq)
>             = 1.25 * util * max_freq / max
>
> which is the formula that has to be used with frequency invariant
> utilization.

Wrong, you cannot talk about current_freq in the invariant case.

> May be we can pass arch_scale_freq_capacity value instead of max one
> as a parameter of update_util function prototype

No, since its a compile time thing, we can simply do:

#ifdef arch_scale_freq_capacity
	next_freq = (1 + 1/n) * max_freq * (util / max)
#else
	next_freq = (1 + 1/n) * current_freq * (util_raw / max)
#endif
