From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 08/14] sched/tune: add detailed documentation
Date: Tue, 15 Sep 2015 17:19:53 +0200
Message-ID: <20150915151953.GF16853@twins.programming.kicks-ass.net>
References: <1440010044-3402-9-git-send-email-patrick.bellasi@arm.com>
 <20150902064958.GA18664@google.com>
 <20150903091849.GB15649@e105326-lin>
 <55F0938A.9000607@linaro.org>
 <20150911110959.GA22876@e105326-lin>
 <55F72773.9090001@linaro.org>
 <20150915150044.GD3206@e105326-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150915150044.GD3206@e105326-lin>
Sender: linux-doc-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ricky Liang <jcliang@chromium.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 15, 2015 at 04:00:45PM +0100, Patrick Bellasi wrote:

> > I'm curious about the drive for one tunable. Is that something there's
> > specifically been a broad call for? Don't get me wrong, I'm all for
> > simplification and cleanup, if the flexibility and used features can be
> > retained.
> 
> All this thread [1] was somehow calling out for a solution which goes
> in the direction of a single tunable.
> 
> The main idea is to exploit the current effort around EAS.
> While we are redesign some parts of the scheduler to be energy-ware it
> is convenient also to include in that design a knob which allows to
> configure how much we want to optimize for reduced power consumption
> or increased performance.

Please flip the argument around; providing lots of knobs for vendors to
do $magic with is _NOT_ a good thing.

The whole out-of-tree cpufreq governor hack fest Android thing is a
complete and utter fail on all levels. Its the embedded, ship, forget,
not contribute cycle all over again.

Making that harder is a _GOOD_ thing.

Esp. now that we get hardware which has multiple frequency domains on
the CPU cores, this is going to be really important.


> > Agreed it's not affecting scheduler decision making (not directly). It's
> > more just the mixing of the policy into the same code, as margin is
> > added in enqueue_task_fair()/task_tick_fair() etc. That one in
> > particular would probably be easy to solve. A more difficult one is if
> > someone wants to make adjustments to the load tracking algorithm because
> > it is driving CPU frequency.
> 
> That's not so straightforward.
> 
> We have plenty of experience, collected on the past years, on CPUFreq
> governors and customer specific mods.
> Don't you think we can exploit that experience to reason around a
> fresh new design that allows to satisfy all requirements while
> providing possibly a simpler interface?
> 
> I agree with you that all the current scenarios must be supported by
> the new proposal. We should probably start by listing them and come
> out with a set of test cases that allow to verify where we are wrt
> the state of the art.
> 
> Tools and benchmarks to verify the proposals and measure the
> regress/progress should become more and more used.
> This is an even more important requirement to setup a common
> language and aims at objective evaluations.
> Moreover, it has been already required by scheduler maintainers in the
> past.

This.

And if $vendor feels their use case doesn't perform well, have them
contribute a benchmark for it. They must have one anyway -- how else are
they going to evaluate the current cpufreq hackery?


Do not encourage vendors to add 'features' in magic warts. Strive to
improve Linux for everyone.
