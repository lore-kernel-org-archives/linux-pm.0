From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Fri, 12 Feb 2016 15:10:09 +0100
Message-ID: <20160212141009.GT6357@twins.programming.kicks-ass.net>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan>
 <56BA8C29.4090905@linaro.org>
 <20160211115959.GI6357@twins.programming.kicks-ass.net>
 <56BCBF7C.2080404@linaro.org>
 <20160211173033.GP6357@twins.programming.kicks-ass.net>
 <56BCD864.6030207@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56BCD864.6030207@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 11, 2016 at 10:52:20AM -0800, Steve Muckle wrote:
> On 02/11/2016 09:30 AM, Peter Zijlstra wrote:
> >> My concern above is that pokes are guaranteed to keep occurring when
> >> > there is only RT or DL activity so nothing breaks.
> >
> > The hook in their respective tick handler should ensure stuff is called
> > sporadically and isn't stalled.
> 
> But that's only true if the RT/DL tasks happen to be running when the
> tick arrives right?
> 
> Couldn't we have RT/DL activity which doesn't overlap with the tick? And
> if no CFS tasks happen to be executing on that CPU, we'll never trigger
> the cpufreq update. This could go on for an arbitrarily long time
> depending on the periodicity of the work.

Possible yes, but why do we care? Such a CPU would be so much idle that
cpufreq doesn't matter one way or another, right?
