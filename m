From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Tue, 1 Mar 2016 15:24:59 +0100
Message-ID: <20160301142459.GR6356@twins.programming.kicks-ass.net>
References: <5387313.xAhVpzgZCg@vostro.rjw.lan>
 <56BA8C29.4090905@linaro.org>
 <20160211115959.GI6357@twins.programming.kicks-ass.net>
 <20160211122429.GM11415@e106622-lin>
 <20160211152625.GM6357@twins.programming.kicks-ass.net>
 <CAKfTPtCRAyqx96rNuotHD2qtxBQkBa6K+-kk5bGQB2VbMq+k2A@mail.gmail.com>
 <20160212140415.GS6357@twins.programming.kicks-ass.net>
 <CAKfTPtA42zK+2pm71gDpodynYWXtKBqc-G5bFBh8aCKU=GPh_g@mail.gmail.com>
 <20160301135811.GQ6356@twins.programming.kicks-ass.net>
 <20160301141706.GJ18792@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160301141706.GJ18792@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 01, 2016 at 02:17:06PM +0000, Juri Lelli wrote:
> On 01/03/16 14:58, Peter Zijlstra wrote:
> > On Fri, Feb 12, 2016 at 03:48:54PM +0100, Vincent Guittot wrote:
> > 
> > > Another point to take into account is that the RT tasks will "steal"
> > > the compute capacity that has been requested by the cfs tasks.
> > > 
> > > Let takes the example of a CPU with 3 OPP on which run 2 rt tasks A
> > > and B and 1 cfs task C.
> > 
> > > Let assume that the real time constraint of RT task A is too agressive
> > > for the lowest OPP0 and that the change of the frequency of the core
> > > is too slow compare to this constraint but the real time constraint of
> > > RT task B can be handle whatever the OPP. System don't have other
> > > choice than setting the cpufreq min freq to OPP1 to be sure that
> > > constraint of task A will be covered at anytime.
> > 
> > > Then, we still have 2
> > > possible OPPs. The CFS task asks for compute capacity that fits in
> > > OPP1 but a part of this capacity will be stolen by RT tasks. If we
> > > monitor the load of RT tasks and request capacity for these RT tasks
> > > according to their current utilization, we can decide to switch to
> > > highest OPP2 to ensure that task C will have enough remaining
> > > capacity. A lot of embedded platform faces such kind of use cases
> > 
> > Still doesn't make sense. How would you know the constraint of RT task
> > A, and that it cannot be satisfied by OPP0 ? The only information you
> > have in the task model is a static priority.
> > 
> 
> But, can't we have the problem Vincent describes if we s/RT/DL/ ?

Still not sure I actually see a problem. With DL you have a minimal OPP
required to guarantee correct execution of the DL tasks. For CFS you
have an average util reflecting its workload.

Add the two and you've got an effective OPP request. Or in CPPC terms:
we request a min freq of the DL and a max freq of DL+avg_CFS.

We could probably improve upon that by also tracking an avg DL and
lowering the max freq request to: min(DL, avg_DL + avg_CFS). The
consequence is that when the DL tasks hit peaks (over their avg) the CFS
tasks get a little more delay. But this might be a worthwhile trade-off.
