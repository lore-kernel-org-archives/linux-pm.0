From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Date: Thu, 2 Aug 2018 19:36:01 +0200
Message-ID: <20180802173601.GO2494@hirez.programming.kicks-ass.net>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180802123315.GV2476@hirez.programming.kicks-ass.net>
 <20180802124511.GN2512@hirez.programming.kicks-ass.net>
 <20180802152109.2k45jqbfquef6u62@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180802152109.2k45jqbfquef6u62@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: skannan@codeaurora.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 02, 2018 at 04:21:11PM +0100, Quentin Perret wrote:
> On Thursday 02 Aug 2018 at 14:45:11 (+0200), Peter Zijlstra wrote:

> > To clarify, it makes absolutely no sense what so ever to attempt EAS
> > when the DVFS control is not coordinated.
> 
> I tend to agree with that, but at the same time even if we create a very
> strong dependency on schedutil, we will have no guarantee that the actual
> frequencies used on the platform are the ones we predicted in EAS.

Sure; on x86 for example our micro-code does whatever. But using
schedutil we at least 'guide' it in the general direction we'd expect
with the control that is available.

Using a !schedutil governor doesn't even get us that and we're basically
running on random input without any feedback to close the loop. Not
something I feel we should support or care for.
