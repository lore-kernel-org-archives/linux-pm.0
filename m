From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 16:34:06 +0100
Message-ID: <20161121153406.GA3174@twins.programming.kicks-ass.net>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121121432.GK24383@e106622-lin>
 <20161121122622.GC3092@twins.programming.kicks-ass.net>
 <20161121135308.GN24383@e106622-lin>
 <20161121145919.GA3414@e105326-lin>
 <20161121152606.GI3092@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161121152606.GI3092@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <Juri.Lelli@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2016 at 04:26:06PM +0100, Peter Zijlstra wrote:
> > For example, a task running 30 [ms] every 100 [ms] is a ~300 util_avg
> > task. With PELT, we get a signal which range between [120,550] with an
> > average of ~300 which is instead completely ignored. By capping the
> > decay we will get:
> > 
> >    decay_cap [ms]      range    average
> >                 0      120:550     300
> >                64      140:560     310
> >                32      320:660     430
> > 
> > which means that still the raw PELT signal is wobbling and never
> > provides a consistent response to drive decisions.
> > 
> > Thus, a "predictor" should be something which sample information from
> > PELT to provide a more consistent view, a sort of of low-pass filter
> > on top of the "dynamic metric" which is PELT.

Note that a simple low-pass IIR filter will only shrink the wobble, not
take it out entirely. Or rather, if you make it so strong as to take the
entire wobble out, it'll likely react like molasses.
