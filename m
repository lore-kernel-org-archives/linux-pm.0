From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC 08/14] sched/tune: add detailed documentation
Date: Wed, 16 Sep 2015 09:47:24 +0200
Message-ID: <20150916074724.GB27378@gmail.com>
References: <1440010044-3402-9-git-send-email-patrick.bellasi@arm.com>
 <20150902064958.GA18664@google.com>
 <20150903091849.GB15649@e105326-lin>
 <55F0938A.9000607@linaro.org>
 <20150911110959.GA22876@e105326-lin>
 <55F72773.9090001@linaro.org>
 <20150915150044.GD3206@e105326-lin>
 <20150915151953.GF16853@twins.programming.kicks-ass.net>
 <55F8B915.30202@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55F8B915.30202@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Ricky Liang <jcliang@chromium.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org


* Steve Muckle <steve.muckle@linaro.org> wrote:

> On 09/15/2015 08:19 AM, Peter Zijlstra wrote:
> > Please flip the argument around; providing lots of knobs for vendors to
> > do $magic with is _NOT_ a good thing.
> > 
> > The whole out-of-tree cpufreq governor hack fest Android thing is a
> > complete and utter fail on all levels. Its the embedded, ship, forget,
> > not contribute cycle all over again.
> > 
> > Making that harder is a _GOOD_ thing.
> 
> I get why the plugin-like governor interface may encourage out of tree
> development, but why would providing lots of policy knobs/tunables from
> the scheduler be bad?

There's many disadvantages:

 - People/vendors learn to rely on their knob based hacks and start making noise 
   if one of the knobs changes or goes away, reporting regressions, not always 
   reporting that they have tunables twiddled.

 - If distros start using knobs it's easy to get into a situation where different 
   distros have different knobs, and people tune them further. For every single 
   bugreport we'd have to first make 100% sure what the knobs are.

 - Workloads can sometimes be improved by twiddling knobs - while breaking lots of 
   other workloads. We'd like people who contribute to the scheduler to think 
   about the hard problems and improve the whole picture, not just a small part of 
   it. There's a rich set of 'knobs' to prevent the scheduler from doing things 
   (the various resource affinity system calls and facilities), so it's not like
   user-space does not have the flexibility.

 - Having too much configuration space makes upgrades to newer kernels generally 
   harder - and we want to have the opposite effects.

> Shouldn't that hopefully reduce the likelihood that someone feels the need to 
> roll their own stack of kernel modifications which never make it upstream?

If a scheduler bug or inefficiency can be kludged around with a knob then that 
reduces the likelihood of the scheduler getting improved.

Otherwise I'd like to encourage people to change the source if they want to debug 
a problem or improve things - so having to roll your own patches isn't an 
unconditional negative - it's what this whole OSS thing is about.

Thanks,

	Ingo
