From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 17:46:05 +0100
Message-ID: <20161121164605.GJ3092@twins.programming.kicks-ass.net>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121121432.GK24383@e106622-lin>
 <20161121122622.GC3092@twins.programming.kicks-ass.net>
 <20161121135308.GN24383@e106622-lin>
 <20161121145919.GA3414@e105326-lin>
 <20161121152606.GI3092@twins.programming.kicks-ass.net>
 <20161121162424.GA10744@e105326-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52634 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbcKUQqO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2016 11:46:14 -0500
Content-Disposition: inline
In-Reply-To: <20161121162424.GA10744@e105326-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <Juri.Lelli@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>

On Mon, Nov 21, 2016 at 04:24:24PM +0000, Patrick Bellasi wrote:
> On 21-Nov 16:26, Peter Zijlstra wrote:

> > In any case, worth trying, see what happens.
> 
> Are you saying that you would like to see the code which implements a
> more generic version of the peak_util "filter" on top of PELT?

Not sure about peak_util, I was more thinking of an IIR/PID filter, as
per the email thread referenced below. Doesn't make sense to hide that
in intel_pstate if it appears to be universally useful etc.. 

> IMO it could be a good exercise now that we agree we want to improve
> PELT without replacing it.

I think it would make sense to keep it inside sched_cpufreq for now.

> > > For example, a task running 30 [ms] every 100 [ms] is a ~300 util_avg
> > > task. With PELT, we get a signal which range between [120,550] with an
> > > average of ~300 which is instead completely ignored. By capping the
> > > decay we will get:
> > > 
> > >    decay_cap [ms]      range    average
> > >                 0      120:550     300
> > >                64      140:560     310
> > >                32      320:660     430
> > > 
> > > which means that still the raw PELT signal is wobbling and never
> > > provides a consistent response to drive decisions.
> > > 
> > > Thus, a "predictor" should be something which sample information from
> > > PELT to provide a more consistent view, a sort of of low-pass filter
> > > on top of the "dynamic metric" which is PELT.
> > > 
> > > Should not such a "predictor" help on solving some of the issues
> > > related to PELT slow ramp-up or fast ramp-down?
> > 
> > I think intel_pstate recently added a local PID filter, I asked at the
> > time if something like that should live in generic code, looks like
> > maybe it should.
> 
> That PID filter is not "just" a software implementation of the ACPI's
> Collaborative Processor Performance Control (CPPC) when HWP hardware
> is not provided by a certain processor?

I think it was this thread:

  http://lkml.kernel.org/r/1572483.RZjvRFdxPx@vostro.rjw.lan

It never really made sense such a filter should live in individual
drivers.
