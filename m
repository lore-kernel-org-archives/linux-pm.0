From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [0/11] Energy-aware scheduling use-cases and scheduler issues
Date: Mon, 13 Jan 2014 12:04:18 +0000
Message-ID: <20140113120418.GD11805@arm.com>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
 <20131222162744.GB3250@mgross-Lenovo-Yoga-2-Pro>
 <20131230121010.GA2936@e103034-lin>
 <20140112164759.GB5008@mgross-Lenovo-Yoga-2-Pro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:59086 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751377AbaAMMEs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2014 07:04:48 -0500
Content-Disposition: inline
In-Reply-To: <20140112164759.GB5008@mgross-Lenovo-Yoga-2-Pro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mark gross <markgross@thegnar.org>
Cc: Morten Rasmussen <Morten.Rasmussen@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sun, Jan 12, 2014 at 04:47:59PM +0000, mark gross wrote:
> On Mon, Dec 30, 2013 at 12:10:10PM +0000, Morten Rasmussen wrote:
> > I was hoping that we could come up with a fairly simplistic energy model
> > that could guide the scheduling decisions based on data provided by the
> > vendor. I would start we something very simple and see far we can get
> > and which data that is necessary.
>
> I keep flip flopping in my mind over what is more important.  Energy modeling or
> latency performance measuring.

Both ;)

> I mean, one way to look at the world is given a workload with minimal latency
> and throughput expectations we need deliver those first and then optimize power.

I agree, that's why I don't think blind packing tasks to the left would
work either for power or performance.

> With poor load balancing we do not deliver on performance expectations typically
> in the areas of latencies.  Note, Linux does well on throughput IMO because that
> is easier to measure with kstats and other sampling.
> 
> what sorts of missing thing are needed to measure and understand when wrong
> choices are getting made?  What basic information do we need to capture to know
> if we are doing a good job or not?

I think whatever power awareness we add to the scheduler should aim to
optimise the power consumption (based on some simple model of measuring
the idle time/states and transition on certain platforms and estimating
the energy) but with *minimal* effect on the latency and throughput.
Standard latency/performance benchmarks should always be run to ensure
there are no regressions. Morten's use-cases try to describe scenarios
where the scheduler can do better from a power perspective but without
(drastically) affecting other parameters.

If you have a predictable workload, the scheduler can make the right
decision to optimise for power while keeping the latency under control.
The problem is when the workload changes, the latency would be affected
if tasks need to migrate or the CPU frequency needs to be increased (and
for the latter we currently rely on a cpufreq governor or driver to
detect the workload change and this introduces additional latencies).
Given these pretty independent cpufreq decisions, the best heuristics
for now wrt latency is probably to spread the workload among all the
CPUs and leave enough room for workload changes.

But even with latency under certain limits, you may have for example
small threads (like audio decoding) that could still fit on a CPU when
running at the minimal P-state, with the risk of a big sudden change in
the workload of such thread. That's a trade-off between optimising for
performance and power. A power-aware scheduler does not aim to trade the
latency or throughput for power but rather how well it copes with
workload unpredictability, what margins are guaranteed.

IMHO, adding power awareness to the scheduler could be done in two
(main) ways:

1. Heuristics like packing small tasks with tunables like what "small"
   actually means, how many such "small" tasks and such parameters would
   be specific to each SoC.

2. Power model in the scheduler (I proposed a simplistic one at the end
   of last year) where the scheduler can associate an energy cost with
   its actions (e.g. migrating a task to a CPU) and it would try to
   optimise the overall system energy consumption while preserving the
   latency and throughput.

I consider the second approach being better as you can extend it other
things like power budgets. But it doesn't always go well with hardware
people who don't want to expose real numbers (they don't even need to be
real W or J but just some relative numbers).

-- 
Catalin
