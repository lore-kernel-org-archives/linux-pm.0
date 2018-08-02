From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Date: Thu, 2 Aug 2018 14:45:11 +0200
Message-ID: <20180802124511.GN2512@hirez.programming.kicks-ass.net>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180802123315.GV2476@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180802123315.GV2476@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: skannan@codeaurora.org
Cc: Quentin Perret <quentin.perret@arm.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 02, 2018 at 02:33:15PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 30, 2018 at 12:35:27PM -0700, skannan@codeaurora.org wrote:
> > On 2018-07-24 05:25, Quentin Perret wrote:
> > If it's going to be a different aggregation from what's done for frequency
> > guidance, I don't see the point of having this inside schedutil. Why not
> > keep it inside the scheduler files? Also, it seems weird to use a governor's
> > code when it might not actually be in use. What if someone is using
> > ondemand, conservative, performance, etc?
> 
> EAS hard relies on schedutil -- I suppose we need a check for that
> somewhere and maybe some infrastructure to pin the cpufreq governor.

Either that or disable EAS when another governor is selected.

> We're simply not going to support it for anything else.

To clarify, it makes absolutely no sense what so ever to attempt EAS
when the DVFS control is not coordinated.
