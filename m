From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
Date: Mon, 18 Jan 2016 15:01:02 +0000
Message-ID: <20160118150102.GC7159@e106622-lin>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <20160115180107.GC6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35091 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbcARPAg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Jan 2016 10:00:36 -0500
Content-Disposition: inline
In-Reply-To: <20160115180107.GC6588@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

Hi Mark,

On 15/01/16 18:01, Mark Brown wrote:
> On Fri, Jan 08, 2016 at 02:09:28PM +0000, Juri Lelli wrote:
> 
> > Second version of this RFC proposes an alternative solution (w.r.t. v1) to the
> > problem of how do we init CPUs original capacity: we run a bogus benchmark (for
> > this RFC I simple stole int_sqrt from lib/ and I run that in a loop to perform
> > some integer computation, I'm sure there are better benchmarks around) on the
> > first cpu of each frequency domain (assuming no u-arch differences inside
> > domains), measure time to complete a fixed number of iterations and then
> > normalize results to SCHED_CAPACITY_SCALE (1024). I didn't spend much time in
> > polishing this up or thinking about a better benchmark, as this is an RFC and
> > I'd like discussion happening before we make this solution better
> > working/looking. However, surprisingly, results are not that bad already:
> 
> This approach looks good to me - certainly vastly preferable to putting
> the numbers into DT.
> 
> >  2. Dynamic profiling at boot (v2)
> > 
> >     pros: - does not require a standardized definition of capacity
> >           - cannot be incorrectly tuned (once benchmark is fixed)
> >           - does not require user/integrator work
> 
> >     cons: - not easy to come up with a clean solution, as it seems interaction
> >             with several subsystems (e.g., cpufreq) is required
> 
> This actually seems to be pretty clean.
> 

Oh, maybe I was overly critic of my code then. :)

> >           - not easy to agree upon a single benchmark (that has to be both
> >             representative and simple enough to run at boot)
> >           - numbers might (and do) vary from boot to boot
> 
> This does come back to the question of how accurate the numbers need to
> be - is "good enough" fine?

Here we probably also have to account for the fact that numbers might
actually change from boot to boot. They might be good enough in average,
but you might have cases in which, for some reason, they turn out to be
far from usual values. Not that I see that happening much on my boxes,
but I guess it can happen.

Best,

- Juri
