From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
Date: Tue, 19 Jan 2016 11:23:23 +0000
Message-ID: <20160119112323.GB8573@e106622-lin>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <56994D87.6000709@linaro.org>
 <20160118151316.GD7159@e106622-lin>
 <CAKfTPtBFR4cowT-j4qVxfUvh6NDNmi6R=J7z9kywi6bONU3Pow@mail.gmail.com>
 <20160118163014.GA10332@e106622-lin>
 <CAKfTPtDJBAXUz=_-QQSkrqwAvmUJd1bUJ-VfSaNER-0NzWpunA@mail.gmail.com>
 <20160119105941.GA28845@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38724 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbcASLW5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jan 2016 06:22:57 -0500
Content-Disposition: inline
In-Reply-To: <20160119105941.GA28845@e104818-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark Brown <broonie@kernel.org>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Rob Herring <robh+dt@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, LAK <linux-arm-kernel@lists.infradead.org>

Hi Catalin,

On 19/01/16 10:59, Catalin Marinas wrote:
> On Mon, Jan 18, 2016 at 05:42:58PM +0100, Vincent Guittot wrote:
> > On 18 January 2016 at 17:30, Juri Lelli <juri.lelli@arm.com> wrote:
> > > On 18/01/16 17:13, Vincent Guittot wrote:
> > >> On 18 January 2016 at 16:13, Juri Lelli <juri.lelli@arm.com> wrote:
> > >> > On 15/01/16 11:50, Steve Muckle wrote:
> > >> >> On 01/08/2016 06:09 AM, Juri Lelli wrote:
> > >> >> >  2. Dynamic profiling at boot (v2)
> > >> >> >
> > >> >> >     pros: - does not require a standardized definition of capacity
> > >> >> >           - cannot be incorrectly tuned (once benchmark is fixed)
> > >> >> >           - does not require user/integrator work
> > >> >> >
> > >> >> >     cons: - not easy to come up with a clean solution, as it seems interaction
> > >> >> >             with several subsystems (e.g., cpufreq) is required
> > >> >> >           - not easy to agree upon a single benchmark (that has to be both
> > >> >> >             representative and simple enough to run at boot)
> > >> >> >           - numbers might (and do) vary from boot to boot
> > >> >>
> > >> >> An important additional con that was mentioned earlier IIRC was the
> > >> >> additional boot time required for the benchmark.
> > >> >
> > >> > Right. I forgot about that.
> > >> >
> > >> >> Perhaps there could be
> > >> >> a kernel command line argument to bypass the benchmark if it is known
> > >> >> that predetermined values will be provided via sysfs later?
> > >> >>
> > >> >
> > >> > This might work, yes.
> > >>
> > >> Instead of command line, I prefer to use DT.
> 
> I fully agree. Command line doesn't scale with multiple CPUs, at most an
> option to bypass the benchmark (though we could just skip it when the DT
> values are present).
> 
> > >> Can't we use something similar to what is currently done in arm arch
> > >> for the early stage of the boot ? We don't have to provide performance
> > >> value for which it's difficult to find a consensus on how to define it
> > >> and which benchmark should be used. We use the micro arch and the
> > >> frequency of the core to define a relative capacity. This give us a
> > >> relatively good idea of the capacity of each core.
> > >
> > > I'm not sure I understand what you are proposing. arm arch is currently
> > > based on having static hardcoded data (efficiency values). But, this has
> > > already been NACKed for arm64 during last review of this RFC.
> > >
> > > Are you proposing something different?
> > 
> > No, i'm proposing to use it at boot time until the dynamic profiling
> > gives better value.
> > We don't have to set any new properties.
> > IIRC, It was nacked because it was of static hardcoded value that was
> > not always reflecting the best accurate capacity of a system. IMHO,
> > it's not that far from reality so can't this be used as an
> > intermediate step while waiting for dynamic profiling ?
> 
> My nack for hard-coded values still stands since this is not just about
> the microarchitecture (MIDR) but how the CPUs are integrated with the
> SoC, additional caches, memory latency, maximum clock frequency (or you
> rely on DT again to get this information and scale the initial CPU
> capacity/efficiency accordingly). MIDR does not capture SoC details.
> 
> Two questions:
> 
> 1. How is the boot time affected by the benchmark?
> 2. How is the boot time affected by considering all the CPUs the same?
> 
> My preference is for DT and sysfs (especially useful for
> development/tuning) but I'm not opposed to a boot-time benchmark if
> people insist on it. If the answer to point 2 is "insignificant", we
> could as well defer the capacity setting to user space (sysfs).
> 

Given that we are not targeting boot time with this, but rather better
performance afterwards, I don't expect significant differences; but,
I'll get numbers :).

Thanks,

- Juri
