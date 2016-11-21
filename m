From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 12:12:43 +0100
Message-ID: <20161121111243.GK3102@twins.programming.kicks-ass.net>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121104800.GC10014@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:50594 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753457AbcKULMs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2016 06:12:48 -0500
Content-Disposition: inline
In-Reply-To: <20161121104800.GC10014@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>

On Mon, Nov 21, 2016 at 04:18:00PM +0530, Viresh Kumar wrote:
> On 21-11-16, 11:19, Peter Zijlstra wrote:
> > Urgh...
> > 
> > 
> > So no tunables and rate limits here at all please.
> > 
> > During LPC we discussed the rampup and decay issues and decided that we
> > should very much first address them by playing with the PELT stuff.
> > Morton was going to play with capping the decay on the util signal. This
> > should greatly improve the ramp-up scenario and cure some other wobbles.
> > 
> > The decay can be set by changing the over-all pelt decay, if so desired.
> > 
> > Also, there was the idea of; once the above ideas have all been
> > explored; tying the freq ram rate to the power curve.
> > 
> > So NAK on everything tunable here.
> 
> Okay, as I told you on IRC, we already have a tunable: rate_limit_us for the
> schedutil governor which defines the minimum time before which the governor
> wouldn't try to update the frequency again. Perhaps 10-20 ms is the ideal value
> for that everyone is using.
> 
> So eventually that should also die and we should get inputs from PELT stuff ?

I think it should be replaced by a value provided by the driver. It
makes sense to have a rate-limit in so far as that it doesn't make sense
to try and program the hardware faster than it can actually change
frequencies and/or have a programming cost amortization. And this very
clearly is a driver specific thing.

It however doesn't make sense to me to fudge with this in order to
achieve ramp up/down differences.
